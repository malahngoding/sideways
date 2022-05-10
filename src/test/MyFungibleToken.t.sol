// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "../MyFungibleToken.sol";

contract MyFungibleTokenTest is DSTest {
    using stdStorage for StdStorage;

    Vm private vm = Vm(HEVM_ADDRESS);
    MyFungibleToken private myFungibleToken;
    StdStorage private stdstore;

    function setUp() public {
        // Deploy NFT contract
        myFungibleToken = new MyFungibleToken("NFT_tutorial", "TUT", "baseUri");
    }

    function testFailNoMintPricePaid() public {
        myFungibleToken.mintTo(address(1));
    }

    function testMintPricePaid() public {
        myFungibleToken.mintTo{value: 0.08 ether}(address(1));
    }

    function testFailMaxSupplyReached() public {
        uint256 slot = stdstore
            .target(address(myFungibleToken))
            .sig("currentTokenId()")
            .find();
        bytes32 loc = bytes32(slot);
        bytes32 mockedCurrentTokenId = bytes32(abi.encode(10000));
        vm.store(address(myFungibleToken), loc, mockedCurrentTokenId);
        myFungibleToken.mintTo{value: 0.08 ether}(address(1));
    }

    function testFailMintToZeroAddress() public {
        myFungibleToken.mintTo{value: 0.08 ether}(address(0));
    }

    function testNewMintOwnerRegistered() public {
        myFungibleToken.mintTo{value: 0.08 ether}(address(1));
        uint256 slotOfNewOwner = stdstore
            .target(address(myFungibleToken))
            .sig(myFungibleToken.ownerOf.selector)
            .with_key(1)
            .find();

        uint160 ownerOfTokenIdOne = uint160(
            uint256(
                (
                    vm.load(
                        address(myFungibleToken),
                        bytes32(abi.encode(slotOfNewOwner))
                    )
                )
            )
        );
        assertEq(address(ownerOfTokenIdOne), address(1));
    }

    function testBalanceIncremented() public {
        myFungibleToken.mintTo{value: 0.08 ether}(address(1));
        uint256 slotBalance = stdstore
            .target(address(myFungibleToken))
            .sig(myFungibleToken.balanceOf.selector)
            .with_key(address(1))
            .find();

        uint256 balanceFirstMint = uint256(
            vm.load(address(myFungibleToken), bytes32(slotBalance))
        );
        assertEq(balanceFirstMint, 1);

        myFungibleToken.mintTo{value: 0.08 ether}(address(1));
        uint256 balanceSecondMint = uint256(
            vm.load(address(myFungibleToken), bytes32(slotBalance))
        );
        assertEq(balanceSecondMint, 2);
    }

    function testSafeContractReceiver() public {
        Receiver receiver = new Receiver();
        myFungibleToken.mintTo{value: 0.08 ether}(address(receiver));
        uint256 slotBalance = stdstore
            .target(address(myFungibleToken))
            .sig(myFungibleToken.balanceOf.selector)
            .with_key(address(receiver))
            .find();

        uint256 balance = uint256(
            vm.load(address(myFungibleToken), bytes32(slotBalance))
        );
        assertEq(balance, 1);
    }

    function testFailUnSafeContractReceiver() public {
        vm.etch(address(1), bytes("mock code"));
        myFungibleToken.mintTo{value: 0.08 ether}(address(1));
    }

    function testWithdrawalWorksAsOwner() public {
        // Mint an myFungibleToken, sending eth to the contract
        Receiver receiver = new Receiver();
        address payable payee = payable(address(0x1337));
        uint256 priorPayeeBalance = payee.balance;
        myFungibleToken.mintTo{value: myFungibleToken.MINT_PRICE()}(
            address(receiver)
        );
        // Check that the balance of the contract is correct
        assertEq(
            address(myFungibleToken).balance,
            myFungibleToken.MINT_PRICE()
        );
        uint256 myFungibleTokenBalance = address(myFungibleToken).balance;
        // Withdraw the balance and assert it was transferred
        myFungibleToken.withdrawPayments(payee);
        assertEq(payee.balance, priorPayeeBalance + myFungibleTokenBalance);
    }

    function testWithdrawalFailsAsNotOwner() public {
        // Mint an NFT, sending eth to the contract
        Receiver receiver = new Receiver();
        myFungibleToken.mintTo{value: myFungibleToken.MINT_PRICE()}(
            address(receiver)
        );
        // Check that the balance of the contract is correct
        assertEq(
            address(myFungibleToken).balance,
            myFungibleToken.MINT_PRICE()
        );
        // Confirm that a non-owner cannot withdraw
        vm.expectRevert("Ownable: caller is not the owner");
        vm.startPrank(address(0xd3ad));
        myFungibleToken.withdrawPayments(payable(address(0xd3ad)));
        vm.stopPrank();
    }
}

contract Receiver is ERC721TokenReceiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 id,
        bytes calldata data
    ) external view override returns (bytes4) {
        console.log(operator);
        console.log(from);
        console.log(id);
        console.log(data.length);
        return this.onERC721Received.selector;
    }
}

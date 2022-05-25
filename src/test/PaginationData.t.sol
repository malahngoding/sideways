// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../PaginationData.sol";

contract PaginationDataTest is Test {
    PaginationData paginationData;

    function setUp() public {
        paginationData = new PaginationData();
    }

    function testOnlyShouldReturnEmptyString() public {
        emit log_address(msg.sender);
        assertEq(paginationData.get(msg.sender), "");
    }

    function testSetValueAndGetTheSameValue() public {
        address randomish = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked("nonce", blockhash(block.number))
                    )
                )
            )
        );

        emit log_address(randomish);
        paginationData.set(randomish, "Hello Future!");
        assertEq(paginationData.get(randomish), "Hello Future!");
    }
}

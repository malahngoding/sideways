// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "forge-std/Test.sol";
import "../HelloSmartContracts.sol";

contract HelloSmartContractsTest is Test {
    HelloSmartContracts helloSmartContracts;

    function setUp() public {
        helloSmartContracts = new HelloSmartContracts();
    }

    function testGet() public {
        assertEq(helloSmartContracts.get(), "Hello Future!");
    }

    function testSet() public {
        helloSmartContracts.set("Break a leg");
        assertEq(helloSmartContracts.get(), "Break a leg");
    }
}

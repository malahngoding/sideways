// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "forge-std/Test.sol";
import "../Blast.sol";

contract BlastTest is Test {
    Blast blast;

    function setUp() public {
        blast = new Blast();
    }

    function testGet() public {
        assertEq(blast.get(), "Hello Future!");
    }

    function testSet() public {
        blast.set("Break Dance");
        assertEq(blast.get(), "Break Dance");
    }
}

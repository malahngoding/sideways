// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13;

contract Blast {
    string private greet = "Hello Future!";

    function get() public view returns (string memory) {
        return greet;
    }

    function set(string memory _value) public {
        greet = _value;
    }
}

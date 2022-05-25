// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PaginationData {
    mapping(address => string) private theMap;

    function get(address _addr) public view returns (string memory) {
        return theMap[_addr];
    }

    function set(address _addr, string memory _i) public {
        theMap[_addr] = _i;
    }

    function remove(address _addr) public {
        delete theMap[_addr];
    }
}

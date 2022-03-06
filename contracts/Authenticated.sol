// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/hardhat/console.sol";

contract Authenticated {
    struct UserDetail {
        string service;
        bool userSummoned;
    }

    mapping(string => UserDetail) user;

    function summon(string memory _token, string memory _service) public {
        user[_token].service = _service;
        user[_token].userSummoned = true;
    }

    function cast(string memory _token) public view returns (bool) {
        return (user[_token].userSummoned);
    }

    function revoke(string memory _token) public {
        user[_token].userSummoned = false;
    }
}

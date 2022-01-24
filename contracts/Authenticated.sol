// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/hardhat/console.sol";

contract Authenticated {
    struct UserDetail {
        address addr;
        bytes32 password;
        bool isUserLoggedIn;
    }

    mapping(address => UserDetail) user;

    function register(address _address, string memory _password) public {
        require(user[_address].addr != msg.sender);
        user[_address].addr = _address;
        user[_address].password = keccak256(abi.encodePacked(_password));
        user[_address].isUserLoggedIn = false;
    }

    function login(address _address, string memory _password)
        public
        returns (bool)
    {
        console.log(_address, _password, msg.sender);
        if (keccak256(abi.encodePacked(_password)) == user[_address].password) {
            user[_address].isUserLoggedIn = true;
            return true;
        } else {
            return false;
        }
    }

    function checkIsUserLogged(address _address) public view returns (bool) {
        return (user[_address].isUserLoggedIn);
    }

    function logout(address _address) public returns (bool) {
        require(user[_address].addr != msg.sender);
        user[_address].isUserLoggedIn = false;
        return true;
    }
}

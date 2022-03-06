// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract HelloHedera {
    address private owner;
    string private message;

    constructor(string memory message_) {
        owner = msg.sender;
        message = message_;
    }

    function setMessage(string memory message_) public {
        if (msg.sender != owner) return;
        message = message_;
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

    function kill() public {
        if (msg.sender == owner) selfdestruct(payable(msg.sender));
    }
}

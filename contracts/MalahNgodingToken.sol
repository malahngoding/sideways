// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MalahNgodingToken is ERC20 {
    uint256 private _totalSupply = 50000000;

    constructor() ERC20("Malah Ngoding Token", "MNT") {
        _mint(msg.sender, _totalSupply * (10**decimals()));
    }
}

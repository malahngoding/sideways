// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MalahNgodingToken is ERC20 {
    uint256 private _totalSupply = 50000000;

    constructor() ERC20("b5ef6c8b39db0cd25f6f683a1425ec6f Token", "MNT") {
        _mint(msg.sender, _totalSupply * (10**decimals()));
    }
}

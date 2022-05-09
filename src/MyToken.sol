// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/utils/Counters.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract Polyland is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private supply;

    uint256 public maxSupply = 4;

    struct Triangle {
        string name;
        int8 edge1;
        int8 edge2;
        int8 edge3;
    }

    Triangle[] public triangles;

    constructor() ERC721("Polyland", "PLLND") {
        triangles.push(Triangle("Triangle0", 0, 0, 0));
        triangles.push(Triangle("Triangle1", 1, 1, 1));
        triangles.push(Triangle("Triangle2", 2, 2, 2));
        triangles.push(Triangle("Triangle3", 3, 3, 3));
        triangles.push(Triangle("Triangle4", 4, 4, 4));
    }

    modifier supplyCap() {
        require(supply.current() <= maxSupply, "All patches minted.");
        _;
    }

    function totalSupply() public view returns (uint256) {
        return supply.current();
    }

    function getTriangles() public view returns (Triangle[] memory) {
        return triangles;
    }

    function mintTriangle(address account)
        public
        onlyOwner
        supplyCap
        returns (uint256)
    {
        supply.increment();

        uint256 newPatchId = supply.current();
        _mint(account, newPatchId);

        return newPatchId;
    }
}

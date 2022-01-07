/* eslint-disable node/no-missing-import */
import { expect } from "chai";
import { ethers } from "hardhat";
import { NFT } from "../typechain";

describe("NFT", async () => {
  let nft: NFT;
  let nftContractAddress;
  beforeEach(async () => {
    const NFT = await ethers.getContractFactory("NFT");
    nft = await NFT.deploy();
    await nft.deployed();
    nftContractAddress = nft.address;
  });
  it("Contract should be deployed", async () => {
    expect(nftContractAddress.length).equals(42);
  });
  it("Should creating token", async () => {
    const newNFT = await nft.createToken("https://jsonkeeper.com/b/RUUS");
    console.log(newNFT);
  });
  it("Should match NFT URI", async () => {
    await nft.createToken("https://jsonkeeper.com/b/RUUS");
    const nftURI = await nft.tokenURI(0);
    expect(nftURI).equals("https://jsonkeeper.com/b/RUUS");
  });
});

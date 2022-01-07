import { ethers } from "hardhat";

export const deployNFT = async () => {
  const NFT = await ethers.getContractFactory("NFT");
  const nft = await NFT.deploy();
  await nft.deployed();
  console.log("NFT deployed to:", nft.address);
};

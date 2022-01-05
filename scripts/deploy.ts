import { ethers } from "hardhat";

async function main() {
  const NFTMarket = await ethers.getContractFactory("NFTMarket");
  const nftMarket = await NFTMarket.deploy();
  await nftMarket.deployed();
  console.log("NFTMarket deployed to:", nftMarket.address);

  const NFT = await ethers.getContractFactory("NFT");
  const nft = await NFT.deploy(nftMarket.address);
  await nft.deployed();
  console.log("NFT deployed to:", nft.address);

  const MalahNgodingToken = await ethers.getContractFactory(
    "MalahNgodingToken"
  );
  const malahNgodingToken = await MalahNgodingToken.deploy();
  await malahNgodingToken.deployed();
  console.log("MalahNgodingToken deployed to:", malahNgodingToken.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

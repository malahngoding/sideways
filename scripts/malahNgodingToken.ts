import { ethers } from "hardhat";

export const deployMalahNgodingToken = async () => {
  const MalahNgodingToken = await ethers.getContractFactory(
    "MalahNgodingToken"
  );
  const malahNgodingToken = await MalahNgodingToken.deploy();
  await malahNgodingToken.deployed();
  console.log("MalahNgodingToken deployed to:", malahNgodingToken.address);
};

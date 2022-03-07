import { ethers } from "hardhat";

export const deployHashToken = async () => {
  const HashToken = await ethers.getContractFactory("HashToken");
  const hashToken = await HashToken.deploy();
  await hashToken.deployed();
  console.log("HashToken deployed to:", hashToken.address);
};

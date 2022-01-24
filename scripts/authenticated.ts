import { ethers } from "hardhat";

export const deployAuthenticated = async () => {
  const Authenticated = await ethers.getContractFactory("Authenticated");
  const authenticated = await Authenticated.deploy();
  await authenticated.deployed();
  console.log("Authenticated deployed to:", authenticated.address);
};

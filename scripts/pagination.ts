import { ethers } from "hardhat";

export const deployPagination = async () => {
  const Pagination = await ethers.getContractFactory("Pagination");
  const pagination = await Pagination.deploy();
  await pagination.deployed();
  console.log("Pagination deployed to:", pagination.address);
};

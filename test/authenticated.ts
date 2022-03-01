/* eslint-disable node/no-missing-import */
import { expect } from "chai";
import { ethers } from "hardhat";
import { Authenticated } from "../typechain";

describe("Authenticated", async () => {
  let authenticated: Authenticated;
  let wallet: { address: string };

  beforeEach(async () => {
    const Authenticated = await ethers.getContractFactory("Authenticated");
    authenticated = await Authenticated.deploy();
    await authenticated.deployed();
    wallet = ethers.Wallet.createRandom();
  });
  it("Address be able to summon", async () => {
    await authenticated.summon(wallet.address, "GITHUB");
    const authStatus = await authenticated.cast(wallet.address);
    expect(authStatus).equals(true);
  });
  it("Address be able to revoke", async () => {
    await authenticated.revoke(wallet.address);
    const authStatus = await authenticated.cast(wallet.address);
    expect(authStatus).equals(false);
  });
});

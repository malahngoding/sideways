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
  it("Address be able to register", async () => {
    await authenticated.register(wallet.address, "Password123!");
    const authStatus = await authenticated.checkIsUserLogged(wallet.address);
    expect(authStatus).equals(false);
  });
  it("Address be able to log in", async () => {
    await authenticated.login(wallet.address, "Password123!");
    const authStatus = await authenticated.checkIsUserLogged(wallet.address);
    expect(authStatus).equals(true);
  });
  it("Address be able to log out", async () => {
    await authenticated.logout(wallet.address);
    const authStatus = await authenticated.checkIsUserLogged(wallet.address);
    expect(authStatus).equals(false);
  });
});

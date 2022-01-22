/* eslint-disable node/no-missing-import */
import { expect } from "chai";
import { ethers } from "hardhat";
import { Pagination } from "../typechain";

describe("Pagination", async () => {
  let pagination: Pagination;
  let paginationContractAddress;
  beforeEach(async () => {
    const Pagination = await ethers.getContractFactory("Pagination");
    pagination = await Pagination.deploy();
    await pagination.deployed();
    paginationContractAddress = pagination.address;
  });
  it("PaginationContract should be deployed", async () => {
    expect(paginationContractAddress.length).equals(42);
  });
  it("Should creating 10 entries", async () => {
    const array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    for (const item of array) {
      await pagination.create(`${item}_Text`, "URL", "MEDIA", false);
    }
    const length = await pagination.getLength();
    expect(length).equals(10);
  });
  it("Should get correct entries", async () => {
    const array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    for (const item of array) {
      await pagination.create(`${item}_Text`, "URL", "MEDIA", false);
    }
    array.forEach(async (element, index) => {
      expect((await pagination.getAt(index)).text).equals(`${element}_Text`);
    });
  });
  it("Should get correct pagination", async () => {
    const array = [
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
    ];
    for (const item of array) {
      await pagination.create(
        `${item}_text`,
        `${item}_url`,
        `${item}_media`,
        false
      );
    }
    const page = await pagination.getBetween(1, 3);
    expect(page.length).equals(3);
    expect(page[0].text).equals(`2_text`);
  });
  it("Should concatenate string", async () => {
    const value = await pagination.concatenate("Test", "Data");
    expect(value).equals("Test Data");
  });
});

/* eslint-disable node/no-missing-import */
import { deployMalahNgodingToken } from "./malahNgodingToken";
import { deployNFT } from "./nft";
import { deployPagination } from "./pagination";

async function main() {
  await deployMalahNgodingToken();
  await deployNFT();
  await deployPagination();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

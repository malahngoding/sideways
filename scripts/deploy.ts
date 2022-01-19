/* eslint-disable node/no-missing-import */
import { deployMalahNgodingToken } from "./malahNgodingToken";
import { deployNFT } from "./nft";

async function main() {
  await deployMalahNgodingToken();
  await deployNFT();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

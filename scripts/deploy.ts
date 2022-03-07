/* eslint-disable node/no-missing-import */
import { deployAuthenticated } from "./authenticated";
import { deployHashToken } from "./deployHashToken";
import { deployNFT } from "./nft";
import { deployPagination } from "./pagination";

async function main() {
  await deployHashToken();
  await deployNFT();
  await deployPagination();
  await deployAuthenticated();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

/* eslint-disable node/no-missing-import */
import { deployMalahNgodingToken } from "./malahNgodingToken";

async function main() {
  await deployMalahNgodingToken();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

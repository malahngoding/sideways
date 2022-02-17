// eslint-disable-next-line node/no-missing-import
import { deployHelloHedera } from "./hedera";

async function main() {
  await deployHelloHedera();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

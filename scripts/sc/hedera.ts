/* eslint-disable node/no-missing-import */
import { ethers } from "hardhat";
import {
  Client,
  FileCreateTransaction,
  ContractCreateTransaction,
  ContractFunctionParameters,
} from "@hashgraph/sdk";

export default async function main() {
  // Set Operator Client
  const client = Client.forTestnet().setOperator(
    process.env.HEDERA_ACCOUNT_ID || "",
    process.env.HEDERA_PRIVATE_KEY || ""
  );
  // Contract byte handling
  const contractName = "HelloHedera";
  console.log(`Uploading ${contractName} bytecode to Hedera File Service`);
  const HelloHedera = await ethers.getContractFactory(contractName);

  const fileCreateTx = new FileCreateTransaction().setContents(
    HelloHedera.bytecode
  );
  const submitTx = await fileCreateTx.execute(client);
  const fileReceipt = await submitTx.getReceipt(client);
  const bytecodeFileId = fileReceipt.fileId;
  console.log("The smart contract byte code file ID is " + bytecodeFileId);
  // Contract deployment handling
  const contractTx = await new ContractCreateTransaction()
    .setBytecodeFileId(bytecodeFileId || "")
    .setGas(100000)
    .setConstructorParameters(
      new ContractFunctionParameters().addString("Hello from Hedera!")
    );
  const contractResponse = await contractTx.execute(client);
  const contractReceipt = await contractResponse.getReceipt(client);
  const newContractId = contractReceipt.contractId;
  console.log("The smart contract ID is " + newContractId);
  return newContractId;
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

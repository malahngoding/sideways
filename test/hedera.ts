/* eslint-disable node/no-missing-import */
import { expect } from "chai";
import {
  Client,
  ContractCallQuery,
  ContractExecuteTransaction,
  ContractFunctionParameters,
  Hbar,
} from "@hashgraph/sdk";

const contractId = "0.0.29472161";

describe("HelloHedera", async () => {
  it("Should match deployed constructor", async () => {
    // Set Operator Client
    const client = Client.forTestnet().setOperator(
      process.env.HEDERA_ACCOUNT_ID || "",
      process.env.HEDERA_PRIVATE_KEY || ""
    );
    // Call Smart Contracts
    const transaction = await new ContractExecuteTransaction()
      .setContractId(contractId)
      .setGas(100000)
      .setFunction(
        "set_message",
        new ContractFunctionParameters().addString("Hello from Hedera again!")
      );
    const txResponse = await transaction.execute(client);
    const receipt = await txResponse.getReceipt(client);
    const transactionStatus = receipt.status;

    console.log("The transaction consensus status is " + transactionStatus);

    const contractQuery = await new ContractCallQuery()
      .setContractId(contractId)
      .setGas(100000)
      .setFunction("get_message")
      .setQueryPayment(new Hbar(0.01));
    const getMessage = await contractQuery.execute(client);
    const message = getMessage.getString(0);
    console.log("The contract message: " + message);
    expect(message).equals("Hello from Hedera again!");
  });
});

const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });
const { CRYPTO_CAVE_NFT_CONTRACT_ADDRESS } = require("../constants");

async function main() {
  // Address of the Crypto Cave NFT contract that you deployed in the previous module
  const cryptoCaveNFTContract = CRYPTO_CAVE_NFT_CONTRACT_ADDRESS;

  /*
    A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
    so cryptoCaveTokenContract here is a factory for instances of our CryptoCaveToken contract.
    */
  const cryptoCaveTokenContract = await ethers.getContractFactory(
    "CryptoCaveToken"
  );

  // deploy the contract
  const deployedCryptoCaveTokenContract = await cryptoCaveTokenContract.deploy(
    cryptoCaveNFTContract
  );

  await deployedCryptoCaveTokenContract.deployed();
  // print the address of the deployed contract
  console.log(
    "Crypto Cave Token Contract Address:",
    deployedCryptoCaveTokenContract.address
  );
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
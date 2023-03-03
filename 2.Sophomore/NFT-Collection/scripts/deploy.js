const { ethers } = require("hardhat");
require("dotenv").config({path: ".env"});

const { WHITELIST_CONTRACT_ADDRESS, METADATA_URL } = require("../constants");

async function main(){
  // Address of the whitelist contract
  const whitelistContract = WHITELIST_CONTRACT_ADDRESS;


  const metadataURL = METADATA_URL;

  const cryptoCaveContract = await ethers.getContractFactory("CryptoCave");

  const deployedCryptoCaveContract = await cryptoCaveContract.deploy(
    metadataURL,
    whitelistContract
  )

  await deployedCryptoCaveContract.deployed();

  console.log(
    "Crypto Cave Contract Address: ",
    deployedCryptoCaveContract.address
  )
}

main()
.then(() => process.exit(0))
.catch((error) => {
  console.log(error);
  process.exit(1);
})
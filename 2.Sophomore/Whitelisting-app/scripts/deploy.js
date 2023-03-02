const { ethers } = require("hardhat");


async function main(){
  const whitelistContract =  await ethers.getContractFactory("Whitelisting");

  //10 is the number of addresses that can be added to the whitelist, passed to the constructor
  const whitelist = await whitelistContract.deploy(10);
  //wait for the contract to be mined
  await whitelist.deployed();

  console.log("Whitelist contract deployed to:", whitelist.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
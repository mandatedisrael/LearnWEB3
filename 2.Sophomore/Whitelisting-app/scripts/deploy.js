const {ethers } = require("hardhat");

async function main() {
  const getContract = await ethers.getContractFactory("LW3NFT");
  const contract = await getContract.deploy();
  await contract.deployed();
  console.log("Contract deployed to:", contract.address);
};

main()
.then(() => {process.exit(0)})
.catch((error) => {
    console.error(error);
    process.exit(1);
});
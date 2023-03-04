require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" })


const ALCHEMY_URL = process.env.ALCHEMY_HTTPS;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.4",
  networks: {
    goerli: {
      url: ALCHEMY_URL,
      accounts: [PRIVATE_KEY],
    }
}
};

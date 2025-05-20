require('dotenv').config();
const { ethers } = require('hardhat');

async function main() {
  const sign = await ethers.getContractFactory('SignatureNFT');
  const contract = await sign.deploy();
  await contract.deployed();
  console.log('SignatureNFT deployed to:', contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

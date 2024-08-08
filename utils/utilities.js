const { network, ethers } = require("hardhat");

const fundToken = async (contract, sender, recipient, amount) => {
  const FUND_AMOUNT = ethers.utils.parseUnits(amount, 18);

  // Impersonate the sender account
  await network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [sender],
  });

  const whale = await ethers.provider.getSigner(sender);

  const contractSigner = contract.connect(whale);
  await contractSigner.transfer(recipient, FUND_AMOUNT);

  // Stop impersonating the sender account
  await network.provider.request({
    method: "hardhat_stopImpersonatingAccount",
    params: [sender],
  });
};

const fundContract = async (contract, sender, recipient, amount) => {
  // Fund baseToken to the contract
  await fundToken(contract, sender, recipient, amount);
};

module.exports = {
  fundContract,
};

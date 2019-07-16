var Vote = artifacts.require("Vote");

module.exports = function(deployer) {
  deployer.deploy(Vote,["Yes", "No"].map(x => web3.utils.asciiToHex(x)));
};
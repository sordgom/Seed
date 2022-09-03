const SeedBatch = artifacts.require("SeedBatch");
const SeedNFT = artifacts.require("SeedNFT");

module.exports = function (deployer) {
  deployer.deploy(SeedNFT,"Event 1","Symbol 1","",1);
};

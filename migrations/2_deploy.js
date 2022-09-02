const SeedBatch = artifacts.require("SeedBatch");
const SeedNFT = artifacts.require("SeedNFT");

module.exports = function (deployer) {
  deployer.deploy(SeedBatch);
};

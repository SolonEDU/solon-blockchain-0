var Budget = artifacts.require("Budget");

module.exports = function(deployer) {
    deployer.deploy(Budget, "transfer 500 to eric", 500,2 );
}
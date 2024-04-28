// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {TugAWar} from "src/TugAWar.sol";

contract DeployTugAWarScript is Script {
  function run() public {
    uint256 deployKey = vm.envUint("DEPLOY_KEY");
    vm.startBroadcast(deployKey);
    runInternal();
    vm.stopBroadcast();
  }

  function runInternal() internal {
    TugAWar taw = new TugAWar(
      vm.envAddress("DS_ZONE_ADDR"),
      vm.envAddress("ERC6551_ACCOUNT_IMLEMENTATION_ADDRESS"));
    console.log(address(taw));
  }
}


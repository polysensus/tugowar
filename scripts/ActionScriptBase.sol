// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";

contract ActionScriptBase is Script {

  function startBroadcast(string memory keyName) internal {
    // If keyName is not set, the script is assumed to be run with --ledger
    uint256 deployKey = vm.envOr(keyName, uint256(0));
    if (deployKey != 0)
      vm.startBroadcast(deployKey);
    else
      vm.startBroadcast();
  }
}

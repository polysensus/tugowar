// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console} from "forge-std/Script.sol";
import {ActionScriptBase} from "./ActionScriptBase.sol";

import {TugAWar} from "src/TugAWar.sol";
import {ERC6551Account} from "src/ERC6551Account.sol";

import {TUGAWAR, LIGHT_ACCOUNT} from "./constants.sol";

contract JoinTheLightScript is ActionScriptBase {

    TugAWar public taw;

    function run() external {

      taw = TugAWar(TUGAWAR);
      bytes memory joinTheLightCall = abi.encodeWithSignature("joinTheLight()");
      ERC6551Account lightPlayerAccount = ERC6551Account(payable(LIGHT_ACCOUNT));

      startBroadcast("POLYZONE_KEY");
      lightPlayerAccount.execute(payable(address(taw)), 0, joinTheLightCall, 0);
      vm.stopBroadcast();
    }
}

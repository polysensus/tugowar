// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

// --- test framework imports
import {Test, console} from "forge-std/Test.sol";
import "forge-std/console2.sol";

import {ERC6551Account} from "src/ERC6551Account.sol";

import {DeployTugAWarScript} from "scripts/DeployTugAWar.s.sol";
import {console} from "forge-std/Test.sol";


contract DeployAccountImplScriptTest is Test {

  string RPC = vm.rpcUrl("rpc");
  uint256 FORK_BLOCK = vm.envUint("FORK_BLOCK");
  uint256 fork;

  function setUp() public {
      if (!vm.envOr("ENABLE_FORK_TESTS", false)) return;

      fork = vm.createFork(RPC, FORK_BLOCK);
      vm.selectFork(fork);
  }

  function test_DeployTugAWarScript() public {
    if (!vm.envOr("ENABLE_FORK_TESTS", false)) return;
    assertEq(vm.activeFork(), fork);
    vm.selectFork(fork);
    DeployTugAWarScript s = new DeployTugAWarScript();
    s.run();
  }
}

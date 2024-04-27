// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface TugAWar {       
    function getCurrentRopePosition() external view returns (uint256);
    function joinTheLight() external;
    function joinTheDark() external;
    function Add() external;
    function Sub() external;
}

contract FakeTugAWar is TugAWar {       
    function getCurrentRopePosition() public view returns (uint256) {
      return (uint256)(10);
    }
    function joinTheLight() public {}
    function joinTheDark() public {}
    function Add() public {}
    function Sub() public {}
}

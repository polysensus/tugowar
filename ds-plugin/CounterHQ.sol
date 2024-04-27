// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Game} from "cog/IGame.sol";
import {State} from "cog/IState.sol";
import {Schema} from "@ds/schema/Schema.sol";
import {Actions} from "@ds/actions/Actions.sol";
import {BuildingKind} from "@ds/ext/BuildingKind.sol";
import {TugAWar, FakeTugAWar} from "./TugAWar.sol";
import {TUGAWAR_ADDRESS} from "./config.sol";

using Schema for State;

contract CounterHQ is BuildingKind {

    function readScore() external {}
    function joinTheLight() external {}
    function joinTheDark() external {} 
    function Add() external {}
    function Sub() external {}
    function Quit() external {}

    function use(Game ds, bytes24 buildingInstance, bytes24, /*actor*/ bytes calldata payload) public override {

        TugAWar taw = TugAWar(TUGAWAR_ADDRESS);

        if ((bytes4)(payload) == this.readScore.selector)
          _readScore(ds, taw, buildingInstance);

        // Now the trick with these methods, which change state, is that the
        // token bound account is pre-funded by the player (or game treasury or
        // whatever) to carry the cost.
        //
        // Downstream doesn't need to support this directly in order for it to
        // 'just work (tm)'
        else if ((bytes4)(payload) == this.joinTheLight.selector)
          _joinTheLight(ds, taw, buildingInstance);
        else if ((bytes4)(payload) == this.joinTheDark.selector)
          _joinTheDark(ds, taw, buildingInstance);
        else if ((bytes4)(payload) == this.Add.selector)
          _Add(ds, taw, buildingInstance);
        else if ((bytes4)(payload) == this.Sub.selector)
          _Sub(ds, taw, buildingInstance);
    }
    

    function _readScore(Game ds, TugAWar taw, bytes24 buildingInstance) internal {
        // read score
        uint256 score = taw.getCurrentRopePosition();

        // set score
        ds.getDispatcher().dispatch(
            abi.encodeCall(Actions.SET_DATA_ON_BUILDING, (buildingInstance, "score", bytes32(score)))
        );
    }

    function _joinTheLight(Game ds, TugAWar taw, bytes24 buildingInstance) internal {

      // msg.sender needs to be the token holder for this to work, which may
      // not work with a bundler ...
      taw.joinTheLight();

      // set that we have joined the light
      ds.getDispatcher().dispatch(
          abi.encodeCall(Actions.SET_DATA_ON_BUILDING, (buildingInstance, "joined", bytes32("the light")))
      );
    }

    function _joinTheDark(Game /*ds*/, TugAWar /*taw*/, bytes24 /*buildingInstance*/) internal {
      // console.log("joinTheDark: todo");
    }
    function _Add(Game /*ds*/, TugAWar /*taw*/, bytes24 /*buildingInstance*/) internal {
      // console.log("Add: todo");
    }
    function _Sub(Game /*ds*/, TugAWar /*taw*/, bytes24 /*buildingInstance*/) internal {
      // console.log("Sub: todo");
    }
}

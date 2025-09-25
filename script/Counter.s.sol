// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import "forge-std/console.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    Counter public counter;

    function setUp() public {}

    // forge script CounterScript --rpc-url https://ethereum.public.blockpi.network/v1/rpc/public
    // forge script CounterScript --rpc-url 127.0.0.1:8545 --broadcast --sender 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    function run() public {
        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);

        counter = new Counter();

        console.log(address(counter));

        vm.stopBroadcast();
    }
}

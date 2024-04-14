// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintMoodNft is Script {
    function run() external {
        mintNftOnContract();
    }

    function mintNftOnContract() public {
        vm.startBroadcast();
        MoodNft(0x5FbDB2315678afecb367f032d93F642f64180aa3).mintNft();
        vm.stopBroadcast();
    }
}

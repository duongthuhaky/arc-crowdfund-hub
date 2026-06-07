// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/CrowdfundHub.sol";

contract DeployCrowdfundHub is Script {
    function run() external {
        vm.startBroadcast();
        new CrowdfundHub(0x3600000000000000000000000000000000000000);
        vm.stopBroadcast();
    }
}

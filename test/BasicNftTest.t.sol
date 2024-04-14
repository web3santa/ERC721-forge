// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    DeployBasicNft public deployer;

    address henry = makeAddr("henry");
    uint256 public constant STARTING_BALANCE = 1 ether;
    uint256 public constant MINT_AMOUNT = 0.01 ether;
    string public PUG = "ipfs://QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8";

    function setUp() external {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
        vm.deal(henry, STARTING_BALANCE);
    }

    function testNft() public view {
        string memory expectName = basicNft.name();
        string memory actualName = "Doggie";

        assert(
            keccak256(abi.encodePacked(expectName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testMintNft() public {
        vm.prank(henry);
        basicNft.mintNft{value: 1 ether}(PUG);

        assertEq(basicNft.balanceOf(henry), 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }

    function testBalanceAfterMintNft() public {
        vm.prank(henry);
        basicNft.mintNft{value: MINT_AMOUNT}(PUG);

        console.log(henry.balance);

        assertEq(henry.balance, STARTING_BALANCE - MINT_AMOUNT);
    }
}

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";
import {Test, console} from "forge-std/Test.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(address(msg.sender)); // This is a prank
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assert(STARTING_BALANCE == ourToken.balanceOf(bob));
    }

    function testAllowance() public {
        uint256 initialAllowance = 1000;

        vm.prank(bob); // This is a prank
        ourToken.approve(alice, initialAllowance);

        uint256 transferAmount = 100;

        vm.prank(alice); // This is a prank
        ourToken.transferFrom(bob, alice, transferAmount);
        assertEq(transferAmount, ourToken.balanceOf(alice));
        assertEq(STARTING_BALANCE - transferAmount, ourToken.balanceOf(bob));
    }

    function testTransfer() public {
        address recipient = address(1);
        uint256 transferAmount = 100;

        uint256 initialBalance = ourToken.balanceOf(msg.sender);

        vm.prank(address(msg.sender)); // Simulate recipient calling approve (allowance not needed for basic transfer)

        ourToken.transfer(recipient, transferAmount);

        assertEq(
            ourToken.balanceOf(msg.sender),
            initialBalance - transferAmount
        );
        assertEq(ourToken.balanceOf(recipient), transferAmount);
    }

    function testInsufficientBalance() public {
        address recipient = address(1);
        uint256 transferAmount = deployer.INITIAL_SUPPLY() + 1;

        vm.prank(recipient); // Simulate recipient calling approve (allowance not needed for basic transfer)
        ourToken.approve(msg.sender, type(uint256).max); // Grant unlimited allowance for testing

        vm.expectRevert();
        ourToken.transfer(recipient, transferAmount);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/CrowdfundHub.sol";

contract MockUSDC {
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    function mint(address to, uint256 amount) external {
        balanceOf[to] += amount;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        require(balanceOf[from] >= amount, "insufficient");
        require(allowance[from][msg.sender] >= amount, "not approved");
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        allowance[from][msg.sender] -= amount;
        return true;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "insufficient");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        return true;
    }
}

contract CrowdfundHubTest is Test {
    CrowdfundHub public target;
    MockUSDC public usdc;
    address public user1 = address(0x1);

    function setUp() public {
        usdc = new MockUSDC();
        target = new CrowdfundHub(address(usdc));
        usdc.mint(address(this), 1000000 * 1e6);
        usdc.approve(address(target), type(uint256).max);
    }

    function testDeposit() public {
        target.deposit(100 * 1e6);
        assertEq(target.totalDeposited(), 100 * 1e6);
    }

    function testWithdrawAll() public {
        target.deposit(100 * 1e6);
        target.withdrawAll();
        assertEq(usdc.balanceOf(address(target)), 0);
    }

    function testDepositZeroReverts() public {
        vm.expectRevert("CrowdfundHub: zero amount");
        target.deposit(0);
    }
}

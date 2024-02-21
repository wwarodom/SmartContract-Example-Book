// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Uniswap {
    mapping(address => uint256) public balances;

    function swapTokens(uint256 amountIn, uint256 amountOut) public {
        // Simulate the token swap by deducting 'amountIn' tokens from the sender and adding 'amountOut' tokens to their balance.
        balances[msg.sender] -= amountIn;
        balances[msg.sender] += amountOut;
    }
}

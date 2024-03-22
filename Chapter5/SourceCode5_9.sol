// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract Uniswap01 {
    mapping(address => uint256) public balances;

    function swapTokens(uint256 amountIn, uint256 amountOut) public {
        // Simulate the token swap by deducting 'amountIn' tokens from the sender and adding 'amountOut' tokens to their balance.
        balances[msg.sender] += amountOut;
        balances[msg.sender] -= amountIn;
    }
}

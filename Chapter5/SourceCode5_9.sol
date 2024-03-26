// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Uniswap01 {
    mapping(address => mapping( string => uint256)) public balances;
    constructor () {
        balances[msg.sender]["ETH"] =  10 ether;
        balances[msg.sender]["USDT"] = 3000 ether;
    }
    function swapTokens(uint256 amountIn, uint256 amountOut) public {        
        balances[msg.sender]["ETH"] += amountIn;
        balances[msg.sender]["USDT"] -= amountOut;
    }
}

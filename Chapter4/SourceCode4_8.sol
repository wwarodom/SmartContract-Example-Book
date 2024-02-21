// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ErrorHandlingExample {
    function divide(uint256 numerator, uint256 denominator) public pure returns (uint256) {
        require(denominator != 0, "Division by zero is not allowed.");        
        uint256 result = numerator / denominator;
        assert(result > 0);
        return result;
    }
}
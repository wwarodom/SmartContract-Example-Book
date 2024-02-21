// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Library contract
library MathLibrary {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }
}

// Contract using the library
contract MyContract {
    // Import the library
    using MathLibrary for uint256;
    function performAddition(uint256 x, uint256 y) public pure returns (uint256) {        
        return x.add(y); // Use the library function
    }
}

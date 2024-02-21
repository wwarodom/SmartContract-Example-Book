// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract DataLocationExample {
    // State variable (stored in storage)
    uint256 public stateVariable;
    
    function setLocalVariable() public pure returns (uint256) {
        // Local variable (stored in memory)
        uint256 localVar = 10;
        return localVar;
    }
    
    function updateStateVariable(uint256 newValue) public {
        // Accessing and modifying the state variable
        stateVariable = newValue;
    }
    
    function readFromCalldata(uint256[] calldata dataArray) 
               public pure returns (uint256) {
        // Accessing data from calldata
        return dataArray[0];
    }
}

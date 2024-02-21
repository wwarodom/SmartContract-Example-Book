// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract EventExample {
    event LogMessage(string message, uint256 timestamp);    // Defined event

    function sendMessage(string memory _message) public {
        // Emit event to notify external entities or frontend app
        emit LogMessage(_message, block.timestamp);    
    }
}

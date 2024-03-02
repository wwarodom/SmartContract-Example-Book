// SPDX-License-Identifier: MIT 
pragma solidity 0.8.20;

contract HashFinder {
    bytes32 public constant targetHash =
        0x72b7f858dbb0ff500b25e340c20a8d5da685ab5d466fd031d0f7b876217e50d6; // Werapun

    // deposit 10 ETH (msg.value) to HashFinder when deploying
    constructor() payable {}
 
    function attemptSolution(string memory word) public {
        require(targetHash == keccak256(abi.encodePacked(word)), "Incorrect answer");        
        (bool success, ) = msg.sender.call{value: 10 ether}("");
        require(success, "Failed to send Ether");
    }
}

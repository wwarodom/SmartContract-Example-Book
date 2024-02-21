// This contract appears benign, but it contains hidden malicious code
// to exploit the VulnerableContract.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract MaliciousContract {
    address public attacker;

    constructor() {
        attacker = msg.sender;
    }

    function transfer(address to, uint256 amount) public {
        require(msg.sender == attacker, "Unauthorized access!");
        // Perform the legitimate transfer logic
        // However, the attacker can manipulate this logic to exploit the VulnerableContract.
    }
}

// SPDX-License-Identifier: MIT 
// Honeypot contract designed to deceive attackers and make them lose their funds
pragma solidity 0.8.20;

contract Honeypot {
    address public owner;
    uint256 public balance;

    constructor() {
        owner = msg.sender;
    }

    // A function that allows anyone to deposit Ether into the contract
    function deposit() public payable {
        balance += msg.value;
    }

  // An intentionally vulnerable withdraw function that will always fail
    function withdraw() public {
        require(msg.sender == owner, "Only the contract owner can withdraw.");
  // Malicious logic to deceive attackers - this function always reverts
        revert("Withdraw failed! Funds lost.");
    }

    // A function that allows the contract owner to withdraw the funds
    function ownerWithdraw() public {
        require(msg.sender == owner, "Only the contract owner can withdraw.");
        payable(owner).transfer(balance);
        balance = 0;
    }

   // A fallback function to trap any Ether accidentally sent to the contract
    receive() external payable {
  // Malicious logic to deceive attackers - this function always reverts
        revert("Funds lost.");
    }
}

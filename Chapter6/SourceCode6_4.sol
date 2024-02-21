// This contract is vulnerable and interacts with an external contract
// without realizing the potential malicious behavior.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20; 

interface ExternalContract {
    function transfer(address to, uint256 amount) external;
}

contract VictimContract {
    ExternalContract externalContract;
    uint256 public balance;

    constructor(address _externalContractAddress) {
        externalContract = ExternalContract(_externalContractAddress);
    }


    function deposit() public payable {
        balance += msg.value;
    }

    function withdraw() public {
        uint256 amountToWithdraw = balance;
        balance = 0;
        externalContract.transfer(msg.sender, amountToWithdraw); // External call to transfer funds
    }
}

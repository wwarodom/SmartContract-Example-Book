// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract SimpleBank {
    mapping(address => uint256) private balances;
    address public owner;

    event Deposit(address indexed account, uint256 amount);
    event Withdraw(address indexed account, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdraw amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function getContractBalance() public view onlyOwner returns (uint256) {
        return address(this).balance;
    }
}
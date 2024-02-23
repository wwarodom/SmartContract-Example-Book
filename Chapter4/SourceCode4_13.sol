// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Example {    

    address private owner;
    uint balance;

    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _; // This underscore represents the original function's code
    }

    modifier balanceNotZero {
        // Modifier 2 code
        _;
        require( balance > 0 ,"Balance must greater than 0" );
    }

    constructor() {
        balance = 0;
        owner = msg.sender;
    }

    
    function doSomething() public view onlyOwner returns (string memory) {
        return "Hello";
    }

    function doSomething2(uint _balance) public onlyOwner balanceNotZero returns (uint) {
        balance = _balance;
        return balance;
    }
}

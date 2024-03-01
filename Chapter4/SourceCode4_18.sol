// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract PayableExample {
   address payable owner;
  
   constructor() { owner = payable(msg.sender); }

   function paymentToSmartContract() external payable {  }
  
   function checkBalance() external view returns (uint) {
       // address(this) => smart contract address
       // address(this).balance => Ether in smart contract
       return address(this).balance;
   }
  
   function payment(address payable _to) payable external {
       // transfer Ether value from smart contract to _to
       _to.transfer(msg.value);  
   }
  
   function ownerBalance() external view returns (uint) {
       return owner.balance;       // get Ether from owner
   } 
}

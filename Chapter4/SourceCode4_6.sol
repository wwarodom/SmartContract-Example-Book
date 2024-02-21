// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract Hello { 
    // private: in this contract, public outside the contract
    string private message = "Hello World";    

   // can modify state
   function setMessage(string memory _message) public {  
       message = _message;
   }

   // view: only read state (Not modify)
   function getMessage() public view returns (string memory) {   
       return message;
   }

   // not allowed to read/write state
   function foo() public pure returns (uint256 , string memory) {  
       return (1,"Foo bar");
   }
}

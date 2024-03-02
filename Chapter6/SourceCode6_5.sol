// SPDX-License-Identifier: MIT

pragma solidity 0.8.20; 

contract Malicious {
    event Log(string message);       

    fallback () external { 
        emit Log("log in Malicious was called in fallback");
    } 

    // if this function DOES NOT exist, fallback is called
    function log() public  {  
        emit Log("log in Malicious was called ");
        // ...Attacker can put some commands he wants here...
    }
}

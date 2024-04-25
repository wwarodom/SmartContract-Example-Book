// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract Innocent {
    Mask mask; 

    constructor(address _mask) {
        mask = Mask(_mask);
    } 

    function callMaskLog() public {
        mask.log();
    }    
}

// This contract can be hided in another file and not publicly available,
// Then a user cannot see how log() works.
contract Mask {
    event Log(string message); 

    function log() public  {
        emit Log("Mask log was called");
    }
}

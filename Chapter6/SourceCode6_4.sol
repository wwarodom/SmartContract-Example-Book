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

contract Mask {
    event Log(string message); 

    function log() public  {
        emit Log("Mask log was called");
    }
}

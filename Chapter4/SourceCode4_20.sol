// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

contract ReceiveEther { 
    event log(string  mesg, bytes data); 

    receive() external payable {   
        emit log("receive() is called.", msg.data);
    }

    fallback() external payable {  
        emit log("fallback() is called.", msg.data );
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther { 
    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        // receive()  get called
        (bool sent, ) = _to.call{value: msg.value}(""); 
        require(sent, "Failed to send Ether");
    }
    
    function sendViaCallWithData(address payable _to) public payable { 
        // fallback() get called, "withData" is sent via msg.data 
        (bool sent, ) = _to.call{value: msg.value}("withData"); 
        require(sent, "Failed to send Ether");
    }
}

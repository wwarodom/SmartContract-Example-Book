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
        // work only transfer to EOA account, doesn't work for a smart contract address
        // Failure to transfer to a smart contract address
        // since it will execute receive() or fallback() that costs gas more 2300
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Similar to transfer() but returns a boolean value indicating success or failure.
        // and also have default gas limit: 2300  as transfer()
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        // receive()  get called
        // (bool sent, ) = _to.call{value: msg.value}(""); 
        (bool sent, bytes memory data) = _to.call{gas :10000, value: msg.value}("");  // receive
        require(sent, "Failed to send Ether");
    }
    
    function sendViaCallWithData(address payable _to) public payable { 
        // fallback() get called, "withData" is sent via msg.data 
        (bool sent, ) = _to.call{value: msg.value}("withData");                     // fallback
        require(sent, "Failed to send Ether");
    }
}

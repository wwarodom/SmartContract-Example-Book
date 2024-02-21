// SPDX-License-Identifier: MIT 
pragma solidity 0.8.20; 

contract Auction {
    address public highestBidder;
    uint public highestBid;

    function findHash(uint secretNumber) public pure returns (bytes32) {
        return keccak256(abi.encode(secretNumber));
    }

    function bid() public payable {
        require(msg.value > highestBid, "Bid amount must be higher than the current highest bid");
        highestBidder = msg.sender;
        highestBid = msg.value;
    }
}

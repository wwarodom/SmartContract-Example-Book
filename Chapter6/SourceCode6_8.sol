// SPDX-License-Identifier: MIT 

pragma solidity 0.8.20; 

contract ProtectedAuction {
    struct Bid {
        bytes32 commitment;
        uint amount;
    }

    mapping(address => Bid) public bids;
    address public highestBidder;
    uint public highestBid;
    uint public revealEndTime;
    bool public auctionEnded;

    modifier onlyBeforeRevealEnd() {
        require(block.timestamp < revealEndTime, "Reveal period has ended");
        _;
    }

    modifier onlyAfterRevealEnd() {
        require(block.timestamp >= revealEndTime, "Reveal period has not ended");
        _;
    }

    function commitBid(bytes32 _commitment) public payable onlyBeforeRevealEnd {
        require(bids[msg.sender].commitment == bytes32(0), "Bidder has already committed");
        require(msg.value > 0, "Bid amount must be greater than 0");
        bids[msg.sender] = Bid({
            commitment: _commitment,
            amount: msg.value
        });
    }

    function revealBid(uint _secretNumber) public onlyAfterRevealEnd {
        require(bids[msg.sender].commitment != bytes32(0), "Bidder has not committed");
        bytes32 expectedCommitment = keccak256(abi.encode(_secretNumber));
        require(bids[msg.sender].commitment == expectedCommitment, "Invalid secret number");

        uint bidAmount = bids[msg.sender].amount;
        if (bidAmount > highestBid) {
            highestBidder = msg.sender;
            highestBid = bidAmount;
        }

        delete bids[msg.sender];
    }

    function endAuction() public onlyAfterRevealEnd {
        require(!auctionEnded, "Auction has already ended");
        auctionEnded = true;
        // Perform actions based on the highest bidder and bid amount
    }
}

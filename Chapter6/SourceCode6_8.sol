// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


// A deploys SecuredHashFinder with 10 ETH
// B runs attemptSolution() with "Werapun" to get _solution
// B submits commit() with _solution (msg.sender & "Werapun")
// C can see _solution of B, (msg.sender & "Werapun") 
// C submits commit() the same _solution of B with higher gas cost to frontrun the transaction
// C failed to reveal() even C submits the correct _solution() with "Werapun"
//    since _solution of the previous hash in the commit stage is created with msg.sender
// C cannot claim ETH, while B can

contract SecuredHashFinder {
    
    struct Commit {
        bytes32 solutionHash;
        uint256 commitTime; 
    }

    // Werapun
    bytes32 public targetHash =
        0x72b7f858dbb0ff500b25e340c20a8d5da685ab5d466fd031d0f7b876217e50d6; 

    address public winner;

    // Status of game
    bool public ended;

    // Mapping to store the commit details with address
    mapping(address => Commit) commits;

    // Modifier to check if the game is active
    modifier gameActive() {
        require(!ended, "Already ended");
        _;
    }
 
    // deposit 10 ETH (msg.value) to SecuredHashFinder when deploying
    constructor() payable {}
 
    // the util function to find _solutionHash 
    function attemptSolution(string memory word) public view returns (bytes32 ) { 
        return keccak256(abi.encodePacked(msg.sender, word));
    }

    /* 
       Commit function to store the calcalted hash from attemptSolution(msg.sender & solution).
       Users can only commit once.
    */
    function commit(bytes32 _solution) public gameActive {
        Commit storage commit1 = commits[msg.sender];
        require(commit1.commitTime == 0, "Already committed");
        commit1.solutionHash = _solution;
        commit1.commitTime = block.timestamp;
    }
 
    /*  
        Reveal the solution to get reward,
        however the previous commit solution, the hash (msg.sender & word) must be matchted.
        even the frontrunner can be the placed transaction in advance, 
        but it still gets hash verification failed due to the msg.sender
    */

    function reveal(string memory _solution)
        public
        gameActive
    {
        Commit storage commit2 = commits[msg.sender];
        require(commit2.commitTime != 0, "Not committed yet");
        require(
            commit2.commitTime < block.timestamp,
            "Cannot reveal in the same block"
        ); 

        bytes32 solutionHash =
            keccak256(abi.encodePacked(msg.sender, _solution));
        
        // The frontrunner will failed in this step due to the different msg.sender
        require(solutionHash == commit2.solutionHash, "Hash doesn't match");

        require(
            keccak256(abi.encodePacked(_solution)) == targetHash, "Incorrect answer"
        );

        winner = msg.sender;
        ended = true;

        (bool sent,) = payable(msg.sender).call{value: address(this).balance}("");
        if (!sent) {
            winner = address(0);
            ended = false;
            revert("Failed to send ether.");
        }
    }
}

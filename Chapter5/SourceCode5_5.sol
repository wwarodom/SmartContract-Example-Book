// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract SimpleVote {
    mapping(string => uint256) public votes;

    function voteForCandidate(string memory candidate) public {
        votes[candidate] += 1;
    }

    function getVotesForCandidate(string memory candidate) public view returns (uint256) {
        return votes[candidate];
    }
}

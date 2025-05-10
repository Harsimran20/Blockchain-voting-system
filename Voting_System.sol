// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVoting {
    address public owner;
    bool public votingOpen;

    struct Candidate {
        string name;
        uint voteCount;
    }

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    constructor(string[] memory candidateNames) {
        owner = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate(candidateNames[i], 0));
        }
        votingOpen = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    modifier voteIsOpen() {
        require(votingOpen, "Voting is closed");
        _;
    }

    function vote(uint candidateIndex) public voteIsOpen {
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");

        candidates[candidateIndex].voteCount++;
        hasVoted[msg.sender] = true;
    }

    function endVoting() public onlyOwner {
        votingOpen = false;
    }

    function getWinner() public view returns (string memory winnerName, uint winnerVotes) {
        require(!votingOpen, "Voting is still open");

        uint maxVotes = 0;
        uint winnerIndex = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerIndex = i;
            }
        }

        return (candidates[winnerIndex].name, maxVotes);
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }
}

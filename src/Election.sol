// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./ElectionErrors.sol";

contract Election is Ownable {
    uint256 public electionEndTime;
    string[] public candidates; //["Vasya","Taska","Basta","Papsha"]
    uint256 maxVotes;
    uint256 leader;
    bool stopped;

    mapping(address => bool) alreadyVoted;
    mapping(uint256 => uint256) candidatsResult;

    modifier validCandidate(uint256 index) {
        require(index < candidates.length, CandidateNotExist(leader));
        _;
    }

    modifier notOwner() {
        require(msg.sender != owner(), OwnerNotAllowed());
        _;
    }

    constructor(string[] memory _candidates) Ownable(msg.sender)  {
        require(_candidates.length > 0, NoAvailableCandidates());
        candidates = _candidates;
    }

    function vote(uint256 _candidateIndex) public validCandidate(_candidateIndex) notOwner {
        require(alreadyVoted[msg.sender] == false, ElectorAlreadyVoted());
        require(block.timestamp < electionEndTime, ElectionIsOver());
        require(stopped == false, VotingIsStopped());

        alreadyVoted[msg.sender] = true;
        candidatsResult[_candidateIndex] += 1;

        if (candidatsResult[_candidateIndex] > maxVotes) {
            maxVotes = candidatsResult[_candidateIndex];
            leader = _candidateIndex;
        }
    }

    function getElectionWinner() public view validCandidate(leader) returns(string memory) {
        require(stopped == true, VotingIsNotStopped());
        require(maxVotes > 0, VotingIsFailed());

        string memory _winner = candidates[leader];
        return _winner;
    }

    function toggleVote() public onlyOwner {
        stopped = !stopped;
    }

    function setElectionTime(uint256 durationInSeconds) public onlyOwner {
        electionEndTime = block.timestamp + durationInSeconds;
    }
}

// Done:
//add maxVotes functionality
//add contract owner
//contract owner can't vote
//add stop voting functionality
//only owner can't stop voting
//HARD
//add electionTime functionality using block.timestamp

/*function getCandidatesList() public view returns (string memory) {
    require(candidates.length > 0, "No available candidates");
    bytes memory output;

    for (uint256 i = 0; i < candidates.length; i++) {
        string memory current = string(abi.encodePacked(Strings.toString(i), " - ", candidates[i], ",  "));
        output = abi.encodePacked(output, current);
    }
    return string(output);
}*/

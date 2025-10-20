// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import "@openzeppelin/contracts/utils/Strings.sol";

contract Election {
    address owner;
    uint256 public electionEndTime;
    string[] candidates; //["Vasya","Taska","Basta","Papsha"]
    uint256 maxVotes;
    uint256 leader;
    bool stopped;

    mapping(address => bool) alreadyVoted;
    mapping(uint256 => uint256) candidatsResult;

    constructor(string[] memory _candidates) {
        require(_candidates.length > 0, NoAvailableCandidates());
        candidates = _candidates;
        owner = msg.sender;
    }

    error ElectorAlreadyVoted();
    error CandidateNotExist(uint256 _number);
    error OwnerCantVote();
    error ElectionIsOver();
    error VotingIsStopped();
    error OnlyOwnerOperation();
    error VotingIsNotStopped();
    error VotingIsFailed();
    error NoAvailableCandidates();

    function vote(uint256 _number) public {
        require(alreadyVoted[msg.sender] == false, ElectorAlreadyVoted());
        require(_number < candidates.length, CandidateNotExist(_number));
        require(msg.sender != owner, OwnerCantVote());
        require(block.timestamp < electionEndTime, ElectionIsOver());
        require(stopped == false, VotingIsStopped());

        alreadyVoted[msg.sender] = true;
        candidatsResult[_number] += 1;

        if (candidatsResult[_number] > maxVotes) {
            maxVotes = candidatsResult[_number];
            leader = _number;
        }
    }

    function getElectionWinner() public view returns(string memory) {
        require(stopped == true, VotingIsNotStopped());
        require(maxVotes > 0, VotingIsFailed());
        require(leader < candidates.length, CandidateNotExist(leader));

        string memory _winner = candidates[leader];
        return _winner;
    }

    function getCandidatesList() public view returns (string memory) {
        require(candidates.length > 0, "No available candidates");
        bytes memory output;

        for (uint256 i = 0; i < candidates.length; i++) {
            string memory current = string(abi.encodePacked(Strings.toString(i), " - ", candidates[i], ",  "));
            output = abi.encodePacked(output, current);
        }
        return string(output);
    }


    function toggleVote() public {
        require(msg.sender == owner, OnlyOwnerOperation());
        stopped = !stopped;
    }

    function setElectionTime(uint256 _electionEndTime) public {
        require(msg.sender == owner, OnlyOwnerOperation());
        electionEndTime = block.timestamp + _electionEndTime;
    }

    // Done:
    //add maxVotes functionality
    //add contract owner
    //contract owner can't vote
    //add stop voting functionality
    //only owner can't stop voting
    //HARD
    //add electionTime functionality using block.timestamp
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
//import "@openzeppelin/contracts/utils/Strings.sol";
import "./ElectionErrors.sol" as Errors;

contract Election is Ownable {
    uint256 public electionEndTime;
    string[] public candidates; //["Vasya","Taska","Basta","Papsha"]
    uint256 maxVotes;
    uint256 leader;
    bool stopped;

    mapping(address => bool) alreadyVoted;
    mapping(uint256 => uint256) candidatsResult;

    modifier validCandidate(uint256 index) {
        _validCandidate(index);
        _;
    }

    modifier notOwner() {
        _notOwner();
        _;
    }

    function _validCandidate(uint256 index) private view {
        require(index < candidates.length, Errors.CandidateNotExist(index));
    }

    function _notOwner() private view {
        require(msg.sender != owner(), Errors.OwnerNotAllowed());
    }

    // Вызов конструктора — это не внешний вызов контракта после деплоя,
    // а часть транзакции деплоя.
    // То есть constructor вызывается не "извне" через ABI, а при создании контракта,
    // поэтому Solidity не разрешает calldata для параметров конструктора
    // (начиная с 0.8.x — только memory можно).
    constructor(string[] memory _candidates) Ownable(msg.sender)  {
        require(_candidates.length > 0, Errors.NoAvailableCandidates());
        candidates = _candidates;
    }

    function vote(uint256 _candidateIndex) public validCandidate(_candidateIndex) notOwner {
        require(alreadyVoted[msg.sender] == false, Errors.ElectorAlreadyVoted());
        require(block.timestamp < electionEndTime, Errors.ElectionIsOver());
        require(stopped == false, Errors.VotingIsStopped());

        alreadyVoted[msg.sender] = true;
        candidatsResult[_candidateIndex] += 1;

        if (candidatsResult[_candidateIndex] > maxVotes) {
            maxVotes = candidatsResult[_candidateIndex];
            leader = _candidateIndex;
        }
    }

    function getElectionWinner() public view validCandidate(leader) returns(string memory) {
        require(stopped == true, Errors.VotingIsNotStopped());
        require(maxVotes > 0, Errors.VotingIsFailed());

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

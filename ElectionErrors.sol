// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

error ElectorAlreadyVoted();
error CandidateNotExist(uint256 _number);
error ElectionIsOver();
error VotingIsStopped();
error VotingIsNotStopped();
error VotingIsFailed();
error NoAvailableCandidates();
error OwnerNotAllowed();

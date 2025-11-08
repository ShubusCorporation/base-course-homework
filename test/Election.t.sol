// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Election} from "../src/Election.sol";

import {
    NoAvailableCandidates,
    CandidateNotExist,
    OwnerNotAllowed,
    ElectorAlreadyVoted,
    ElectionIsOver,
    VotingIsStopped,
    VotingIsNotStopped,
    VotingIsFailed
} from "../src/ElectionErrors.sol";

contract ElectionTest is Test {
    Election public election;
    address owner = makeAddr("owner");
    address voter1 = makeAddr("voter1");
    address voter2 = makeAddr("voter2");

    string[] candidates = ["Alice", "Bob", "Charlie"];

    function setUp() public {
        vm.prank(owner);
        election = new Election(candidates);
    }

    function testConstructorInitializesCandidates() public view {
        assertEq(election.candidates(0), "Alice");
        assertEq(election.candidates(1), "Bob");
        assertEq(election.candidates(2), "Charlie");
    }

    function testRevertOnEmptyCandidatesArray() public {
        string[] memory empty;
        vm.expectRevert(NoAvailableCandidates.selector);
        vm.prank(owner);
        new Election(empty);
    }

    function testVoteWorksCorrectly() public {
        vm.prank(owner);
        election.setElectionTime(1000);

        vm.prank(voter1);
        election.vote(1); // Vote for Bob

        // Bob is winner now (index 1)
        string memory winner;
        vm.prank(owner);
        election.toggleVote(); // Let's stop voting
        winner = election.getElectionWinner();

        assertEq(winner, "Bob");
    }

    function testRevertIfOwnerTriesToVote() public {
        vm.prank(owner);
        election.setElectionTime(1000);

        vm.expectRevert(OwnerNotAllowed.selector);
        vm.prank(owner);
        election.vote(0);
    }

    function testRevertIfVotingTwice() public {
        vm.prank(owner);
        election.setElectionTime(1000);

        vm.prank(voter1);
        election.vote(2);

        vm.expectRevert(ElectorAlreadyVoted.selector);
        vm.prank(voter1);
        election.vote(1);
    }

    function testRevertIfVotingAfterTimeExpired() public {
        vm.prank(owner);
        election.setElectionTime(10);

        vm.warp(block.timestamp + 11); // Out of time

        vm.expectRevert(ElectionIsOver.selector);
        vm.prank(voter1);
        election.vote(1);
    }

    function testRevertIfVotingStopped() public {
        vm.prank(owner);
        election.setElectionTime(1000);

        vm.prank(owner);
        election.toggleVote(); // Let's stop voting

        vm.expectRevert(VotingIsStopped.selector);
        vm.prank(voter1);
        election.vote(1);
    }

    function testSetElectionTimeWorks() public {
        vm.prank(owner);
        election.setElectionTime(300);
        assertEq(election.electionEndTime(), block.timestamp + 300);
    }

    function testToggleVoteTogglesCorrectly() public {
        vm.prank(owner);
        election.toggleVote();
        vm.prank(owner);
        election.toggleVote();
    }

    function testRevertGetWinnerBeforeStop() public {
        vm.prank(owner);
        election.setElectionTime(1000);

        vm.prank(voter1);
        election.vote(1);

        vm.expectRevert(VotingIsNotStopped.selector);
        election.getElectionWinner();
    }

    function testRevertGetWinnerIfNoVotes() public {
        vm.prank(owner);
        election.toggleVote();

        vm.expectRevert(VotingIsFailed.selector);
        election.getElectionWinner();
    }

    function testRevertIfCandidateNotExist() public {
        vm.prank(owner);
        election.setElectionTime(1000);

        vm.expectRevert(abi.encodeWithSelector(CandidateNotExist.selector, 0));
        vm.prank(voter1);
        election.vote(999); // There's no such candidate
    }
}

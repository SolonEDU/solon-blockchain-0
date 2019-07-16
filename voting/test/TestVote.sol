pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Vote.sol";

contract TestVote {
    bytes32 yes = "yes";
    bytes32 no = "no";
    bytes32[] choices = [yes,no];
    Vote ballot = new Vote(choices);

    function testVoting() public {
        ballot.vote(0);
        bytes32 win = ballot.winner_name();
        Assert.equal(yes,win, "Yes should win");
    }

    function testView() public {
        Assert.equal(1,ballot.total_votes(),"total votes is 1");
    }

    function testfirst() public {
        Assert.equal(0,ballot.num_votes(1),"no one voted for no");
    }
}
pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import "./ERC20.sol";

contract Budget is ERC20{

    string public name;
    address creator;
    address admin;
    uint public endTime;
    bool ended;
    uint moneyRequested;

    constructor(string memory _name, uint _moneyRequested, uint _daysAfter) public {
	    name = _name;
        creator = msg.sender;
	    endTime = now + (_daysAfter * 1 days);
        ended = false;
        moneyRequested = _moneyRequested;

        options.push(Option({
        name: "yes",
        vote_count: 0
        }));

        options.push(Option({
        name: "no",git 
        vote_count: 0
        }));
    }

    function voteEnd() public {
        require(now >= endTime);
        require(!ended);

        ended = true;
    }

    function votePass() public {
        // 3. Conditions for Votes
        require((total_votes() >= 10) && (num_votes(0) > total_votes()/2));
        require(msg.sender != creator);

        // 4. Effects
        transferFrom(msg.sender, creator, moneyRequested);
    }

    struct Option {
        bytes32 name;
        uint vote_count;
    }

    struct Voter {
        bool voted;
        address name;
        uint vote_index;
    }

    mapping(address => Voter) public voters;

    Option[] public options;

    function vote(uint option) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote_index = option;

        options[option].vote_count += 1;
    }

    function num_votes(uint option) public view returns(uint num_votes_) {
        num_votes_ = options[option].vote_count;
    }

    function total_votes() public view returns(uint total_votes_) {
        for(uint option = 0; option < options.length; option++) {
            total_votes_ += num_votes(option);
        }
    }
}
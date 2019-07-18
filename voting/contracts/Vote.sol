pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract Vote{
    
    mapping(address => Voter) public voters; 
    Option[] public options;
    uint public end_time;
    bool ended; 

    struct Option {
        bytes32 name;
        uint vote_count;
    }

    struct Voter {
        // uint reputation;
        bool voted;
        address name;
        uint vote_index; //index of option voted for
    }

    function generate_vote(bytes32[] memory choices, uint time_limit) public {
        for(uint i = 0; i < choices.length; i++) {
            options.push(Option({
                name: choices[i],
                vote_count : 0
            }));
        }
        end_time = now + (time_limit * 1 days);
        ended = false;
    }

    function vote(uint option) public {
        Voter storage sender = voters[msg.sender];
        require(now <= end_time, "Vote ended");
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

    function winning_option() public view returns(uint winning_option_) {
        uint winning_vote_count = 0;
        for(uint option = 0; option < options.length; option++) {
            if(num_votes(option) > winning_vote_count) {
                winning_vote_count = num_votes(option);
                winning_option_ = option;
            }
        }
    }

    function winner_name() public view returns (bytes32 winner_name_) {
        winner_name_ = options[winning_option()].name;
    }

    function end_vote() public {
        require(now >= end_time, "vote not ended yet");
        require(!ended, "already ended");
        ended = true;
    }
}
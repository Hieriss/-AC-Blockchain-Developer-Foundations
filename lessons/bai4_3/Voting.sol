// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address public owner;
    uint public candidatesCount;

    struct Candidate {
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;

    mapping(address => bool) public hasVoted;

    event Voted(address indexed voter, uint candidateId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner!");
        _;
    }

    constructor() {
        owner = msg.sender;
    }


    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++; 
        candidates[candidatesCount] = Candidate({
            name: _name,
            voteCount: 0 
        });
    }

    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted!");
        
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID!");

        hasVoted[msg.sender] = true;

        candidates[_candidateId].voteCount++;

        emit Voted(msg.sender, _candidateId);
    }

    function voteETH(uint _candidateId) public payable {
        require(msg.value == 0.000001 ether, "Must send exactly 0.000001 ETH to vote!");
        
        require(!hasVoted[msg.sender], "You have already voted!");
        
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID!");

        hasVoted[msg.sender] = true;

        candidates[_candidateId].voteCount++;

        emit Voted(msg.sender, _candidateId);
    }
}

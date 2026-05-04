// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingEligibility {
    uint public minAge = 18;
    address public owner;

    constructor() {
        owner = msg.sender; 
    }

    function checkEligibility(uint _age) public view returns (bool) {
        if (_age >= minAge) {
            return true;
        } else {
            return false;
        }
    }

    function updateMinAge(uint _newMinAge) public {
        require(msg.sender == owner, "Loi: Ban khong phai la nguoi tao contract!");
        
        minAge = _newMinAge;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Welcome {
    string public greeting;
    address public deployer;

    constructor(string memory _greeting) {
        greeting = _greeting;
        deployer = msg.sender;
    }

    function getGreeting() public view returns (string memory, address) {
        return (greeting, deployer);
    }
}

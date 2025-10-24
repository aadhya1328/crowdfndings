// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdFund {
    address public owner;
    uint public goal;
    uint public totalRaised;

    constructor(uint _goal) {
        owner = msg.sender;
        goal = _goal;
    }

    // Function 1: Allow users to contribute funds
    function contribute() public payable {
        require(msg.value > 0, "Contribution must be greater than zero");
        totalRaised += msg.value;
    }

    // Function 2: Allow owner to withdraw funds if goal is reached
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(totalRaised >= goal, "Goal not reached yet");
        payable(owner).transfer(address(this).balance);
    }

    // Function 3: Check if the goal is reached
    function goalReached() public view returns (bool) {
        return totalRaised >= goal;
    }
}


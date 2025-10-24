// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdFund {
    address public owner;
    uint public goal;
    uint public totalRaised;
    uint public deadline;

    mapping(address => uint) public contributions;

    constructor(uint _goal, uint _durationInDays) {
        owner = msg.sender;
        goal = _goal;
        deadline = block.timestamp + (_durationInDays * 1 days);
    }

    // Function 1: Contribute to the campaign
    function contribute() public payable {
        require(block.timestamp < deadline, "Campaign ended");
        require(msg.value > 0, "Contribution must be greater than zero");
        contributions[msg.sender] += msg.value;
        totalRaised += msg.value;
    }

    // Function 2: Withdraw funds (only if goal reached)
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(totalRaised >= goal, "Goal not reached yet");
        payable(owner).transfer(address(this).balance);
    }

    // Function 3: Check if the goal is reached
    function goalReached() public view returns (bool) {
        return totalRaised >= goal;
    }

    // Function 4: Refund contributors if goal not met and time is over
    function refund() public {
        require(block.timestamp > deadline, "Campaign still active");
        require(totalRaised < goal, "Goal was reached, no refunds");
        uint amount = contributions[msg.sender];
        require(amount > 0, "No contributions to refund");
        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    // Function 5: View individual contribution
    function getContribution(address contributor) public view returns (uint) {
        return contributions[contributor];
    }
}

}


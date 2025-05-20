// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MerchSigningContract {
    address public athlete;
    uint256 public requiredPayment; // in wei
    uint256 public deadline;
    string public merchDescription;
    bool public signed;
    address public buyer;

    event DealInitiated(address buyer, uint256 amount, string merchDescription);
    event SignedMerch(address athlete, string merchDescription, uint256 timestamp);

    constructor(
        uint256 _requiredPayment,
        uint256 _durationInDays,
        string memory _merchDescription
    ) {
        athlete = msg.sender;
        requiredPayment = _requiredPayment;
        merchDescription = _merchDescription;
        deadline = block.timestamp + (_durationInDays * 1 days);
        signed = false;
    }

    function payToSign() external payable {
        require(msg.value >= requiredPayment, "Insufficient payment");
        require(block.timestamp <= deadline, "Deadline passed");
        require(!signed, "Already signed");

        buyer = msg.sender;

        emit DealInitiated(buyer, msg.value, merchDescription);
    }

    function athleteSigns() external {
        require(msg.sender == athlete, "Only athlete can sign");
        require(buyer != address(0), "No buyer yet");
        require(!signed, "Already signed");

        signed = true;
        payable(athlete).transfer(address(this).balance);

        emit SignedMerch(athlete, merchDescription, block.timestamp);
    }

    function cancelAndRefund() external {
        require(msg.sender == buyer, "Only buyer can refund");
        require(block.timestamp > deadline, "Deadline not passed");
        require(!signed, "Already signed");

        signed = true; // prevent reentry
        payable(buyer).transfer(address(this).balance);
    }
}

// SPDX-License-Identifier: MIT

// smart contract that allows anyone to deposit ETH into the crowd_fund contract
// and only the owners can withdraw
pragma solidity ^0.8;

contract CrowdFund{
    address owner;
    string name;
    string description;
    uint balance;

    // mappings
    mapping(string => uint) public userToAmountSent;

    constructor(string memory _name, string memory _description){
        // assigning whoever creates the contract as the owner
        owner = msg.sender;
        name = _name;
        description = _description;
    }


    function fund(string memory _username) public payable {
        // checking to see if the user can send this amount (Based on the sender's balance)
        require(check_balance(msg.sender) >= msg.value, "Insufficient Funds!");
        // checking to make sure something is sent
        require(msg.value >= 5, "That Is Too Low.");

        // updating balance value
        balance += msg.value;
        // mapping sender to amount sent
        userToAmountSent[_username] += msg.value;
    }

    function check_balance(address _address) public view returns (uint){
        return _address.balance;
    }



    // modifiers

    modifier onlyOwner {
        // checking if the message sender is the owner of the contract.
        require(msg.sender == owner, "This Crowd Fund Does Not Belong To You.");
        _;
    }
}
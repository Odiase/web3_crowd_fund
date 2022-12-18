// SPDX-License-Identifier: MIT

// smart contract that allows anyone to deposit ETH into the crowd_fund contract
// and only the owners can withdraw
pragma solidity ^0.8;

contract CrowdFund{
    address owner;

    constructor(){
        // assigning whoever creates the contract as the owner
        owner = msg.sender;
    }
    
}
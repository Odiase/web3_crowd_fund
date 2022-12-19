// SPDX-License-Identifier: MIT

// smart contract that allows anyone to deposit ETH into the crowd_fund contract
// and only the owners can withdraw
pragma solidity ^0.8;

contract CrowdFund{
    // state variables
    address public owner;
    string name;
    bytes32 ownerName;
    string description;
    uint balance;

    // mappings and arrays
    mapping(string => uint) public userToAmountSent;

    string[] public funders;

    // modifiers
    modifier onlyOwner {
        // checking if the message sender is the owner of the contract.
        require(msg.sender == owner, "Only The Owner Can Withdraw Funds.");
        _;
    }



    constructor(string memory _name, string memory _description, bytes32 _ownerName){
        // assigning whoever creates the contract as the owner
        owner = msg.sender;
        name = _name;
        description = _description;
        ownerName = _ownerName;
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
        funders.push(_username);
    }

    function check_balance(address _address) public view returns (uint){
        return _address.balance;
    }

    function withdraw() public payable onlyOwner {
        // transferring all the funds sent to the smart contract to the owner's address
        payable(msg.sender).transfer(address(this).balance);
        balance = 0;

        // setting all the values from funders to zero since all funds have been withdrawn
        for (uint i = 0; i < funders.length; i++){
            userToAmountSent[funders[0]] = 0;
        }
    }

    function numberOfFunders() public view returns (uint) {return funders.length;}
}



// A Contract Factory that creates CrowdFund Contracts
contract CrowdFundFactory{
    // mappings and arrays
    mapping(string => CrowdFund) public nameToCrowdFund;
    mapping(bytes32 => CrowdFund[]) public ownerToCrowdFunds;
    CrowdFund[] public createdCrowdFunds;


    function createCrowdFundContract(string memory _name, string memory _description, bytes32 _ownerName) public {
        // creating new fund me contract
        CrowdFund newCrowdFund = new CrowdFund(_name, _description, _ownerName);

        // adding to maps and creating array
        ownerToCrowdFunds[_ownerName].push(newCrowdFund);
        nameToCrowdFund[_name] = newCrowdFund;
        createdCrowdFunds.push(newCrowdFund);
    }

    function getSingleCrowdFund(string memory _name) public view returns (CrowdFund) {
        require(crowdFundExists(_name), "There Is No CrowdFund With That Name");
        return(nameToCrowdFund[_name]);
    }

    function crowdFundExists(string memory _name) public new_mod view returns (bool) {
        // checking if there is any crowd fund linked to this name
        return abi.encodePacked(nameToCrowdFund[_name]).length > 0 ? true : false;
    }
}
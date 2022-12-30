// SPDX-License-Identifier: MIT

// smart contract that allows anyone to deposit ETH into the crowd_fund contract
// and only the owners can withdraw
pragma solidity ^0.8;

contract CrowdFund{
    // state variables
    address public ownerAddress;
    string public name;
    string public ownerName;
    string public description;
    uint256 public balance;

    // mappings and arrays
    mapping(string => uint) public userToAmountSent;
    mapping(address => bool) public Funded;

    // array
    string[] public funders;

    // modifiers
    modifier onlyOwner {
        // checking if the message sender is the owner of the contract.
        require(msg.sender == ownerAddress, "Only The Owner Can Withdraw Funds.");
        _;
    }

    constructor(string memory _name, string memory _description, string memory _ownerName, address _sender){
        // assigning whoever creates the contract as the owner
        ownerAddress = _sender;
        name = _name;
        description = _description;
        ownerName = _ownerName;
    }


    function fund(string memory _username, uint256 amount, address sender) public payable {
        uint256 leastValue = 256305105597703;

        // checking to make sure something is sent
        require(sender.balance >= leastValue, "This is too little to be sent.");

        // updating balance value
        // uint256 valueInWei = amount ether;
        balance += amount;
        
        // mapping sender to the amount sent
        userToAmountSent[_username] += amount;

        // adding sender to array
        if (Funded[sender] == true){}
        else {
            funders.push(_username);
            Funded[sender] = true;
        }
    }

    function getBalance() public view returns (uint) {
        return balance;
    }

    function getOwner() public view returns (address) {
        return ownerAddress;
    }

    function withdraw(address sender) public payable{
        // checking if transaction sender is the owner of the crowd fund
        require(sender == ownerAddress, "Only The Owner Can Withdraw Funds.");

        // transferring all the funds sent to the smart contract to the owner's address
        balance -= address(this).balance;
        payable(sender).transfer(address(this).balance);

        // setting all the values from funders to zero since all funds have been withdrawn
        for (uint i = 0; i < funders.length; i++){
            userToAmountSent[funders[0]] = 0;
        }
    }

    function getAttributes() public view returns (string memory, string memory, uint256, uint256) {
        return (name, ownerName, balance, numberOfFunders());
    }

    function numberOfFunders() public view returns (uint256) {return funders.length;}
}














// A Contract Factory that creates CrowdFund Contracts and interacts with them

contract CrowdFundFactory{
    // mappings and arrays
    mapping(string => CrowdFund) public nameToCrowdFund;
    mapping(string => CrowdFund[]) public ownerToCrowdFunds;
    CrowdFund[] public createdCrowdFunds;



    function createCrowdFundContract(string memory _name, string memory _description, string memory _ownerName, address _owner_address) public {
        // checking if a crowd fund with this name exists
        require(crowdFundExists(_name) == false, "A Crowd Fund With This Name Already Exists.");

        // creating new CrowdFund contract
        CrowdFund newCrowdFund = new CrowdFund(_name, _description, _ownerName, _owner_address);

        // adding to maps and creating array
        ownerToCrowdFunds[_ownerName].push(newCrowdFund);
        nameToCrowdFund[_name] = newCrowdFund;
        createdCrowdFunds.push(newCrowdFund);
    }

    function getSingleCrowdFund(string memory _name) public view returns (string memory, string memory, uint256, uint256) {
        require(crowdFundExists(_name), "There Is No CrowdFund With That Name");
        CrowdFund crowd_fund = getCrowdFundObject(_name);

        // return data
        return(crowd_fund.getAttributes());
    }

    function getSingleCrowdFundByAddress(address _address) public view returns (string memory, string memory, uint256, uint256) {
        CrowdFund crowd_fund = CrowdFund(address(_address));

        // return data
        return(crowd_fund.getAttributes());
    }

    function getOwnerCrowdFunds(string memory _ownerName) public view returns (CrowdFund[] memory){
        require(ownerExists(_ownerName), "This User Does Not Have Any Crowd Fund.");
        CrowdFund[] memory crowd_funds = ownerToCrowdFunds[_ownerName];
        return crowd_funds;
    }

    function fund(string memory _username, string memory _crowd_fund_name) public payable {
        CrowdFund crowd_fund = getCrowdFundObject(_crowd_fund_name);

        // checking to see if the user can send this amount (Based on the sender's balance)
        require(msg.sender.balance >= msg.value, "sender does not have enough funds");

        // calling the fund function in the crowd fund contract and passing in the username, amount and sender's address
        // as arguments
        crowd_fund.fund{value : msg.value}(_username, msg.value, msg.sender);
    }

    function withdrawBalance(string memory _crowd_fund_name) public payable {
        CrowdFund crowd_fund = getCrowdFundObject(_crowd_fund_name);
        crowd_fund.withdraw(msg.sender);
    }

    function crowdFundBalance(string memory _name) public view returns (uint256) {
        CrowdFund crowd_fund = getCrowdFundObject(_name);
        return crowd_fund.balance();
    }




    // helper functions

    function crowdFundExists(string memory _name) internal view returns (bool) {
        // checking if there is any crowd fund linked to this name
        if (address(nameToCrowdFund[_name]) == 0x0000000000000000000000000000000000000000) {
            return false;
        }
        return true;
        // return abi.encodePacked(nameToCrowdFund[_name]).length > 0 ? true : false;
    }

    function ownerExists(string memory _ownerName) internal view returns (bool) {
        // checking if there is any crowd fund with an owner that has that name
        return abi.encodePacked(ownerToCrowdFunds[_ownerName]).length > 0 ? true : false;
    }

    function getCrowdFundObject(string memory _name) public view returns (CrowdFund) {
         return(CrowdFund(address(nameToCrowdFund[_name])));
    }
}
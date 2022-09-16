// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract PfProjectOne12 {
address owner;

 string public constant name = "Beerus Token"; //Tokens Name
 string public constant symbol = "BRS"; //Tokens Symbol
 uint public totalSupply = 10**10; //Tokens Total Supply
 uint256 public immutable decimals; 
 
 //********Events*******//
    event Transfer(address indexed recipient, address indexed to, uint amount);
 //*******Mapping******//   
    mapping(address=>uint) private balances; //Storing the user's balance in key-Value pair

    constructor() {
        owner = msg.sender;
        balances[msg.sender] = totalSupply;
        decimals = 10;
    } 
//******Modifier*******//
    modifier onlyOwner() {
        require(msg.sender == owner,"You are not the Owner"); //Behavioral Restriction Check
        _;
    }
//*******Checking Balance of Address aka User*******//
    function balanceOf(address user) public view returns(uint){
        return balances[user]; //Return how much tokens the address holds
    }
//*******Token Transfer Function*******//
    function transfer(address reciever, uint amount) public returns(bool){
        require(balances[msg.sender] >= amount,"You dont have enough tokens to transfer"); //Check
        balances[msg.sender] -= amount; // balances[msg.sender] = balances[msg.sender] - amount
        balances[reciever] += amount; //balances[reciever] = balances[reciever] + amount

        emit Transfer(msg.sender,reciever,amount); // Event trigger
        return true;
    }

}


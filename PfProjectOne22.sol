// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract PfProjectOne22 {
address owner;

 string public constant name = "Sponge Bob Token"; //Tokens Name
 string public constant symbol = "SBT"; //Tokens Symbol
 uint public totalSupply = 10**10; //Tokens Total Supply
 uint256 public immutable decimals; 
 
 //*******Mapping******//   
    mapping(address=>uint) private balances; //Storing the user's balance in key-Value pair
    mapping(address=>mapping(address=>uint)) private approved;
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
        require(balances[msg.sender] >= amount,"You don't have enough tokens to transfer"); //Check
        balances[msg.sender] -= amount; // balances[msg.sender] = balances[msg.sender] - amount
        balances[reciever] += amount; //balances[reciever] = balances[reciever] + amount

        emit Transfer(msg.sender,reciever,amount); // Event trigger
        return true;
    }
//Allows a contract to transfer tokens on owner/deployers behalf
    function transferFrom(address _from, address _to, uint _amount) public returns(bool success) {
        uint approvedTokens = approved[_from][msg.sender];
        require(balances[_from] >= _amount && approvedTokens>=_amount);
        balances[_from] -= _amount;
        balances[_to] += _amount;
        approved[_from][msg.sender] -= _amount;

        emit Transfer(_from, _to, _amount);
        return true;
    }
//Allows spender to withdraw from your account multiple times, up to the value amount.
// If this function is called again it overwrites the current allowance with value
    function approval(address spender, uint value) public returns(bool success) {
         approved[msg.sender][spender] = value;
         
         emit Approval(msg.sender,spender,value);
         return true;
    } 

    //Returns the amount which _spender is still allowed to withdraw from _owner
    function allowance(address _owner, address spender) public view returns(uint){
       return approved[_owner][spender];
    }
 
//*******Minting*******//
     function Mint(uint quantity) public onlyOwner returns(uint){
        totalSupply += quantity; //totalSupply = totalSupply + quantity
        balances[msg.sender] += quantity; //balances[msg.sender] = balances[msg.sender] + quantity
        return totalSupply;
    }

    //This function burns the entered amount from the totalSupply
      function burn(address user, uint amount) public onlyOwner returns(uint) {
        require(balances[user] >= amount,"You have enough tokens to burn"); //check
        balances[user] -= amount; // balances[user] = balances[user] - amount
        totalSupply -= amount; //totalSupply = totalSupply - amount
        return totalSupply;
    }


 //********Events*******//
    event Transfer(address indexed recipient, address indexed to, uint amount);
    event Approval(address indexed from, address indexed to, uint amount);
}


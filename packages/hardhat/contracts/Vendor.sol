pragma solidity 0.8.20; //Do not change the solidity version as it negatively impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable{
    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

    YourToken public yourToken;

    // Initialize state variables.
    uint256 public constant tokensPerEth = 100;


    constructor(address tokenAddress) Ownable(msg.sender){
        yourToken = YourToken(tokenAddress);
    }


    // Buy tokens from the contract. 
    function buyTokens() public payable {
        require(msg.sender.balance >= msg.value, "Insufficient balance");
        uint tokens = msg.value * tokensPerEth;

        // Transfer the tokens to the buyer.
        yourToken.transfer(msg.sender, tokens);

        // Trigger an event for the front end.
        emit BuyTokens(msg.sender, msg.value, tokens);
    }


    // Withdraw all ETH from the contract as the owner. 
    function withdraw() public onlyOwner(){
        // Check if the contract has ETH.
        require(address(this).balance > 0, "No ETH in the contract.");

        // Transfer the tokens to the owner. 
        payable(owner()).transfer(address(this).balance);
    }
    

    // Sell tokens back to the contract.
    function sellTokens(uint256 _amount) public {
        uint256 etherAmount = _amount / tokensPerEth;

        require(address(this).balance >= etherAmount, "Vendor contract has insufficient funds");
        require(yourToken.balanceOf(msg.sender) >= _amount, "Insufficient balance");

        // Transfer the tokens to this contract.
        yourToken.transferFrom(msg.sender, address(this), _amount);

        // Transfer the ether to the seller.
        payable(msg.sender).transfer(etherAmount);
    }
}

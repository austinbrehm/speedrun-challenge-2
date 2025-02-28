pragma solidity 0.8.20; //Do not change the solidity version as it negatively impacts submission grading
// SPDX-License-Identifier: MIT

// import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor {
    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

    YourToken public yourToken;

    // Initialize state variables.
    uint256 public constant tokensPerEth = 100;

    constructor(address tokenAddress) {
        yourToken = YourToken(tokenAddress);
    }

    function buyTokens() public payable {
        uint tokens = msg.value * tokensPerEth;
        yourToken.transfer(msg.sender, tokens);

        // Trigger an event for the front end.
        emit BuyTokens(msg.sender, msg.value, tokens);
    }

    // ToDo: create a withdraw() function that lets the owner withdraw ETH

    // ToDo: create a sellTokens(uint256 _amount) function:
}

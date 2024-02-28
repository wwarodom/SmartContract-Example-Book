// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Always input amount in wei (https://eth-converter.com/)
// Simplified conversion rate: 1ETH  = 2 MTK 
// 1. ERC20Token:   mint()        create 10 MTK to UniswapLike
// 2. buyTokens 
//    2.1 UniswapLike: buyTokens()  (msg.value: 1ETH) => 2 MTK
//    2.2 ERC20Token:  balanceOf()   check balanceOf EOA => 2 MTK
// 3. sellTokens
//    3.1 ERC20Token:  approve()    10 MTK for spender (UniswapLike)
//    3.2 ERC20Token:  allowance()  verify approve() between owner(EOA) and spender(UniswapLike)
//    3.3 UniswapLike: sellToken()  amount 1 MTK => 0.5 ETH

contract ERC20Token is ERC20, ERC20Burnable, Ownable {
    constructor(address initialOwner) 
        ERC20("MyToken", "MTK") 
        Ownable(initialOwner)
    {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

contract UniswapLike {
    ERC20Token public token; 
    event TokenPurchased(address indexed buyer, uint256 ethAmount, uint256 tokenAmount);
    event TokenSold(address indexed seller, uint256 ethAmount, uint256 tokenAmount);

    constructor(address tokenAddress) {
        token = ERC20Token(tokenAddress);
    }

    // buy MTK tokens from UniswapLike, and pay ETH to UniswapLike
    function buyTokens() public payable {
        require(msg.value > 0, "Please pay ETH to contract" );
        uint256 ethAmount = msg.value;
        uint256 tokenAmount = ethAmount * 2; 
        require(token.balanceOf(address(this)) >= tokenAmount, "Insufficient token balance");
        token.transfer(msg.sender, tokenAmount);   // send MTK to msg.sender
        emit TokenPurchased(msg.sender, ethAmount, tokenAmount);
    }

    // sell MTK tokens to Uniswap, and get ETH back
    function sellTokens(uint256 tokenAmount) public {
        require(token.balanceOf(msg.sender) >= tokenAmount, "Insufficient token balance");
        uint256 ethAmount = tokenAmount / 2; 
        token.transferFrom(msg.sender, address(this), tokenAmount); 
        payable(msg.sender).transfer(ethAmount);  // send ETH to msg.sender (EOA)
        emit TokenSold(msg.sender, ethAmount, tokenAmount);
    }

    function getContractEthBalance() public view returns (uint256) {
        return address(this).balance; 
    }

    function getContractTokenBalance() public view returns (uint256) {
        return token.balanceOf(address(this));
    }
}

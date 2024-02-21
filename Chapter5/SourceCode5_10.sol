// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ERC20Token {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * (10**uint256(_decimals));
        balances[msg.sender] = totalSupply;
    }
    function transfer(address to, uint256 value) public returns (bool) {
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= value;
        balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
}

contract UniswapLike {
    ERC20Token public token;
    uint256 public ethBalance;

    event TokenPurchased(address indexed buyer, uint256 ethAmount, uint256 tokenAmount);
    event TokenSold(address indexed seller, uint256 ethAmount, uint256 tokenAmount);

    constructor(address tokenAddress) {
        token = ERC20Token(tokenAddress);
    }

    function buyTokens() public payable {
        uint256 ethAmount = msg.value;
        uint256 tokenAmount = ethAmount * 10; // Simplified conversion rate

        require(token.balanceOf(address(this)) >= tokenAmount, "Insufficient token balance");
        token.transfer(msg.sender, tokenAmount);
        ethBalance += ethAmount;

        emit TokenPurchased(msg.sender, ethAmount, tokenAmount);
    }

    function sellTokens(uint256 tokenAmount) public {
        require(token.balanceOf(msg.sender) >= tokenAmount, "Insufficient token balance");
        uint256 ethAmount = tokenAmount / 10; // Simplified conversion rate

        token.transferFrom(msg.sender, address(this), tokenAmount);
        payable(msg.sender).transfer(ethAmount);
        ethBalance -= ethAmount;

        emit TokenSold(msg.sender, ethAmount, tokenAmount);
    }

    function getContractEthBalance() public view returns (uint256) {
        return ethBalance;
    }

    function getContractTokenBalance() public view returns (uint256) {
        return token.balanceOf(address(this));
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721Enumerable, Ownable {
    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    uint256 private tokenIdCounter;

    function mint(address to) public onlyOwner {
        uint256 tokenId = tokenIdCounter;
        tokenIdCounter++;
        _mint(to, tokenId);
    }
}

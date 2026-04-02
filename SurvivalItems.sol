// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SurvivalItems is ERC721Enumerable, Ownable {
    using Strings for uint256;

    // Mapping from token ID to item name
    mapping(uint256 => string) private _itemNames;
    // Maximum number of tokens that can be minted
    uint256 public maxMintable;
    // Count of minted tokens
    uint256 public mintedCount;

    constructor(uint256 _maxMintable) ERC721("SurvivalItem", "ITEM") {
        maxMintable = _maxMintable;
        mintedCount = 0;
    }

    function mint(string memory itemName) external onlyOwner {
        require(mintedCount < maxMintable, "Max minting limit reached!");
        uint256 tokenId = totalSupply() + 1;
        _mint(msg.sender, tokenId);
        _itemNames[tokenId] = itemName;
        mintedCount++;
    }

    function itemName(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "Query for nonexistent token");
        return _itemNames[tokenId];
    }

    function totalItemsMinted() external view returns (uint256) {
        return mintedCount;
    }
}
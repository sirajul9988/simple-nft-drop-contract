// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTDrop is ERC721, Ownable {
    uint256 public constant MAX_SUPPLY = 10000;
    uint256 public constant MINT_PRICE = 0.05 ether;
    uint256 private _totalSupply;
    string private _baseTokenURI;

    constructor(string memory name, string memory symbol, string memory baseURI) 
        ERC721(name, symbol) 
        Ownable(msg.sender) 
    {
        _baseTokenURI = baseURI;
    }

    function mint(uint256 quantity) public payable {
        require(_totalSupply + quantity <= MAX_SUPPLY, "Exceeds max supply");
        require(msg.value >= MINT_PRICE * quantity, "Insufficient ETH sent");

        for (uint256 i = 0; i < quantity; i++) {
            uint256 tokenId = _totalSupply + 1;
            _totalSupply++;
            _safeMint(msg.sender, tokenId);
        }
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory newBaseURI) external onlyOwner {
        _baseTokenURI = newBaseURI;
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
}

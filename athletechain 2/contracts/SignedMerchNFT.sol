// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SignedMerchNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;
    mapping(address => bool) public authorizedSigners;

    constructor() ERC721("SignedMerchNFT", "SMNFT") {}

    function authorizeSigner(address signer) external onlyOwner {
        authorizedSigners[signer] = true;
    }

    function revokeSigner(address signer) external onlyOwner {
        authorizedSigners[signer] = false;
    }

    function mintSignedMerch(address to, string memory tokenURI) external {
        require(authorizedSigners[msg.sender], "Not authorized to mint");

        uint256 tokenId = nextTokenId;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);

        nextTokenId++;
    }
}

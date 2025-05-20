// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SignatureNFT is ERC721URIStorage, Ownable {
    struct Athlete {
        string name;
        bool exists;
    }
    mapping(address => Athlete) public athletes;
    uint256 public nextTokenId;

    event AthleteRegistered(address indexed wallet, string name);
    event NFTMinted(address indexed athlete, address indexed fan, uint256 tokenId, string uri);

    constructor() ERC721("SignatureNFT", "SNFT") {}

    function registerAthlete(address wallet, string memory name) external onlyOwner {
        require(!athletes[wallet].exists, "Already registered");
        athletes[wallet] = Athlete(name, true);
        emit AthleteRegistered(wallet, name);
    }

    function mint(address athlete, address fan, string memory tokenURI) external {
        require(athletes[athlete].exists, "Athlete not registered");
        uint256 tokenId = nextTokenId++;
        _safeMint(fan, tokenId);
        _setTokenURI(tokenId, tokenURI);
        emit NFTMinted(athlete, fan, tokenId, tokenURI);
    }
}

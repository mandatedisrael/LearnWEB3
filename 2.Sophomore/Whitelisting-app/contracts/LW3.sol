// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract LW3NFT is ERC721{
    constructor() ERC721("LW3NFT", "LW3") {
        _mint(msg.sender, 1);
    }
}
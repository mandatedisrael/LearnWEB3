//SPDX-Licence-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IWhitelist.sol";

contract CryptoCave is ERC721, Ownable{
    string _baseToURI;

    // _price of one nft
    uint256 public _price = 0.01 ether;

    //to pause contract incase of any emergency
    bool public _paused;

    //max number of CryptoCaves that can be minted

    uint256 public maxTokenIds = 20;

    //total number of tokensids to be minted
    uint256 public tokenIds;

    //whitelist contract instance
    IWhitelist whitelist;

    //boolean to keep track if presale has started or not
    bool public presaleStarted;

    //timestamp for when presale would end
    uint256 public presaleEnded;

    modifier onlyWhenNotPaused(){
        require(!_paused, "Contract currently paused");
        _;
    }

    constructor (string memory baseURI, address whitelistContract) ERC721("Crypto Cave", "CC"){
        _baseToURI = baseURI;
        whitelist = IWhitelist(whitelistContract);
    }

    function startPresale() public onlyOwner {
        presaleStarted = true;
        //set presaleEnded time as current timestamp + 5minutes
        presaleEnded = block.timestamp + 5 minutes;
    }


    function presaleMint() public payable onlyWhenNotPaused {
        require(presaleStarted && block.timestamp < presaleEnded, " Presale is not running at the moment, check back later");
        require(whitelist.whitelistedAddresses(msg.sender), "You are not whitelisted");
        require(tokenIds < maxTokenIds, "All tokens of Crypto Cave have been minted ");
        require(msg.value >= _price, "Ether sent is not enough to mint a Crypto Cave");
        tokenIds += 1;

        //_safeMint is a safer version of the _mint function as it ensures that
        // if the address being minted to is a contract, then it knows how to deal with ERC721 tokens
        // If the address being minted to is not a contract, it works the same way as _mint
        _safeMint(msg.sender, tokenIds);
    }

     function mint() public payable onlyWhenNotPaused {
        require(presaleStarted && block.timestamp >=  presaleEnded, "Presale has not ended yet");
        require(tokenIds < maxTokenIds, "Exceed maximum Crypto Devs supply");
        require(msg.value >= _price, "Ether sent is not correct");
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseToURI;
    }

    function setPaused (bool val) public onlyOwner {
        _paused = val;
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    //function to receive ether. msg.data must be empty
    receive() external payable {}

    //fallback function is called dwhen msg.data is not empty
    fallback() external payable {}

}
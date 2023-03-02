//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Whitelisting {

    uint8 public maxNumberOfWhitelistedAddresses;

    mapping(address => bool) public whitelistedAddresses;

    uint8 public numAddressesWhitelisted;
    constructor(uint8 _maxNumberOfWhitelistedAddresses) {
        maxNumberOfWhitelistedAddresses = _maxNumberOfWhitelistedAddresses;
        
    }

    function  _addAddressToWhitelist() public {
        //check if the address is already whitelisted
        require(!whitelistedAddresses[msg.sender], "You are already whitelisted");

        //check if the number of whitelisted addresses is less than the max number of whitelisted addresses
        require(numAddressesWhitelisted < maxNumberOfWhitelistedAddresses, "The number of whitelisted addresses is already at the maximum");

        //add the address to the whitelist
        whitelistedAddresses[msg.sender] = true;

        //increment the number of whitelisted addresses
        numAddressesWhitelisted += 1;
    }
        
    }
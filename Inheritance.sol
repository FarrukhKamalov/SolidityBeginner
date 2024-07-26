// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;




contract Ownable {
    address owner;

    modifier onlyOwner(){
        require(msg.sender == owner, "Owner emassiz!");
        _;
    }

    constructor()  {
        owner = msg.sender;
    }
}


contract SecretVault {
    string secret;
    constructor(string memory _secret)  {
        secret = _secret;
    }

    function getSecret() public view returns(string memory) {
        return secret;
    }
}

contract MyContract is Ownable {
    // internhance
    // factories
    // interaction

    address secretVault;

    constructor(string memory _secret) {
        SecretVault _secretVault = new SecretVault(_secret);
        secretVault = address(_secretVault);
        super;
    }

    function getSecret() public view onlyOwner returns(string memory) {
        return SecretVault(secretVault).getSecret();
    }

    
}
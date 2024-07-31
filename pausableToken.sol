// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PausableToken {
    address public owner;
    bool public paused;
    mapping(address => uint) public balances;

    constructor ()  {
        owner = msg.sender;
        paused = false;
        balances[owner] = 1000;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Owner emassiz!");
        _;
    }

    modifier notPaused() {
        require(paused == false, "Contract pauseda");
        _;
    }

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }

    function transfer( address to, uint amount) public  notPaused{
        require(balances[msg.sender] >= amount, "Mablag yetarli emas!");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
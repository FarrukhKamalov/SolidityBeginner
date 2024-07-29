// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;




contract MultiplayerGame {
    mapping(address => bool) public players;

    function joinGame() public virtual {
        players[msg.sender] = true;
    }
}


contract Game is MultiplayerGame {
    string public gameName;
    uint256 public playerCount;

    constructor(string memory _gameName) {
        gameName = _gameName;
        playerCount = 0;
    }

    function startGame() public {
        
    }

    function joinGame() public override {
        super.joinGame();
        playerCount++;
    }
}
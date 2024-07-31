// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventExample {

    event NewUserRegistered(address indexed user, string username);

    struct User {
        string username;
        uint256 age;
    }

    mapping(address => User) public users;

    function registerUser(string memory _username, uint256 _age) public {
        User storage newUser = users[msg.sender];
        newUser.username = _username;
        newUser.age = _age;

        emit NewUserRegistered(msg.sender, newUser.username);
    }
}
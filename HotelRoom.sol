// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract HotelRoom {
    enum Statuses {
        Vacant,
        Occupied
    }
    Statuses public currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier checkPrice(uint _amount) {
        require(msg.value >= _amount, "Mablag yetarli emas.");
        _;
    }

    modifier checkStatus() {
        require(currentStatus == Statuses.Vacant, "Hona bo'sh emas!");
        _;
    }

    function book() public payable checkStatus checkPrice(2 ether) {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);

        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(true, "Tranzaksiya amalga oshmadi!");
        emit Occupy(msg.sender, msg.value);
    }
}

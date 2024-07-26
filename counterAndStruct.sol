// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint count;

    constructor() {
        count = 0;
    }

    function getCount() public view returns (uint){
         return count;
    }

    function incrementCount() public {
        count++;
    }

    function decrementCount() public {
        count = count - 1;
    }



    struct MyStruct {
        string firstName;
        address userAddress;
    }


    MyStruct public mystruct = MyStruct("Farrukh", 0x882F55ca0818cDc527b82Edf150F24b778fA0416);
}
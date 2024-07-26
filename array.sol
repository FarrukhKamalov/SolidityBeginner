// SPDX-License-Identifier: MIT

contract MyContract {
    uint8[] public uintArray = [1,2,3,5,8,11,19,30,49,79,138];
    string[] public stringArray = ["Apple", "Banana", "Potato"];

    string[] public myArray;



    function addValue(string memory _value) public {
        myArray.push(_value);
    }

    function getValues( ) public view returns (string[] memory){
        return myArray;
    }


    function stringArrayCount() public view returns (uint) {
        return stringArray.length;
    }
}
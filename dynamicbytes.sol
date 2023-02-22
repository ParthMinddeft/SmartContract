// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract dynamicbyte {
    bytes public temp;
 
    constructor()
    { 
        temp = "123abcd4567";
    }
 
    function pushElement() public {
        temp.push('c');
    }

    function popElement() public {
        temp.pop();
    }

    function getlength() public view returns(uint) {
        return temp.length;
    } 

    function getElement(uint _idx) public view returns(bytes1)
    {
        return temp[_idx];
    }  
}
// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract State 
{
    // state variable //store in blockchain //saved in contract storage
    // cost gas
    uint public age;  
    uint public name;
    /*constructor() public
    {
        age = 10;
    }*/
    function setAge() public 
    {
        age = 10;
    }
}
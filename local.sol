// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract local //stored in stack
{
    string name = "Parth"; //state variable
    function store() pure public returns(uint) 
    // pure function is used for no any changes in state variable and read the data
    // string variable by default stored in storage
    // dont cost gas
    {
        string memory name = "Parth";
        uint age = 10; //stored in stack // local variable
        return age;
    }
}
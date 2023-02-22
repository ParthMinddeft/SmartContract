// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract demo
{
    struct Student
    {
         string name;
         string addr;
    }
    mapping(uint=>Student) public data;

    function setter(uint _roll,string memory _addr,string memory _name) public
    {
        data[_roll]=Student(_name,_addr);
    }
}
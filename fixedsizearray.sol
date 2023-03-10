// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract array
{
    uint[4] public arr = [10,20,30,40];

    function setter(uint index,uint value) public 
    {
        arr[index]=value;
    }

    function length() public view returns(uint)
    {
        return arr.length;
    }
}
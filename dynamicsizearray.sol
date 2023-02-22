// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract array
{
    uint[] public arr;

    function pushelement(uint item) public
    {
        arr.push(item);
    }

    function len() public view returns(uint)
    {
        return arr.length;
    }

    function pop() public
    {
        arr.pop();
    }
}
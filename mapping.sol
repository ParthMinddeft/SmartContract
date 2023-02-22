// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract demo
{
    mapping(uint=>string) public roll_no;

    function setter(uint keys,string memory value) public
    {
        roll_no[keys]=value;
    }
}
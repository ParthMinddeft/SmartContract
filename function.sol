// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract local
{
    /*uint public age = 10;

    function setter() public
    {
        age++;
    }*/

    uint age = 10;

    function getter() public view returns(uint)
    {
        return age;
    }

    function setter(uint newage) public 
    {
        //age = age+1;
        age = newage;
    }
}
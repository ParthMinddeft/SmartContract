// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract allfunction {
    uint public age = 20;

    function viewfunction() public view returns(uint)
    {
        return age;
    }

    function purefunction() public pure returns(uint)
    {
        return 1;
    }

    function purefunctionn(uint _x) public pure returns(uint)
    {
        return _x;
    }

    function simple() public {
        age = age + 10;
    }

    function dummy() public view returns(uint){
        return age + 10;
    }
}

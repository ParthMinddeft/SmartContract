// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract A {
    uint public x = 100;
    address public owner = msg.sender;

    function f1() public pure returns(string memory)
    {
        return "hello a1";
    }
    function f2() public pure returns(string memory)
    {
        return "hello a2";
    }
    function f3() public pure virtual returns(string memory)
    {
        return "hello a3";
    }
    function f4() public pure virtual returns(string memory)
    {
        return "hello a4";
    }
}

contract B is A {
    function f3() public pure virtual override returns(string memory)
    {
        return "hello b3";
    }
    function f4() public pure override returns(string memory)
    {
        return "hello b4";
    }
}

contract C is B {
    function f3() public pure override returns(string memory)
    {
        return "hello c3";
    }
}
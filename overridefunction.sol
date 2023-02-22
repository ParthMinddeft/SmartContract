// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract A {
    uint public a;

    constructor()
    {
        a = 100;
    }

    function funA() public {
        a = 10;
    }

    function fun() public pure virtual returns(string memory)
    {
        return "hi i am in a";
    }
}

contract B is A{
    uint public b;

    constructor()
    {
        b = 120;
    }

    function funB() public {
        b = 20;
    }

    function fun() public pure virtual override returns(string memory)
    {
        return "hi i am in b";
    }
}

contract C is A,B {
    function fun() public pure override(A,B) returns(string memory)
    {
        return "hi i am in b";
    }
}
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
}

contract C is A,B {

}
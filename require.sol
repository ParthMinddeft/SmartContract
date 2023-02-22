// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract Require {
    address public s1 = msg.sender;
    uint public age = 10;

    function check(uint _Z) public {
        age = age + 5;
        require(_Z>2,"data is less than two");
    }

    function onyowner() public {
        require(s1==msg.sender,"you are note the owner");
        age = age-2;
    }
}
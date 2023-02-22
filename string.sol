// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract stringvalue {
    string public str = "parth";

    function data(string memory _str1) public pure returns(string memory){
        string memory name = _str1;
        return name;
    }
}
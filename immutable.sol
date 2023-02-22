// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract Immutable {
    
    address public immutable owner;
    address public constant ownertwo = address(1);
    address public owner3 = address(1);

    constructor(address _owner) {
        owner = _owner;
    } 

    function I() public view returns(address)
    {
        return owner;
    }

    function C() public pure returns(address)
    {
        return ownertwo;
    }

    function S() public view returns(address)
    {
        return owner3;
    }
}
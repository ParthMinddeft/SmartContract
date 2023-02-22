// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract cons
{
    uint public count;

    constructor(uint new_count)
    {
        count = new_count;
    }
}
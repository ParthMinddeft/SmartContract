// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract fallbackreceive {

    // fallback() external payable{

    // }

    receive() external payable{

    }

    function checkbalance() public view returns(uint) {
        return address(this).balance;
    }
}
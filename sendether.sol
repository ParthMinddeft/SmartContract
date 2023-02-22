// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract ethers
{
    function receiveETH() public payable{
        
    }

    function getbalance() public view returns(uint){
        return address(this).balance;
    }

    function transfer(address payable add, uint amt) public {
        add.transfer(amt);
    } 
}
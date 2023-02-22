// tests/ERC1155.sol
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.9;

contract nfttradesell {
    mapping(address => mapping(uint256 => list)) public listing;
    mapping(address => uint256) public balances;
    struct list {
        uint256 price;
        address seller;
    }

    function addlist(uint256 price, address contractadd, uint256 tokenId) public {
        ERC1155 token = ERC1155(contractadd);
        require(token.balanceOf(msg.sender,tokenId) > 0, "caller must own given token");
        require(token.isApprovedForAll(msg.sender,address(this)),"contract must be approved");
        listing[contractadd][tokenId] = list(price,msg.sender);
    }

    function purchase(address contractadd, uint256 tokenId, uint256 amount) public payable {
        list memory item = listing[contractadd][tokenId];
        require(msg.value >= item.price * amount, "insufficient funds sent");
        balances[item.seller] += msg.value;
        ERC1155 token = ERC1155(contractadd);
        token.safeTransferFrom(item.seller,msg.sender,tokenId,amount,"");
    }

    function withdraw(uint256 amount, address payable destaddr) public {
        require(amount <= balances[msg.sender], "insufficient funds");
        destaddr.transfer(amount);
        balances[msg.sender] -= amount;
    }
}



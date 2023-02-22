// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Mytoken is ERC1155 { //0x1526e25801cE1320D09EEA54E7617cC90B4F4398
    uint256 public constant POKEMON = 1;

    constructor() public ERC1155("https://ipfs.io/ipfs/QmQRQV64YMrfRgn1NJpBm5MfB8cuaQZJtAQzvciNTtz6nm")
    {
        _mint(msg.sender, POKEMON , 100 , "");
    }

    function uri(uint256 _tokenId) override public view returns (string memory) {
        return string(
            abi.encodePacked("https://ipfs.io/ipfs/QmRAoKdHgTYhuXwX9ekkr748LfJY1FDJbr7gTdWHn81qXZ?filename=code.json",
            Strings.toString(_tokenId),
            '.json'
            )
        );
    }
}
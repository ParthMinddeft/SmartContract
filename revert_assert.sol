// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract Require {
    address public s1 = msg.sender;
    uint public age = 10;

    error throwError(string,address);//custom error

    function check(uint _Z) public {
        age = age + 5;
        require(_Z>2,"data is less than two");
    }

    function checkdata(uint _Z) public {
        age = age + 5;

        if(_Z<2)
        {
            //revert("data is less than two");
            revert throwError("data is less than two",msg.sender);
        }
    }

    function onyowner() public {
        require(s1==msg.sender,"you are note the owner");
        if(s1!=msg.sender)
        {
            revert("you are not the owner");
        }
        age = age-2;
    }

    function checkowner() public view{
        assert(s1==0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    }
}
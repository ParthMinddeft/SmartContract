// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract example
{
    int public difference;
    int public sum;
    int public numberone;
    int public numbertwo;
    int public answer;

    function getdetails(int _numberone,int _numbertwo) public {
        numberone = _numberone;
        numbertwo = _numbertwo;
    }

    function differences() public {
        difference = numberone - numbertwo;
        if(difference < 0)
        {
            answer = difference + 1;
        }
        else
        {
            answer = difference + 10;
        }
    }

    function sums() public {
        sum = numberone + numbertwo;
        if(sum > 50)
        {
            answer = sum + 5;
        }
        else
        {
            answer = sum + 8;
        }
    }
} 
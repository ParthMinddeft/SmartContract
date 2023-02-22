// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract data
{
    struct Student
    {
        uint grade;
        string name;
        string course;
        string subject;
    }
    mapping(uint=>Student) public dataMap;

    function getdetails(uint _roll,uint _grade,string memory _name,string memory _course) public
    {
        dataMap[_roll] = Student(_grade,_name,_course,'');
        Student storage sto = dataMap[_roll];
        if(sto.grade > 50)
        {
            sto.subject = "rust";
        }
        else
        {
            sto.subject = "solidity";
        }
    }
}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Teacher {
   string name;
   constructor(string memory _name)  public {
       name = _name;
   }
}

contract ComputerTeacher is Teacher {
   string department;
   constructor(string memory _name, string memory _department)  Teacher(_name) public {
       department = _department;
   }
   function showDetails() public view returns (string memory, string memory) {
       return (name, department);
   }
}

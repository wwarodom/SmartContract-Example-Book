// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// can inherit from other interfaces
interface ILine {
   function distance(uint x1, uint x2) external returns (uint);
}
interface IShape is ILine {
   // uint constant public x = 5;   cannot declare variable
   // no virtual keyword required,
   //                 must be external only
   function area(uint side) external pure returns (uint) ;
}

// Can extend interface (or not extend)
// visibility must be equal to or greater than the virtual function
contract Square is IShape { 

  // public or external only, virtual/override is implicit
  function area(uint side) public pure returns (uint){
      return side**2;
   }
   
   function distance(uint x1, uint x2) external override pure returns (uint) {
       return (x2>x1)?x2-x1:x1-x2;  // assume y = 0
   }
}

contract TestSquare {
 Square immutable square;
 constructor(address _square) {
     square = Square(_square);
 }

 // call from constructor
 function area1(uint x) public view returns (uint) {  
     return square.area(x);
 }

  // directly call (pure function, less gas)
 function area2(address _square, uint x) public pure returns (uint) {
     return Square(_square).area(x);
 }

 function line1(address _square, uint x1, uint x2) public pure returns (uint) {
     return Square(_square).distance(x1,x2);
 }
}

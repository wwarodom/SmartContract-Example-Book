// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Hello {
   string message = "Hello world";
   int myInt =3;
   bool myBool = false;
   bytes myByte = 'B';   

   struct myStruct {
       uint ax;
       string bx;
   }

   mapping( uint => myStruct ) public myMap;
   mapping( uint => mapping(address => myStruct)) public myMap2;

   function setMyMap()  public  {
       myStruct memory ms;
       ms = myStruct(1,"Foo");
       myMap[0] = ms;
       myMap[9] = myStruct(9,"Bar");
       myMap2[0][msg.sender] = myStruct(2,"New");  // 2D associate array
   }

   function getMyMap2() public view returns (uint, string memory  ) {
       return (myMap2[0][msg.sender].ax, myMap2[0][msg.sender].bx);
   }
}
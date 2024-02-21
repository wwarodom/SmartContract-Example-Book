// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

abstract contract Animal {
   function move() external pure virtual returns (uint); //abstract function

   function sound() external pure returns (string memory) {
       return "Woof";
   }
}

contract Bird is Animal {
   function move() external pure override returns (uint) {
       return 10;
   }
}

contract TestBird {
   Bird bird = new Bird();
   // Animal animal = new Animal(); // cannot instantiate
   function birdMove() external view returns (uint) {
       return bird.move();
   }
   function birdSound() external view returns (string memory) {
       return bird.sound();
   }
}

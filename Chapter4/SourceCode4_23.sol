// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Parent {
  event Log(string );
  string internal str = "Hello";  // public internal private (no external)
  // for visibility: private internal, external, public
  function foo()  internal pure returns (uint) { return 1; }
  function foo(uint a)  internal  pure returns (uint) { return a;}
  function bar() virtual  public  {
      foo(); // cannot execute with external
      foo(3);
      emit Log("Parent");
  }
}
contract Child is Parent {
  Parent p = new Parent();
  // Child ch = new Child();  // cannot instantiate

  function bar() override  public {
      // foo();    // doesn't work with internal,internal work when override
      emit Log("Child");
  }

  function baz() public {
      bar();    // call child contract
      this.bar();  // call child contract
       p.bar();    // call parent contract
       super.bar(); // call parent contract      
  }
}

// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract EnumExample {
  enum DAYS { MON, TUE }
  
  function showEnum() external view returns (DAYS) {
      return DAYS.TUE; // return uint 1
  }  
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract MemoryStorageExample {
    uint[] public number  = [1,2,3];

    function showNumber() public returns (uint, uint)  {
        uint[] storage st_num = number;
        st_num[1] = 4;

        uint[] memory mm_num  = number;
        mm_num[2] = 5;
        return (st_num[1], mm_num[2]);
    }
}

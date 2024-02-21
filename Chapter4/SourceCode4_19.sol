// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Callee {
    event log(string mesg);

    fallback() external payable {
        emit log("fallback() is called");
    }

    function foo() external {
        emit log("foo() is called");
    }
}

contract Caller {
    function call2foo(address _callee) public {
        (bool success, ) = _callee.call(abi.encodeWithSignature("foo()"));
    }

    function call2fallback(address _callee) public {
        (bool success, ) = _callee.call(
                             abi.encodeWithSignature("nonExistingFunction()"));
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract PaymentExample {
    event PaymentReceived(address sender, uint256 amount);
    function makePayment() public payable {
        emit PaymentReceived(msg.sender, msg.value);
    }
}

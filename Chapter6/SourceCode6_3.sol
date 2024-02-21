function withdraw(uint _amount) public {
    require(balances[msg.sender] >= _amount);
    require(_amount <= WITHDRAWAL_LIMIT);   // Checks
    require(block.timestamp >= lastWithdrawTime[msg.sender] + 1 weeks);

    // Effects - Update state first
    balances[msg.sender] -= _amount;
    lastWithdrawTime[msg.sender] = block.timestamp;

    // Interactions - Perform external interactions after state updates
    (bool sent, ) = msg.sender.call{value: _amount}("");
    require(sent, "Failed to send Ether");
}

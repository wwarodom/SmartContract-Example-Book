// … Modify EtherStore contract …

function withdraw() public {
   uint bal = balances[msg.sender];

   // Checks
   require(bal > 0);               

   // Effects - Update state first
    balances[msg.sender] = 0;
        
   // Interactions - Perform external interactions after state updates
   (bool sent, ) = msg.sender.call{value: bal}("");
   require(sent, "Failed to send Ether"); 
}

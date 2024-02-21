modifier onlyOwner {
    require(msg.sender == owner, "Only the contract owner can call this function");
    _; // This underscore represents the original function's code
}
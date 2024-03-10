// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/UniswapV3Flash.sol";

contract UniswapV3FlashTest is Test {
    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    uint24 constant POOL_FEE = 3000;

    IWETH private weth = IWETH(WETH);
    IERC20 private usdc = IERC20(USDC);

    UniswapV3Flash private uni = new UniswapV3Flash(USDC, WETH, POOL_FEE);

    function setUp() public {}

    function testFlash() public {
        // Approve WETH fee
        weth.deposit{value: 1e18}();
        weth.approve(address(uni), 1e18);

        uint256 balBefore = weth.balanceOf(address(this));
        console.log("Balance before flash:", balBefore/1e17); // 1 eth
        uni.flash(0, 100 * 1e18);                            // borrow 0 USDC, 100 WETH
        uint256 balAfter = weth.balanceOf(address(this));
        console.log("Balance after flash:", balAfter/1e17);  // 0.7 eth

        uint256 fee = balBefore - balAfter;
        console.log("WETH fee", fee/1e17);          // 0.3 eth
    }
}
 
// forge test -vv --gas-report --fork-url https://eth-mainnet.g.alchemy.com/v2/<<ALCHEMY_API_KEY>> --match-path test/UniswapV3Flash.t.sol

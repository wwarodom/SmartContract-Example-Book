// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract UniswapV3Flash {
    address private constant FACTORY =
        0x1F98431c8aD98523631AE4a59f267346ea31F984;

    event log(string , uint);

    struct FlashCallbackData {
        uint256 amount0;
        uint256 amount1;
        address caller;
    }

    IERC20 private immutable token0;
    IERC20 private immutable token1;

    IUniswapV3Pool private immutable pool;

    constructor(address _token0, address _token1, uint24 _fee) {
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
        pool = IUniswapV3Pool(getPool(_token0, _token1, _fee));
    }

    function getPool(address _token0, address _token1, uint24 _fee)
        public
        pure
        returns (address)
    {
        PoolAddress.PoolKey memory poolKey =
            PoolAddress.getPoolKey(_token0, _token1, _fee);
        return PoolAddress.computeAddress(FACTORY, poolKey);
    }

    function flash(uint256 amount0, uint256 amount1) external {
        bytes memory data = abi.encode(
            FlashCallbackData({
                amount0: amount0,
                amount1: amount1,
                caller: msg.sender
            })
        );
        IUniswapV3Pool(pool).flash(address(this), amount0, amount1, data);
    }

    function uniswapV3FlashCallback(
        uint256 fee0,
        uint256 fee1,
        bytes calldata data
    ) external {
        require(msg.sender == address(pool), "not authorized");

        FlashCallbackData memory decoded = abi.decode(data, (FlashCallbackData));
       
        // Put your business logic here with 100 WETH before repay
        emit log("decode.amount0",decoded.amount0); // amount0 = 0      USDC
        emit log("decode.amount1",decoded.amount1); // amount1 = 100e18 WETH
        emit log("fee0: ",fee0);                    // fee0 = 0
        emit log("fee1: ",fee1);                    // fee1 = 3e17

        // Repay borrow
        if (fee0 > 0) {
            token0.transferFrom(decoded.caller, address(this), fee0);
            token0.transfer(address(pool), decoded.amount0 + fee0);
        }
        if (fee1 > 0) {
            token1.transferFrom(decoded.caller, address(this), fee1);
            token1.transfer(address(pool), decoded.amount1 + fee1);
        }
    }
}

library PoolAddress {
    bytes32 internal constant POOL_INIT_CODE_HASH =
        0xe34f199b19b2b4f47f68442619d555527d244f78a3297ea89325f843f87b8b54;

    struct PoolKey {
        address token0;
        address token1;
        uint24 fee;
    }

    function getPoolKey(address tokenA, address tokenB, uint24 fee)
        internal
        pure
        returns (PoolKey memory)
    {
        if (tokenA > tokenB) (tokenA, tokenB) = (tokenB, tokenA);
        return PoolKey({token0: tokenA, token1: tokenB, fee: fee});
    }

    function computeAddress(address factory, PoolKey memory key)
        internal
        pure
        returns (address pool)
    {
        require(key.token0 < key.token1);
        pool = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            hex"ff",
                            factory,
                            keccak256(
                                abi.encode(key.token0, key.token1, key.fee)
                            ),
                            POOL_INIT_CODE_HASH
                        )
                    )
                )
            )
        );
    }
}

interface IUniswapV3Pool {
    function flash(
        address recipient,
        uint256 amount0,
        uint256 amount1,
        bytes calldata data
    ) external;
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount)
        external
        returns (bool);
}

interface IWETH is IERC20 {
    function deposit() external payable;
    function withdraw(uint256 amount) external;
}

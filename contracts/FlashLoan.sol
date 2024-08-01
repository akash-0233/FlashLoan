// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "./interfaces/IUniswapV2Factory.sol";
import "./interfaces/IUniswapV2Pair.sol";
import "./interfaces/IUniswapV2Router01.sol";
import "./interfaces/IUniswapV2Router02.sol";
import "./interfaces/IERC20.sol";

import "./libraries/SafeERC20.sol";
import "./libraries/UniswapV2Library.sol";

contract FlashLoan {
    address private constant PANCAKE_FACTORY =
        0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73; 
    address private constant PANCAKE_ROUTER =
        0x10ED43C718714eb63d5aA57B78B54704E256024E;

    // Token Addresses
    address private constant BUSD = 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56;
    address private constant WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    address private constant CROX = 0x2c094F5A7D1146BB93850f629501eB749f6Ed491;
    address private constant CAKE = 0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82;

    uint256 private deadline = block.timestamp + 1 days;
    uint256 private constant MAX_INT = 115792089237316195423570985008687907853269984665640564039457584007913129639935;


        // Initiate Arbitrage

        function initiateArbitrage (address _busdBorrow, uint _amount){
            IERC20(BUSD).safeApprove(address(PANCAKE_ROUTER), MAX_INT);
            IERC20(CROX).safeApprove(address(PANCAKE_ROUTER), MAX_INT);
            IERC20(CAKE).safeApprove(address(PANCAKE_ROUTER), MAX_INT);

            address pair = IUniswapV2Factory(PANCAKE_FACTORY).getPair(_busdBorrow, WBNB);
            require(pair != address(0), "Pool does not exist");

            address token0 = IUniswapV2Pair(pair).token0();
            address token1 = IUniswapV2Pair(pair).token1();


            uint amount0Out = _busdBorrow == token0?_amount:0;
            uint amount1Out = _busdBorrow == token1?_amount:0;
            IUniswapV2Pair(pair).swap(amount0Out, amount1Out, to, data);
        }

        // Pancake Call

        // Trade
}
 
// SPDX-License-Identifier: GPL-3.0
// Strangecoin ICO

// version of the compiler
pragma solidity ^0.8.7;

contract Strangecoin_ico {

    // Introducing maximum number of Strangecoins available for sale.
    uint public max_strangecoins = 1000000;

    // Introducing the USD to Strangecoins conversion rate.
    uint public usd_to_strangecoins = 1000;

    // Introducing the total number of Strangecoins that have been bought by the investors.
    uint public total_strangecoins_bought = 0;

    // Mapping from the investor address to its equity in Strangecoins and USD.
    mapping(address => uint) equity_strangecoins;
    mapping(address => uint) equity_usd;

    // Checking if an investor can buy Strangecoins
    modifier can_buy_strangecoins(uint usd_invested) {
        require (usd_invested * usd_to_strangecoins + total_strangecoins_bought <= max_strangecoins);
        _;
    }

    // Getting the equity in Stangecoins of an investor.
    function equity_in_strangecoins(address investor) external view returns(uint) {
        return equity_strangecoins[investor];
    }

    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external view returns(uint) {
        return equity_usd[investor];
    }

    // Buying Strangecoins
    function buy_strangecoins(address investor, uint usd_invested) external
    can_buy_strangecoins(usd_invested) {
        uint strangecoins_bought = usd_invested * usd_to_strangecoins;
        equity_strangecoins[investor] += strangecoins_bought;
        equity_usd[investor] = equity_strangecoins[investor] / 1000;
        total_strangecoins_bought += strangecoins_bought;
    }

    // Selling Stangecoins
    function sell_strangecoins(address investor, uint strangecoins_sold) external {
        equity_strangecoins[investor] -= strangecoins_sold;
        equity_usd[investor] = equity_strangecoins[investor] / 1000;
        total_strangecoins_bought -= strangecoins_sold;
    }
}
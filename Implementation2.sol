// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./Implementation1.sol";

contract Implementation2 is Implementation1 {

    
    function _burn(uint amount) private returns(uint burnableToken){
    }

    function calculateBurn(uint amount) public pure returns(uint burn){
      burn = (amount * 10)/100;
    }

}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

import "./Proxible.sol";

contract Implementation1 is ERC20("EIP-1822", "EIPI"), Proxiable {
    
    address public owner;
    bool public initialized = false;
    string tokenName;
    string tokenSymbol;

    modifier onlyOwner() {
      require(owner == msg.sender, "No permission except to owner");
      _;
    }

    function initialize() public {
        _mint(address(this), 1000e18);
        require(owner == address(0), "Already initalized");
        owner = msg.sender;
        initialized = true;
        tokenName = "EIP-1822";
        tokenSymbol = "EIPI";
    }

   function name() public view virtual override returns (string memory) {
        return tokenName;
    }

    function symbol() public view virtual override returns (string memory) {
        return tokenSymbol;
    }
    
    function encodeer() public pure returns(bytes memory){
        return abi.encodeWithSignature("initialize()");
    }

    function mintToken(uint amount, address _to) public onlyOwner {
       _mint(_to, amount);
    }

    function transferOut(address sendTo,uint amountOut) public onlyOwner {
      uint contractBal = balanceOf(address(this));
      require(sendTo != address(0), "You cant transfer to address 0");
      require(contractBal >= amountOut, "Insufficient funds!");
     _transfer(address(this), sendTo, amountOut);
    }

    function updateCode(address newCode) onlyOwner public {
        updateCodeAddress(newCode);
    }
}
pragma solidity 0.4.24;

import "node_modules/openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

contract SatolepCoin is IERC20 {

  uint256 private initial_supply = 10000000000;
  uint256 private total_supply = initial_supply;
  address public deployer;

  mapping (address => uint256) users;

  constructor() public {
    deployer = msg.sender;
  }

  function totalSupply() public view returns (uint256) {
    return total_supply;
  }

  function balanceOf(address who) public view returns (uint256) {
    uint256 balance = users[who];
    return balance;
  }

  function allowance(address owner, address spender) public view returns (uint256) {

  }

  function transfer(address to, uint256 value) public returns (bool) {
    require(total_supply >= value, "Only can transfer if system has the ammount of tokens");
    total_supply = total_supply - value;
    users[to] = users[to] + value;

    emit Transfer(this, to, value);

    return true;
  }

  /**
   *
   */
  function approve(address spender, uint256 value) public returns (bool) {
    if (users[spender] >= value) {
      return true;
    }
    return false;
  }

  function transferFrom(address from, address to, uint256 value) public returns (bool) {
    require(users[from] >= value, "Only can transfer if the participant has the ammount of tokens");

    users[from] = users[from] - value;
    users[to] = users[to] - value;

    emit Transfer(from, to, value);

    return true;
  }
}
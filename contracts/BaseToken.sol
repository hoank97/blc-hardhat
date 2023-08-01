// SPDX-License-Identifier: MIT

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.19;

contract Token {
    string public name = "HoaNK";
    string public symbol = "HNK";
    uint8 public decimals = 18;
    uint256 public totalSupply = 100;
    address public owner;

    // A mapping is a key/value map. Here we store each account's balance.
    mapping(address => uint256) balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Mint(address indexed minter, uint256 value);
    event Burn(address indexed bunner, uint256 value);

    constructor() {
        balances[msg.sender] = totalSupply * (10 ** decimals);
        owner = msg.sender;
    }

    function mint(uint256 value) public {
        require(msg.sender == owner);
        totalSupply += value * (10 ** decimals);
        balances[msg.sender] += value * (10 ** decimals);
        emit Mint(msg.sender, value);
    }

    function burn(uint256 value) public {
        require(balances[msg.sender] >= value, "Insufficient balance");
        totalSupply -= value * (10 ** decimals);
        balances[msg.sender] -= value * (10 ** decimals);
        emit Burn(msg.sender, value);
    }

    function transfer(address to, uint256 amount) external {
        require(
            balances[msg.sender] >= amount * (10 ** decimals),
            "Not enough tokens"
        );

        balances[msg.sender] -= amount * (10 ** decimals);
        balances[to] += amount * (10 ** decimals);

        // Notify off-chain applications of the transfer.
        emit Transfer(msg.sender, to, amount);
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}

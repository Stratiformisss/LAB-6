// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LOLToken {
    string public name = "LOLToken"; // Указываем наименование токена
    string public symbol = "LOL"; // Указываем символ токена
    uint8 public decimals = 8; // Указываем количество десятичных чисел
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 value);

    constructor() {
        // Здесь не требуется указывать владельца контракта, поскольку любой адрес может вызывать функцию mint
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(_value <= allowance[_from][msg.sender], "Allowance exceeded");
        
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    
    function mint(address to, uint256 value) public returns (bool success) {
        // В этой версии контракта нет ограничения, кто может выпускать токены и сколько максимально
        require(to != address(0), "Invalid address");
        totalSupply += value * 10**decimals;
        balanceOf[to] += value * 10**decimals;
        emit Mint(to, value * 10**decimals);
        return true;
    }
}

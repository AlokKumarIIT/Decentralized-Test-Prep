// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestPrepToken is ERC20 {
    address public owner;

    mapping(address => uint256) public studentScores;

    event TokensRewarded(address indexed student, uint256 amount);

    constructor() ERC20("TestPrepToken", "TPT") {
        owner = msg.sender;
        _mint(msg.sender, 1000000 * 10 ** 18);  
    }

    
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    
    function recordScore(address student, uint256 score) public onlyOwner {
        require(score > 0, "Score must be greater than zero");

        studentScores[student] = score;

       
        uint256 tokensToMint = score * 10 ** 18; 
        _mint(student, tokensToMint);

        emit TokensRewarded(student, tokensToMint);
    }

 
    function getStudentScore(address student) public view returns (uint256) {
        return studentScores[student];
    }
}

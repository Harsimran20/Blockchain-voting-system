# 🗳️ SimpleVoting Smart Contract

A minimal decentralized voting system built with Solidity. It allows users to vote for predefined candidates, ensures one vote per address, and displays the winner after voting ends.

---

## 📌 Features

- ✅ Owner-controlled voting session
- ✅ Add multiple candidates at deployment
- ✅ One vote per address (enforced)
- ✅ Publicly viewable winner after voting ends
- ✅ View all candidates and vote counts

---

## 🛠️ Contract Details

- **Language**: Solidity ^0.8.0  
- **Deployer**: Becomes contract `owner`  
- **Voting State**: Controlled by `votingOpen`  
- **Security**: Only owner can end voting  
- **Storage**:
  - `Candidate[] candidates` — list of candidates
  - `mapping(address => bool) hasVoted` — tracks who has voted

---

## 🚀 How to Use

### 1. Deploy on Remix
- Open [Remix IDE](https://remix.ethereum.org/)
- Paste the contract code in a `.sol` file.
- Compile with Solidity ^0.8.0
- Deploy using JavaScript VM / Injected Provider (MetaMask)
- Input candidate names (e.g., `["Alice", "Bob", "Charlie"]`)

### 2. Voting
- Call `vote(index)` from different addresses (select different Remix accounts)
- Each account can vote once
- Voting remains open until the owner calls `endVoting()`

### 3. Ending the Vote
- Only the contract owner can call `endVoting()`
- Once ended, `votingOpen = false`

### 4. Get the Winner
- Call `getWinner()`
- Returns the name and votes of the leading candidate

---

## 📦 Functions Overview

| Function | Access | Description |
|----------|--------|-------------|
| `constructor(string[] memory candidateNames)` | Public | Initializes candidates |
| `vote(uint candidateIndex)` | Public | Votes for a candidate |
| `endVoting()` | Owner only | Ends the voting session |
| `getWinner()` | Public | Returns the winner (name & votes) |
| `getCandidates()` | Public | Returns all candidates and their vote counts |

---

## ✅ Example

```solidity
// Vote for candidate at index 1 (e.g., "Bob")
simpleVoting.vote(1);

// End voting (must be contract owner)
simpleVoting.endVoting();

// Get the winner
(string memory name, uint votes) = simpleVoting.getWinner();

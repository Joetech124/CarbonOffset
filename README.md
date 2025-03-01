# CarbonOffset: Decentralized Climate Action Protocol

A blockchain-based system for transparent carbon offsetting and climate action.

## Overview

CarbonOffset is a decentralized protocol that enables individuals and organizations to contribute to climate action initiatives through a transparent and verifiable system. Built on the Stacks blockchain using Clarity smart contracts, it provides a way to track carbon offset contributions and calculate their environmental impact over time.

## Features

- Contribute tokens to carbon offset initiatives
- Automatic impact calculation based on contribution time
- Proportional distribution of environmental impact credits
- Transparent tracking of all contributions
- Verifiable proof of climate action participation

## Smart Contract Functions

### Core Functions

- `activate`: Initialize the CarbonOffset program with a steward
- `contribute`: Add tokens to the carbon offset vault
- `calculate-impact`: Calculate the environmental impact generated over time
- `claim-credits`: Withdraw contributed tokens along with earned impact credits

### Error Codes

- `100`: Caller is not the program steward
- `101`: Program already activated
- `102`: Contribution amount must be greater than zero
- `103`: No time has elapsed since last calculation
- `104`: No contributions available to claim

## Data Structures

The contract tracks:

- Program steward address
- Total carbon vault balance
- Impact multiplier rate (environmental impact generated per block)
- Last calculation block height
- Mapping of contributor balances

## Technical Details

The system calculates environmental impact based on three key factors:

1. Time elapsed (in blockchain blocks)
2. Impact multiplier (configurable parameter)
3. Proportional contribution amount

When contributors claim their credits, they receive their original contribution plus a proportional share of the newly generated environmental impact, calculated based on their percentage of the total vault.

## Getting Started

1. Clone this repository
2. Install Clarinet for local development
3. Run tests to verify functionality
4. Deploy to testnet for public testing

# SocialVault

## Next-Generation Creator Economy Protocol on Bitcoin

[![Stacks](https://img.shields.io/badge/Built%20on-Stacks-purple)](https://stacks.co)
[![Bitcoin](https://img.shields.io/badge/Secured%20by-Bitcoin-orange)](https://bitcoin.org)
[![Clarity](https://img.shields.io/badge/Language-Clarity-blue)](https://clarity-lang.org)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

## Overview

SocialVault is a comprehensive decentralized protocol that revolutionizes creator monetization through Bitcoin-secured smart contracts. Built on Stacks L2, it combines algorithmic reputation systems, NFT-based memberships, and microtransaction rewards to create a sustainable creator economy.

## Key Features

- **Dynamic Reputation System**: Time-decay algorithms reward consistent engagement
- **NFT Membership Tiers**: Progressive benefits through tokenized memberships
- **Creator Monetization**: Direct tipping with built-in engagement rewards
- **Community Governance**: Tokenized reputation certificates for voting rights
- **Treasury Management**: Automated reward distribution and emergency controls
- **Bitcoin Security**: Inherits Bitcoin's finality through Stacks L2

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                          SocialVault Protocol                   │
├─────────────────────────────────────────────────────────────────┤
│  Frontend Applications  │  API Layer  │  Analytics Dashboard   │
├─────────────────────────────────────────────────────────────────┤
│                     Smart Contract Layer                        │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  │
│  │  User Profiles  │  │  Creator Engine │  │  NFT Contracts  │  │
│  │  • Reputation   │  │  • Monetization │  │  • Membership   │  │
│  │  • Engagement   │  │  • Rewards      │  │  • Reputation   │  │
│  │  • History      │  │  • Settings     │  │  • Metadata     │  │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘  │
├─────────────────────────────────────────────────────────────────┤
│                        Stacks Blockchain                        │
│  • Clarity Smart Contracts  • STX Transactions  • Block Time    │
├─────────────────────────────────────────────────────────────────┤
│                        Bitcoin Network                          │
│  • Final Settlement  • Security Model  • Proof of Transfer     │
└─────────────────────────────────────────────────────────────────┘
```

## Contract Architecture

### Core Components

#### 1. User Management System

- **User Profiles**: Reputation tracking, engagement history, earnings
- **Creator Settings**: Monetization parameters, reward distribution
- **Profile Initialization**: Onboarding with starting reputation

#### 2. Reputation Engine

- **Dynamic Scoring**: Time-based decay mechanism (24-hour cycles)
- **Engagement Rewards**: Points for tips, likes, shares, comments
- **Reputation Bounds**: Maximum score limits and validation
- **Activity Tracking**: Last activity timestamps for decay calculation

#### 3. NFT Ecosystem

- **Reputation NFTs**: Certificates for achievement milestones
- **Membership NFTs**: Tiered access with progressive benefits
- **Metadata Storage**: On-chain attributes and ownership records
- **Minting Controls**: Threshold-based qualification system

#### 4. Monetization Layer

- **Direct Tipping**: STX transfers with reputation rewards
- **Engagement Incentives**: Creator-configurable reward mechanisms
- **Treasury Management**: Automated fund distribution
- **Fee Structure**: Minimum tip amounts and transaction costs

## Data Flow

### User Engagement Flow

```
User Action → Validation → Reputation Update → Reward Processing → Event Logging
     │              │              │                 │               │
     │              │              │                 │               └─→ Engagement History
     │              │              │                 └─→ STX Transfer (if applicable)
     │              │              └─→ Profile Update + Activity Timestamp
     │              └─→ Spam Prevention + Cooldown Check
     └─→ Authentication + Contract State Check
```

### Creator Monetization Flow

```
Tip Received → Amount Validation → STX Transfer → Reputation Boost → Engagement Reward
     │               │                 │              │                    │
     │               │                 │              │                    └─→ Creator Rewards
     │               │                 │              └─→ +100 Reputation Points
     │               │                 └─→ Direct Payment to Creator
     │               └─→ Minimum Amount Check (1 STX)
     └─→ Sender ≠ Recipient Validation
```

### NFT Minting Flow

```
Mint Request → Eligibility Check → Tier Calculation → NFT Creation → Metadata Storage
     │              │                   │                │              │
     │              │                   │                │              └─→ On-chain Metadata
     │              │                   │                └─→ NFT Contract Interaction
     │              │                   └─→ Reputation-based Tier Assignment
     │              └─→ Reputation Threshold + Existing NFT Check
     └─→ User Authentication + Contract State
```

## Getting Started

### Prerequisites

- Node.js 16+
- Stacks CLI
- Clarinet (for local development)

### Installation

```bash
# Clone the repository
git clone https://github.com/your-org/socialvault.git
cd socialvault

# Install dependencies
npm install

# Install Clarinet
curl -L https://github.com/hirosystems/clarinet/releases/download/v1.0.0/clarinet-linux-x64.tar.gz -o clarinet.tar.gz
tar -xzf clarinet.tar.gz
sudo mv clarinet /usr/local/bin/
```

### Local Development

```bash
# Initialize Clarinet project
clarinet new socialvault-local
cd socialvault-local

# Add the contract
clarinet contract install

# Run tests
clarinet test

# Check contract syntax
clarinet check
```

### Deployment

```bash
# Deploy to testnet
clarinet deploy --network testnet

# Deploy to mainnet
clarinet deploy --network mainnet
```

## Contract Interface

### Key Functions

#### User Functions

- `initialize-user-profile()` - Create new user profile
- `tip-creator(creator, amount)` - Send STX tip to creator
- `engage-with-creator(creator, type)` - Record engagement activity
- `mint-reputation-certificate()` - Mint reputation NFT
- `mint-membership-certificate()` - Mint membership NFT

#### Creator Functions

- `setup-creator-profile(threshold, reward)` - Initialize creator settings
- `update-creator-settings(threshold, reward)` - Modify monetization parameters
- `toggle-creator-status()` - Enable/disable creator mode

#### Read-Only Functions

- `get-user-profile(user)` - Retrieve user data
- `get-current-reputation(user)` - Calculate current reputation with decay
- `get-membership-tier(tier-id)` - Get tier information
- `calculate-tier-for-reputation(reputation)` - Determine tier eligibility

### Error Codes

- `ERR-UNAUTHORIZED (u100)` - Access denied
- `ERR-ALREADY-EXISTS (u101)` - Duplicate resource
- `ERR-NOT-FOUND (u102)` - Resource not found
- `ERR-INSUFFICIENT-BALANCE (u103)` - Insufficient funds
- `ERR-INVALID-AMOUNT (u104)` - Invalid transaction amount
- `ERR-COOLDOWN-ACTIVE (u107)` - Spam prevention active

## Security Features

### Access Control

- Owner-only administrative functions
- User-specific profile management
- Creator-specific monetization controls

### Economic Security

- Minimum tip amounts (1 STX)
- Reputation decay mechanisms
- Engagement cooldown periods
- Maximum reputation caps

### Emergency Controls

- Contract pause/unpause functionality
- Emergency fund withdrawal
- Treasury balance monitoring

## Governance

### Membership Tiers

- **Bronze** (1,000+ reputation): Basic access
- **Silver** (2,000+ reputation): Enhanced access + exclusive content
- **Gold** (5,000+ reputation): Premium access + governance rights
- **Platinum** (8,000+ reputation): Full access + revenue sharing

### Reputation Mechanics

- Starting reputation: 100 points
- Tip giving: +50 points
- Tip receiving: +100 points
- Engagement activities: +25-50 points
- Decay period: 24 hours (144 blocks)

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Testing

```bash
# Run all tests
clarinet test

# Run specific test
clarinet test tests/reputation_test.ts

# Generate coverage report
clarinet test --coverage
```

## Documentation

- [API Reference](docs/api.md)
- [Integration Guide](docs/integration.md)
- [Security Audit](docs/security.md)
- [Deployment Guide](docs/deployment.md)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.\

## Roadmap

### Phase 1

- ✅ Core reputation system
- ✅ NFT membership tiers
- ✅ Creator monetization
- ✅ Smart contract deployment

### Phase 2

- 🔄 Frontend application
- 🔄 Mobile app development
- 🔄 Creator dashboard
- 🔄 Analytics platform

### Phase 3

- ⏳ Cross-chain integration
- ⏳ Advanced governance features
- ⏳ Institutional creator tools
- ⏳ Revenue sharing protocols

---

**Built with ❤️ on Bitcoin via Stacks**

# arc-crowdfund-hub

Crowdfunding campaigns with USDC goal and refund if not met

## Built for Arc Blockchain

- **Chain ID:** 5042002
- **RPC:** https://rpc.testnet.arc.network
- **Explorer:** https://testnet.arcscan.app
- **Gas Token:** USDC (6 decimals)

## Smart Contract: CrowdfundHub

### Features
- `createCampaign()`
- `contribute()`
- `finalize()`
- `refund()`
- `deposit()` — Deposit USDC into the contract
- `withdrawAll()` — Owner withdraws all USDC

## Development

```bash
cd contracts
forge install
forge build
forge test -vv
```

## Deploy to Arc Testnet

```bash
cd contracts
forge create src/CrowdfundHub.sol:CrowdfundHub \
  --rpc-url https://rpc.testnet.arc.network \
  --private-key $PRIVATE_KEY \
  --constructor-args 0x3600000000000000000000000000000000000000 \
  --legacy
```

## License

MIT

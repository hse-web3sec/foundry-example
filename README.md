## Foundry

```sh
forge install

# testing
forge test --match-contract MyTokenTest
forge test --match-test test_Name

# fork-testing
forge test --match-test test_Fork --fork-url https://ethereum.public.blockpi.network/v1/rpc/public
forge script CounterScript --rpc-url https://ethereum.public.blockpi.network/v1/rpc/public

# local script for anvil
anvil
forge script CounterScript --rpc-url 127.0.0.1:8545 --broadcast
```
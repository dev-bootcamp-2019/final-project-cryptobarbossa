1. Reentrancy on a Single Function:
   This contract does not store any balances so we are safe from any malicious withdrawal attempts.

2. Cross-function Reentrancy:
   Just like the single function reentrancy, we are safe from transfer and withdrawal attacks.

3. Integer Overflow and Underflow:
   I have used the SafeMath.sol Library and implemented value checks that make sure we dont pass on values that over or under exceed the limitations.

4. DoS with (Unexpected) revert:
   The smart contract does not come into a situation where a DOS will be present on the contract or will affect contract functionality.

5. DoS with Block Gas Limit:
   Same as the unexpected revert DoS, we are not in a position to be attacked by these methods.

6. Call Depth Attack
   This attack is deprecated due to protocol changes and will not be present in any smart contract.

Decisions made for the project:

The project is designed to allow any ethereum participant to engage with an external autonomous Artificial agent that assists in task automation via Visual navigation. Currently the agents are operation on Instagram and can assist your account in getting engagement without real users spending hours on the site.

Priority was to get everything working and making sure the agent was interacting appropriatly with the Ethereum network.

IPFS Usage:

1. This project frontend is deployed on the IPFS network AND on a normal server. So feel free to try both versions. Addresses to both versions will be provided in the README.md file.

Design Pattern USED:

1. Circuit Breaker: allows for the contract to stop any engagement with the Agents if anything were to happen. The emergency is activated by the owner of the contract only.

Design Pattern NOT used:

1. Speed bumps: There was no reason for implementing any slow delays on the contract as the contract itself will not be in such a situation to benefit from this.

2. Rate limiting: No hard reason to implement this as the priority is to connect potential user and agent. Perhaps a funding contract in the future can be implemented with specific withdraws where rate limiting can be implemented.

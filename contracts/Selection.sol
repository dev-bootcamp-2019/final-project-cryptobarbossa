pragma solidity 0.5.0;

contract Selection {
  // Model a Agent
  struct Agent {
    uint id;
    string name;
    bool busy;
  }

  // Store accounts that have voted
  mapping(address => bool) public engagers;
  // Store Agents
  // Fetch Agent
  mapping(uint => Agent) public agents;
  // Store Agents Count
  uint public agentsCount;

  // voted event
  event engagedEvent (
  uint indexed _agentId
  );

  constructor () public {
    addAgent("0x45539C89A9836399C45C3a8c0F01e8ae4EB43dFD");
    addAgent("ETH_agent_2");
    addAgent("ETH_agent_3");
    addAgent("ETH_agent_4");
  }

  function addAgent (string memory _name) private {
    agentsCount ++;
    agents[agentsCount] = Agent(agentsCount, _name, false);
  }

  function engage (uint _agentId) public {
    // require that they haven't engaged before
    require(!engagers[msg.sender], "Already engaged.");

    // require a valid agent
    require(_agentId > 0 && _agentId <= agentsCount, "Incorrect ID");

    // record that user is engaging with agent
    engagers[msg.sender] = true;

    // update agent Count
    agents[_agentId].busy = true;

    // trigger engagement event
    emit engagedEvent(_agentId);
  }

  function () external payable {
    // payable contract
  }
}

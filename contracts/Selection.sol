pragma solidity 0.5.0;

contract Selection {
  // Model a Agent
  struct Agent {
    uint256 id;
    string name;
    address payable agentAddress;
    bool busy;
  }

  // Store accounts that have voted
  mapping(address => bool) public engagers;

  // Store Agents
  // Fetch Agent
  mapping(uint256 => Agent) public agents;

  // Store Agents Count
  uint256 public agentsCount;

  // voted event
  event engagedEvent (
  uint256 indexed _agentId
  );

  constructor () public {
    // TODO: uncomment below for rinkeby testnet
    // addAgent("0x45539C89A9836399C45C3a8c0F01e8ae4EB43dFD");
    // addAgent("ETH_agent_2");
    // addAgent("ETH_agent_3");
    // addAgent("ETH_agent_4");

    // For testing we will use the Ganache network
    addAgent("consensys.influencer", 0x838574D3AB509D87430b49460e2bA326bbE51B77);
    // addAgent("consensys.influencer", 0x838574D3AB509D87430b49460e2bA326bbE51B77);
    // addAgent("consensys.influencer", 0x838574D3AB509D87430b49460e2bA326bbE51B77);
    // addAgent("consensys.influencer", 0x838574D3AB509D87430b49460e2bA326bbE51B77);
  }

  function addAgent (string memory username, address payable _agentAddress) private {
    agentsCount ++;
    agents[agentsCount] = Agent(agentsCount, username , _agentAddress, false);
  }

  function engage (uint256 _agentId) public payable {
    // require that they haven't engaged before
    require(!engagers[msg.sender], "Already engaged.");

    // require a valid agent
    require(_agentId > 0 && _agentId <= agentsCount, "Incorrect ID");

    // require user sent enough eth payment
    require(msg.value >= 0.01 ether, "Not enough ETH sent. Minimum ETH required: 0.01");

    // record that user is engaging with agent
    engagers[msg.sender] = true;

    // update agent Count
    agents[_agentId].busy = true;
    agents[_agentId].agentAddress.transfer(msg.value);
    // trigger engagement event
    emit engagedEvent(_agentId);
  }

  // function engage (uint256 _agentId) public {
  //   // require that they haven't engaged before
  //   require(!engagers[msg.sender], "Already engaged.");

  //   // require a valid agent
  //   require(_agentId > 0 && _agentId <= agentsCount, "Incorrect ID");

  //   // record that user is engaging with agent
  //   engagers[msg.sender] = true;

  //   // update agent Count
  //   agents[_agentId].busy = true;
  //   // trigger engagement event
  //   emit engagedEvent(_agentId);
  // }

  function () external payable {
    // payable contract
    // if(msg.value >= minimumPayment){
    //   for(uint256 i = 0; i < agentsCount; i++){
    //     if(){
    //       engage();
    //     }
    //   }
    // }
  }
}

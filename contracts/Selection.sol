pragma solidity 0.5.0;

contract Selection {

    /* set owner */
  address public owner;

  // Model a Agent
  struct Agent {
    uint256 id;
    string name;
    address payable agentAddress;
    bool busy;
  }

  // Store accounts that have engaged
  mapping(address => bool) public engagers;

  // Store Agents
  // Fetch Agent
  mapping(uint256 => Agent) public agents;

  // Store Agents Count
  uint256 public agentsCount;

  // voted event
  event engagedEvent (uint256 indexed _agentId);

  event DisputeResolved(uint256 indexed _agentId);

  constructor () public {
    owner = msg.sender;
    // TODO: uncomment below for rinkeby testnet
    // addAgent("0x45539C89A9836399C45C3a8c0F01e8ae4EB43dFD");
    // addAgent("ETH_agent_2");
    // addAgent("ETH_agent_3");
    // addAgent("ETH_agent_4");

    // For testing we will use the Ganache network
    addAgent("consensys.influencer", 0xE5d210b3EC941C71C20096Dde60eE0e6dB74C0cC);
    // addAgent("consensys.influencer", 0x838574D3AB509D87430b49460e2bA326bbE51B77);
    // addAgent("consensys.influencer", 0x838574D3AB509D87430b49460e2bA326bbE51B77);
    // addAgent("consensys.influencer", 0x838574D3AB509D87430b49460e2bA326bbE51B77);
  }

  function addAgent (string memory username, address payable _agentAddress) public onlyOwner {
    agentsCount ++;
    agents[agentsCount] = Agent(agentsCount, username , _agentAddress, false);
  }

  modifier paidEnough () {
    // require minimum payment.
    require(msg.value >= 0.01 ether, "Not enough ETH sent. Minimum ETH required: 0.01");
    _;
  }

    modifier paidEnoughLocal () {
    // require minimum payment.
    require(msg.value >= 1, "Not enough ETH sent. Minimum ETH required: 0.01");
    _;
  }

  modifier userAlreadyAssigned () {
    // require that user has not engaged already.
    require(engagers[msg.sender] == false, "User already engaged with another agent.");
    _;
  }

  modifier validAgent (uint256 _agentId) {
    // require a valid agent
    require(_agentId > 0 && _agentId <= agentsCount, "Incorrect ID");
    _;
  }

  modifier onlyOwner {
    require(msg.sender == owner, "Only owner allowed access.");
    _;
  }

  function engage (uint256 _agentId) public payable paidEnough() userAlreadyAssigned() validAgent(_agentId) {
    // record that user is engaging with agent
    engagers[msg.sender] = true;

    // update agent Count
    agents[_agentId].busy = true;
    agents[_agentId].agentAddress.transfer(msg.value);
    // trigger engagement event
    emit engagedEvent(_agentId);
  }

  // Used to test contract functionality. 
  function engageLocal (uint256 _agentId) public payable paidEnoughLocal() validAgent(_agentId) {
    // record that user is engaging with agent
    engagers[msg.sender] = true;

    // update agent Count
    agents[_agentId].busy = true;
    agents[_agentId].agentAddress.transfer(msg.value);
    // trigger engagement event
    emit engagedEvent(_agentId);
  }

  /* Mimick example of a dispute between a buyer and agent. */
  function resolveDispute (uint256 _agentId) public onlyOwner returns (bool) {
    agents[_agentId].busy = false;
    // trigger resolved event
    emit DisputeResolved(_agentId);
    return true;
  }

  function fetchAgent (uint256 _agentId) public view returns (uint256 id, string memory name, address payable agentAddress, bool busy) {
    id = agents[_agentId].id;
    name = agents[_agentId].name;
    agentAddress = agents[_agentId].agentAddress;
    busy = agents[_agentId].busy;
    return (id, name, agentAddress, busy);
  }

  // Allow contract to receive ether
  function () external payable {}
}

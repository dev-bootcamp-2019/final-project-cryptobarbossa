pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Selection.sol";

contract TestSelection {

  // Initial Ether balance
  uint public initialBalance = 30 ether;

  // Proxy assignments
  Selection public selection;
  Proxy public agent;
  Proxy public buyer;

  uint256 agentId = 1;
  string agentName = "consensys.influencer";
  address payable agentAddress = 0xE5d210b3EC941C71C20096Dde60eE0e6dB74C0cC;
  bool isBusy = false;

  // Fake price and agent data
  uint256 fakeAgentId = 120;
  uint256 fakePrice = 7;

  // Model a Agent
  struct Agent {
    uint256 id;
    string name;
    address payable agentAddress;
    bool busy;
  }

  // Before each func
  function beforeEach () public {
    selection = new Selection();

    agent = new Proxy(address(selection));

    buyer = new Proxy(address(selection));

    uint256 fund = 1;

    address(buyer).transfer(fund);

    selection.addAgent(agentName, agentAddress);
  }

  // Test access modifier with custom function
  function testOnlyOwnerModifier () public {
    (bool res,) = buyer.resolveDispute(agentId);

    Assert.isFalse(res, "Dispute can only be resolved by owner.");

    bool resOwner = selection.resolveDispute(agentId);

    Assert.isTrue(resOwner, "Dispute can only be resolved by owner.");
  }

  // Test to check if agent is available
  function testAgentAvailable () public {

    uint256 _id;
    string memory _name;
    address payable _agentAddress;
    bool _busy;

    (_id, _name, _agentAddress, _busy) = selection.fetchAgent(agentId);

    Assert.equal(_id, agentId, "Expected id");
    Assert.equal(_name, agentName, "Expected name");
    Assert.equal(_agentAddress, agentAddress, "Expected address");
    Assert.equal(_busy , isBusy, "Expected to NOT be busy");
  }

  // Test to check if user can buy package from non-existing agent
  function testBuyPackageWrongAgent () public {
    (bool res,) = buyer.engage(fakeAgentId, 0.01 ether);

    Assert.isFalse(res, "Fake agent ID needed as input");
  }

  // Test to check if user can buy package from existing agent
  function testBuyPackageCorrectAgent () public {
    // (bool res,) = buyer.engageLocal(agentId, 1000000000000000000);
    (bool res,) = buyer.engageLocal(agentId, 1);

    Assert.isTrue(res, "Package purchase failed.");
  }

  // Test to check if user can buy package from existing agent
  function testBuyPackageWrongPrice () public {
    (bool res,) = buyer.engage(agentId, 0.0001 ether);

    Assert.isFalse(res, "Package purchase failed.");
  }

  // Allow this contract to receive ether
  function () external payable {}

}

// Proxy contract
contract Proxy {
  address public target;

  constructor (address _target) public {
    target = _target;
  }

  // Allow contract to receive ether
  function () external payable {}

  function getTarget () public view returns (address) {
    return target;
  }

  function resolveDispute (uint256 _agentId) public returns (bool, bytes memory) {
    return address(target).call(abi.encodeWithSignature("resolveDispute(uint256)", _agentId));
  }

  function engage (uint256 _agentId, uint256 offer) public returns (bool, bytes memory) {
    return address(target).call.value(offer)(abi.encodeWithSignature("engage(uint256)", _agentId));
  }
  
  function engageLocal (uint256 _agentId, uint256 offer) public returns (bool, bytes memory) {
    return address(target).call.value(offer)(abi.encodeWithSignature("engageLocal(uint256)", _agentId));
  }
}
App = {
  web3Provider: null,
  contracts: {},
  account: "0x0",
  hasEngaged: false,

  init: function() {
    return App.initWeb3();
  },

  initWeb3: function() {
    // TODO: refactor conditional
    if (typeof web3 !== "undefined") {
      // If a web3 instance is already provided by Meta Mask.
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      // Specify default instance if no web3 instance provided
      App.web3Provider = new Web3.providers.HttpProvider(
        "http://localhost:7545"
      );
      web3 = new Web3(App.web3Provider);
    }
    return App.initContract();
  },

  initContract: function() {
    $.getJSON("Selection.json", function(selection) {
      // Instantiate a new truffle contract from the artifact
      App.contracts.Selection = TruffleContract(selection);
      // Connect provider to interact with contract
      App.contracts.Selection.setProvider(App.web3Provider);

      App.listenForEvents();

      return App.render();
    });
  },

  // Listen for events emitted from the contract
  listenForEvents: function() {
    App.contracts.Selection.deployed().then(function(instance) {
      // Restart Chrome if you are unable to receive this event
      // This is a known issue with Metamask
      // https://github.com/MetaMask/metamask-extension/issues/2393
      instance
        .engagedEvent(
          {},
          {
            fromBlock: 0,
            toBlock: "latest"
          }
        )
        .watch(function(error, event) {
          console.log("event triggered", event);
          // Reload when a new engagement is recorded
          App.render();
        });
    });
  },

  render: function() {
    var selectionInstance;
    var loader = $("#loader");
    var content = $("#content");

    loader.show();
    content.hide();

    // Load account data
    web3.eth.getCoinbase(function(err, account) {
      if (err === null) {
        App.account = account;
        $("#accountAddress").html("Your Account: " + account);
      }
    });

    // Load contract data
    App.contracts.Selection.deployed()
      .then(function(instance) {
        selectionInstance = instance;
        return selectionInstance.agentsCount();
      })
      .then(function(agentsCount) {
        var agentsResults = $("#agentsResults");
        agentsResults.empty();

        var packageSelect = $("#packageSelect");
        packageSelect.empty();

        packageSelect.append(
          "<option value='" +
            10000000000000000 +
            "' >" +
            "0.01 ETH: Basic Influencer Package @ 200 Daily User Engagements " +
            "</ option>"
        );
        packageSelect.append(
          "<option value='" +
            20000000000000000 +
            "' >" +
            "0.02 ETH: Popular Kid Package @ 500 Daily User Engagements" +
            "</ option>"
        );
        packageSelect.append(
          "<option value='" +
            30000000000000000 +
            "' >" +
            "0.03 ETH: Ethtravagent Package @ 1000 Daily User Engagements" +
            "</ option>"
        );

        var agentsSelect = $("#agentsSelect");
        agentsSelect.empty();

        for (var i = 1; i <= agentsCount; i++) {
          selectionInstance.agents(i).then(function(agent) {
            var id = agent[0];
            var instagram_account = agent[1];
            var agent_address = agent[2];
            var busy = agent[3];

            // Render agent Result
            var agentTemplate =
              "<tr><th>" +
              id +
              "</th><td>" +
              instagram_account +
              "</td><td>" +
              agent_address +
              "</td><td>" +
              busy +
              "</td></tr>";
            agentsResults.append(agentTemplate);

            // Render agent ballot option
            var agentOption =
              "<option value='" + id + "' >" + instagram_account + "</ option>";
            agentsSelect.append(agentOption);
          });
        }
        return selectionInstance.engagers(App.account);
      })
      .then(function(hasEngaged) {
        // Do not allow a user to engage
        if (hasEngaged) {
          $("form").hide();
        }
        loader.hide();
        content.show();
      })
      .catch(function(error) {
        console.warn(error);
      });
  },

  castEngagement: function() {
    var agentId = $("#agentsSelect").val();
    var packageCost = $("#packageSelect").val();
    App.contracts.Selection.deployed()
      .then(function(instance) {
        return instance.engage(agentId, {
          from: App.account,
          value: packageCost
        });
      })
      .then(function(result) {
        // Wait for engagement to update
        $("#content").hide();
        $("#loader").show();
      })
      .catch(function(err) {
        console.error(err);
      });
  }
};

$(function() {
  $(window).load(function() {
    App.init();
  });
});

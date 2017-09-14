Feature: Kea Control Channel - socket
  Tests for Kea Command Control Channel using unix socket to pass commands.

@v4 @controlchannel
  Scenario: control.channel.socket.set-config-basic
  Test Setup:
  Server is configured with 192.168.50.0/24 subnet with 192.168.50.5-192.168.50.5 pool.
  Server has control channel on unix socket with name $(SOFTWARE_INSTALL_DIR)var/kea/control_socket.
  Send server configuration using SSH and config-file.

  DHCP server is started.

  Test Procedure:
  Client requests option 1.
  Client sends DISCOVER message.

  Pass Criteria:
  Server MUST respond with OFFER message.
  Response MUST include option 1.
  Response MUST contain yiaddr 192.168.50.5.
  Response option 1 MUST contain value 255.255.255.0.

  Test Setup:
  Server is configured with 192.168.50.0/24 subnet with 192.168.50.50-192.168.50.50 pool.
  Server has control channel on unix socket with name $(SOFTWARE_INSTALL_DIR)var/kea/control_socket.
  Generate server configuration file.

  Using UNIX socket on server in path $(SOFTWARE_INSTALL_DIR)var/kea/control_socket send {"command": "set-config","arguments":  $(SERVER_CONFIG) }

  Test Procedure:
  Client requests option 1.
  Client sends DISCOVER message.

  Pass Criteria:
  Server MUST respond with OFFER message.
  Response MUST include option 1.
  Response MUST contain yiaddr 192.168.50.50.
  Response option 1 MUST contain value 255.255.255.0.

@v4 @controlchannel
  Scenario: control.channel.socket.change-socket-during-reconfigure
  Test Setup:
  Server is configured with 192.168.50.0/24 subnet with 192.168.50.5-192.168.50.5 pool.
  Server has control channel on unix socket with name $(SOFTWARE_INSTALL_DIR)var/kea/control_socket.
  Send server configuration using SSH and config-file.

  DHCP server is started.

  Test Procedure:
  Client requests option 1.
  Client sends DISCOVER message.

  Pass Criteria:
  Server MUST respond with OFFER message.
  Response MUST include option 1.
  Response MUST contain yiaddr 192.168.50.5.
  Response option 1 MUST contain value 255.255.255.0.

  Test Setup:
  Server is configured with 192.168.50.0/24 subnet with 192.168.50.50-192.168.50.50 pool.
  Server has control channel on unix socket with name $(SOFTWARE_INSTALL_DIR)var/kea/control_socket2.
  Generate server configuration file.

  Using UNIX socket on server in path $(SOFTWARE_INSTALL_DIR)var/kea/control_socket send {"command": "set-config","arguments":  $(SERVER_CONFIG) }

  Test Procedure:
  Client requests option 1.
  Client sends DISCOVER message.

  Pass Criteria:
  Server MUST respond with OFFER message.
  Response MUST include option 1.
  Response MUST contain yiaddr 192.168.50.50.
  Response option 1 MUST contain value 255.255.255.0.

  Using UNIX socket on server in path $(SOFTWARE_INSTALL_DIR)var/kea/control_socket send {"command": "list-commands","arguments": {}}
  Using UNIX socket on server in path $(SOFTWARE_INSTALL_DIR)var/kea/control_socket2 send {"command": "list-commands","arguments": {}}

@v4 @controlchannel
Scenario: control.channel.socket.after-restart-load-config-file

  Test Setup:
  Server is configured with 192.168.50.0/24 subnet with 192.168.50.5-192.168.50.5 pool.
  Server has control channel on unix socket with name $(SOFTWARE_INSTALL_DIR)var/kea/control_socket.
  Send server configuration using SSH and config-file.

  DHCP server is started.

  Test Procedure:
  Client requests option 1.
  Client sends DISCOVER message.

  Pass Criteria:
  Server MUST respond with OFFER message.
  Response MUST include option 1.
  Response MUST contain yiaddr 192.168.50.5.
  Response option 1 MUST contain value 255.255.255.0.

  Test Setup:
  Server is configured with 192.168.50.0/24 subnet with 192.168.50.50-192.168.50.50 pool.
  Server has control channel on unix socket with name $(SOFTWARE_INSTALL_DIR)var/kea/control_socket.
  Generate server configuration file.

  Using UNIX socket on server in path $(SOFTWARE_INSTALL_DIR)var/kea/control_socket send {"command": "set-config","arguments":  $(SERVER_CONFIG) }

  Test Procedure:
  Client requests option 1.
  Client sends DISCOVER message.

  Pass Criteria:
  Server MUST respond with OFFER message.
  Response MUST include option 1.
  Response MUST contain yiaddr 192.168.50.50.
  Response option 1 MUST contain value 255.255.255.0.

  Restart DHCP server.

  Test Procedure:
  Client requests option 1.
  Client sends DISCOVER message.

  Pass Criteria:
  Server MUST respond with OFFER message.
  Response MUST include option 1.
  Response MUST contain yiaddr 192.168.50.5.
  Response option 1 MUST contain value 255.255.255.0.


Feature: DHCPv4 address request process
    Those are simple DHCPv4 tests for address assignment. During SELECTING state in relay traffic.

@v4 @dhcp4 @relay @request
    Scenario: v4.request.relay-selecting-success-chaddr

    Test Setup:
    Server is configured with 192.168.50.0/24 subnet with 192.168.50.1-192.168.50.1 pool.
    Send server configuration using SSH and config-file.
DHCP server is started.

    Test Procedure:
    Set network variable source_port with value 67.
    Set network variable source_address with value $(GIADDR4).
    Set network variable destination_address with value $(SRV4_ADDR).
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
    Client requests option 1.
    Client sends DISCOVER message.

    Pass Criteria:
    Server MUST respond with OFFER message.
    Response MUST include option 1.
    Response MUST contain yiaddr 192.168.50.1.
    Response option 1 MUST contain value 255.255.255.0.

    Test Procedure:
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
    Client copies server_id option from received message.
    Client adds to the message requested_addr with value 192.168.50.1.
    Client requests option 1.
    Client sends REQUEST message.

    Pass Criteria:
    Server MUST respond with ACK message.
    Response MUST contain yiaddr 192.168.50.1.
	Response MUST include option 1.
    Response option 1 MUST contain value 255.255.255.0.

@v4 @dhcp4 @relay @request
    Scenario: v4.request.relay-selecting-success-chaddr-empty-pool

    Test Setup:
    Server is configured with 192.168.50.0/24 subnet with 192.168.50.1-192.168.50.1 pool.
    Send server configuration using SSH and config-file.
DHCP server is started.

    Test Procedure:
    Set network variable source_port with value 67.
    Set network variable source_address with value $(GIADDR4).
    Set network variable destination_address with value $(SRV4_ADDR).
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
    Client requests option 1.
    Client sends DISCOVER message.

    Pass Criteria:
    Server MUST respond with OFFER message.
    Response MUST contain yiaddr 192.168.50.1.
	Response MUST include option 1.
	Response MUST include option 54.
    Response option 1 MUST contain value 255.255.255.0.
    Response option 54 MUST contain value $(SRV4_ADDR).

    Test Procedure:
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
    Client copies server_id option from received message.
    Client adds to the message requested_addr with value 192.168.50.1.
    Client requests option 1.
    Client sends REQUEST message.

    Pass Criteria:
    Server MUST respond with ACK message.
    Response MUST contain yiaddr 192.168.50.1.
	Response MUST include option 1.
	Response MUST include option 54.
    Response option 1 MUST contain value 255.255.255.0.
    Response option 54 MUST contain value $(SRV4_ADDR).

    Test Procedure:
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
    Client requests option 1.
    Client sets chaddr value to ff:01:02:03:ff:04.
    Client sends DISCOVER message.

    Pass Criteria:
    Server MUST NOT respond.

@v4 @dhcp4 @relay @request
    Scenario: v4.request.relay-selecting-success-client-id

    Test Setup:
    Server is configured with 192.168.50.0/24 subnet with 192.168.50.1-192.168.50.1 pool.
    Send server configuration using SSH and config-file.
DHCP server is started.

    Test Procedure:
    Set network variable source_port with value 67.
    Set network variable source_address with value $(GIADDR4).
    Set network variable destination_address with value $(SRV4_ADDR).
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.

    Client sets chaddr value to 00:00:00:00:00:00.
    Client adds to the message client_id with value 00010203040506.
    Client requests option 1.
    Client sends DISCOVER message.

    Pass Criteria:
    Server MUST respond with OFFER message.
    Response MUST contain yiaddr 192.168.50.1.
	Response MUST include option 1.
	Response MUST include option 54.
	Response MUST include option 61.
    Response option 1 MUST contain value 255.255.255.0.
    Response option 61 MUST contain value 00010203040506.

    Test Procedure:
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
    Client adds to the message client_id with value 00010203040506.
    Client sets chaddr value to 00:00:00:00:00:00.
    Client copies server_id option from received message.
	Client adds to the message requested_addr with value 192.168.50.1.
	Client requests option 1.
	Client sends REQUEST message.

    Pass Criteria:
    Server MUST respond with ACK message.
    Response MUST contain yiaddr 192.168.50.1.
	Response MUST include option 1.
	Response MUST include option 54.
	Response MUST include option 61.
    Response option 1 MUST contain value 255.255.255.0.
    Response option 61 MUST contain value 00010203040506.

@v4 @dhcp4 @relay @request
    Scenario: v4.request.relay-selecting-success-client-id-empty-pool

    Test Setup:
    Server is configured with 192.168.50.0/24 subnet with 192.168.50.1-192.168.50.1 pool.
    Send server configuration using SSH and config-file.
DHCP server is started.

    Test Procedure:
    Set network variable source_port with value 67.
    Set network variable source_address with value $(GIADDR4).
    Set network variable destination_address with value $(SRV4_ADDR).
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
    Client sets chaddr value to 00:00:00:00:00:00.
    Client adds to the message client_id with value 00010203040506.
    Client requests option 1.
    Client sends DISCOVER message.

    Pass Criteria:
    Server MUST respond with OFFER message.
    Response MUST contain yiaddr 192.168.50.1.
	Response MUST include option 1.
	Response MUST include option 54.
	Response MUST include option 61.
    Response option 1 MUST contain value 255.255.255.0.
	Response option 61 MUST contain value 00010203040506.

    Test Procedure:
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
    Client adds to the message client_id with value 00010203040506.
    Client sets chaddr value to 00:00:00:00:00:00.
    Client copies server_id option from received message.
	Client adds to the message requested_addr with value 192.168.50.1.
	Client requests option 1.
	Client sends REQUEST message.

    Pass Criteria:
    Server MUST respond with ACK message.
    Response MUST contain yiaddr 192.168.50.1.
	Response MUST include option 1.
	Response MUST include option 54.
	Response MUST include option 61.
    Response option 1 MUST contain value 255.255.255.0.
    Response option 61 MUST contain value 00010203040506.

    Test Procedure:
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
    Client sets chaddr value to 00:00:00:00:00:00.
    Client adds to the message client_id with value 00020304050607.
    Client requests option 1.
    Client sends DISCOVER message.

    Pass Criteria:
    Server MUST NOT respond.
	
@v4 @dhcp4 @relay @request
Scenario: v4.request.relay-selecting-success-client-id-chaddr-empty-pool
	
	Test Setup:
	Server is configured with 192.168.50.0/24 subnet with 192.168.50.1-192.168.50.1 pool.
	Send server configuration using SSH and config-file.
DHCP server is started.
	
	Test Procedure:
    Set network variable source_port with value 67.
    Set network variable source_address with value $(GIADDR4).
    Set network variable destination_address with value $(SRV4_ADDR).
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
	Client sets chaddr value to 00:00:00:00:00:00.
	Client adds to the message client_id with value 00010203040506.
	Client requests option 1.
	Client sends DISCOVER message.
	
	Pass Criteria:
	Server MUST respond with OFFER message.
	Response MUST contain yiaddr 192.168.50.1.
	Response MUST include option 1.
	Response MUST include option 54.
	Response MUST include option 61.
	Response option 1 MUST contain value 255.255.255.0.
	Response option 61 MUST contain value 00010203040506.
	
	Test Procedure:
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
	Client adds to the message client_id with value 00010203040506.
	Client sets chaddr value to 00:00:00:00:00:00.
	Client copies server_id option from received message.
	Client adds to the message requested_addr with value 192.168.50.1.
	Client requests option 1.
	Client sends REQUEST message.
	
	Pass Criteria:
	Server MUST respond with ACK message.
	Response MUST contain yiaddr 192.168.50.1.
	Response MUST include option 1.
	Response MUST include option 54.
	Response MUST include option 61.
	Response option 1 MUST contain value 255.255.255.0.
	Response option 61 MUST contain value 00010203040506.
	
	Test Procedure:
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
	Client sets chaddr value to 00:00:00:00:00:11.
	Client adds to the message client_id with value 11020304050607.
	Client requests option 1.
	Client sends DISCOVER message.
	
	Pass Criteria:
	Server MUST NOT respond.
	
	Test Procedure:
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
	Client sets chaddr value to 00:00:00:00:00:00.
	Client adds to the message client_id with value 11020304050607.
	Client requests option 1.
	Client sends DISCOVER message.
	
	Pass Criteria:
	Server MUST NOT respond.

@v4 @dhcp4 @relay @request
    Scenario: v4.request.relay-selecting-success-second-request-fail

    Test Setup:
    Server is configured with 192.168.50.0/24 subnet with 192.168.50.1-192.168.50.1 pool.
    Send server configuration using SSH and config-file.
DHCP server is started.

    Test Procedure:
    Set network variable source_port with value 67.
    Set network variable source_address with value $(GIADDR4).
    Set network variable destination_address with value $(SRV4_ADDR).
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.

    Client sets chaddr value to 00:00:00:00:00:00.
    Client requests option 1.
    Client sends DISCOVER message.

    Pass Criteria:
    Server MUST respond with OFFER message.
    Response MUST include option 1.
    Response MUST contain yiaddr 192.168.50.1.
    Response option 1 MUST contain value 255.255.255.0.

    Test Procedure:
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
    Client sets chaddr value to 00:00:00:00:00:00.
    Client copies server_id option from received message.
	Client adds to the message requested_addr with value 192.168.50.1.
	Client requests option 1.
	Client sends REQUEST message.

    Pass Criteria:
    Server MUST respond with ACK message.
    Response MUST contain yiaddr 192.168.50.1.
	Response MUST include option 1.
	Response MUST include option 54.
    Response option 1 MUST contain value 255.255.255.0.

    Test Procedure:
    Client sets chaddr value to 00:00:00:22:11:00.
    Client copies server_id option from received message.
	Client adds to the message requested_addr with value 192.168.50.1.
	Client requests option 1.
    Client sets giaddr value to $(GIADDR4).
    Client sets hops value to 1.
	Client sends REQUEST message.

    Pass Criteria:
    Server MUST respond with NAK message.
	Response MUST include option 54.
	Response option 54 MUST contain value $(SRV4_ADDR).
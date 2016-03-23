Feature: Clockwork

In order for my application to run background processes at certain interval
As a developer
I want clockwork to run


  Scenario: Clockwork Running
    Given clockwork.god config file exists
    And God is running
    Then clockwork should be running

  Scenario: Clockwork running with the right PID
    Given clockwork.god config file exists
    And God is running
    Then clockwork should be running using the pid from clockwork.pid

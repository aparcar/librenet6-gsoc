# LibreNet6
## Idea
Community mesh networks often often lack IPv6 connectivity as their gateway
connection can't offer a subnet which is big enough to offer addresses to all
nodes and their clients. A possible solution is to distribute bigger subnets via
a tunnel connection between a server (or VM) and mesh gateway nodes.
This approach already [exists called LibreNet6](docs.altermundi.net/LibreNet6).
While the current implementation works, it's *hard* to setup and only [documented
in Spanish language](http://docs.altermundi.net/LibreNet6/Setup).
Within this GSoC project the LibreNet6 stack should be simplified and better
documented. Making it easier to install for server and gateway administrators
and offer a more extensive documentation.

## Requirements
* **IPv6 delegation:** LibreMesh gateways use a specified IPv6 subnet of various
  size, depending on demand.
* **Server independece:** If the IPv6 providing server goes down, nodes should
  keep connectivity within the mesh cloud as well as between different clouds.
* **Simple setup:** The gateway operators should be able to install and receive
  IPv6 connectivity with as little manual configuration as possible.
* **Server interface:** A simple administrative user interface should allow the
  management of assigned IPv6 subnets.
## Current implementation
Currently the implementation uses the following software stack:
* **[Tinc VPN](http://tinc-vpn.org/):** used to connect the gateway nodes with
  the IPv6 server. Also it's used to allow inter mesh communication without
using the servers.
* **[Babel Routing Protocol](https://www.irif.fr/~jch/software/babel/):** Used
  on top of the Tinc connection route between mesh gateways and server on the
shortest path.
* **[GitHub for authorized
  keys](https://github.com/libremesh/librenet6-hostkeys):** All public keys of
nodes authorized to connect to the mesh tunnel broker server.

## Implementation ideas for this project
* The [node setup](http://docs.altermundi.net/LibreNet6/Setup#openwrt) should be
installable as a package and provide the required information for connection via
a simple web interface, favorable using the
[lime-app](https://github.com/libremesh/lime-app/).
    * Concretely the [auto generated IPv6 subnet](https://github.com/libremesh/lime-packages/blob/develop/packages/lime-system/files/etc/config/lime-defaults#L18)
(based on used network name) and the generated Tinc public key should be shown.
* Using Babeld adds another routing protocol to the used stack, where most
  LibreMesh setups already use [BMX6](https://github.com/bmx-routing/bmx6). It
should be evaluated of BMX6 (or it's successor
[BMX7](https://github.com/bmx-routing/bmx7)) are a useable replacement.

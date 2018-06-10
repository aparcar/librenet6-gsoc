# LibreNet6 - progress report

During the last few weeks I jumped into LibreNet6 and started on setting up a
local testbed. With a couple of routers and an virtual machine with real a IPv6
subnet I followed the current
[Setup (Spanish)](http://docs.altermundi.net/LibreNet6/Setup) guide and eventually got it
running. The process had various stumbling stones and is rather unpleasant to
setup. In a future setup I'll try to make the setup as simple as possible, only
involving the installation of a single package.

# The need of LibreNet6

Simply said, LibreNet6 allows using the IPv6 functionality of LibreMesh (LiMe).
With a single configuration file at `/etc/config/lime` it's possible to set
nearly all functionality of the LiMe framework, from access points, mesh
connects, used addresses to activated routing protocols.  In the default
configuration all nodes have a `/64` IPv6 subnet defined which is pseudo
randomly generated based on the hash of the defined network name, which thereby
all nodes of a (Layer2) mesh cloud share.  The subnet is part of
[Altermundi's](http://altermundi.net/) address space, enabling in theory public
IPv6 addresses to all nodes and clients of the LiMe cloud. However, most
mesh gateways don't have a direct connection to Altermundi. 

# Speeding up development

I'm not completely new to the LiMe code and contributed on various end
within the last years (motivated by my last years GSoC). Developing and testing
new software were always tedious as all packages had to be created individually
per targets architecture. To speed up this process I spent some time on settings
up [automatic snapshot builds for
LiMe](https://github.com/libremesh/lime-packages/commit/0c81abff2376fff57b14c6be07b5e0a2475334f5)
take care of automatic updating of [LiMe snapshot
repository](https://snapshots.libremesh.org/snapshots/packages/).
As nearly all LiMe code is Lua, it's unnecessary to compile packages  for all
targets. To have a single package running on all architectures, the
`PKGARCH:=all` settings can be used in packages `Makefiles`, and [so I
did](https://github.com/libremesh/lime-packages/commit/faed673052653800d3c10be2f62b416bd54f67d4).
As a result, LiMe has now CI and a constantly updated snapshot repository, this
will allow me (and other LiMe devs) to accelerate the development and testing of
new functionality and packages!

# Evaluation of the current LibreNet6 state

So far the setup was roughly like that:

* Using Tinc 1.0 with a [GitHub
repository](https://github.com/libremesh/librenet6-hostkeys) to share public
keys, which were then deployed on servers.
* Babel were installed manually on nodes requiring execution of various bash
scripts.
* Administrators had to [keep track of used subnets
* manually](http://docs.altermundi.net/LibreNet6/Setup#subredes)

With the previously mentioned testbed I tried some new software and came up with
an easier setup which stays compatible with already deployed connections:

* Use Tinc 1.1 with all it's new feature called [`invite` and
	`join`](https://www.tinc-vpn.org/documentation-1.1/tinc-commands.html#index-invite)
	allows clients to connect simply by running Tinc with a given invite url.
	This also handels key creation & exchange and setup of all Tinc related
	configuration files via a [`invitation-created
	script`](https://www.tinc-vpn.org/documentation-1.1/Writing-an-invitation_002dcreated-script.html#Writing-an-invitation_002dcreated-script).
* Use of the recently added
	[`lime-proto-babled`](https://github.com/libremesh/lime-packages/commit/db20fa4a08de7011d544d218d5cc249c6c8487a8)
	to automatically configure all `babeld`, inclusive in [combination with
	LibreNet6](https://github.com/libremesh/lime-packages/commit/93db12cda2220ca76df01160bb3edbf6f977bac5)
* Offer a [`lime-app`](https://github.com/libremesh/lime-app) to execute Tinc's
    join command via web interface and show state of connection, like a simple
    IPv6 ping check.


GSP Coin Core v2.2
===========================
Cryptocurrency that links to modern Digital Advertising and Marketing.

What is GSP Coin?

GSP Coin is a project that aims to build a new ecosystem for digital and mobile advertising, allowing advertisers to create and manage campaigns through our platforms like Global Ads Media | Global Social Post | Global Smtp Mail with complete automation. A revolutionary Real Time Bidding system allows advertisers to gain most of required web traffic and track the result of their investments in a completely automated fashion. The GSP Coin token will serve as the platform’s internal currency and will be used within the ecosystem.

GSP Coin is a decentralized financial technology accessible to everyone that is fast, reliable and secure with negligible transaction costs. GSP Coin has its own blockchain, which is a fork of Raptoreum codebase with ASIC resistant POW algorithm (GhostRider) and consensus ensuring Smartnodes which make the network immune to 51% attacks. GSP Coin can be mined on both CPU and GPU. GSP Coin cares about privacy and has an integrated CoinJoin mechanism that allows to hide the balance directly in the wallet.

GSP Coin is tied to Digital Advertising and Marketing. Its focus is on bridging the gap between cryptocurrencies and the digital advertising and marketing industries currently, GSP Coin (GSP) has been targeted specifically at adtech companies in the retail industry. GSP Coin’s mission is to bridge the gap between traditional finance and blockchain based transactions via its blockchain protocol.

As our customer base grows, we must be able to do everything in the market that we want to do. This coin will give us the ability to do it all with more flexibility, ease-of-access and less restrictions on geographical location.

Our goal is to develop GSP as a widely available, widely accepted method of trading digital ads tokens.

The primary goal is to pay the suppliers and accept payment from clients in GSP Coin instead of using the USD.

**Problems GSP Coin attempts to solve**

GSP Coin is a transparent and scalable financial system that aims to make cryptocurrencies accessible to everyone. There are four main directions in which we want to contribute:

1. Make managing GSPC easy for everyone by deploying mobile and desktop wallets for major operating systems.

2. Promote the adoption of cryptocurrencies by offering a payment gateway service. The service will facilitate online transactions in cryptocurrency. Customers will be able to pay for goods and services in GSPC, while an entrepreneur can receive settlements automatically.

3. Provide open access to liquidity and trading without prohibitive entry barriers.

4. Enable community participation with high returns: everyone can earn coins by deploying Smartnodes and contributing to blockchain stability and security.

Official Links:
* Webpage: https://gspcoin.us
* Block Explorer: https://explorer.gspcoin.us
* Block Explorer (Mirror): https://explorer.globalsocialpost.com
* Discord: https://discord.gg/Anh2sr4txV
* Telegram: https://t.me/gspc_gspcoin
* Twitter / X: https://x.com/gspcoin
* GitHub: https://github.com/gamgsp/gspcoin

License
-------

GSP Coin Core is released under the terms of the MIT license. See [COPYING](COPYING) for more information or see https://opensource.org/licenses/MIT.

Development Process
-------------------

The `master` branch is meant to be stable. Development is done in separate branches.
[Tags](https://github.com/gamgsp/gspcoin/tags) are created to indicate new official,
stable release versions of GSP Coin Core.

The contribution workflow is described in [CONTRIBUTING.md](CONTRIBUTING.md).

Testing
-------

Testing and code review is the bottleneck for development; we get more pull
requests than we can review and test on short notice. Please be patient and help out by testing
other people's pull requests, and remember this is a security-critical project where any mistake might cost people
lots of money.

### Automated Testing

Developers are strongly encouraged to write [unit tests](src/test/README.md) for new code, and to
submit new unit tests for old code. Unit tests can be compiled and run
(assuming they weren't disabled in configure) with: `make check`. Further details on running
and extending unit tests can be found in [/src/test/README.md](/src/test/README.md).

There are also [regression and integration tests](/test), written
in Python, that are run automatically on the build server.
These tests can be run (if the [test dependencies](/test) are installed) with: `test/functional/test_runner.py`

The Travis CI system makes sure that every pull request is built for Windows, Linux, and OS X, and that unit/sanity tests are run automatically.

### Manual Quality Assurance (QA) Testing

Changes should be tested by somebody other than the developer who wrote the
code. This is especially important for large or high-risk changes. It is useful
to add a test plan to the pull request description if testing the changes is
not straightforward.

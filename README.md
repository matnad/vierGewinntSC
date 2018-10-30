# Connect Four Smart contract

## Short Description

Play [Connect Four](https://en.wikipedia.org/wiki/Connect_Four) on the blockchain.


Player 1 (red) can chose to bet 0.001 - 10 ETH and start a new game.
Any Player 2 (blue) can join him by matching the bet.


Player 1 starts by putting the first stone. The game continues according to the normal rules until one player connects 4 stones in a row, column or diagonal. The time per move is fixed and shown in the interface. If the time runs out, any address can terminate the game and declare the nonactive player the Winner. In any way, the winner gets a payout equal to both bets minus a fixed percentage rake/fee which is withheld by the contract.


The game then resets and can be played again.

## Interface

The interface to play the game is a website powered by the web3 injection engine. It can thus be played on any (even custom) network.

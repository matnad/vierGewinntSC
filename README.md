# Connect Four Smart contract

## Rules of the Game

1. Player 1 chooses the value for the bet between 0.01 and 5 ether.
2. Player 2 has to match the bet of player 1 exactly or the transaction is rejected.
3. Player 2 is obliged to start the game with a second transaction within 240 blocks after the bet of player 1 was matched. This is necessary to guarantee the randomness described in the next step. If player 2 does not start the game within this time frame they will lose their bet and player 1 will get their bet refunded. [1]
4. After player 2 started the game, the game table is shown. The game is a modified version of the well known game connect four. One stone will be placed for each player in a random position that is not in the middle column and doesn't touch a border. Additionally, the starting player is randomly determined. [2]
5. The goal of the game is to connect 4 stones of the same colour in a row, column or diagonal. 
6. The time per move is fixed and shown in the interface. If the time runs out, any address can terminate the game and declare the nonactive player the winner.
7. To incentivize the loosing player to play out the game or give up instead of just choosing to time out, they will receive a part of the fees when giving up or losing. No payout is done to a player who lets the game time out.
8. The winner of the game receives the bet of both players minus a fixed percentage fee which is withheld by the contract.



## Interface

The interface to play the game is a website powered by the web3 injection engine and requires a modern browser with the metamask addon. It can be played on any (even a custom) network.

## Demo

Demo on Rinkeby: http://4gw.rf.gd/4/

## 

[1] Anyone can start the game by triggering the transaction, but only player 2 has a monetary incentive to do so.

[2] The informed reader/player might know that it is not trivial to create entropy on a blockchain. We use the following two-stage approach: When player 2 matches the bet, the block hash of this transaction will be used to construct the random seed (note that even the miner of this block will not know the block hash until the block is completed). When player 2 starts the game with the second transaction, the block hash of the "join-transaction" is revealed. This second transaction needs to be within 240 blocks (~1 hour) after the first transaction. We then combine the block hash with the account address of the miner (coinbase) of the second block using an XOR operation to create the random seed. Using a linear congruential algorithm we derive at least five random numbers from this seed to define the location of the two random stones and the starting player.
# Rules of the game
1. Player 1 sets the hight of the bet (between 0.001 and 1 ether).
2. Player 2 has to match the bet of player 1. If player 2 bets too much, the difference will be sent back. Transactions with insufficient funds will be rejected. 
3. Player 2 is obliged to start the game with a second transaction within 256 blocks after the bet of player 1 was matched. This is necessary to guarantee the randomness described in the next step. If he/she does not meet this requirement, player 1 will get his bet refunded, but player 2 will lose everything.
4. After player 2 started the game, the game table is shown. The game is a modified version of the well known game connect four. Because the traditional game setting is solved (i.e. there is a strategy that allows the first player to win every time), we included one stone for both players which are set randomly at the beginning of the game.[1] Additionally, it is randomly selected which player may set the first stone.
5. The goal of the game is to connect 4 stones of the same colour in a row, column or diagonal. 
6. The time per move is fixed and shown in the interface. If the time runs out, any address can terminate the game and declare the nonactive player the winner.
7. To incentivice the loosing player to give up instead of just chosing to time out, he/she will receive a part of the fees when giving up or losing. No payout is done to someone who lets the game time out.
8. The winner of the game receives the bet of both players minus a fixed percentage rake/fee which is withheld by the contract and the refund provided to the conceding loser.




[1]The informed reader/player might know that it is fairly difficult to create entropy on a blockchain. We use the following two-stage approach: when player 2 matches the bet, the block hash of this transaction is set as a random seed (note that at this point the block hash is not yet defined). When player 2 starts the game (second transaction) the block hash of the "join-transaction" is revealed. This second transaction needs to be within 256 blocks after the first transaction. We then combine the hash with the account address of the miner of the second block (using an XOR operation). In total we need five random numbers to define the location of the two random stones and who may start the game. These are calculated from the seed (i.e. block hash and miners address) using a linear congruential algorithm.

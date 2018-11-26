# New Ideas
1. Random Number Generator for first mover and placement of two initial blocks. 
When submitting the bet, we use the block hash of player twos join-block as a random seed. In a second transaction by player two the block hash is revealed.
It is then combined with block.coinbase of the second transaction of player two, adding additional entropy (combination is done with an XOR operation).
We cannot use the hash of the first block directly, because block.blockhash is not defined for the current block. In total we need five random numbers
which will be calculated from this seed using a linear congruential algorithm (C++11's minstd_rand). It is player twos responsibility to submit the
second transaction within 256 blocks after is first transaction. If player two does not submit a second transaction, player one gets his/her bet back, 
but player two will lose everything.

Interesting reading: https://blog.positive.com/predicting-random-numbers-in-ethereum-smart-contracts-e5358c6b8620

2. To incentivice the loosing player to give up instead of just chosing to time out, he/she will receive a part of the fees when giving up or losing.
No payout is done to someone who lets the game time out.

3. We will include the last five games played below the current game, with the final state of the game being shown.

# To-Dos
1. Include the ideas above in the code.
2. Write an introduction and the rules of the game and include them in the interface.
3. create presentation for class. We use PowerPoint. All files should be uploaded on github, so we can see the changes and content of everyone.
Three parts: Concept (Two players, solved game, our changes, payout & fees, rules 1-2 slides), Link and live demonstration, Show interesting parts of the code (1-2 functions), PRNG & security problems and how we chose to solve them.

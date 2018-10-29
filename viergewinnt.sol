pragma solidity ^0.4.25;
contract CoinFlip {

    address player1;
    address player2;

    uint256 public bet;
    uint256 public maxBet = 10 ether;

    uint8[7][6] public grid;
    uint8 nStones;

    int turnTime = 6400;

    bool player1Turn;
    bool gameRunning;

    function join() public payable {
    // Check if game is gameRunning
    require(
      gameRunning == false,
      "There is currently a game running. Try again when this game ended."
    );

    // Check if slots open, should usually not happen as game should be running
    require(
      player1 == address(0) || player2 == address(0),
      "No player slots open currently."
      );

    // Check if bet is in acceptable range
    require(
      msg.value <= maxBet,
      "Bet is too high."
    );
    require(
      msg.value >= bet,
      "Your bet must match the current bet of player 1."
    );

    // add player and do potential refund
    if (player1 == address(0)) {
      player1 = msg.sender;
      bet = msg.value;
    } else {
      player2 = msg.sender;
      uint256 refund = bet-msg.value;
      if (refund > 0) {
        msg.sender.transfer(refund);
      }
    }

    // check if both players are successfully added and start game
    require(
      player1 != address(0) && player2 != address(0),
      "Player could not be added."
    );

    setUpGame();
    }

    function setUpGame() private {
        gameRunning = true;
        player1Turn = true;
    }

    function setStone(uint8 _col) public {
        // check input
        require(
          _col >= 1 && _col <= 7,
          "Must enter a number between 1 and 7."
          );

        // find row to drop stone
        uint8 col = _col-1;
        uint8 row = 0;
        while (row <= 5 && grid[col][row] != 0) {
            row++;
        }

        // check if column has room
        require(
          row <= 5,
          "Selected column is full."
          );

        // drop correct stone
        if(player1Turn) {
            grid[col][row] = 1;
        } else {
            grid[col][row] = 2;
        }

        // count stones
        nStones++;

        // check if a player won
        if (nStones >= 7) {
            checkVicotryCondition();
        }

        // pass the turn
        switchPriority();
    }

    function checkVicotryCondition() private returns(bool) {
        // check if 4 stones are in a row, col or diagonal
        // if no player won, do nothing
        // if a player won:
        // pay out winnings

        //resetGame();
    }

    function resetGame() private {
        player1 = address(0);
        player2 = address(0);
        delete(grid);
        bet = 0;
        nStones = 0;
    }

    function switchPriority() private {
        player1Turn = !player1Turn;
    }

    function endGame() public {
        // check if time is expired and end game
    }

    function() public payable {
    // Just for funding purposes
    }

}

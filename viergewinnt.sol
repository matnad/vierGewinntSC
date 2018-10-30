pragma solidity ^0.4.25;
contract CoinFlip {

    address public player1;
    address public player2;
    address owner = msg.sender;

    uint public bet;
    uint public maxBet = 10 ether;
    uint public minBet = 0.001 ether;
    uint8 payoutFactor = 90;

    uint8[7][6] public grid;
    uint8 nStones;

    uint turnTime = 6400;
    uint lastBlock;

    bool public player1Turn;
    bool public gameRunning;

    function getGrid() constant returns (uint8[7][6]) {
        return grid;
    }

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

    // add player if bet amount is valid
    if (player1 == address(0)) {
        // Check if bet is in acceptable range
        require(
          msg.value <= maxBet,
          "Bet is too high. Can't be more than 10 ether."
        );
        require(
          msg.value >= minBet,
          "Your bet is too low. Must be at least 0.001 ether."
        );
        player1 = msg.sender;
        bet = msg.value;
        lastBlock = block.number;
        return;
    } else {
    require(
      msg.value == bet,
      "Your bet must match the current bet of player 1 exactly."
    );
      player2 = msg.sender;
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
        lastBlock = block.number;
    }

    function resetGame() private {
        player1 = address(0);
        player2 = address(0);
        delete(grid);
        bet = 0;
        nStones = 0;
        gameRunning = false;
    }

    function setStone(uint8 _col) public {
        // check if game running
        require(
            gameRunning == true,
            "Currently no game running.");

        // check input
        require(
          _col >= 1 && _col <= 7,
          "Must enter a number between 1 and 7."
          );

       // check if correct player
       if (player1Turn) {
           require(
               msg.sender == player1,
               "It's player 1's turn."
           );
        } else {
           require(
               msg.sender == player2,
               "It's player 2's turn."
           );
        }

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
            checkVicotryCondition(col, row);
        }

        // pass the turn
        switchPriority();
    }

    function checkVicotryCondition(uint8 col, uint8 row) private {

        // horizontal
        uint8 vp = 0;
        uint8 p; // player
        if (player1Turn) {
            p = 1;
        } else {
            p = 2;
        }

        uint8 cp = p;
        uint8 i = col;
        while(cp == p && i <= 6) {
            vp++;
            cp = grid[i][row];
            i++;
        }
        cp = p;
        i = 0;
        vp--;
        while(cp == p && i >= 0) {
            vp++;
            cp = grid[row][i];
            i--;
        }

        if (vp >= 4) {
            playerWon();
            return;
        }

        // vertical
        cp = p;
        i = row;
        while(cp == p && i <= 5) {
            vp++;
            cp = grid[col][i];
            i++;
        }
        cp = p;
        i = 0;
        vp--;
        while(cp == p && i >= 0) {
            vp++;
            cp = grid[row][i];
            i--;
        }

        if (vp >= 4) {
            playerWon();
            return;
        }

        // diagonal1
        cp = p;
        i = row;
        uint8 j = col;
        while(cp == p && i <= 5 && j <= 6) {
            vp++;
            cp = grid[j][i];
            i++; j++;
        }
        cp = p;
        i = row;
        j = col;
        vp--;
        while(cp == p && i >= 0 && j >= 0) {
            vp++;
            cp = grid[j][i];
            i--; j--;
        }

        if (vp >= 4) {
            playerWon();
            return;
        }

        // diagonal2
        cp = p;
        i = row;
        j = col;
        while(cp == p && i <= 5 && j >= 0) {
            vp++;
            cp = grid[j][i];
            i++; j--;
        }
        cp = p;
        i = row;
        j = col;
        vp--;
        while(cp == p && i >= 0 && j <= 6) {
            vp++;
            cp = grid[j][i];
            i--; j++;
        }

        if (vp >= 4) {
            playerWon();
            return;
        }

    }

    function playerWon() private {
        if(player1Turn) {
            player1.transfer(bet*2*payoutFactor/100);
        } else {
            player1.transfer(bet*2*payoutFactor/100);
        }
        resetGame();
    }


    function switchPriority() private {
        lastBlock = block.number;
        player1Turn = !player1Turn;
    }

    function endGame() public {
        if (gameRunning == true && (block.number - lastBlock) > turnTime) {
            if(player1Turn) {
                player2.transfer(bet*2*payoutFactor/100);
            } else {
                player1.transfer(bet*2*payoutFactor/100);
            }
            resetGame();
        } else if (gameRunning == false && player1 != address(0) && (block.number - lastBlock) > turnTime) {
            player1.transfer(bet);
            resetGame();
        }
    }

    function() public payable {
    // Just for funding purposes
    }

    function withdraw() public {
        if(msg.sender == owner) {
            owner.transfer(address(this).balance);
        }
    }

}

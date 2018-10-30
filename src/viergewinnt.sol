pragma solidity ^0.4.25;
contract FourConnect {

    address public player1;
    address public player2;
    address owner = msg.sender;

    struct Match {
        address winner;
        uint winnings;
        uint nStones;
    }
    Match public lastMatch;


    uint public bet;
    uint public maxBet = 10 ether;
    uint public minBet = 0.001 ether;
    uint8 payoutFactor = 90;

    uint8[6][7] grid;
    uint8 nStones;

    uint turnTime = 6400;
    uint lastBlock;

    bool public player1Turn;
    bool public gameRunning;


    function getGrid() public view returns (uint8[6][7]) {
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
          _col >= 0 && _col <= 6,
          "Must enter a number between 0 and 6."
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
        uint8 row = 5;
        while (row >= 0 && grid[_col][row] != 0) {
            row--;
        }

        // check if column has room
        require(
          row >= 0,
          "Selected column is full."
          );

        // drop correct stone
        if(player1Turn) {
            grid[_col][row] = 1;
        } else {
            grid[_col][row] = 2;
        }

        // count stones
        nStones++;

        // check if a player won
        if (nStones >= 1) {
            checkVicotryCondition(_col, row);
        }

        // pass the turn
        switchPriority();
    }

    function checkVicotryCondition(uint8 _col, uint8 _row) private {

        // horizontal grid[COL][ROW]
        uint8 p; // player
        if (player1Turn) {
            p = 1;
        } else {
            p = 2;
        }

        uint8 vp = 0;
        uint8 cp = p;
        uint8 i = _col;
        while(cp == p && i <= 6) {
            vp++;
            i++;
            if (i <= 6)
                cp = grid[i][_row];
        }


        // need to prevent uint underflow
        cp = p;
        i = _col;
        vp--;
        while(cp == p && i >= 0) {
            vp++;
            if (i > 0) {
                i--;
                cp = grid[i][_row];
            } else {
                break;
            }
        }


        if (vp >= 4) {
            playerWon();
            return;
        }

        // vertical

        vp = 0;
        cp = p;
        i = _row;
        while(cp == p && i <= 5) {
            vp++;
            i++;
            if (i <= 5)
                cp = grid[_col][i];
        }

        // need to prevent uint underflow
        cp = p;
        i = _row;
        vp--;
        while(cp == p && i >= 0) {
            vp++;
            if (i > 0) {
                i--;
                cp = grid[_col][i];
            } else {
                break;
            }
        }


        if (vp >= 4) {
            playerWon();
            return;
        }

        // diagonal1
        vp = 0;
        cp = p;
        i = _row;
        uint8 j = _col;
        while(cp == p && i <= 5 && j <= 6) {
            vp++; i++; j++;
            if (i <= 5 && j <= 6)
                cp = grid[j][i];
        }

        cp = p;
        i = _row;
        j = _col;
        vp--;
        while(cp == p && i >= 0 && j >= 0) {
            vp++;
            if(i > 0 && j > 0) {
                i--; j--;
                cp = grid[j][i];
            } else {
                break;
            }
        }

        if (vp >= 4) {
            playerWon();
            return;
        }

        // diagonal2
        vp = 0;
        cp = p;
        i = _row;
        j = _col;
        while(cp == p && i <= 5 && j >= 0) {
            vp++;
            if (j > 0)
                j--;
            else
                break;

            if (i < 5)
                i++;
            else
                break;

            cp = grid[j][i];
        }

        cp = p;
        i = _row;
        j = _col;
        vp--;
        while(cp == p && i >= 0 && j <= 6) {
            vp++;
            if (j < 6)
                j++;
            else
                break;

            if (i > 0)
                i--;
            else
                break;

            cp = grid[j][i];
        }

        if (vp >= 4) {
            playerWon();
            return;
        }

        // check for a draw
        if(nStones == 42) {
            drawGame();
        }
    }

    function playerWon() private {
        if(player1Turn) {
            player1.transfer(bet*2*payoutFactor/100);
            lastMatch = Match(player1, bet*2*payoutFactor/100, nStones);
        } else {
            player2.transfer(bet*2*payoutFactor/100);
            lastMatch = Match(player2, bet*2*payoutFactor/100, nStones);
        }
        resetGame();
    }

    function drawGame() private {
        // refund money minus rake
        if(nStones == 42) {
            lastMatch = Match(0, bet*payoutFactor/100, nStones);
            player1.transfer(bet*payoutFactor/100);
            player2.transfer(bet*payoutFactor/100);
            resetGame();
        }
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

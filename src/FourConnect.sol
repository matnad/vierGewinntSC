pragma solidity ^0.4.25;
contract FourConnect {

    // DECLARATION START

    // Static or Settings
    address owner = msg.sender;
    uint public turnTime = 5760; // 5760 blocks ~ 24h

    // Store last 5 matches
    struct Match {
        address winner;
        address opponent;
        uint winnings;
        int8 nStones;
    }
    Match[5] public lastMatches;
    uint8[6][7][5] public finalGrids; // can't put multidimensional arrays in structs
    uint8 public lastMatchPointer = 0;

    // Game variables
    address public player1;
    address public player2;

    bool public player1Turn;
    bool public gameRunning;

    uint public bet;
    uint public maxBet = 5 ether;
    uint public minBet = 0.01 ether;
    uint8 payoutFactor = 90;

    uint8[6][7] grid;
    int8 public nStones = -3;

    uint public lastBlock;

    // Variables to construct a random seed
    address private startCoinbase;
    uint public player2JoinBlockNumber;
    bytes32 private player2JoinBlockHash;
    uint256 private currentRandomNumber;

    // DECLARATION END

    // ------------

    // MODIFIERS START

    modifier onlyActivePlayer {
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
        _;
    }

    // MODIFIERS END

    // ------------

    // FUNCTIONS START

    function getGrid() public view returns (uint8[6][7]) {
        return grid;
    }

    function getFinalGrid(uint8 _pointer) public view returns (uint8[6][7]) {
        return finalGrids[_pointer];
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
        nStones++;
        return;
    } else {
      require(
        msg.value == bet,
        "Your bet must match the current bet of player 1 exactly."
      );
        player2 = msg.sender;
        player2JoinBlockNumber = block.number;
        nStones++;
    }

      // check if both players are successfully added and start game
      require(
        player1 != address(0) && player2 != address(0),
        "Player could not be added."
      );
  }

    function startGame() public {
      require(
          nStones == -1,
          "Can only start the game when both players joined and the game has not started yet."
      );
      // Anyone can start the game. There is no security risk for this
      // First part of seed is already fixed and second part will be depending
      // on this block's coinbase

      if (player2JoinBlockNumber+240 < block.number) {
          // player 2 is too late and loses his bid, player 1 gets refunded
          // player 1 will get his bid back and has incentive to reset
          uint orinigalBet = bet;
          bet = 0;
          player1.transfer(orinigalBet);
          resetGame();
      } else {
          player2JoinBlockHash = blockhash(player2JoinBlockNumber);
          startCoinbase = block.coinbase;
          setUpGame();
      }
  }

  function setUpGame() private {

      currentRandomNumber = uint( player2JoinBlockHash ^ bytes32(uint256(startCoinbase) << 96) );

      player1Turn = (currentRandomNumber % 2) == 0;

      // set two random blocks; one for each player
      // blocks can not be in the middle coloumn and can not be touching a border
      // possible rows: 1,2,3,4
      // possible cols: 1,2,4,5

      // set stone for player 1 ([col][row])

      uint8 row1 = uint8((rand() % 4)) + 1;
      uint8 col1 = uint8((rand() % 4)) + 1;
      if (col1 >= 3)
        col1++;
      grid[col1][row1] = 1;

      // set stone for player 2
      uint8 row2;
      uint8 col2;
      do {
          row2 = uint8((rand() % 4)) + 1;
          col2 = uint8((rand() % 4)) + 1;
          if (col2 >= 3)
            col2++;
      } while (col1 == col2 && row1 == row2);
      grid[col2][row2] = 2;

      gameRunning = true;
      lastBlock = block.number;
      nStones = 2;
  }

  function rand() private returns(uint256) {
      // Linear Congruential Generator (C++11's minstd_rand: ISO/IEC 14882:2011)
      // use randomSeed as X_0
      // X_(n+1) = a*X_n + c mod m
      // a = 48271, c = 0, m = 2**32-1 (=4294967295)
      currentRandomNumber = (48271 * currentRandomNumber) % 4294967295;
      return currentRandomNumber;
  }

    function resetGame() private {
        player1 = address(0);
        player2 = address(0);
        delete(grid);
        bet = 0;
        nStones = -3;
        gameRunning = false;
    }

    function setStone(uint8 _col) onlyActivePlayer public {
        // check if game running
        require(
            gameRunning == true,
            "Currently no game running.");

        // check input
        require(
          _col >= 0 && _col <= 6,
          "Must enter a number between 0 and 6."
          );

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
        if (nStones >= 7) {
            checkVicotryCondition(_col, row);
        }

        // pass the turn
        switchPriority();
    }


    function checkVicotryCondition(uint8 _col, uint8 _row) private {


        uint8 activePlayer; // player
        if (player1Turn)
            activePlayer = 1;
        else
            activePlayer = 2;

        // horizontal check
        int8 victoryPoints = -1; // currents stone will be counted twice, so start at -1

        // right side
        uint8 currentStoneOwner = activePlayer;
        uint8 currentCol = _col;
        while(currentStoneOwner == activePlayer && currentCol <= 6) {
            victoryPoints++;
            currentCol++;
            if (currentCol <= 6)
                currentStoneOwner = grid[currentCol][_row];
        }

        // left side
        currentStoneOwner = activePlayer;
        currentCol = _col;
        while(currentStoneOwner == activePlayer && currentCol >= 0) {
            victoryPoints++;
            currentCol--;
            if (currentCol >= 0)
                currentStoneOwner = grid[currentCol][_row];
        }

        if (victoryPoints >= 4) {
            playerWon();
            return;
        }

        // vertical check
        victoryPoints = 0; // currents stone will be counted once, so start at 0

        // upwards, special case: only look at next stone
        if (_row <= 4 && grid[_col][_row+1] == activePlayer)
            victoryPoints++;

        // downwards
        currentStoneOwner = activePlayer;
        uint8 currentRow = _row;
        while(currentStoneOwner == activePlayer && currentRow >= 0) {
            victoryPoints++;
            currentRow--;
            if (currentRow >= 0)
                currentStoneOwner = grid[_col][currentRow];
        }

        if (victoryPoints >= 4) {
            playerWon();
            return;
        }

        // check diagonal bottom left to top right
        victoryPoints = -1; // currents stone will be counted twice, so start at -1

        // right side
        currentStoneOwner = activePlayer;
        currentRow = _row;
        currentCol = _col;
        while(currentStoneOwner == activePlayer && currentRow <= 5 && currentCol <= 6) {
            victoryPoints++;
            currentRow++;
            currentCol++;
            if (currentRow <= 5 && currentCol <= 6)
                currentStoneOwner = grid[currentCol][currentRow];
        }

        //left side
        currentStoneOwner = activePlayer;
        currentRow = _row;
        currentCol = _col;
        while(currentStoneOwner == activePlayer && currentRow >= 0 && currentCol >= 0) {
            victoryPoints++;
            currentRow--;
            currentCol--;
            if(currentRow >= 0 && currentCol >= 0)
                currentStoneOwner = grid[currentCol][currentRow];
        }

        if (victoryPoints >= 4) {
            playerWon();
            return;
        }

        // check diagonal top left to bottom right
        victoryPoints = -1; // currents stone will be counted twice, so start at -1

        // left side
        currentStoneOwner = activePlayer;
        currentRow = _row;
        currentCol = _col;
        while(currentStoneOwner == activePlayer && currentRow <= 5 && currentCol >= 0) {
            victoryPoints++;
            currentCol--;
            currentRow++;
            if (currentCol >= 0 && currentRow <= 5)
                currentStoneOwner = grid[currentCol][currentRow];
        }

        // right side
        currentStoneOwner = activePlayer;
        currentRow = _row;
        currentCol = _col;
        victoryPoints--;
        while(currentStoneOwner == activePlayer && currentRow >= 0 && currentCol <= 6) {
            victoryPoints++;
            currentRow--;
            currentCol++;
            if (currentRow >= 0 && currentCol <= 6)
                currentStoneOwner = grid[currentCol][currentRow];
        }

        if (victoryPoints >= 4) {
            playerWon();
            return;
        }

        // check for a draw
        if(nStones == 42)
            drawGame();
    }

    function playerWon() private {
        // for security we set bet to 0 before paying out money
        uint orinigalBet = bet;
        bet = 0;

        // incentive to concede: 5% of fees
        uint loserPayout;
        if (block.number - lastBlock > turnTime) {
            // time expired
            loserPayout = 0;
        } else {
            // time not expired
            loserPayout = (orinigalBet * (100-payoutFactor) / 100) / 20;
        }

        if(player1Turn) {
            player1.transfer(orinigalBet*2*payoutFactor/100);
            if (loserPayout > 0)
                player2.transfer(loserPayout);
            storeMatch(Match(player1, player2, orinigalBet*2*payoutFactor/100, nStones));
        } else {
            player2.transfer(orinigalBet*2*payoutFactor/100);
            if (loserPayout > 0)
                player1.transfer(loserPayout);
            storeMatch(Match(player2, player1, orinigalBet*2*payoutFactor/100, nStones));
        }
        resetGame();
    }

    function drawGame() private {
        // refund money minus fee
        if(nStones == 42) {
            uint orinigalBet = bet;
            bet = 0;
            storeMatch(Match(player1, player2, orinigalBet*2*payoutFactor/100, nStones));
            player1.transfer(orinigalBet*payoutFactor/100);
            player2.transfer(orinigalBet*payoutFactor/100);
            resetGame();
        }
    }


    function switchPriority() private {
        lastBlock = block.number;
        player1Turn = !player1Turn;
    }

    function concedeGame() onlyActivePlayer public {
        switchPriority();
        playerWon();
    }

    function endGame() public {
        if (gameRunning == true) {
            require(
                block.number - lastBlock > turnTime,
                "Time needs to be expired."
            );
            // The nonactive player wins due to timeout
            switchPriority();
            playerWon();
        } else if (gameRunning == false) {
            if(nStones == -1) {
                // player 2 failed to start game, let startgame handle this.
                startGame();
            } else {
                // Will give a full refund if game has not yet started (only player1 joined)
                require(
                    player1 != address(0),
                    "There needs to be at least 1 player registered."
                );
                require(
                    block.number - lastBlock > turnTime,
                    "Time needs to be expired."
                );
                require(
                    bet > 0,
                    "Can't refund; there needs to be a bet."
                );
                player1.transfer(bet);
                resetGame();
            }
        }
    }

    function storeMatch(Match _match) private {
      lastMatches[lastMatchPointer] = _match;
      finalGrids[lastMatchPointer] = grid;
      lastMatchPointer = (lastMatchPointer + 1) % 5;
    }

    function() public payable {
    // Just for funding purposes
    }

    function withdraw() public {
        if(msg.sender == owner) {
            owner.transfer(address(this).balance);
        }
    }

    // FUNCTIONS END
}

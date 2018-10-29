pragma solidity ^0.4.25;
contract CoinFlip {

    address player1;
    address player2;

    uint public bet;
    uint8[7][6] public grid;
    uint8 nStones;

    int turnTime = 6400;

    bool player1Turn;
    bool gameRunning;

    function join() public payable {
        // Max bet
        // check if player slots open and game gameRunning
        // check if bet is at least as high as other player
        // add player
    }

    function setStone(uint8 _col) public {
        // check if col is full
        // add stone to col 
        // check if victory condition reached
        uint8 col = _col-1;
        uint8 row = 0;
        for (uint8 i=0; i<=6; i++) {
            if (grid[col][i] == 0) {
                row = i;
                break;
            }
        }

        if(player1Turn) {
            grid[_col][row] = 1;
        } else {
            grid[_col][row] = 2;
        }

        nStones++;

        if (nStones >= 7) {
            checkVicotryCondition;
        }

        switchPriority();
    }

    function checkVicotryCondition() private returns(bool) {
        // check if 4 stones are in a row, col or diagonal
        // if no player won, do nothing
        // if a player won:
        // pay out winnings

        setUpGame();
    }

    function resetGame() private {
        player1 = address(0);
        player2 = address(0);
        grid = uint[7][6]; // reset grid
        bet = 0;

    }

    /*
    function nStones() private returns(uint8){
        uint8 sum = 0;
        for (uint i=0; i<=7; i++) {
            for (uint j=0; j<=6; j++) {
                if (grid[i][j] > 0) {
                    sum++;
                }
            }
        }
        return sum;
    }*/

    function setUpGame() private {
        // give player 1 priority
        player1Turn = true;
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

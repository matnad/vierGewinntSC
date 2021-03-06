    if (typeof addr === 'undefinded') {
        var addr = '0x32009563b1a49891d5ac9c5b05fb911f5e2c760d';
    }


        var abiArray = [
    {
        "constant": true,
        "inputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "lastMatches",
        "outputs": [
            {
                "name": "winner",
                "type": "address"
            },
            {
                "name": "opponent",
                "type": "address"
            },
            {
                "name": "winnings",
                "type": "uint256"
            },
            {
                "name": "nStones",
                "type": "int8"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "bet",
        "outputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "getGrid",
        "outputs": [
            {
                "name": "",
                "type": "uint8[6][7]"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [
            {
                "name": "",
                "type": "uint256"
            },
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "grid",
        "outputs": [
            {
                "name": "",
                "type": "uint8"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "lastMatchPointer",
        "outputs": [
            {
                "name": "",
                "type": "uint8"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "maxBet",
        "outputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [
            {
                "name": "",
                "type": "uint256"
            },
            {
                "name": "",
                "type": "uint256"
            },
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "finalGrids",
        "outputs": [
            {
                "name": "",
                "type": "uint8"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [],
        "name": "withdraw",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [
            {
                "name": "_pointer",
                "type": "uint8"
            }
        ],
        "name": "getFinalGrid",
        "outputs": [
            {
                "name": "",
                "type": "uint8[6][7]"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "player2",
        "outputs": [
            {
                "name": "",
                "type": "address"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "player1Turn",
        "outputs": [
            {
                "name": "",
                "type": "bool"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "player2JoinBlockNumber",
        "outputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [],
        "name": "endGame",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "gameRunning",
        "outputs": [
            {
                "name": "",
                "type": "bool"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "lastBlock",
        "outputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "minBet",
        "outputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "payoutFactor",
        "outputs": [
            {
                "name": "",
                "type": "uint8"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_col",
                "type": "uint8"
            }
        ],
        "name": "setStone",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "nStones",
        "outputs": [
            {
                "name": "",
                "type": "int8"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [],
        "name": "join",
        "outputs": [],
        "payable": true,
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "player1",
        "outputs": [
            {
                "name": "",
                "type": "address"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [],
        "name": "startGame",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [],
        "name": "concedeGame",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "turnTime",
        "outputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "payable": true,
        "stateMutability": "payable",
        "type": "fallback"
    }
];
        if (typeof web3 !== 'undefined') {
            web3 = new Web3(web3.currentProvider);
        }
        else {
            web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
        }
        web3.eth.defaultAccount = web3.eth.accounts[0];
        var user = web3.eth.accounts[0];
        var contract = web3.eth.contract(abiArray);
        var c4 = contract.at(addr);
        $(function () {
            $(document).tooltip();
        });
        /** Try to join the game with a specific bet.
         * val of -1 will read the text field on the website and use that value
         * @param val: has to be -1 or a positive integer. If positive it must be in WEI!
         */
        async function join(val) {
            if (val === -1) {
                val = $("#bet").val() * 1e18;
            }
            c4.join({value: val}, function (error, result) {
                if (!error) {
                    //console.log(result);
                }
                else
                    console.error(error);
            });
        }
        // concede the game
        async function concedeGame() {
            c4.concedeGame(function (error, result) {
                if (!error) {
                    //console.log(result);
                }
                else
                    console.error(error);
            });
        }
        // Start Game
        async function startGame() {
            c4.startGame(function (error, result) {
                if (!error) {
                    //console.log(result);
                }
                else
                    console.error(error);
            });
        }
        // try to play a stone in the specified column
        async function playStone(col) {
            c4.setStone(col, function (error, result) {
                if (!error) {
                    //console.log(result);
                }
                else
                    console.error(error);
            });
        }
        // check if game started
        async function gameRunning() {
            let promise = new Promise((resolve, reject) => {
                c4.gameRunning(function (error, result) {
                    if (!error) {
                        //console.log(result);
                        resolve(result);
                    } else {
                        console.error(error);
                        reject(error);
                    }
                });
            });
            return await promise;
        }
        // check nstones
        async function checkNStones() {
            let promise = new Promise((resolve, reject) => {
                c4.nStones(function (error, result) {
                    if (!error) {
                        //console.log(result);
                        resolve(result);
                    } else {
                        console.error(error);
                        reject(error);
                    }
                });
            });
            return await promise;
        }
        // check current turn
        async function player1Turn() {
            let promise = new Promise((resolve, reject) => {
                c4.player1Turn(function (error, result) {
                    if (!error) {
                        //console.log(result);
                        resolve(result);
                    } else {
                        console.error(error);
                        reject(error);
                    }
                });
            });
            return await promise;
        }
        // check current turn
        async function getPlayer2JoinBlockNumber() {
            let promise = new Promise((resolve, reject) => {
                c4.player2JoinBlockNumber(function (error, result) {
                    if (!error) {
                        //console.log(result);
                        resolve(result);
                    } else {
                        console.error(error);
                        reject(error);
                    }
                });
            });
            return await promise;
        }
        // helper function to display timespan
        function secondsTimeSpanToHMS(s) {
            var h = Math.floor(s / 3600); //Get whole hours
            s -= h * 3600;
            var m = Math.floor(s / 60); //Get remaining minutes
            s -= m * 60;
            return h + ":" + (m < 10 ? '0' + m : m) + ":" + (s < 10 ? '0' + s : s); //zero padding on minutes and seconds
        }
        // try to play a stone in the specified column
        async function endGame() {
            c4.endGame(function (error, result) {
                if (!error) {
                    console.log("EndGame: " + result);
                }
                else
                    console.error(error);
            });
        }
        /**
         * EXECUTION STARTS HERE
         */
        /** Ajax loop to refresh on state change for 30 minutes
         *    All state changes are handeled by the contract with the variable nStones
         *  -3 = Game inactive
         *  -2 = Player 1 joined
         *  -1 = Player 2 joined, waiting to start
         *   2 = Game initialized
         *  1+ = Number of Stones played
         * This function will check nStones every <interval/1000> seconds and refresh the page if a state change is detected.
         * After <duration> seconds the refreshing will stop to not hog resources. Any refresh will restart the timer.
         */
        var duration = 1000 * 60 * 30,
            interval = 1500,
            xhrPending = true,
            intervalTimer,
            nStones;
        // Get the initial value of nStones and then release the pending variable
        c4.nStones(function (error, result) {
            if (!error) {
                nStones = result;
                xhrPending = false;
            }
            else {
                console.error(error);
            }
        });
        // Continuously check nStones to detect a difference. This will only start once the initial function successfully completed.
        // It will also only fire if the previous request is done, otherwise it will skip an update and wait for the previous request.
        intervalTimer = setInterval(function () {
            if (xhrPending) return;
            c4.nStones(async function (error, result) {
                if (!error) {
                    //console.log("chck stones:"+nStones);
                    //console.log("chck result: "+result);
                    if (parseInt(result, 10) != parseInt(nStones, 10)) {
                        location.reload();
                        //console.log("reload");
                    }
                    xhrPending = false;
                }
                else {
                    console.error(error);
                }
            });
            xhrPending = true;
        }, interval);
        setTimeout(function () {
            clearInterval(intervalTimer);
        }, duration);
        // Show current turn and time left, load players and check more time stuff
        // Stacked to allow all in one pass
        c4.player1Turn(async function (error, result) {
            if (!error) {
                var p1t = await player1Turn();
                var nst = await checkNStones();
                var player2JoinBlockNumber = await getPlayer2JoinBlockNumber();
                //console.log("p2jbn:"+player2JoinBlockNumber);
                if (nst > 0) {
                    if (p1t) {
                        $("#priority").html("Next move: <font color=\"red\">Player 1. </font>");
                    } else {
                        $("#priority").html("Next move: <font color=\"blue\">Player 2. </font>");
                    }
                    $("#concede").html("<a href='javascript:concedeGame();' title='If you concede or finish the game, you will recieve a small compensation transfered to your account. If you let the time run out, you forfeit that compensation.'>Concede Game</a>");
                }
                var lastBlock,
                    currentBlock,
                    turnTime;
                c4.lastBlock(function (error, result) {
                    if (!error) {
                        //console.log("lastBlock: "+result)
                        lastBlock = parseInt(result, 10);
                        c4.turnTime(function (error, result) {
                            if (!error) {
                                //console.log("turnTime: "+result)
                                turnTime = parseInt(result, 10);
                                web3.eth.getBlockNumber(function (error, result) {
                                    if (!error) {
                                        //console.log("current block :" +result);
                                        currentBlock = parseInt(result, 10);
                                        var timeRemaining = (lastBlock + turnTime) - currentBlock;
                                        //console.log("time remaining: "+timeRemaining);
                                        var endGameLink = "javascript:endGame();";
                                        if (nst == -1) {
                                            // waiting to start
                                            var startTimeRemaining = player2JoinBlockNumber - currentBlock + 240;
                                            if (startTimeRemaining > 0) {
                                                $("#priority").append("Player 2 has to start the game within the next " + startTimeRemaining + " blocks (~" + secondsTimeSpanToHMS(startTimeRemaining * 15) + ") or they forfeit the game."); //<a href='#' >Why is this step needed?</a>
                                            } else {
                                                $("#priority").append("Player 2 failed to start the game in time. <a href='" + endGameLink + "' >Click here to reset the game and return Player 1's bet.</a>");
                                            }
                                        } else {
                                            // waiting for players or game running
                                            if (timeRemaining > 0) {
                                                $("#priority").append("Time remaining: " + timeRemaining + " blocks (~" + secondsTimeSpanToHMS(timeRemaining * 15) + ").")
                                            } else {
                                                $("#priority").append("Time has run out (" + timeRemaining + " blocks)! ");
                                                if (p1t)
                                                    $("#priority").append("<a href='" + endGameLink + "' >Click here to end the game and declare Player 2 the winner.</a>");
                                                else
                                                    $("#priority").append("<a href='" + endGameLink + "' >Click here to end the game and declare Player 1 the winner.</a>");
                                            }
                                        }
                                        // get player 2 and then 1 (stacked to make sure they resolve in sequence)
                                        c4.player2(function (error, result) {
                                            if (!error) {
                                                if (result == '0x0000000000000000000000000000000000000000' || result == '0x') {
                                                    $("#player2").html('Waiting for Player 2 to join the game...');
                                                    $("#priority").hide(); // hide until 2 players present
                                                    if (timeRemaining <= 0) {
                                                        $("#player2").append(" The waiting time of " + turnTime + " blocks is expired (" + timeRemaining + " blocks). You can still join, or <a href='" + endGameLink + "'>cancel the game and refund Player 1.</a>");
                                                    }
                                                } else {
                                                    $("#player2").html('<font color=\"blue\">Player2: ' + result + '</font>');
                                                }
                                                c4.player1(function (error, result) {
                                                    if (!error) {
                                                        if (result == '0x0000000000000000000000000000000000000000' || result == '0x') {
                                                            $("#player1").html('No one has joined the game so far.');
                                                            $("#player2").html('');
                                                        } else {
                                                            $("#player1").html('<font color="red">Player1: ' + result + '</font>');
                                                        }
                                                    }
                                                    else
                                                        console.error(error);
                                                });
                                            }
                                            else
                                                console.error(error);
                                        });
                                    }
                                    else {
                                        console.error(error);
                                    }
                                });
                            }
                            else {
                                console.error(error);
                            }
                        });
                    }
                    else {
                        console.error(error);
                    }
                });
            }
            else {
                console.error(error);
            }
        });
        // Get bet and create join button
        c4.bet(async function (error, result) {
            if (!error) {
                var running = await gameRunning();
                var nst = await checkNStones();
                if (running == true) {
                    $("#joinGame").html("Game is currently running. The players each bet " + result / 1e18 + " ETH on this match.")
                } else {
                    //console.log("resbet: "+result);
                    if (nst == -3) {
                        $("#joinGame").append("&nbsp;&nbsp;&nbsp;<a href='javascript:join(-1);' title='The minumim bet is 0.01 ETH and the maximum bet is 5 ETH.'>Enter your bet <strong>IN ETH</strong> and start a new game!<a>");
                    } else {
                        if (nst == -2) {
                            $("#bet").val("0");
                            $("#bet").hide();
                            $("#joinGame").html("<a href='javascript:join(" + result + ");'>Player 1 bet " + result / 1e18 + " ether. Match his bet and start the game!<a>");
                        } else if (nst == -1) {
                            $("#joinGame").html("<strong><a href=\"javascript:startGame();\" title='This step is needed to generate a secure seed for the random number generator; making sure the starting player and the starting blocks are properly randomized.'>-START THE GAME-</a></strong>. <br>");
                            $("#bet").hide();
                        }
                    }
                }
            }
            else {
                console.error(error);
            }
        });
        // Draw Grid
        c4.getGrid(function (error, result) {
            if (!error) {
                // result = result.flat(); // flat doesnt work on some machines
                result = result.reduce((acc, val) => acc.concat(val), []);
                var grid = [];
                for (i = 0; i < 42; i++) {
                    grid.push(result[i]["c"][0]);
                }
                var text = "";
                var count = 0;
                for (k = 0; k < 6; k++) {
                    for (j = 0; j < 7; j++) {
                        count++;
                        if (j * 6 + k <= 5)
                            text += "<tr>";
                        var playString = " onClick='javascript:playStone(" + Math.floor((j * 6 + k) / 6) + ");'";
                        if (grid[j * 6 + k] == 0)
                            text += "<td><button type=\"button\" " + playString + "></button></td>";
                        else if (grid[j * 6 + k] == 1)
                            text += "<td><button type=\"button\" class=\"red\" ></button></td>";
                        else
                            text += "<td><button type=\"button\" class=\"blue\"></button></td>";
                        if (j * 6 + k >= 36)
                            text += "</tr>";
                    }
                }
                $("#tableBody").html(text);
            }
            else {
                console.error(error);
            }
        });
        // read results of last matches and display if any are found
        async function getLastMatch(pos) {
            let promise = new Promise((resolve, reject) => {
                c4.lastMatches(pos, function (error, result) {
                    if (!error) {
                        //console.log(result);
                        resolve(result);
                    } else {
                        console.error(error);
                        reject(error);
                    }
                });
            });
            return await promise;
        }
        c4.lastMatchPointer(async function (error, result) {
            if (!error) {
                //console.log("pointer:"+result);
                var pointer = result;
                // grab matches and enforce order
                var lastMatches = new Array(5);
                for (var i = 4; i >= 0; i--) {
                    pos = (pointer + i) % 5;
                    var lm = await getLastMatch(pos);
                    lastMatches[pos] = lm;
                }
                //console.log(lastMatches);
                // print matches in order
                $("#lastMatch").html("Last Matches:<br> <ul>");
                for (var i = 4; i >= 0; i--) {
                    match = lastMatches[i];
                    //console.log(match);
                    if (match[3] == 42) {
                        $("#lastMatch").append("<li>Draw. Each player won " + match[2] / 1e18 + " ETH after " + match[3] + " moves. <a href=\"javascript:dialogGrid(" +
                            (i + 1) + ",'" + match[0] + "','" + match[1] + "'," + match[3] + ")\">Click here to see final position.</a></li>");
                    } else if (match[3] > 0) {
                        $("#lastMatch").append("<li>" + match[0] + " won " + match[2] / 1e18 + " ETH after " + match[3] + " moves. <a href=\"javascript:dialogGrid(" +
                            (i + 1) + ",'" + match[0] + "','" + match[1] + "'," + match[3] + ")\">Click here to see final position.</a></li>");
                    }
                }
                $("#lastMatch").append("</ul>");
            }
            else {
                console.error(error);
            }
        });
        $(document).ready(function () {
            $("#joinGame").css('visibility', 'visible');
        });
        function dialogGrid(id, p1, p2, nsts) {
            if (id == 0)
                return;
            c4.getFinalGrid(id - 1, function (error, result) {
                if (!error) {
                    //console.log("final grid:"+result);
                    // result = result.flat(); // flat doesnt work on some machines
                    result = result.reduce((acc, val) => acc.concat(val), []);
                    var grid = [];
                    for (i = 0; i < 42; i++) {
                        grid.push(result[i]["c"][0]);
                    }
                    var text = "";
                    var count = 0;
                    for (k = 0; k < 6; k++) {
                        for (j = 0; j < 7; j++) {
                            count++;
                            if (j * 6 + k <= 5)
                                text += "<tr>";
                            if (grid[j * 6 + k] == 0)
                                text += "<td><button type=\"button\"></button></td>";
                            else if (grid[j * 6 + k] == 1)
                                text += "<td><button type=\"button\" class=\"red\" ></button></td>";
                            else
                                text += "<td><button type=\"button\" class=\"blue\"></button></td>";
                            if (j * 6 + k >= 36)
                                text += "</tr>";
                        }
                    }
                    if (nsts == 42) {
                        $("#dialog_player1").html("<Player 1: " + p1);
                        $("#dialog_player2").html("Player 2: " + p2);
                    } else {
                        $("#dialog_player1").html("Winner: " + p1);
                        $("#dialog_player2").html("Opponent: " + p2);
                    }
                    $("#tableBodyDialog").html(text);
                    $("#dialog").dialog({width: 480});
                }
                else {
                    console.error(error);
                }
            });
        }
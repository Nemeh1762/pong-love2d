
local Extras = {}

local utf8 = require("utf8")

-- Game Settings
Extras.winningScore = 5

-- Player Names
Extras.player1Name = ""
Extras.player2Name = ""

-- Total Match Wins
Extras.player1Wins = 0
Extras.player2Wins = 0

-- Game States
Extras.state = "naming"

-- Active Player for Name Input
Extras.activePlayer = 1

-- Winner
Extras.winner = nil

-- Increase Ball Speed (Extra Feature)
function Extras.increaseBallSpeed(ball)

    local speedX = math.min(math.abs(ball.dx) * 1.05, 850)
    local speedY = math.min(math.abs(ball.dy) * 1.05, 850)

    ball.dx = (ball.dx < 0 and -speedX or speedX)
    ball.dy = (ball.dy < 0 and -speedY or speedY)

end

-- Start New Match
function Extras.startMatch(Game)

    Game.resetMatch()

    Extras.winner = nil
    Extras.state = "playing"

end

-- Finish Match
function Extras.finishMatch(player)

    Extras.winner = player
    Extras.state = "gameover"

    if player == 1 then
        Extras.player1Wins = Extras.player1Wins + 1
    else
        Extras.player2Wins = Extras.player2Wins + 1
    end

end

-- Handle Name Input
function Extras.textinput(text)

    if Extras.state ~= "naming" then
        return
    end

    if Extras.activePlayer == 1 then

        if utf8.len(Extras.player1Name) < 16 then
            Extras.player1Name = Extras.player1Name .. text
        end

    else

        if utf8.len(Extras.player2Name) < 16 then
            Extras.player2Name = Extras.player2Name .. text
        end

    end

end

-- Handle Keyboard Input
function Extras.keypressed(key, Game)

    if Extras.state == "naming" then

        if key == "backspace" then

            if Extras.activePlayer == 1 then

                local position = utf8.offset(
                    Extras.player1Name, -1
                )

                if position then
                    Extras.player1Name =
                        string.sub(Extras.player1Name, 1, position - 1)
                end

            else

                local position = utf8.offset(
                    Extras.player2Name, -1
                )

                if position then
                    Extras.player2Name =
                        string.sub(Extras.player2Name, 1, position - 1)
                end

            end

        elseif key == "return" or key == "kpenter" then

            if Extras.activePlayer == 1 then

                if Extras.player1Name == "" then
                    Extras.player1Name = "Player 1"
                end

                Extras.activePlayer = 2

            else

                if Extras.player2Name == "" then
                    Extras.player2Name = "Player 2"
                end

                Extras.startMatch(Game)

            end

        end

    elseif Extras.state == "gameover" then

        if key == "return" or key == "kpenter" then

            Extras.startMatch(Game)

        elseif key == "n" then

            Extras.player1Name = ""
            Extras.player2Name = ""

            Extras.activePlayer = 1
            Extras.winner = nil

            Extras.state = "naming"

        end

    end

end

return Extras


local Game = require("game")
local Extras = require("extras")
local Design = require("design")

-- =================================
-- Load Game
-- =================================

function love.load()

    love.window.setMode(Game.WIDTH, Game.HEIGHT)
    love.window.setTitle("Pong - Retro Futuristic Arcade")

    Design.load()

end

-- =================================
-- Update Game
-- =================================

function love.update(dt)

    if Extras.state ~= "playing" then
        return
    end

    -- Update Game and Handle Paddle Hits
    local scorer = Game.update(
        dt,
        Extras.increaseBallSpeed
    )

    -- Handle Scoring and Winning
    if scorer == "player1" then

        if Game.player1Score >= Extras.winningScore then

            Extras.finishMatch(1)

        else

            Game.resetBall(-1)

        end

    elseif scorer == "player2" then

        if Game.player2Score >= Extras.winningScore then

            Extras.finishMatch(2)

        else

            Game.resetBall(1)

        end

    end

end

-- =================================
-- Draw Game
-- =================================

function love.draw()

    Design.draw(Game, Extras)

end

-- =================================
-- Keyboard Input
-- =================================

function love.keypressed(key)

    Extras.keypressed(key, Game)

end

-- =================================
-- Text Input
-- =================================

function love.textinput(text)

    Extras.textinput(text)

end

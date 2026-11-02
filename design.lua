
local Design = {}

-- Color Palette
local COLORS = {
    background = {0.06, 0.09, 0.15},
    turquoise = {0.21, 0.84, 0.77},
    orange = {1.0, 0.65, 0.32},
    cream = {0.95, 0.94, 0.87},
    muted = {0.58, 0.65, 0.72},
    panel = {0.09, 0.13, 0.21}
}

-- Load Fonts
function Design.load()

    Design.titleFont = love.graphics.newFont(38)
    Design.largeFont = love.graphics.newFont(30)
    Design.mediumFont = love.graphics.newFont(20)
    Design.smallFont = love.graphics.newFont(14)

end

-- Background
local function drawBackground(Game)

    love.graphics.clear(COLORS.background)

    -- Decorative background circles
    love.graphics.setColor(0.12, 0.18, 0.25, 0.35)

    for i = 1, 8 do

        love.graphics.circle(
            "fill",
            i * 110,
            150 + (i % 2) * 300,
            35
        )

    end

    -- Game Area Border
    love.graphics.setColor(0.25, 0.35, 0.43, 0.5)

    love.graphics.rectangle(
        "line",
        15, 15,
        Game.WIDTH - 30,
        Game.HEIGHT - 30,
        10, 10
    )

end

-- Game Title
local function drawTitle(Game)

    love.graphics.setFont(Design.titleFont)
    love.graphics.setColor(COLORS.cream)

    love.graphics.printf(
        "PONG",
        0, 145,
        Game.WIDTH,
        "center"
    )

    love.graphics.setFont(Design.smallFont)
    love.graphics.setColor(COLORS.turquoise)

    love.graphics.printf(
        "RETRO FUTURISTIC ARCADE",
        0, 190,
        Game.WIDTH,
        "center"
    )

end

-- Naming Screen
local function drawNaming(Game, Extras)

    drawTitle(Game)

    love.graphics.setFont(Design.mediumFont)
    love.graphics.setColor(COLORS.cream)

    love.graphics.printf(
        "CREATE YOUR PLAYERS",
        0, 250,
        Game.WIDTH,
        "center"
    )

    love.graphics.setFont(Design.mediumFont)

    love.graphics.setColor(COLORS.turquoise)

    local name1 = Extras.player1Name

    if Extras.activePlayer == 1 then
        name1 = name1 .. "_"
    end

    love.graphics.printf(
        "PLAYER 1: " .. name1,
        0, 315,
        Game.WIDTH,
        "center"
    )

    love.graphics.setColor(COLORS.orange)

    local name2 = Extras.player2Name

    if Extras.activePlayer == 2 then
        name2 = name2 .. "_"
    end

    love.graphics.printf(
        "PLAYER 2: " .. name2,
        0, 365,
        Game.WIDTH,
        "center"
    )

    love.graphics.setFont(Design.smallFont)
    love.graphics.setColor(COLORS.muted)

    love.graphics.printf(
        "TYPE YOUR NAME AND PRESS ENTER",
        0, 450,
        Game.WIDTH,
        "center"
    )

    love.graphics.printf(
        "BACKSPACE TO DELETE",
        0, 480,
        Game.WIDTH,
        "center"
    )

end

-- Scoreboard
local function drawScoreboard(Game, Extras)

    love.graphics.setFont(Design.mediumFont)

    love.graphics.setColor(COLORS.turquoise)

    love.graphics.printf(
        Extras.player1Name,
        50, 35, 300,
        "center"
    )

    love.graphics.setColor(COLORS.orange)

    love.graphics.printf(
        Extras.player2Name,
        450, 35, 300,
        "center"
    )

    love.graphics.setFont(Design.largeFont)
    love.graphics.setColor(COLORS.cream)

    love.graphics.printf(
        tostring(Game.player1Score),
        50, 65, 300,
        "center"
    )

    love.graphics.printf(
        tostring(Game.player2Score),
        450, 65, 300,
        "center"
    )

    love.graphics.setFont(Design.smallFont)
    love.graphics.setColor(COLORS.muted)

    love.graphics.printf(
        "MATCH WINS: " .. Extras.player1Wins,
        50, 108, 300,
        "center"
    )

    love.graphics.printf(
        "MATCH WINS: " .. Extras.player2Wins,
        450, 108, 300,
        "center"
    )

    -- Center Divider
    love.graphics.setColor(0.4, 0.5, 0.55, 0.5)

    love.graphics.line(40, 135, Game.WIDTH - 40, 135)

end

-- Center Line
local function drawCenterLine(Game)

    love.graphics.setColor(
        COLORS.turquoise[1],
        COLORS.turquoise[2],
        COLORS.turquoise[3],
        0.6
    )

    for y = 155, Game.HEIGHT - 60, 30 do

        love.graphics.rectangle(
            "fill",
            Game.WIDTH / 2 - 2,
            y,
            4,
            15,
            2, 2
        )

    end

end

-- Neon Style Paddle
local function drawPaddle(paddle, color)

    -- Soft Glow
    love.graphics.setColor(
        color[1],
        color[2],
        color[3],
        0.18
    )

    love.graphics.rectangle(
        "fill",
        paddle.x - 5,
        paddle.y - 5,
        paddle.width + 10,
        paddle.height + 10,
        8, 8
    )

    -- Main Paddle
    love.graphics.setColor(color)

    love.graphics.rectangle(
        "fill",
        paddle.x,
        paddle.y,
        paddle.width,
        paddle.height,
        5, 5
    )

end

-- Ball
local function drawBall(ball)

    local centerX = ball.x + ball.width / 2
    local centerY = ball.y + ball.height / 2
    local radius = ball.width / 2

    -- Soft Glow
    love.graphics.setColor(1, 0.65, 0.32, 0.15)

    love.graphics.circle(
        "fill",
        centerX,
        centerY,
        radius + 12
    )

    -- Main Ball
    love.graphics.setColor(COLORS.cream)

    love.graphics.circle(
        "fill",
        centerX,
        centerY,
        radius
    )

end

-- Controls
local function drawControls(Game)

    love.graphics.setFont(Design.smallFont)
    love.graphics.setColor(COLORS.muted)

    love.graphics.printf(
        "PLAYER 1: W / S       PLAYER 2: UP / DOWN",
        0,
        Game.HEIGHT - 35,
        Game.WIDTH,
        "center"
    )

end

-- Game Over Screen
local function drawGameOver(Game, Extras)

    love.graphics.setColor(0.02, 0.04, 0.08, 0.94)

    love.graphics.rectangle(
        "fill",
        100, 190,
        600, 230,
        12, 12
    )

    love.graphics.setColor(COLORS.orange)
    love.graphics.setFont(Design.largeFont)

    love.graphics.printf(
        "GAME OVER",
        100, 220, 600,
        "center"
    )

    love.graphics.setColor(COLORS.cream)
    love.graphics.setFont(Design.mediumFont)

    local winnerName = Extras.player1Name

    if Extras.winner == 2 then
        winnerName = Extras.player2Name
    end

    love.graphics.printf(
        winnerName .. " WINS!",
        100, 275, 600,
        "center"
    )

    love.graphics.setFont(Design.smallFont)
    love.graphics.setColor(COLORS.turquoise)

    love.graphics.printf(
        "PRESS ENTER TO PLAY AGAIN",
        100, 335, 600,
        "center"
    )

    love.graphics.setColor(COLORS.muted)

    love.graphics.printf(
        "PRESS N TO CHANGE NAMES",
        100, 375, 600,
        "center"
    )

end

-- Main Draw Function
function Design.draw(Game, Extras)

    drawBackground(Game)

    if Extras.state == "naming" then
        drawNaming(Game, Extras)
        return
    end

    drawScoreboard(Game, Extras)
    drawCenterLine(Game)

    drawPaddle(Game.player1, COLORS.turquoise)
    drawPaddle(Game.player2, COLORS.orange)

    drawBall(Game.ball)
    drawControls(Game)

    if Extras.state == "gameover" then
        drawGameOver(Game, Extras)
    end

end

return Design


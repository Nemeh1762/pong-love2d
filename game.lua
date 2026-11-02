
local Game = {}

-- Screen Dimensions
Game.WIDTH = 800
Game.HEIGHT = 600

-- Player Scores
Game.player1Score = 0
Game.player2Score = 0

-- Left Paddle
Game.player1 = {
    x = 30,
    y = 250,
    width = 15,
    height = 100,
    speed = 300
}

-- Right Paddle
Game.player2 = {
    x = 755,
    y = 250,
    width = 15,
    height = 100,
    speed = 300
}

-- Ball
Game.ball = {
    x = 390,
    y = 290,
    width = 20,
    height = 20,
    dx = 250,
    dy = 150
}

-- AABB Collision Detection
function Game.checkCollision(a, b)

    return a.x < b.x + b.width and
           a.x + a.width > b.x and
           a.y < b.y + b.height and
           a.y + a.height > b.y

end

-- Reset Ball
function Game.resetBall(direction)

    Game.ball.x = 390
    Game.ball.y = 290

    Game.ball.dx = 250 * direction
    Game.ball.dy = 150

end

-- Reset Match
function Game.resetMatch()

    Game.player1Score = 0
    Game.player2Score = 0

    Game.player1.y = 250
    Game.player2.y = 250

    Game.resetBall(1)

end

-- Update Game
function Game.update(dt, onPaddleHit)

    local p1 = Game.player1
    local p2 = Game.player2
    local ball = Game.ball

    -- Left Paddle Movement (W / S)

    if love.keyboard.isDown("w") then
        p1.y = p1.y - p1.speed * dt
    end

    if love.keyboard.isDown("s") then
        p1.y = p1.y + p1.speed * dt
    end

    -- Right Paddle Movement (Up / Down)

    if love.keyboard.isDown("up") then
        p2.y = p2.y - p2.speed * dt
    end

    if love.keyboard.isDown("down") then
        p2.y = p2.y + p2.speed * dt
    end

    -- Keep Paddles Inside Screen

    p1.y = math.max(0, math.min(
        p1.y,
        Game.HEIGHT - p1.height
    ))

    p2.y = math.max(0, math.min(
        p2.y,
        Game.HEIGHT - p2.height
    ))

    -- Ball Movement

    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt

    -- Top Wall Collision

    if ball.y <= 0 then
        ball.y = 0
        ball.dy = -ball.dy
    end

    -- Bottom Wall Collision

    if ball.y + ball.height >= Game.HEIGHT then
        ball.y = Game.HEIGHT - ball.height
        ball.dy = -ball.dy
    end

    -- Left Paddle Collision

    if ball.dx < 0 and Game.checkCollision(ball, p1) then

        ball.x = p1.x + p1.width
        ball.dx = math.abs(ball.dx)

        onPaddleHit(ball)

    end

    -- Right Paddle Collision

    if ball.dx > 0 and Game.checkCollision(ball, p2) then

        ball.x = p2.x - ball.width
        ball.dx = -math.abs(ball.dx)

        onPaddleHit(ball)

    end

    -- Scoring Detection

    if ball.x + ball.width < 0 then

        Game.player2Score = Game.player2Score + 1
        return "player2"

    elseif ball.x > Game.WIDTH then

        Game.player1Score = Game.player1Score + 1
        return "player1"

    end

    return nil

end

return Game

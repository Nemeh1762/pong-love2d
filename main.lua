
-- Screen dimensions
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

-- Left Paddle
player1 = {
    x = 30,
    y = 250,
    width = 15,
    height = 100,
    speed = 300
}

-- Right Paddle
player2 = {
    x = 755,
    y = 250,
    width = 15,
    height = 100,
    speed = 300
}

function love.load()

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)

    love.window.setTitle("Pong Game")

end

function love.update(dt)

    -- Left Paddle Movement (W / S)

    if love.keyboard.isDown("w") then
        player1.y = player1.y - player1.speed * dt
    end

    if love.keyboard.isDown("s") then
        player1.y = player1.y + player1.speed * dt
    end

    -- Right Paddle Movement (Up / Down)

    if love.keyboard.isDown("up") then
        player2.y = player2.y - player2.speed * dt
    end

    if love.keyboard.isDown("down") then
        player2.y = player2.y + player2.speed * dt
    end

    -- Keep paddles inside the screen

    player1.y = math.max(0, math.min(
        player1.y,
        WINDOW_HEIGHT - player1.height
    ))

    player2.y = math.max(0, math.min(
        player2.y,
        WINDOW_HEIGHT - player2.height
    ))

end

function love.draw()

    -- Dark background
    love.graphics.clear(0.05, 0.05, 0.10)

    -- Draw left paddle
    love.graphics.setColor(1, 1, 1)

    love.graphics.rectangle(
        "fill",
        player1.x,
        player1.y,
        player1.width,
        player1.height
    )

    -- Draw right paddle
    love.graphics.rectangle(
        "fill",
        player2.x,
        player2.y,
        player2.width,
        player2.height
    )

end

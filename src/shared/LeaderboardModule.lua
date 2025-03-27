local LeaderboardModule = {}
local Players = game:GetService("Players")

-- Set up the leaderstats for new players
Players.PlayerAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local money = Instance.new("IntValue")
    money.Name = "Money"
    money.Value = 0  -- Starting money value
    money.Parent = leaderstats

    local xp = Instance.new("IntValue")
    xp.Name = "XP"
    xp.Value = 0  -- Starting XP value
    xp.Parent = leaderstats
end)

-- Function to add money to a player's leaderstats
function LeaderboardModule.AddMoney(player, amount)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local money = leaderstats:FindFirstChild("Money")
        if money then
            money.Value = money.Value + amount
        end
    end
end

-- Function to add XP to a player's leaderstats
function LeaderboardModule.AddXP(player, amount)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local xp = leaderstats:FindFirstChild("XP")
        if xp then
            xp.Value = xp.Value + amount
        end
    end
end

return LeaderboardModule

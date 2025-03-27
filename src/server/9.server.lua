local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LeaderboardModule = require(ReplicatedStorage.LeaderboardModule)
local Players = game:GetService("Players")

-- Example usage: add 50 money and 10 XP to a player

Players.PlayerAdded:Connect(function(player)
    LeaderboardModule.AddMoney(player, 50)
    LeaderboardModule.AddXP(player, 10)
    player.CharacterAdded:Connect(function(character)
        LeaderboardModule.AddMoney(player, 50)
        LeaderboardModule.AddXP(player, 10)
    end)
end)



-- need to fix this one

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Reference the imported Zombie model from the Workspace
local zombie = workspace:FindFirstChild("Drooling Zombie")
if not zombie then
    error("Zombie model not found in Workspace!")
end

-- Try to get the zombie's main part (Torso or HumanoidRootPart)
local torso = zombie:FindFirstChild("Torso") or zombie:FindFirstChild("HumanoidRootPart")
if not torso then
    error("Zombie does not have a 'Torso' or 'HumanoidRootPart'!")
end

-- Ensure the torso is not anchored so it can move
torso.Anchored = false

-- Function to damage a player when touched
local DAMAGE_AMOUNT = 20
local function onZombieTouched(hit)
    local character = hit.Parent
    if character then
        local playerHumanoid = character:FindFirstChildWhichIsA("Humanoid")
        if playerHumanoid then
            playerHumanoid:TakeDamage(DAMAGE_AMOUNT)
        end
    end
end

-- Connect the touch event to the zombie's main part
torso.Touched:Connect(onZombieTouched)

-- Function to chase a player if within 20 studs
local function chasePlayer(player)
    print("Chasing player:", player.Name)
    local character = player.Character or player.CharacterAdded:Wait()
    local targetPart = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    if not targetPart then return end

    while character and character.Parent and zombie and zombie.Parent do
        local distance = (targetPart.Position - torso.Position).Magnitude

        if distance <= 20 then
            print("Less than 20")
            local origin = torso.Position
            local direction = (targetPart.Position - origin).Unit * 20

            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {zombie, character}
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

            local rayResult = workspace:Raycast(origin, direction, raycastParams)
            if rayResult and rayResult.Instance:IsDescendantOf(character) then
                local moveDirection = (targetPart.Position - torso.Position).Unit
                torso.Velocity = moveDirection * 10  -- Adjust speed as needed
            else
                torso.Velocity = Vector3.new(0, torso.Velocity.Y, 0)
            end
        else
            torso.Velocity = Vector3.new(0, torso.Velocity.Y, 0)
        end

        RunService.Heartbeat:Wait()
    end
end

-- Listen for new players joining and start chasing them
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        chasePlayer(player)
    end)
end)

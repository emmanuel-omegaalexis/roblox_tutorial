local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

----------------------------
-- Create the Zombie NPC
----------------------------

local DAMAGE_AMOUNT = 20  -- Adjust damage as needed

-- Create a basic model for the zombie
local zombie = Instance.new("Model")
zombie.Name = "Zombie"
zombie.Parent = workspace

-- Create the zombie's torso (used as the main part)
local torso = Instance.new("Part")
torso.Name = "Torso"
torso.Size = Vector3.new(2, 2, 1)
torso.Position = Vector3.new(10, 1, 0)  -- Starting position
torso.Anchored = false
torso.Parent = zombie

-- Add a humanoid so it behaves like a character (optional for demonstration)
local humanoid = Instance.new("Humanoid")
humanoid.Parent = zombie

local function onZombieTouched(hit)
    local character = hit.Parent
    if character then
        local playerHumanoid = character:FindFirstChildWhichIsA("Humanoid")
        if playerHumanoid then
            playerHumanoid:TakeDamage(DAMAGE_AMOUNT)
        end
    end
end

torso.Touched:Connect(onZombieTouched)

-------------------------------------------
-- Function to Chase a Player if Nearby
-------------------------------------------
local function chasePlayer(player)
    -- Wait for the player's character to load
    local character = player.Character or player.CharacterAdded:Wait()
    -- Try to get the head (or fallback to HumanoidRootPart)
    local targetPart = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    if not targetPart then
        return
    end

    -- Continuously check while the character and zombie exist
    while character and character.Parent and zombie and zombie.Parent do
        -- Calculate distance from zombie to the target part
        local distance = (targetPart.Position - torso.Position).Magnitude

        if distance <= 20 then
            -- Use raycasting from the zombie's torso towards the player's target part
            -- Raycasting is like shining a laser beam from a point in a specific direction to see what it hits. 
            -- Imagine you’re standing in a dark room with a flashlight. When you point the flashlight in one direction, 
            -- you can see if there's an object in its path. In programming, raycasting sends an invisible "ray" (or line) 
            -- and returns information about the first object it encounters along that line. This is useful for detecting 
            -- obstacles, checking if a player is in sight, or finding where to place objects in a game.
            
            local origin = torso.Position
            local direction = (targetPart.Position - origin).Unit * 20  -- Ray length of 20 studs

            local raycastParams = RaycastParams.new()
            -- Exclude the zombie and the player's character from the raycast
            raycastParams.FilterDescendantsInstances = {zombie, character}
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

            local rayResult = workspace:Raycast(origin, direction, raycastParams)
            
            if rayResult then
                -- If the ray hits something and it's part of the player's character, we "see" the player
                if rayResult.Instance:IsDescendantOf(character) then
                    -- Move the zombie towards the player's target part
                    local moveDirection = (targetPart.Position - torso.Position).Unit
                    torso.Velocity = moveDirection * 10  -- Adjust speed as needed
                else
                    -- If something blocks the line of sight, stop horizontal movement
                    torso.Velocity = Vector3.new(0, torso.Velocity.Y, 0)
                end
            else
                -- If nothing was hit, still move toward the player
                local moveDirection = (targetPart.Position - torso.Position).Unit
                torso.Velocity = moveDirection * 10
            end
        else
            -- If player is not within 20 studs, stop horizontal movement
            torso.Velocity = Vector3.new(0, torso.Velocity.Y, 0)
        end

        --RunService.Heartbeat:Wait() pauses the execution of the loop until the next frame update. Essentially, it waits for 
        -- the Heartbeat event, which fires every frame, and then returns the time (delta time) elapsed 
        -- since the last Heartbeat. This helps in making your loop frame-rate independent and ensures smooth 
        -- updates without freezing the script.
        RunService.Heartbeat:Wait()
    end
end

-------------------------------------
-- Listen for New Players Joining
-------------------------------------
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        -- Start chasing the player when their character spawns
        chasePlayer(player)
    end)
end)

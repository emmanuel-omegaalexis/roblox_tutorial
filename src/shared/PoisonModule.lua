local PoisonModule = {}

local DAMAGE = 20  -- Damage dealt when touched

-- Function to create a poison sphere and a spawn point
function PoisonModule.createPoisonEnvironment()
    -- Create the poison sphere
    local sphere = Instance.new("Part")
    sphere.Name = "PoisonSphere"
    sphere.Shape = Enum.PartType.Ball
    sphere.Size = Vector3.new(5, 5, 5)
    sphere.Position = Vector3.new(0, 5, 0)
    sphere.Color = Color3.fromRGB(255, 0, 0)
    sphere.Material = Enum.Material.Neon  -- Makes it glow
    sphere.Anchored = true
    sphere.Parent = workspace

    -- Create a spawn point 10 studs away from the sphere
    local spawnPoint = Instance.new("SpawnLocation")
    spawnPoint.Name = "PoisonSpawn"
    spawnPoint.Size = Vector3.new(6, 1, 6)
    -- Position the spawn point 10 studs to the right (X axis) of the sphere
    spawnPoint.Position = sphere.Position + Vector3.new(10, 0, 0)
    spawnPoint.Anchored = true
    spawnPoint.CanCollide = false
    -- Optional: Hide the spawn location's appearance if you don't want it visible
    spawnPoint.Transparency = 1
    spawnPoint.Neutral = true  -- Allow any player to spawn here
    spawnPoint.Parent = workspace

    -- Connect a Touched event on the sphere to cause damage to players
    sphere.Touched:Connect(function(hit)
        local character = hit.Parent
        if character then
            local humanoid = character:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
                print("Dealing damage to", character)
                humanoid:TakeDamage(DAMAGE)
                -- sphere:Destroy()  -- Remove the sphere after touching it
            end
        end
    end)
end

return PoisonModule

local MoonModule = {}

-- Function to create a moon-like sphere
function MoonModule.createMoon(xaxis)

    xaxis = xaxis or -5
    -- Create a new Part
    local moon = Instance.new("Part")
    moon.Shape = Enum.PartType.Ball        -- Make it spherical
    moon.Size = Vector3.new(5, 5, 5)           -- Set a size (you can adjust as needed)
    moon.Position = Vector3.new(xaxis, 10, 0)      -- Set an initial position
    moon.Material = Enum.Material.Granite     -- Set a material (granite gives a rocky look)
    
    -- Parent the moon to the Workspace so it appears in the game
    moon.Parent = workspace

    return moon
end

-- Function to rotate the moon on its own axis
-- rotationSpeed: degrees per second (e.g., 30 means it rotates 30° per second)
function MoonModule.rotateMoon(moon, rotationSpeed)
    local RunService = game:GetService("RunService")
    
    -- Connect to the Heartbeat event for smooth frame updates
    local connection
    connection = RunService.Heartbeat:Connect(function(deltaTime)
        if moon and moon.Parent then
            -- Rotate around the Y-axis (vertical axis)
            moon.CFrame = moon.CFrame * CFrame.Angles(0, math.rad(rotationSpeed * deltaTime), 0)
        else
            -- Disconnect if the moon is removed from the workspace
            connection:Disconnect()
        end
    end)
end

function MoonModule.rotateMoonUsingWhile(moon, rotationSpeed)
    -- rotationSpeed: degrees per second
    while moon and moon.Parent do
        local dt = task.wait(0.03)  -- Wait returns the time passed since the last call
        -- local dt = 1
        moon.CFrame = moon.CFrame * CFrame.Angles(0, math.rad(rotationSpeed * dt), 0)
    end
end

return MoonModule

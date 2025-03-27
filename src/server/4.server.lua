local Players = game:GetService("Players")

-- Function to create the wall with touch event
function createWall()
    local wall = Instance.new("Part")
    wall.Size = Vector3.new(20, 10, 1)        -- Set the wall size
    wall.Position = Vector3.new(0, 5, -10)        -- Position the wall off the ground
    wall.Anchored = true                      -- Keep the wall stationary
    wall.Parent = workspace                   -- Parent the wall to the Workspace

    -- When the wall is touched...
    wall.Touched:Connect(function(hit)
        local character = hit.Parent
        local player = Players:GetPlayerFromCharacter(character)
        
        if player then
            local playerGui = player:WaitForChild("PlayerGui")
            
            -- Create a ScreenGui to show the message
            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "OuchGui"
            screenGui.Parent = playerGui
            
            -- Create a TextLabel to display "Ouch!"
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
            textLabel.Position = UDim2.new(0.35, 0, 0.45, 0)
            textLabel.Text = "Ouch!"
            textLabel.TextScaled = true
            textLabel.BackgroundTransparency = 0.5
            textLabel.Parent = screenGui

            -- Remove the GUI after 2 seconds
            wait(2)
            screenGui:Destroy()
        end
    end)
end

-- Call the function to create the wall
createWall()

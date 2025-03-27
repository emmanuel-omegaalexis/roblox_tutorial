local PartStacker = {}

-- Create a vertical stack of parts.
-- numBlocks: Number of parts to create (default is 5 if not provided)
function PartStacker.createStack(numBlocks)
    numBlocks = numBlocks or 5  -- default value if none provided
    local basePosition = Vector3.new(0, 5, 0)  -- starting position
    local blockHeight = 4  -- height of each block

    -- Find or create the folder "Stacks" in the Workspace
    local folder = workspace:FindFirstChild("Stacks")
    if not folder then
        folder = Instance.new("Folder")
        folder.Name = "Stacks"
        folder.Parent = workspace
    end

    for i = 1, numBlocks do
        local part = Instance.new("Part")
        part.Size = Vector3.new(4, blockHeight, 4)
        part.Name = "Block" .. i
        -- Position each block so it stacks above the previous one
        part.Position = basePosition + Vector3.new(0, (i - 1) * blockHeight, 0)
        
        if i == numBlocks then
            -- The last block is green.
            part.Color = Color3.fromRGB(0, 255, 0)
        else
            -- Change the red value with the loop index.
            -- Scale the red component to 255 over the number of blocks.
            local redValue = math.floor((i / numBlocks) * 255)
            part.Color = Color3.fromRGB(redValue, 0, 0)
        end
        
        -- Parent the part to the folder "Stacks"
        part.Parent = folder
    end
end

function PartStacker.printStackColors()
    local folder = workspace:FindFirstChild("Stacks")
    if not folder or not folder:IsA("Folder") then
        print("No 'Stacks' folder found in Workspace.")
        return
    end

    for _, child in ipairs(folder:GetChildren()) do
        if child:IsA("Part") then
            print(child.Name .. " color:", child.Color)
        end
    end
end

return PartStacker

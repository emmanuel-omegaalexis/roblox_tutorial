local workspace = game:GetService("Workspace")


-- Create a new part
local part = Instance.new("Part")

-- Set the part's parent to the Workspace so it appears in the game
part.Parent = workspace

-- Optional: Set the part's position (this example places it at (0, 5, 0))
part.Position = Vector3.new(10, 5, 0)

-- Change the part's color to red using RGB values
part.Color = Color3.fromRGB(255, 0, 0)

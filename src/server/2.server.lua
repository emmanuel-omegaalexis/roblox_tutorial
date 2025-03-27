local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MoonModule = require(ReplicatedStorage.MoonModule)

local moon = MoonModule.createMoon()     -- Create the moon
MoonModule.rotateMoon(moon, 30)            -- Rotate the moon at 30 degrees per second



local moon2 = MoonModule.createMoon(5)     -- Create the moon
MoonModule.rotateMoonUsingWhile(moon2, 50)            -- Rotate the moon at 30 degrees per second


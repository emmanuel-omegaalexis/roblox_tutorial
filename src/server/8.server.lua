local Lighting = game:GetService("Lighting")

-- Define the starting time (0 to 24). For example, 8 for 8:00 AM.
local startTime = 8
Lighting.ClockTime = startTime

-- Define speeds: these determine how much the ClockTime changes per update
local daySpeed = 0.05   -- slower during the day (6–18)
local nightSpeed = 0.1  -- faster during the night (elsewhere)
local updateInterval = 0.1  -- update every 0.1 seconds

while true do
    local currentTime = Lighting.ClockTime
    local speed

    -- Determine the speed based on time of day
    if currentTime >= 6 and currentTime < 18 then
        speed = daySpeed
    else
        speed = nightSpeed
    end

    -- Update the ClockTime and wrap around after 24
    Lighting.ClockTime = (currentTime + speed) % 24
    wait(updateInterval)
end

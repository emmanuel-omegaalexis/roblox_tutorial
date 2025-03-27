local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PartStacker = require(ReplicatedStorage.PartStacker)

PartStacker.createStack(5)  -- Creates a stack of 10 parts

task.wait(2)

PartStacker.printStackColors()  -- Prints the colors of the parts in the stack
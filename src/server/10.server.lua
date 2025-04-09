--[[
===============================================================================
 CFRAME TUTORIAL - A Single Script Guide
===============================================================================

 What is a CFrame?
 -----------------
 CFrame stands for Coordinate Frame. It's a fundamental data type in Roblox
 used to represent both POSITION (where something is) and ORIENTATION (how
 something is rotated) in 3D space. Think of it as a combination of a
 Vector3 for position and a rotation matrix for orientation.

 Why use CFrames?
 ----------------
 - Precise positioning and rotation.
 - Handling relative movements (e.g., moving a part 5 studs *forward* regardless
   of its current rotation).
 - Making objects look at specific points.
 - Essential for complex mechanics, animations, camera manipulation, raycasting, etc.

 This script will create a Part in the workspace and manipulate it using
 CFrames, printing explanations to the Output window along the way.
 Make sure your Output window is visible (View -> Output).

===============================================================================
]]

-- Let's wait a moment for the game to load properly
wait(1)
print("===== CFrame Tutorial Initializing =====")

-- === 1. SETUP: Creating our Demo Part ===
-- We need a visual object to demonstrate CFrame manipulation.
local demoPart = Instance.new("Part")
demoPart.Name = "CFrameDemoPart"
demoPart.Anchored = true -- Keep it from falling or being affected by physics
demoPart.BrickColor = BrickColor.new("Bright blue")
demoPart.Size = Vector3.new(4, 2, 6) -- Make it non-square so orientation is obvious (Front face is -Z)
demoPart.Position = Vector3.new(0, 5, -15) -- Initial position in the world
demoPart.Parent = workspace

-- Add a decal to clearly show the front face (usually -Z axis)
local decal = Instance.new("Decal")
decal.Face = Enum.NormalId.Front
decal.Texture = "rbxassetid://241768982 -- A simple arrow texture" -- Roblox Arrow Decal
decal.Color3 = Color3.new(1, 1, 0) -- Yellow
decal.Parent = demoPart

print("Created a blue Part named 'CFrameDemoPart' at", demoPart.Position)
wait(3)

-- === 2. Accessing and Understanding a Part's CFrame ===
print("\n--- Section 2: Accessing CFrames ---")

-- Every BasePart (like Part, MeshPart, UnionOperation) has a CFrame property.
local currentCFrame = demoPart.CFrame
print("The Part's current CFrame is:", currentCFrame)
-- Notice the output: It shows multiple numbers. These represent the Position
-- and the Rotation Matrix components.

-- You can easily get the positional component of a CFrame:
local currentPosition = demoPart.CFrame.Position -- Preferred way
-- local currentPositionAlso = demoPart.CFrame.p -- Older, shorter way, still works
print("Extracted Position from CFrame:", currentPosition)
print("This matches the Part's .Position property:", demoPart.Position)

-- A CFrame also contains orientation information. Key components are vectors
-- representing the directions of the Part's local axes in world space:
print("LookVector (Direction the Front face (-Z) points):", currentCFrame.LookVector)
print("RightVector (Direction the Right face (+X) points):", currentCFrame.RightVector)
print("UpVector (Direction the Top face (+Y) points):", currentCFrame.UpVector)
-- These are *unit vectors* (length of 1) indicating direction.

wait(4)

-- === 3. Creating New CFrames ===
print("\n--- Section 3: Creating New CFrames ---")

-- You can create CFrames from scratch using various constructors.

-- 3a. CFrame.new(Vector3 position) - Creates a CFrame at a position with NO rotation (aligned with world axes)
print("Creating a CFrame using just position...")
local posOnlyCFrame = CFrame.new(Vector3.new(5, 10, -10))
-- You can also pass x, y, z directly: CFrame.new(5, 10, -10)

print("Setting Part's CFrame to the position-only CFrame:", posOnlyCFrame)
demoPart.CFrame = posOnlyCFrame
-- Observe the part moving in the workspace. Its orientation should reset.
print("Part's new LookVector (should be 0, 0, -1):", demoPart.CFrame.LookVector)
wait(3)

-- 3b. CFrame.new(Vector3 position, Vector3 lookAt) - Creates a CFrame at 'position', oriented to face 'lookAt'
print("Creating a CFrame that looks at a specific point...")
local lookAtPoint = Vector3.new(0, 5, 0) -- A point near the world origin
print("Target LookAt point:", lookAtPoint)

-- Create a CFrame at the part's current position, but looking towards lookAtPoint
local lookAtCFrame = CFrame.new(demoPart.Position, lookAtPoint)

print("Setting Part's CFrame to the lookAt CFrame:", lookAtCFrame)
demoPart.CFrame = lookAtCFrame
-- Observe the part rotating. Its front face should now point towards (0, 5, 0).
print("Part's new LookVector (should point towards lookAtPoint):", demoPart.CFrame.LookVector)
-- Verify: The direction from the part to the lookAt point
local directionToLookAt = (lookAtPoint - demoPart.Position).Unit -- .Unit makes it length 1
print("Calculated direction vector:", directionToLookAt, "(Should match LookVector)")
wait(4)

-- 3c. CFrame.Angles(rx, ry, rz) - Creates a PURE ROTATION CFrame (positioned at 0,0,0). Angles are in RADIANS!
print("Creating a rotation-only CFrame using CFrame.Angles...")
-- IMPORTANT: Angles must be in radians, not degrees! Use math.rad() to convert.
local rotationAngleY = math.rad(45) -- 45 degrees around the Y axis (Yaw)
local rotationAngleX = math.rad(-20) -- -20 degrees around the X axis (Pitch)

local rotationCFrame = CFrame.Angles(rotationAngleX, rotationAngleY, 0)
print("Created a rotation CFrame:", rotationCFrame)
-- Note: This CFrame has Position (0, 0, 0) because it only represents rotation.
print("Position component of the rotation CFrame:", rotationCFrame.Position)

-- If you set a part's CFrame directly to this, it will MOVE to (0,0,0) AND rotate.
-- print("Temporarily moving part to origin and rotating...")
-- local originalCFrame = demoPart.CFrame -- Save original
-- demoPart.CFrame = rotationCFrame
-- wait(2)
-- demoPart.CFrame = originalCFrame -- Restore
-- print("Restored original CFrame.")
-- Usually, you COMBINE rotation CFrames with positional CFrames using multiplication (see next section).

wait(3)


-- === 4. CFrame Multiplication (Combining Transformations) ===
print("\n--- Section 4: CFrame Multiplication - The Core Concept ---")
-- Multiplying CFrames combines their transformations. The order MATTERS!
-- CFrame1 * CFrame2 means: Apply the transformation of CFrame2 RELATIVE to CFrame1's position and orientation.

-- Think: Start at CFrame1, then perform the movement/rotation defined by CFrame2 *from that new perspective*.

-- 4a. Translating (Moving) Relative to Current Orientation
print("Translating the Part relative to its current orientation...")
local moveForwardDistance = 10 -- Studs
local moveUpDistance = 3 -- Studs

-- Create a translation CFrame. CFrame.new(x, y, z) represents a translation FROM the origin.
-- We want to move FORWARD (local -Z axis) and UP (local +Y axis)
-- Remember: Forward is NEGATIVE Z in Roblox parts' local space.
local relativeTranslation = CFrame.new(0, moveUpDistance, -moveForwardDistance)

print("Applying relative translation CFrame:", relativeTranslation)
-- Calculation: New CFrame = Current CFrame * Relative Translation
local translatedCFrame = demoPart.CFrame * relativeTranslation
demoPart.CFrame = translatedCFrame
-- Observe the part moving forward and slightly up, according to *its own* orientation.
print("Part moved forward and up relative to itself.")
wait(3)

-- 4b. Rotating Relative to Current Orientation
print("Rotating the Part relative to its current orientation...")
local relativeRotation = CFrame.Angles(0, math.rad(-90), 0) -- Rotate 90 degrees left (around local Y axis)

print("Applying relative rotation CFrame:", relativeRotation)
-- Calculation: New CFrame = Current CFrame * Relative Rotation
local rotatedCFrame = demoPart.CFrame * relativeRotation
demoPart.CFrame = rotatedCFrame
-- Observe the part rotating 90 degrees to its left.
print("Part rotated -90 degrees around its own Y axis.")
wait(3)

-- 4c. Combining Translation and Rotation
print("Applying combined relative translation and rotation...")
-- Let's move 5 studs to the Part's RIGHT (+X) and rotate 30 degrees DOWN (around local X axis, negative angle)
local combinedRelative = CFrame.new(5, 0, 0) * CFrame.Angles(math.rad(-30), 0, 0)
-- You multiply the components together to get the combined relative transform

print("Applying combined relative CFrame:", combinedRelative)
local combinedCFrame = demoPart.CFrame * combinedRelative
demoPart.CFrame = combinedCFrame
print("Part moved right and pitched down relative to itself.")
wait(3)

-- 4d. Order Matters! CFrame1 * CFrame2 is NOT CFrame2 * CFrame1
print("Demonstrating that CFrame multiplication order matters...")
local cfA = CFrame.new(10, 0, 0) -- A translation
local cfB = CFrame.Angles(0, math.rad(90), 0) -- A rotation

local result_A_then_B = cfA * cfB
local result_B_then_A = cfB * cfA

print("Result A * B (Translate then Rotate relative to translated frame):", result_A_then_B)
print("Result B * A (Rotate then Translate relative to rotated frame):", result_B_then_A)
-- Notice the positions and orientations are different!

wait(4)


-- === 5. Transforming Vectors with CFrames ===
print("\n--- Section 5: Transforming Vectors ---")

-- You can use CFrames to convert coordinates or directions between world space
-- and an object's local space.

-- 5a. CFrame * Vector3 (Object Space to World Space Point)
print("Converting a Local Point to World Space...")
local localPoint = Vector3.new(2, 1, -3) -- 2 studs right, 1 stud up, 3 studs forward from the part's center/origin
print("Local point relative to the part:", localPoint)

-- Calculate where this local point exists in the actual game world
local worldPoint = demoPart.CFrame * localPoint
print("Calculated World Space position of the local point:", worldPoint)

-- Let's visualize this point with a temporary small sphere
local marker = Instance.new("Part")
marker.Name = "WorldPointMarker"
marker.Shape = Enum.PartType.Ball
marker.Size = Vector3.new(0.5, 0.5, 0.5)
marker.Color = Color3.new(1, 1, 0) -- Yellow
marker.Anchored = true
marker.CanCollide = false
marker.Position = worldPoint
marker.Parent = workspace
-- Clean up the marker after a few seconds
game:GetService("Debris"):AddItem(marker, 5) -- Debris service removes instances after a delay
print("Created a yellow sphere marker at the calculated world position (will disappear).")
wait(3)

-- 5b. CFrame:PointToObjectSpace(Vector3) (World Space to Object Space Point)
print("Converting a World Point back to Local Space...")
local worldTargetPoint = Vector3.new(0, 2, 0) -- A point in the world
print("World target point:", worldTargetPoint)

-- Calculate where this world point is relative to the part's CFrame
local objectSpacePoint = demoPart.CFrame:PointToObjectSpace(worldTargetPoint)
print("Calculated Object Space position relative to the part:", objectSpacePoint)
-- This tells you: to get from the part's origin to the worldTargetPoint, you'd need
-- to move objectSpacePoint.X studs along the part's RightVector,
-- objectSpacePoint.Y studs along the part's UpVector, and
-- objectSpacePoint.Z studs along the part's LookVector.

wait(3)

-- 5c. Vector Transformation (Directions)
-- Sometimes you want to convert a DIRECTION, ignoring position.
print("Converting a Direction vector...")
local localDirection = Vector3.new(0, 0, -1) -- Represents "forward" in local space
print("Local direction:", localDirection)

-- Convert this local direction into a world direction based on the part's orientation
local worldDirection = demoPart.CFrame:VectorToWorldSpace(localDirection)
print("Calculated World Space direction:", worldDirection)
print("(This should be the same as the Part's LookVector:", demoPart.CFrame.LookVector, ")")

-- And the inverse:
local worldUp = Vector3.new(0, 1, 0) -- World's Up direction
print("World Up direction:", worldUp)
local objectSpaceUp = demoPart.CFrame:VectorToObjectSpace(worldUp)
print("World Up represented in the Part's local coordinate system:", objectSpaceUp)

wait(4)


-- === 6. CFrame Inverse ===
print("\n--- Section 6: CFrame Inverse ---")
-- The inverse of a CFrame represents the opposite transformation. If a CFrame
-- moves you from A to B, its inverse moves you from B back to A.

local cf = demoPart.CFrame
local cfInverse = cf:Inverse()

print("Current CFrame:", cf)
print("Inverse CFrame:", cfInverse)

-- Multiplying a CFrame by its inverse results in the "Identity" CFrame (no translation, no rotation)
-- (May have tiny floating point inaccuracies)
local identityCheck = cf * cfInverse
print("CFrame * Inverse (should be close to identity):", identityCheck)

-- Use Case: Finding the relative CFrame between two world CFrames.
-- How do I get from CFrame A to CFrame B? Answer: A:Inverse() * B
local targetPart = Instance.new("Part")
targetPart.Name = "TargetPart"
targetPart.Anchored = true
targetPart.BrickColor = BrickColor.new("Bright red")
targetPart.Size = Vector3.new(1, 1, 1)
targetPart.CFrame = CFrame.new(10, 5, -20) * CFrame.Angles(0, math.rad(30), 0)
targetPart.Parent = workspace
print("Created a red TargetPart at:", targetPart.Position)

local cfA = demoPart.CFrame -- Our blue part's CFrame
local cfB = targetPart.CFrame -- The red part's CFrame

local relativeCFrame_A_to_B = cfA:Inverse() * cfB
print("Relative CFrame to get from Blue Part to Red Part:", relativeCFrame_A_to_B)

-- Let's test it: Start at A, apply the relative transform. Should end up at B.
local testPosition = cfA * relativeCFrame_A_to_B
print("Test: Blue_CFrame * Relative_CFrame_A_to_B =", testPosition)
print("Compare with Red Part's CFrame:", cfB, "(Should be very close)")

wait(5)
targetPart:Destroy() -- Clean up the target part


-- === 7. Lerp (Linear Interpolation) ===
print("\n--- Section 7: Lerp for Smooth Transitions ---")
-- CFrame:Lerp(goalCFrame, alpha) allows you to find a CFrame that is partway
-- between the starting CFrame and the goal CFrame.
-- 'alpha' is a fraction between 0 and 1.
-- 0 = returns the start CFrame
-- 1 = returns the goal CFrame
-- 0.5 = returns a CFrame exactly halfway between start and goal (in position and rotation)

print("Demonstrating Lerp for smooth movement/rotation...")
local startCFrame = demoPart.CFrame
local goalOffset = CFrame.new(0, 5, 15) * CFrame.Angles(math.rad(60), math.rad(-180), math.rad(20))
local goalCFrame = startCFrame * goalOffset -- Define a goal relative to the start

print("Starting CFrame:", startCFrame)
print("Goal CFrame:", goalCFrame)
print("Moving part smoothly using Lerp...")

local duration = 2 -- seconds for the transition
local steps = 30 -- number of steps in the transition
for i = 1, steps do
	local alpha = i / steps -- Calculate alpha from 0 to 1
	local interpolatedCFrame = startCFrame:Lerp(goalCFrame, alpha)
	demoPart.CFrame = interpolatedCFrame
	wait(duration / steps)
end

-- Ensure it ends exactly at the goal CFrame due to potential floating point inaccuracies in the loop
demoPart.CFrame = goalCFrame
print("Lerp transition complete. Part is at Goal CFrame.")

wait(3)


-- === 8. Conclusion ===
print("\n--- Section 8: Conclusion ---")
print("You've reached the end of the CFrame tutorial!")
print("Key Takeaways:")
print("- CFrames store Position AND Orientation.")
print("- Access with `Part.CFrame`, get position with `CFrame.Position`.")
print("- Create new CFrames with `CFrame.new()`, `CFrame.Angles()`.")
print("- Use CFrame Multiplication (`*`) for relative transformations (Order Matters!).")
print("- `CFrame * Vector3` converts local points to world points.")
print("- `:Inverse()` gets the opposite transformation.")
print("- `:Lerp()` is great for smooth CFrame transitions.")

print("\nCFrames are powerful! Experiment by modifying this script or applying these concepts in your own projects.")
print("Common uses include: Custom character controllers, procedural generation, tool grip editing, VFX placement, camera systems, and much more.")

-- You can uncomment this line to remove the demo part when the script finishes
-- demoPart:Destroy()
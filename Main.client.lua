-- CONFIG
local ZONE_RADIUS = 15
local BALL_NAME = "Ball"

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- PLAYER
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

-- BALL
local ball = workspace:WaitForChild(BALL_NAME)

-- MODULE
local ZoneDetection = require(script.ZoneDetection)

--------------------------------------------------
-- ZONE VISUELLE
--------------------------------------------------
local zone = Instance.new("Part")
zone.Shape = Enum.PartType.Ball
zone.Size = Vector3.new(ZONE_RADIUS * 2, ZONE_RADIUS * 2, ZONE_RADIUS * 2)
zone.Anchored = true
zone.CanCollide = false
zone.Transparency = 0.7
zone.Material = Enum.Material.ForceField
zone.Color = Color3.fromRGB(0, 170, 255)
zone.Parent = workspace

--------------------------------------------------
-- UI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
local label = Instance.new("TextLabel", gui)

label.Size = UDim2.fromScale(0.4, 0.1)
label.Position = UDim2.fromScale(0.3, 0.8)
label.BackgroundTransparency = 0.3
label.TextScaled = true
label.TextColor3 = Color3.new(1, 0, 0)
label.Text = ""

--------------------------------------------------
-- LOOP
--------------------------------------------------
RunService.RenderStepped:Connect(function()
	zone.Position = root.Position

	if ZoneDetection.IsBallDangerous(ball, root, ZONE_RADIUS) then
		label.Text = "⚠️ CLIQUE MAINTENANT"
	else
		label.Text = ""
	end
end)

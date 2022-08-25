-- Destroy The previous version of himself :
pcall(function()
    game.Players.LocalPlayer.PlayerGui.ScreenGui.HUD.Left["Collapse-Meter"]:Destroy()
end)

local frame = Instance.new("Frame")
frame.Name = "Collapse-Meter"
frame.Parent = game.Players.LocalPlayer.PlayerGui.ScreenGui.HUD.Left
frame.Size = UDim2.new(0,350,0,60)
frame.Position = UDim2.new(0,0,0.275,0)
frame.BackgroundColor3 = Color3.fromRGB(0, 179, 255)
frame.BorderColor3 = Color3.fromRGB(27, 42, 53)

local UICorner = Instance.new("UICorner")
UICorner.Parent = frame
UICorner.CornerRadius = UDim.new(1,0)
local UIStroke = Instance.new("UIStroke")
UIStroke.ApplyStrokeMode = "Contextual"
UIStroke.Color = Color3.fromRGB(24, 88, 149)
UIStroke.LineJoinMode = "Round"
UIStroke.Thickness = 3
UIStroke.Parent = frame
UIStroke.Name = "UIStroke"



local Icon = Instance.new("ImageLabel")
Icon.AnchorPoint = Vector2.new(1,0.5)
Icon.Image = "http://www.roblox.com/asset/?id=10640455681"
Icon.BackgroundTransparency = 1
Icon.Size = UDim2.new(0, 80,0, 80)
Icon.Position = UDim2.new(0,60,0.5,0)
Icon.Parent = frame
Icon.ScaleType = "Fit"


local Label = Instance.new("TextLabel")
Label.Parent = frame
Label.BackgroundTransparency = 1
Label.AnchorPoint = Vector2.new(0, 0.5)
Label.Text = "Left : 15000"
Label.Position = UDim2.new(0, 70,0.5, 0)
Label.Size = UDim2.new(1, -110,1, -10)
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.TextScaled = true
Label.BorderColor3 = Color3.fromRGB(27, 42, 53)
Label.BorderSizePixel = 1
Label.Font = "FredokaOne"
Label.TextXAlignment = "Left"
Label.TextYAlignment = "Center"

LabelStroke = UIStroke:Clone()
LabelStroke.Thickness = 2
LabelStroke.Parent = Label
LabelStroke.Color = Color3.fromRGB(24, 88, 149)

local Close = Instance.new("Frame")
Close.AnchorPoint = Vector2.new(0.5, 0.5)
Close.BackgroundTransparency = 0
Close.Name = "Close"
Close.Size = UDim2.new(0,40,0,40)
Close.Position = UDim2.new(1,-10,0.5,0)
Close.Parent = frame
Close.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
Close.Active = true

CloseUICorner = Instance.new("UICorner")
CloseUICorner.Parent = Close
CloseUICorner.CornerRadius = UDim.new(1,0)

CloseUIStroke = Instance.new("UIStroke")
CloseUIStroke.ApplyStrokeMode = "Contextual"
CloseUIStroke.Color = Color3.fromRGB(144, 37, 57)
CloseUIStroke.Thickness = 3
CloseUIStroke.LineJoinMode = "Round"
CloseUIStroke.Parent = Close

CloseLabel = Label:Clone()
CloseLabel.Parent = Close
CloseLabel.Text = "+"
CloseLabel.Rotation = 0
CloseLabel.TextXAlignment = "Center"
CloseLabel.TextYAlignment = "Bottom"
CloseLabel.Size = UDim2.new(0,50,0,50)
CloseLabel.TextSize = 60
CloseLabel.AnchorPoint = Vector2.new(0.5,0.5)
CloseLabel.Position = UDim2.new(0.5,0,0.5,0)
CloseLabel.TextScaled = false
CloseLabel.TextWrapped = false

CloseLabelStroke = CloseUIStroke:Clone()
CloseLabelStroke.Parent = CloseLabel
CloseLabelStroke.Color = Color3.fromRGB(24, 88, 149)
CloseLabelStroke.Thickness = 2

CloseButton = Instance.new("TextButton")
CloseButton.Transparency = 1
CloseButton.Text = ""
CloseButton.Size = UDim2.new(1,0,1,0)
CloseButton.Parent = Close
CloseButton.MouseButton1Click:Connect(function()
	print("Destroy")
	frame:Destroy()
end)

local l__Workspace__1 = game:GetService("Workspace");
local v2 = require(game:GetService("ReplicatedStorage").LoadModule);
local l__MinedBlocksResetLimit__1 = v2("Constants").MinedBlocksResetLimit;
local u2 = v2("AddCommas");
for v3, v4 in pairs((v2("Worlds"))) do
	local u3 = l__Workspace__1.Worlds:FindFirstChild(v3).Sign.Display.SurfaceGui;
	local function v5()
		local v6 = workspace:GetAttribute("MineBlocksCount");
		local v7 = l__MinedBlocksResetLimit__1 - v6;
		Label.Text = "Left : "..  string.format(v7);
	end;
	workspace:GetAttributeChangedSignal("MineBlocksCount"):Connect(v5);
	v5();
	u3 = ipairs;
	for v9, v10 in u3(v4.Layers) do
		local l__Checkpoint__11 = v10.Checkpoint;
		if l__Checkpoint__11 ~= nil then
			local v12 = l__Workspace__1.Checkpoints:FindFirstChild(l__Checkpoint__11.Name);
			if v12 ~= nil then
				local l__Sign__13 = v12:FindFirstChild("Sign");
				if l__Sign__13 ~= nil then
					local l__SurfaceGui__4 = l__Sign__13.Display.SurfaceGui;
					local function v14()
						local v15 = workspace:GetAttribute("MineBlocksCount");
						local v16 = l__MinedBlocksResetLimit__1 - v15;
						Label.Text = "Left : ".. string.format(v16);
					end;
					workspace:GetAttributeChangedSignal("MineBlocksCount"):Connect(v14);
					v14();
				end;
			end;
		end;
	end;
end;
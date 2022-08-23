-- Destroy Gui
function DestroyUI()
	pcall(function()
		Save()
		ResetSettings()
		game:GetService("CoreGui").SatoshiHub:Destroy()
	end)
end
DestroyUI()
-- Anti Afk
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
-- Values
local ReplicatedStorage = game.ReplicatedStorage
local Events = ReplicatedStorage.Events
local File = "Satoshi-Hub-" .. game.Players.LocalPlayer.Name .. "-Config.txt"
local ScreenGui = game.Players.LocalPlayer.PlayerGui.ScreenGui
Variables = {
-- Bool
AutoFarm = false;
AutoMine = false;
MineAura = false;
AutoFactory = false;
AutoBuyBoosts = false;
AutoEquipBestPets = false;
RemoveHatchingAnimation = false;
AutoClaimGroupBenefits = false;
AutoDeposit = false;
AutoSell = false;
ShowedCollapseMeter = false;
AutoRebirth = false;
AutoSellMax = 0;
-- String
FactoryType = "Shells";
Theme = "GrapeTheme";
HideKey = "RightShift";
-- Int
AutoFarmDepth = 2030;
FactoryAmmount = 4;
}
local DefaultSettings = Variables
function ResetSettings()
	for i,v in pairs(DefaultSettings) do print (i .. "	Value : " .. tostring(v)) end
	Variables = DefaultSettings
end
function Save()
	spawn(function()
		print("Saving Settings")
		local json
		local HttpService = game:GetService("HttpService")
		if (writefile) then
			json = HttpService:JSONEncode(Variables)
			writefile(File, json)
			print("Succes")
		else
			print("--- Sorry Your Executor Dont Support Save ---")
		end
	end) -- Spawn End
end -- Save End
function Load()
	print("----------- Loading Settings -----------")
	local json
	local HttpService = game:GetService("HttpService")
	if (readfile and isfile and isfile(File)) then
		Variables = HttpService:JSONDecode(readfile(File))
	else
		print("--- Sorry Your Executor Dont Support Save ---")
	end
end
Load()
for i,v in pairs(Variables) do print (i .. "	Value : " .. tostring(v)) end
print("----------- SuccesFullyLoaded -----------")
-- Tables
local Worlds = {}
for i,v in pairs(game.Workspace.Worlds:GetChildren()) do
		table.insert(Worlds,i,tostring(v))
		--print("Index : " .. tostring(i+3) .. " Name : " ..  tostring(v))
end
local Layers = {}
for i,v in pairs(game.Workspace.Checkpoints:GetChildren()) do
		table.insert(Layers,i,tostring(v))
		--print("Index : " .. tostring(i+3) .. " Name : " ..  tostring(v))
end
local Chests = {}
for i,v in pairs(game.Workspace.Checkpoints:GetChildren()) do
		Chest = v:FindFirstChild("Chest")
		if Chest then
			table.insert(Chests,i,tostring(v))
		end
		--print("Index : " .. tostring(i+3) .. " Name : " ..  tostring(v))
end
local UIS = {"Quests" , "Forge", "RebirthShop" , "GemEnchant", "Factory"}
local Boosts = {"Lucky","Super Lucky","Omega Lucky","Big Earner","Super Rich"}
local FactoryAmmountTable = {"1. 170-200 Gems","2. 550-700 Gems","3. 1300-1500 Gems","4. 2300-3800 Gems","5. 8300 Gems Shells Only"}
local CodesTable = {"FreeCrate","FreeEgg","Release","Gems","RareCrate","FreeGems","RareCrate","SuperLucky","Lucky","Factory","Update4","July4th","Update5","Fishing","Update6","Season2","Mystery",
"Update8","ExtraLuck","SuperEvent","LostCity","Update9","Atlantis","UltraLucky","Update10","LuckEvent","Update11","Atlantic"}
local ThemeTable = {"DarkTheme","LightTheme","BloodTheme","GrapeTheme","Ocean","Midnight","Sentinel","Synapse","Serpent"}
local GemChests = {"Crystal Cavern","Glitched Chasm"}
local SelectedBoosts = {}
-- UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Bueezi/Satoshi-Hub/main/UI-Library.lua"))()
local Window = Library.CreateLib("Satoshi Hub", Variables.Theme)

-- Tabs
local FarmTab = Window:NewTab("Farm")
local FactoryTab = Window:NewTab("Factory & Boosts")
local TeleportTab = Window:NewTab("Teleport")
local UITab = Window:NewTab("UI")
local PetsTab = Window:NewTab("Eggs & Pets")
local UtilityTab = Window:NewTab("Utility")
local SettingsTab = Window:NewTab("Settings")

-- Sections
local FarmSection = FarmTab:NewSection("AutoFarm")
local MineSection = FarmTab:NewSection("Mine")

local FactorySection = FactoryTab:NewSection("Factory")
local BuyBoostsSection = FactoryTab:NewSection("Buy Boosts")

local TeleportOptionSection = TeleportTab:NewSection("Options")
local WorldSection = TeleportTab:NewSection("World")
local LayerSection = TeleportTab:NewSection("Layer")

local UIOptionSection = UITab:NewSection("Options")
local OpenUISection = UITab:NewSection("Open UI")

local PetsOptionSection = PetsTab:NewSection("Options")

local UtilitySection = UtilityTab:NewSection("Utility")

local SettingsSection = SettingsTab:NewSection("Settings")

-- Farm Begin
local AutoFarmToggle = FarmSection:NewToggle("Auto Farm", "Uses the Autominer until depth then MineAura", function(state)
Variables.AutoFarm = state
Save()
end)
local AutoFarmDepthToggle = FarmSection:NewTextBox("AutoFarm Depth", "Defines the depth where blox aura start", function(txt)
Variables.AutoFarmDepth = tonumber(txt)
Save()
end)
local AutoFarmLabel = FarmSection:NewLabel("AutoFarm Status : Off")
-- Mine Section
local AutoMineToggle = MineSection:NewToggle("Auto Mine", "Mines blocks below player", function(state)
Variables.AutoMine = state
Save()
end)
local MineAuraToggle = MineSection:NewToggle("Mine Aura", "Randomly mines blocks around player", function(state)
Variables.MineAura = state
Save()
end)
MineSection:NewToggle("Auto Sell", "Sells automaticly to the selected location", function(state)
Variables.AutoSell = state
end)
local AutoSellMaxTextBox = MineSection:NewTextBox("AutoSell Max", "Will Sell When BackpackStorage is The Defined Value , 0 to Disable", function(txt)
Variables.AutoSellMax = tonumber(txt)
Save()
end)
MineSection:NewToggle("Auto Rebirth", "AutoMaticly Rebirths", function(state)
Variables.AutoRebirth = state
end)
-- Farm End

-- Factory & Boosts Begin
FactorySection:NewButton("Open Factory UI","Opens The Factory UI", function()
	local ActualUI = ScreenGui["Factory"]
	ActualUI.Visible = true
	ActualUI.Frame.Close.Frame.Button.MouseButton1Click:Connect(function()
	ActualUI.Visible = false
	end)
end)
local FactoryTypeUI = FactorySection:NewDropdown("Factory Type", "Select Currency", {"Coins","CyberTokens","Shells"}, function(currentOption)
    Variables.FactoryType = currentOption
	Save()
end)
local FactoryAmmountUI = FactorySection:NewDropdown("Factory Amount", "Select Amount of gemms u want to make", FactoryAmmountTable, function(currentOption)
	Variables.FactoryAmmount = table.find(FactoryAmmountTable,currentOption)
    print(Variables.FactoryAmmount)
	Save()
end)
local AutoFactoryToggle = FactorySection:NewToggle("Auto Factory", "Automaticly crafts & claims factory best option", function(state)
	Variables.AutoFactory = state
	Save()
end)
--Buy Boosts Section
local BuyAllBoostsToggle = BuyBoostsSection:NewToggle("Auto Buy All Boosts", "Automaticly Buys All Boosts", function(state)
	local Number = 0
	while Number < 5 do
		table.insert(SelectedBoosts,number,true)
		Number = Number + 1
	end
	BuyAllBoosts()
	Save()
end)
for i,v in pairs(Boosts) do
	BuyBoostsSection:NewToggle(v .. " Boost AutoBuy", "Automaticly buys the " .. v .. "selected boosts", function(state)
		SelectedBoosts[i] = state
		BuyAllBoosts()
		Save()
	end)
end
-- Factory & Boosts End

-- Teleport Begin
TeleportOptionSection:NewButton("Collect Gem Chests", "Teleports you to all gem chests", function()
    CollectGemChest = true
end)
local CollectGemChestLabel = TeleportOptionSection:NewLabel("Collect Gem Chest Status : Off")
TeleportOptionSection:NewButton("Unlock All Layers", "Makes you unlock all layers", function()
    UnlockAllLayers = true
end)
local UnlockAllLayersLabel = TeleportOptionSection:NewLabel("UnlockAllLayers Status : Off")
TeleportOptionSection:NewLabel("Teleports :")
for i,v in pairs(Worlds) do
	WorldSection:NewButton("Teleport To " .. v , "Teleports you to " .. v , function()
		game.ReplicatedStorage.Events.Teleport:FireServer(tostring(v))
	end)
end
for i,v in pairs(Layers) do
	LayerSection:NewButton("Teleport To " .. v , "Teleports you to " .. v , function()
		game.ReplicatedStorage.Events.Teleport:FireServer(tostring(v))
	end)
end
-- Teleport End

-- UI Begin
UIOptionSection:NewToggle("Show Collapse Meter", "Shows a collapse meter", function(state)
Variables.ShowCollapseMeter = state
Save()
end)
for i,v in pairs(UIS) do
	OpenUISection:NewButton("Open " .. v .. " UI", "Opens The " .. v .. " UI", function()
		local ActualUI = ScreenGui[v]
		ActualUI.Visible = true
		ActualUI.Frame.Close.Frame.Button.MouseButton1Click:Connect(function()
		ActualUI.Visible = false
		end)
	end)
end
-- UI End

-- Eggs & Pets Begin
PetsOptionSection:NewToggle("Auto Equip Best Pets", "Automaticly equip the best pets you have", function(state)
	Variables.AutoEquipBestPets = state
	Save()
end)
local RemoveHatchingAnimationToggle = PetsOptionSection:NewToggle("Remove Hatching Animation", "Removes the egg hatching Animation", function(state)
	Variables.RemoveHatchingAnimation = state
	Save()
end)
-- Eggs & Pets End

-- Utility Begin
local AutoClaimGroupBenefitsToggle = UtilitySection:NewToggle("Auto Claim Group Benefits", "Automaticly Claims Group Benefits", function(state)
	Variables.AutoClaimGroupBenefits = state
	Save()
end)
local AutoDepositToggle = UtilitySection:NewToggle("AutoDeposit Forge Shards", "Automaticly Deposits shards to the forge", function(state)
	Variables.AutoDeposit = state
	Save()
end)
UtilitySection:NewButton("Redeem All Codes", "Redeems All Codes Last Update 21/08", function()
    RedeemAllCodes = true
end)
local RedeemAllCodesLabel = UtilitySection:NewLabel("Redeem All Codes Status : Off")

UtilitySection:NewButton("PlaceTeleporter", "Redeems All Codes Last Update 21/08", function()
    PlaceTeleporter()
end)
-- Utility End

-- Settings Begin
SettingsSection:NewKeybind("Hide UI Key", "Select The Key to hide the UI", Enum.KeyCode.RightShift, function()
	--Library:ToggleUI()
	local SatoshiHub = game:GetService("CoreGui").SatoshiHub.Main
	if SatoshiHub.Visible == true then 
		SatoshiHub:TweenSize(UDim2.new(0.05, 0, 0.05, 0))
		wait(1)
		SatoshiHub.Visible = false
	else
		SatoshiHub.Visible = true
		SatoshiHub:TweenSize(UDim2.new(0, 525, 0, 318))
	end
	Save()
end)
SettingsSection:NewDropdown("Theme", "Select the theme of the UI", ThemeTable, function(currentOption)
	Variables.Theme = currentOption
	Save()
	ResetSettings()
	wait(0.3)
	DestroyUI()
	loadstring(game:HttpGet'https://raw.githubusercontent.com/Bueezi/Satoshi-Hub/main/Main.lua')()
end)
SettingsSection:NewButton("DestroyUI", "Destroys the Gui", function()
	Save()
    DestroyUI()
end)
SettingsSection:NewButton("Refresh", "Destroys the Gui", function()
	Refresh()
end)
-- Settings End

-----------------------------------------------------------------------------------------------Functions--------------------------------------------------------------------------------------------------

-- Refresh
Toggles = {AutoFarm = AutoFarmToggle;}
function Refresh()
	spawn(function()
		for i,v in pairs(Toggles) do
			pcall(function()
				print ("Toggle : " .. tostring(v))
				if (table.find(Toggles,i)) == true then
					v:UpdateToggle("Toggle On")
					print("On")
				else
					v:UpdateToggle("Toggle Off")
					print("Off")
				end
				print("Refreshed")
			end)
		end
	end)
end

--------------------- FarmTab Begin --------------------

-- AutoFarm Begin
spawn(function()
    while true do
		wait(0.5)
		while Variables.AutoFarm == true do
			local blockdepth = Variables.AutoFarmDepth * -5 + 3  -- Converts the blocks height into roblox height
			if game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y > blockdepth then -- if player is above the chosen depth then automine
                Variables.MineAura = false
				Variables.AutoMine = true
				AutoFarmLabel:UpdateLabel("AutoFarm Status : AutoMine")
            else -- If Player is Under The Chosen depth then Mine Aura
                Variables.AutoMine = false
				Variables.MineAura = true
				AutoFarmLabel:UpdateLabel("AutoFarm Status : Mine Aura")
            end -- If Stop
			wait(0.3)
			Variables.AutoMine = false
			Variables.MineAura = false
			AutoFarmLabel:UpdateLabel("AutoFarm Status : Off")
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- AutoFarm End

--Automine Init
function breakblock(pos)
   local args = {
       [1] = pos
   }

   game:GetService("ReplicatedStorage").Events.MineBlock:FireServer(unpack(args))
end

local Mod = require(game:GetService("ReplicatedStorage").SharedModules.ChunkUtil)

function getPartBelow()
   local Character = game.Players.LocalPlayer.Character
   local Foot = Character.RightFoot
   local RayOrigin = Foot.Position
   local RayDirection = Vector3.new(0, -1, 0)

   local Params = RaycastParams.new()
   Params.FilterType = Enum.RaycastFilterType.Blacklist
   Params.FilterDescendantsInstances = {Character}

   local Result = workspace:Raycast(RayOrigin, RayDirection, Params)

   if Result then
       local RayInstance = Result.Instance
       print("Instance hit: " .. tostring(RayInstance))
       return RayInstance
   end

   return nil
end


-- Automine Init End

-- AutoMine
spawn(function()
    while true do
		wait(0.5)
		while Variables.AutoMine == true do
			task.wait()
		    local closest = getPartBelow()
		    if closest ~= nil then
				local Pos = closest.Position
			    local NewPos = Mod.worldToCell(Pos)
			    task.spawn(function()
					breakblock(NewPos)
				end)
		   end
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- AutoMine End

-- Mine Aura Init
local TweenService = game:GetService("TweenService")
local LoadModules = require(game.ReplicatedStorage.LoadModule);
getgenv().v2 = require(game:GetService("ReplicatedStorage").LoadModule)
getgenv().u6 = v2("ChunkUtil")
getgenv().v3 = v2("Constants")
getgenv().v4 = v3.CellSize * v3.ChunkSize
local MainData = game:GetService("RunService"):IsServer() and LoadModules("DataService") or LoadModules("LocalData");
-- Mine Aura Init End
    
-- Mine Aura Function Begin
spawn(function()
    while true do
		wait(0.5)
        while Variables.MineAura == true do
            pcall(function()
                for i,v in pairs(game:GetService("Workspace").Chunks:GetChildren()) do
                    for i,v in pairs(v:GetChildren()) do
                    if v3.MaxSelectionDistance > (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude then
                    local a = v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position * math.random(0.1, 0.001) 
                        CID2 = a
                        local convert2 = u6.worldToCell(a - Vector3.new(0,-1,0))
                        game:GetService("ReplicatedStorage").Events.MineBlock:FireServer(convert2)
                    task.wait(0.001)
                end
                    end
                end
            end)
			wait(0.15)
        end -- While Blox aura end
    end -- Infinite Loop end
end) -- Spawn Function End

-- AutoSell Begin
function PlaceTeleporter()
	local closest = getPartBelow()
	if closest ~= nil then
		local Pos = closest.Position
		local NewPos = Mod.worldToCell(Pos)
		print(tostring(NewPos))
		game.ReplicatedStorage.Events.RemoveTeleporter:FireServer(NewPos)
		game.ReplicatedStorage.Events.PlaceTeleporter:FireServer(NewPos)
	end
end
function GetLayer()
	local Player = game.Players.LocalPlayer
	local v1 = require(game.ReplicatedStorage.LoadModule);
	local u1 = v1("GetLayer");
	local u2 = v1("GetWorld");
	local v2 = u1.fromPlayer(Player) or "Surface";
	if v2 == "Surface" then
		v2 = u2.fromPlayer(Player) .. " Surface";
	end;
	Layer = v2 .. "Sell"
end



function Sell()
	local Humanoid = game.Players.LocalPlayer.Character.HumanoidRootPart
	local LastPositionX = Humanoid.Position.X
	local LastPositionZ = Humanoid.Position.Z
	local LastCFrame = Humanoid.CFrame
	GetLayer()
	print("Sell Location : " .. Layer)
	game.ReplicatedStorage.Events.Teleport:FireServer(Layer)
	wait(1)
	Humanoid.CFrame = CFrame.new(Humanoid.Position.X,9999,Humanoid.Position.Z)
	Teleport(LastPositionX,9999,LastPositionZ) -- Teleport Back To Point
	Humanoid.CFrame = LastCFrame -- Teleport to depth and Orientation
end
function GetRebirthPrice()
	local p1 = game.Players.LocalPlayer.leaderstats.Rebirths.Value
	local p2 = require(game.ReplicatedStorage.LoadModule)("LocalData"):GetData("GemEnchantments")
	local v1 = require(game:GetService("ReplicatedStorage").SharedModules.Helpers.GetRebirthCost)
	local RebirthCost = v1(p1,p2)
	return(RebirthCost)
end
function Teleport(x,y,z)
	loadstring(game:HttpGet'https://pastebin.com/raw/uF2sempX')() -- Load Teleport Script
	valtomove = 1.5
	tp(x,y,z)
end
function GetBackpackValue()
	local Inventory = require(game:GetService("ReplicatedStorage").SharedModules.Helpers.GetBackpackStatus)(p1)["Inventory"]
	local Blocks = require(game:GetService("ReplicatedStorage").SharedModules.Data.Blocks)
	local BackpackBrutValue = 0
	local BackpackValue = 0
	for i,OreTable in pairs(Inventory) do 
		local Ore = OreTable[1]
		local Amount = OreTable[2]
		local Value = Blocks[Ore]["Value"][2]
		local Value2 = Value * Amount
		BackpackBrutValue = BackpackBrutValue + Value2
		--print("Ore Name : " .. Ore .. " Amount : " .. tostring(Amount) .. " Value : " .. Value .. " Value2 : " .. Value2)
	end

	local moduleformat = require(game.ReplicatedStorage.LoadModule)
	local LocalData = moduleformat("LocalData")
	local CurrencyMulti = moduleformat("GetCurrencyMultiplier")
	local multiCoins = CurrencyMulti(Player, "Coins", LocalData:GetData("Passes"), LocalData:GetData("GemEnchantments"))
	BackpackValue = BackpackBrutValue * tonumber(multiCoins) + 0.5
	return(BackpackValue)
end

spawn(function()
    while true do
		wait(0.5)
		while Variables.AutoSell == true do
			pcall(function()
				game:GetService("ReplicatedStorage").ClientModules.Utility.Gui.CreatePrompt.Prompt.Name = "Prompta"
			end)
			local v1 = require(game:GetService("ReplicatedStorage").SharedModules.Helpers.GetBackpackStatus);
			local t = v1(p2)
			local BackpackStorage = t["Storage"]
			local BackpackFull = t["Full"]
			if BackpackStorage > Variables.AutoSellMax and Variables.AutoSellMax ~= 0 then 
				print("Selling Cause BackpackStorage > AutoSellMax")
				Sell()
			elseif BackpackFull then 
				print("Selling Cause BackpackFull")
				Sell()
			end
			wait(0.2)
		end -- If/While End
		pcall(function()
				game:GetService("ReplicatedStorage").ClientModules.Utility.Gui.CreatePrompt.Prompta.Name = "Prompt"
		end)
	end -- Infinite Loop End
end) -- Spawn End
-- AutoSell End

-- AutoRebirth Begin 
spawn(function()
    while true do
		wait(0.5)
		while Variables.AutoRebirth == true do
			--print("Rebirth Price : " .. GetRebirthPrice() .. " BackpackValue : " .. GetBackpackValue())
			if (GetBackpackValue() + game.Players.LocalPlayer.leaderstats.Coins.Value) > GetRebirthPrice() then
				print("Rebirthing")
					local Humanoid = game.Players.LocalPlayer.Character.HumanoidRootPart
					local LastPositionX = Humanoid.Position.X
					local LastPositionZ = Humanoid.Position.Z
					local LastCFrame = Humanoid.CFrame
					GetLayer()
					print("Sell Location : " .. Layer)
					game.ReplicatedStorage.Events.Teleport:FireServer(Layer)
					wait(1)
					game:GetService("ReplicatedStorage").Events.Rebirth:FireServer()
					wait(1)
					Humanoid.CFrame = CFrame.new(Humanoid.Position.X,9999,Humanoid.Position.Z)
					Teleport(LastPositionX,9999,LastPositionZ) -- Teleport Back To Point
					Humanoid.CFrame = LastCFrame -- Teleport to depth and Orientation
				
			end
			wait(0.3)
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- AutoRebirth End

--------------------- FarmTab End --------------------

--------------------- Factory & Boosts Tab Begin --------------------
-- Shard Auto Deposit Begin
spawn(function()
    while true do
		wait(0.5)
		while Variables.AutoDeposit == true do
			game.ReplicatedStorage.Events.DepositShards:FireServer()
			wait(5)
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- Shard Auto Deposit End

-- AutoFactory Start
spawn(function()
    while true do
		wait(0.5)
		if Variables.AutoFactory == true then
			local Number = 0
			local FactoryTypeString = Variables.FactoryType .. " " .. Variables.FactoryAmmount
			while Number < 3 do
				Number = Number + 1
				game.ReplicatedStorage.Events.ClaimFactoryCraft:FireServer(Number)
				game.ReplicatedStorage.Events.StartFactoryCraft:FireServer(FactoryTypeString,Number)
			end
			wait(5)
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- AutoFactory End

-- Boost Buy start
spawn(function()
    while true do
		wait(10)
		for i,v in pairs (SelectedBoosts) do
			if v == true then
				game.ReplicatedStorage.Events.BuyBoost:FireServer(Boosts[i] , 1)
				game.ReplicatedStorage.Events.BuyBoost:FireServer(Boosts[i] , 2)
			end
		end
	end -- Infinite Loop End
end) -- Spawn End
function BuyAllBoosts()
	number = 0
	for i,v in pairs(SelectedBoosts) do
		if v == "true" then number = number + 1 end
		if number == 5 then BuyAllBoostsToggle:UpdateToggle("Toggle On")
		else BuyAllBoostsToggle:UpdateToggle("Toggle Off") end
	end
end
-- Boost Buy end

--------------------- Factory & Boosts Tab End --------------------

-- AutoEquipBestPets Start
spawn(function()
    while true do
		wait(0.5)
		while Variables.AutoEquipBestPets == true do
			game.ReplicatedStorage.Events.EquipBestPets:FireServer()
			wait(5)
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- AutoEquipBestPets End

-- Teleporter Teleport Start


-- Unlock All Layers Begin
spawn(function()
    while true do
		wait(0.5)
		if Variables.UnlockAllLayers == true then
			for i,v in pairs(Layers) do
				UnlockAllLayersLabel:UpdateLabel("UnlockAllLayers Status : " .. i .. "/" .. #Layers .. " Layer : " .. v)
				game.ReplicatedStorage.Events.Teleport:FireServer(v)
				wait(1)
			end
			Variables.UnlockAllLayers = false
			UnlockAllLayersLabel:UpdateLabel("Collect Gem Chest Status : Done")
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- Unlock All Layers End

-- Auto Claim Group Benefits Begin
spawn(function()
    while true do
		wait(0.5)
		while Variables.AutoClaimGroupBenefits == true do
			ReplicatedStorage.Functions.ClaimGroupBenefits:InvokeServer()
			wait(10)
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- Auto Claim Group Benefits End




-- CollectGemChest Begin
spawn(function()
    while true do
		wait(0.5)
		if Variables.CollectGemChest == true then
			for i,v in pairs(GemChests) do
				local Character = game.Players.LocalPlayer.Character.HumanoidRootPart
				CollectGemChestLabel:UpdateLabel("Collect Chest Status : " .. i .. "/" .. #GemChests .. " Chest : " .. v)
				repeated = 0
				while repeated < 5 do
				Character.CFrame = game:GetService("Workspace").Checkpoints[v].Chest.Activation.Root.CFrame
				wait(0.05)
				Character.CFrame = game:GetService("Workspace").Checkpoints[v].Chest.Activation.Tag.CFrame
				wait(0.05)
				repeated = repeated + 1
				end
			end
			Variables.CollectGemChest = false
			CollectGemChestLabel:UpdateLabel("Collect Gem Chest Status : Done")
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- Collect end

-- Remove Hatching Animation Start 
spawn(function()
    while true do
		wait(3)
		if Variables.RemoveHatchingAnimation == true then
			pcall(function()
				game:GetService("ReplicatedStorage").ClientModules.Other.OpenEgg.HatchGui.Name = "HatchGuia"
			end)
		else
			pcall(function()
				game:GetService("ReplicatedStorage").ClientModules.Other.OpenEgg.HatchGuia.Name = "HatchGui"
			end)
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- Remove Hatching Animation End

-- Redeem All Codes Begin
spawn(function()
    while true do
		wait(0.5)
		if RedeemAllCodes == true then
			for i,v in pairs(CodesTable) do
				game.ReplicatedStorage.Functions.RedeemCode:InvokeServer(v)
				RedeemAllCodesLabel:UpdateLabel("Redeem All Codes Status : " .. i .. "/" .. #CodesTable .. " Code : " .. v)
				wait(.3)
			end
			RedeemAllCodes = false
			RedeemAllCodesLabel:UpdateLabel("Redeem All Codes Status : Done")
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- Unlock All Layers End
-- Redeem All Codes End

-- ShowCollapseMeter Begin
spawn(function()
    while true do
		wait(0.5)
		if Variables.ShowCollapseMeter == true then
				if Showed == false then 
					loadstring(game:HttpGet'https://pastebin.com/raw/AsbftPik')()
					Showed = true
				else
					pcall(function()
						game.Players.LocalPlayer.PlayerGui.ScreenGui.HUD.Left["Collapse-Meter"]:Destroy()
					end)
					Showed = false
				end
			Variables.ShowCollapseMeter = false
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- ShowCollapseMeter End

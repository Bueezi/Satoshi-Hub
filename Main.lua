script.Parent = game.Players.LocalPlayer.PlayerScripts
script.Name = "Ms2"
-- Destroy Gui
local Destroyed = false
local Loaded = false
function DestroyUI()
_G.DestroyUIGlobalVariable = true
end
DestroyUI()
spawn(function()
	wait(0.3)
	while wait(0.2) do
		if _G.DestroyUIGlobalVariable == true then
			print("--- Destroying UI ---")
			Save()
			ResetSettings()
			pcall(function()
				game:GetService("CoreGui").SatoshiHub:Destroy()
			end)
			_G.DestroyUIGlobalVariable = false
			Destroyed = true
			wait(math.huge)
		end
	end
end)
wait(0.3)
_G.DestroyUIGlobalVariable = false
print("----------------------------------- New Gui -----------------------------------")
-----------------------------------------------------------------------------------------------Data--------------------------------------------------------------------------------------------------
----------- Saved Data -----------
local Variables = {
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
CollapseMeter = false;
AutoRebirth = false;
CollapseProtection = false;
DebugMode = false;
AutoHatchEgg = false;
SelectedBoosts = {};
-- String
FactoryType = "Shells";
Theme = "Midnight";
HideKey = "RightShift";
CollapseLocation = "Crystal Cavern";
EggToHatch = "Basic Egg";
-- Int
AutoFarmDepth = 2030;
FactoryAmmount = 4;
AutoSellMax = 0;
CratesToOpen = 5;
-- Tables
SelectedBoosts = {};
GlobalStats = {
RebirthMade = 0;
};
}
----------- Local Data -----------
-- Paths
local ReplicatedStorage = game.ReplicatedStorage
local Events = ReplicatedStorage.Events
local File = "Satoshi-Hub-" .. game.Players.LocalPlayer.Name .. "-Config.json"
local ScreenGui = game.Players.LocalPlayer.PlayerGui.ScreenGui
local VariableName = getfenv() -- very bad
-- Bool
local Teleporting = false
local CollectAllChests = false
local UnlockAllLayers = false
-- Int
local MiningPoint = CFrame.new(-12,-9242,-12)
local MiningPointX = -12
local MiningPointZ = -12
local RebirthMade = 0
local Time = 0
local StartRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
-- Tables
local Toggles = {}
local DefaultSettings = Variables
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
local Eggs = {}
for i,v in pairs(game.Workspace.Eggs:GetChildren()) do
		table.insert(Eggs,i,tostring(v))
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
local SelectedCrates = {}
local UIS = {"Quests" , "Forge", "RebirthShop" , "GemEnchant", "Factory"}
local moduleformat = require(game.ReplicatedStorage.LoadModule)
local Boosts = moduleformat("Boosts")
local Crates = require(game:GetService("ReplicatedStorage").SharedModules.Data.Crates)
local FactoryAmmountTable = {"1. 170-200 Gems","2. 550-700 Gems","3. 1300-1500 Gems","4. 2300-3800 Gems","5. 8300 Gems Shells Only"}
local CodesTable = {"FreeCrate","FreeEgg","Release","Gems","RareCrate","FreeGems","RareCrate","SuperLucky","Lucky","Factory","Update4","July4th","Update5","Fishing","Update6","Season2","Mystery",
"Update8","ExtraLuck","SuperEvent","LostCity","Update9","Atlantis","UltraLucky","Update10","LuckEvent","Update11","Atlantic"}
local ThemeTable = {"DarkTheme","LightTheme","BloodTheme","GrapeTheme","Ocean","Midnight","Sentinel","Synapse","Serpent"}

----------------------------------------------------------------------------------------------- UI Data --------------------------------------------------------------------------------------------------
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Bueezi/Satoshi-Hub/main/UI-Library.lua"))()
local Window = Library.CreateLib("Satoshi Hub", Variables.Theme)

-- Tabs
local FarmTab = Window:NewTab("Farm")
local FactoryTab = Window:NewTab("Factory & Boosts")
local TeleportTab = Window:NewTab("Teleport")
local UITab = Window:NewTab("UI")
local PetsTab = Window:NewTab("Eggs & Crates")
local UtilityTab = Window:NewTab("Utility")
local StatsTab = Window:NewTab("Stats")
local SettingsTab = Window:NewTab("Settings")

-- Sections
local FarmSection = FarmTab:NewSection("AutoFarm")
local MineSection = FarmTab:NewSection("Mine")

local FactorySection = FactoryTab:NewSection("Factory")
local BuyBoostsSection = FactoryTab:NewSection("Buy Boosts")

local TeleportOptionSection = TeleportTab:NewSection("Options")
local WorldSection = TeleportTab:NewSection("World")
local LayerSection = TeleportTab:NewSection("Layer")

local OpenUISection = UITab:NewSection("Open UI")

local PetsOptionSection = PetsTab:NewSection("Options")
local OpenCratesSection = PetsTab:NewSection("Open Crates")

local UtilitySection = UtilityTab:NewSection("Utility")

local SessionStatsSection = StatsTab:NewSection("This Session :")
local GlobalStatsSection = StatsTab:NewSection("Global Stats :")

local SettingsSection = SettingsTab:NewSection("Settings")

----------------------------------------------------------------------------------------------- UI --------------------------------------------------------------------------------------------------

---------------------- AutoFarm & Mine ----------------------
----------- AutoFarm -----------
Toggles["AutoFarm"] = FarmSection:NewToggle("Auto Farm", "Uses the Autominer until depth then MineAura", function(state)
Variables.AutoFarm = state
Save()
end)
FarmSection:NewTextBox("AutoFarm Depth", "Defines the depth where blox aura start", function(txt)
Variables.AutoFarmDepth = tonumber(txt)
Save()
end)
local AutoFarmLabel = FarmSection:NewLabel("AutoFarm Status : Off")
----------- Mine -----------
Toggles["AutoMine"] = MineSection:NewToggle("Auto Mine", "Mines blocks below player", function(state)
Variables.AutoMine = state
Save()
end)
Toggles["MineAura"]  = MineSection:NewToggle("Mine Aura", "Randomly mines blocks around player", function(state)
Variables.MineAura = state
Save()
end)
Toggles["AutoSell"]  = MineSection:NewToggle("Auto Sell", "Sells automaticly to the selected location", function(state)
Variables.AutoSell = state
Save()
end)
MineSection:NewTextBox("AutoSell Max", "Will Sell When BackpackStorage is The Defined Value , 0 to Disable", function(txt)
Variables.AutoSellMax = tonumber(txt)
Save()
end)
Toggles["AutoRebirth"]   = MineSection:NewToggle("Auto Rebirth", "AutoMaticly Rebirths", function(state)
Variables.AutoRebirth = state
Save()
end)
Toggles["CollapseProtection"] = MineSection:NewToggle("Anti-Collapse", "Make Sure Tu Set MiningPoint Before", function(state)
Variables.CollapseProtection = state
Save()
end)
MineSection:NewDropdown("Anti-Collapse-Location", "Select Anti Collapse Location", Layers, function(currentOption)
Variables.CollapseLocation = currentOption
Save()
end)
---------------------- Factory & Boosts ----------------------
----------- Factory -----------
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
Toggles["AutoFactory"]  = FactorySection:NewToggle("Auto Factory", "Automaticly crafts & claims factory best option", function(state)
	Variables.AutoFactory = state
	Save()
end)
----------- Boosts -----------
Toggles["BuyAllBoosts"] = BuyBoostsSection:NewToggle("Auto Buy All Boosts", "Automaticly Buys All Boosts", function(state)
	BuyAllBoosts(state)
	Save()
end)
for i,v in pairs(Boosts) do
	Toggles["BuyLuckyBoost"] = BuyBoostsSection:NewToggle("Lucky Boost Auto Buy", "Automaticly Buys The Luck Boost", function(state)
	Variables.SelectedBoosts[i] = state
	Save()
	end)
end
---------------------- Teleport ----------------------
----------- Teleport -----------
TeleportOptionSection:NewButton("Collect All Chests", "Teleports you to all chests", function()
    CollectAllChests = true
end)
local CollectAllChestsLabel = TeleportOptionSection:NewLabel("Collect All Chest Status : Off")
TeleportOptionSection:NewButton("Unlock All Layers", "Makes you unlock all layers", function()
    UnlockAllLayers = true
end)
local UnlockAllLayersLabel = TeleportOptionSection:NewLabel("UnlockAllLayers Status : Off")
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
---------------------- UI ----------------------
----------- UI -----------
for i,v in pairs(UIS) do
	OpenUISection:NewButton("Open " .. v .. " UI", "Opens The " .. v .. " UI", function()
		local ActualUI = ScreenGui[v]
		ActualUI.Visible = true
		ActualUI.Frame.Close.Frame.Button.MouseButton1Click:Connect(function()
		ActualUI.Visible = false
		end)
	end)
end
---------------------- Eggs & Crates ----------------------
----------- Eggs -----------
PetsOptionSection:NewDropdown("Select Egg To Open", "Select Egg To Open", Eggs, function(currentOption)
    Variables.EggToHatch = currentOption
	Save()
end)
Toggles["AutoHatchEgg"] = PetsOptionSection:NewToggle("Auto Open Selected Egg", "Automaticly Opens The Selected Egg", function(state)
	Variables.AutoHatchEgg = state
	Save()
end)
Toggles["AutoEquipBestPets"] = PetsOptionSection:NewToggle("Auto Equip Best Pets", "Automaticly equip the best pets you have", function(state)
	Variables.AutoEquipBestPets = state
	Save()
end)
Toggles["RemoveHatchingAnimation"] = PetsOptionSection:NewToggle("Remove Hatching/Crate Open Animation", "Removes the egg hatching and Crate Open Animation", function(state)
	Variables.RemoveHatchingAnimation = state
	Save()
end)
----------- Crates -----------
local CratesToOpenTextBox = OpenCratesSection:NewTextBox("Crates To Open", "Set How Many Crates u Want to Open", function(txt)
Variables.CratesToOpen = tonumber(txt)
Save()
end)
for i,v in pairs(Crates) do
	OpenCratesSection:NewToggle(i .. "  Auto Open", "Automaticly open the " .. i .. "Crate", function(state)
		SelectedCrates[i] = state
		Save()
	end)
end
---------------------- Utility ----------------------
----------- Utility -----------
Toggles["CollapseMeter"] = UtilitySection:NewToggle("Show Collapse Meter", "Shows a collapse meter", function(state)
Variables.CollapseMeter = state
Save()
if state then
	loadstring(game:HttpGet'https://raw.githubusercontent.com/Bueezi/Satoshi-Hub/main/Collapse-Meter.lua')()
else
	pcall(function()
		game.Players.LocalPlayer.PlayerGui.ScreenGui.HUD.Left["Collapse-Meter"]:Destroy()
	end)
end
end)
Toggles["AutoClaimGroupBenefits"] = UtilitySection:NewToggle("Auto Claim Group Benefits", "Automaticly Claims Group Benefits", function(state)
	Variables.AutoClaimGroupBenefits = state
	Save()
end)
Toggles["AutoDeposit"] = UtilitySection:NewToggle("AutoDeposit Forge Shards", "Automaticly Deposits shards to the forge", function(state)
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
---------------------- Stats ----------------------
----------- Stats -----------
local RunningForLabel = SessionStatsSection:NewLabel("Running For : Error")
local BlocksLeftLabel = SessionStatsSection:NewLabel("Blocks left : Error")
local RebirthMadeLabel = SessionStatsSection:NewLabel("Rebirth Made : Error")
local LeftToRebirthLabel = SessionStatsSection:NewLabel("Left To Rebirth : Error")
local BackpackWorthCoinsLabel = SessionStatsSection:NewLabel("Bakcpack Worth Coins : Error")
----------- Global Stats -----------
local GlobalRebirthMadeLabel = GlobalStatsSection:NewLabel("Rebirth Made : Error")
---------------------- Settings ----------------------
----------- Settings -----------
SettingsSection:NewKeybind("Hide UI Key", "Select The Key to hide the UI", Enum.KeyCode.RightShift, function()
	--Library:ToggleUI()
	local SatoshiHub = game:GetService("CoreGui").SatoshiHub.Main
	if SatoshiHub.Visible == true then 
		SatoshiHub:TweenSize(UDim2.new(0, 53, 0, 32))
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
	DestroyUI()
	print("Teme Changed")
end)
SettingsSection:NewButton("DestroyUI", "Destroys the Gui", function()
    DestroyUI()
end)
SettingsSection:NewButton("Reset Settings", "Ressets All The Settings", function()
    ResetSettings()
	Save()
	RefreshToggles()
end)
SettingsSection:NewButton("Test", "Ressets All The Settings", function()
end)
Toggles["DebugMode"] = SettingsSection:NewToggle("Debug Mode", "Automaticly Deposits shards to the forge", function(state)
	Variables.DebugMode = state
	Save()
	game:GetService("ReplicatedStorage").Events.SetOption:FireServer("Debug Mode" , state)
end)
-- Settings End

-----------------------------------------------------------------------------------------------Functions--------------------------------------------------------------------------------------------------
---------------------- Spawn ----------------------
----------- Anti-Afk -----------
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
----------- Save & Load -----------
function Save()
	if Loaded == true then
		local json
		local HttpService = game:GetService("HttpService")
		if (writefile) then
			json = HttpService:JSONEncode(Variables)
			writefile(File, json)
			print("--- SuccesFully Saved Settings ---")
		else
			print("--- Sorry Your Executor Dont Support Save ---")
		end
	end
end -- Save End
function Load()
	print("----------- Loading Settings -----------")
	local json
	local HttpService = game:GetService("HttpService")
	if (readfile and isfile and isfile(File)) then
		Variables = HttpService:JSONDecode(readfile(File))
		--for i,v in pairs(Variables) do print (i .. " = " .. tostring(v)) end
		-- Add New Variables
		for i,v in pairs(DefaultSettings) do
			-- Print Variables
			if Variables[i] == nil then
				Variables[i] = v
				print("----------- Adding Variable " .. i .. " -----------")
			end
		end
		print("----------- SuccesFullyLoaded -----------")
	else
		print("--- Save Not Found / Executor Dont Support Save ---")
	end
end
----------- ResetSettings -----------
function ResetSettings()
	for i,v in pairs(Variables) do
		if i ~= "GlobalStats" then
			--print("Ressetting : " .. tostring(i) .. " From : " .. tostring(v) .. " To : " .. tostring(DefaultSettings[i]))
			Variables[i] = DefaultSettings[i]
		end
	end
	print("----------- Settings Resetted -----------")
end
Load()
----------- Refresh Toggles -----------
function RefreshToggles()
	if Variables.MineAura == true then
		Variables.AutoMine = false
		Variables.MineAura = false
	end
	for i,v in pairs(Toggles) do
		v:UpdateToggle( nil, Variables[i])
	end
	print("----------- Toggles Refreshed -----------")
end
RefreshToggles()
----------------------------------------------------------------------------------------------- UI Functions----------------------------------------------------------------------------------------------
---------------------- AutoFarm ----------------------
----------- AutoFarm -----------
spawn(function()
    while wait(0.5) do
		while Variables.AutoFarm == true do
			local blockdepth = Variables.AutoFarmDepth * -5 + 3  -- Converts the blocks height into roblox height
			if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position.Y > blockdepth then -- if player is above the chosen depth then automine
                Variables.MineAura = false
				Variables.AutoMine = true
				AutoFarmLabel:UpdateLabel("AutoFarm Status : AutoMine, Depth : " .. tostring(Variables.AutoFarmDepth))
            else -- If Player is Under The Chosen depth then Mine Aura
                Variables.AutoMine = false
				Variables.MineAura = true
				AutoFarmLabel:UpdateLabel("AutoFarm Status : Mine Aura, Depth : " .. tostring(Variables.AutoFarmDepth))
            end -- If Stop
			wait(0.3)
			if Variables.AutoFarm == false then
			    Variables.AutoMine = false
				Variables.MineAura = false
			end
		end -- If/While End
		AutoFarmLabel:UpdateLabel("AutoFarm Status : Off, Depth : " .. tostring(Variables.AutoFarmDepth))
	end -- Infinite Loop End
end) -- Spawn End
---------------------- Mine ----------------------
----------- Automine Init -----------
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
       --print("Instance hit: " .. tostring(RayInstance))
       return RayInstance
   end

   return nil
end
----------- Automine -----------
spawn(function()
    while wait(0.5) do
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
----------- Mine Aura Init -----------
local TweenService = game:GetService("TweenService")
local LoadModules = require(game.ReplicatedStorage.LoadModule);
getgenv().v2 = require(game:GetService("ReplicatedStorage").LoadModule)
getgenv().u6 = v2("ChunkUtil")
getgenv().v3 = v2("Constants")
getgenv().v4 = v3.CellSize * v3.ChunkSize
local MainData = game:GetService("RunService"):IsServer() and LoadModules("DataService") or LoadModules("LocalData");
local OresType = {"Gemstone" , "Rare Gemstone","Common Ore"}
----------- Mine Aura -----------
spawn(function()
    while wait(0.5) do
        while Variables.MineAura == true and wait(0.2) do
            pcall(function()
                for i,v in pairs(game:GetService("Workspace").Chunks:GetChildren()) do
                    for i,v in pairs(v:GetChildren()) do
						if v3.MaxSelectionDistance > (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude then
							local a = v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position * math.random(0.1, 0.001) 
							CID2 = a
							local convert2 = u6.worldToCell(a - Vector3.new(0,-1,0))
							game:GetService("ReplicatedStorage").Events.MineBlock:FireServer(convert2)
							task.wait(0.001)
							--print(convert2)
						end
                    end
                end
            end)
        end -- While Blox aura end
    end -- Infinite Loop end
end) -- Spawn Function End
----------- AutoSell Functions -----------
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
	return Layer
end
function GetWorld()
	local Player = game.Players.LocalPlayer
	local v1 = require(game.ReplicatedStorage.LoadModule);
	local u2 = v1("GetWorld");
	local World = u2.fromPlayer(Player)
	return World
end
function Sell()
	if Teleporting == false then
		Teleporting = true
		local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
		local LastPositionX = Humanoid.Position.X
		local LastPositionZ = Humanoid.Position.Z
		local LastCFrame = Humanoid.CFrame
		local Layer = GetLayer()
		print("Sell Location : " .. Layer)
		game.ReplicatedStorage.Events.Teleport:FireServer(Layer)
		wait(1)
		TeleportFunction(LastPositionX,nil,LastPositionZ,true) -- Teleport Back To Point
		Humanoid.CFrame = LastCFrame
		Teleporting = false
	end
end
function GetRebirthPrice()
	local p1 = game.Players.LocalPlayer.leaderstats.Rebirths.Value
	local p2 = require(game.ReplicatedStorage.LoadModule)("LocalData"):GetData("GemEnchantments")
	local v1 = require(game:GetService("ReplicatedStorage").SharedModules.Helpers.GetRebirthCost)
	local RebirthCost = v1(p1,p2)
	return(RebirthCost)
end
function TeleportFunction(X,Y,Z,Sky)
	loadstring(game:HttpGet'https://raw.githubusercontent.com/Bueezi/Satoshi-Hub/main/Teleport.lua')() -- Load Teleport Script
	Teleport(X,Y,Z,Variables.DebugMode,Sky)
end
function GetBackpackValue()
	local Inventory = require(game:GetService("ReplicatedStorage").SharedModules.Helpers.GetBackpackStatus)(p1)["Inventory"]
	local Blocks = require(game:GetService("ReplicatedStorage").SharedModules.Data.Blocks)
	local BackpackCoinsBrutValue = 0
	local BackpackCoinsValue = 0
	for i,OreTable in pairs(Inventory) do 
		local Ore = OreTable[1]
		local Amount = OreTable[2]
		local Currency = Blocks[Ore]["Value"][1]
		local Value = Blocks[Ore]["Value"][2]
		local TotalValue = Value * Amount
		if Currency == "Coins" then
			BackpackCoinsBrutValue = BackpackCoinsBrutValue + TotalValue
		end
		--print("Currency : " .. Currency .. " Ore Name : " .. Ore .. " Amount : " .. tostring(Amount)  .. " Ore Value : " .. TotalValue)
	end
	local moduleformat = require(game.ReplicatedStorage.LoadModule)
	local LocalData = moduleformat("LocalData")
	local CurrencyMulti = moduleformat("GetCurrencyMultiplier")
	local multiCoins = CurrencyMulti(Player, "Coins", LocalData:GetData("Passes"), LocalData:GetData("GemEnchantments"))
	BackpackCoinsValue = math.floor(BackpackCoinsBrutValue * tonumber(multiCoins) + 0.5)
	return{
	Coins = BackpackCoinsValue;
	}
end
function GetBlocksLeft()
	local BlockLeft = loadstring(game:HttpGet'https://raw.githubusercontent.com/Bueezi/Satoshi-Hub/main/Blocks-Left')()
	return BlockLeft
end
----------- AutoSell -----------
spawn(function()
    while wait(0.5) do
		while Variables.AutoSell == true and wait(0.2) do
			pcall(function()
				game:GetService("ReplicatedStorage").ClientModules.Utility.Gui.CreatePrompt.Prompt.Name = "Prompta"
			end)
			local v1 = require(game:GetService("ReplicatedStorage").SharedModules.Helpers.GetBackpackStatus);
			local t = v1(p2)
			local BackpackStorage = t["Storage"]
			local BackpackFull = t["Full"]
			if BackpackStorage > Variables.AutoSellMax and Variables.AutoSellMax ~= 0 then 
				print("Selling Because AutoSellMax")
				Sell()
			elseif BackpackFull then 
				print("Selling Because BackpackFull")
				Sell()
			end
			pcall(function()
				game:GetService("ReplicatedStorage").ClientModules.Utility.Gui.CreatePrompt.Prompta.Name = "Prompt"
			end)
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
----------- AutoRebirth -----------
spawn(function()
    while wait(0.5) do
		while Variables.AutoRebirth == true and wait(0.3) do
			--print("Rebirth Price : " .. GetRebirthPrice() .. " BackpackValue : " .. GetBackpackValue()["Coins"])
			if (GetBackpackValue()["Coins"] + game.Players.LocalPlayer.leaderstats.Coins.Value) > GetRebirthPrice() then
				if Teleporting == false then
					Teleporting = true
					local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
					local LastPositionX = Humanoid.Position.X
					local LastPositionZ = Humanoid.Position.Z
					local LastCFrame = Humanoid.CFrame
					local Layer = GetLayer()
					print("Rebirth Location : " .. Layer)
					game.ReplicatedStorage.Events.Teleport:FireServer(Layer)
					wait(1)
					game:GetService("ReplicatedStorage").Events.Rebirth:FireServer()
					wait(1)
					TeleportFunction(LastPositionX,nil,LastPositionZ,true) -- Teleport Back To Point
					Humanoid.CFrame = LastCFrame -- Teleport to depth and Orientation
					Teleporting = false
				end
			end
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
----------- Anti-Collapse -----------
spawn(function()
    while wait(0.5) do
		while Variables.CollapseProtection == true and wait(3) do
			local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
			local CollapseLocationPart = game:GetService("Workspace").Checkpoints[Variables.CollapseLocation].Root
			local CollapseLocationCFrame =  CollapseLocationPart.CFrame + Vector3.new(12,0,-3)
			local CollapseLocationX = CollapseLocationCFrame.X
			local CollapseLocationZ = CollapseLocationCFrame.Z
			local LastPositionY = Humanoid.Position.Y
			-- Teleport To Anti-Collapse-Location
			function TeleportToCollapseLocation()
				if Teleporting == false then
					Teleporting = true
					game.ReplicatedStorage.Events.Teleport:FireServer(Variables.CollapseLocation)
					TeleportFunction(CollapseLocationX,nil,CollapseLocationZ,true)
					Humanoid.CFrame = CollapseLocationCFrame
					Teleporting = false
				end
			end
			-- Position Moved
			if math.floor(Humanoid.Position.X + 0.5) ~= math.floor(CollapseLocationX + 0.5) or math.floor(Humanoid.Position.Z + 0.5) ~= math.floor(CollapseLocationZ + 0.5) then
				TeleportToCollapseLocation()
				local WhileNumber = 0
				while Humanoid.Position.Y > LastPositionY and WhileNumber < 60 do
					wait(0.5)
					WhileNumber = WhileNumber + 1
				end
			end
			-- Collapse
			if GetBlocksLeft() > 14995 then
				print("Collapsing ...")
				TeleportToCollapseLocation()
				wait(5)
			end
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- Anti Collapse End

---------------------- Factory & Boosts ----------------------
----------- AutoFactory -----------
spawn(function()
    while wait(0.5) do
		if Variables.AutoFactory == true and wait(5) then
			local Number = 0
			local FactoryTypeString = Variables.FactoryType .. " " .. Variables.FactoryAmmount
			while Number < 3 do
				Number = Number + 1
				game.ReplicatedStorage.Events.ClaimFactoryCraft:FireServer(Number)
				game.ReplicatedStorage.Events.StartFactoryCraft:FireServer(FactoryTypeString,Number)
			end
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
----------- Auto-BuyBoost -----------
spawn(function()
    while wait(10) do
		for i,v in pairs (Variables.SelectedBoosts) do
			if v == true then
				game.ReplicatedStorage.Events.BuyBoost:FireServer(i , 1)
				game.ReplicatedStorage.Events.BuyBoost:FireServer(i , 2)
			end
		end
	end -- Infinite Loop End
end) -- Spawn End
----------- BuyAllBoosts -----------
function BuyAllBoosts(state)
	for i,v in pairs(Boosts) do
		Variables.SelectedBoosts[i] = state
	end
end
---------------------- Teleport ----------------------
----------- AutoCollect Chest -----------
spawn(function()
    while wait(0.5) do
		if CollectAllChests == true then
			local PreviousWorld = GetWorld()
			while Teleporting == true do wait(0.1) end -- Wait Teleporting == false
			Teleporting = true
			for i,v in pairs(Chests) do
				local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
				local Part = game:GetService("Workspace").Checkpoints[v].Chest.Activation.Tag
				ChestX = Part.CFrame.X
				ChestZ = Part.CFrame.Z
				CollectAllChestsLabel:UpdateLabel("Collect Chest Status : " .. i .. "/" .. #Chests .. " Chest : " .. v)
				game.ReplicatedStorage.Events.Teleport:FireServer(v)
				wait(0.5)
				TeleportFunction(ChestX,nil,ChestZ,false)
				Humanoid.CFrame = Part.CFrame
				wait(0.5)
			end
			Teleporting = false
			game.ReplicatedStorage.Events.Teleport:FireServer(PreviousWorld)
			CollectAllChests = false
			CollectAllChestsLabel:UpdateLabel("Collect All Chest Status : Done")
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
---------------------- Eggs & Pets ----------------------
----------- AutoOpenEgg -----------
spawn(function()
    while wait(0.5) do
		while Variables.AutoHatchEgg == true and wait(1) do
			keypress(84)
			wait(0.25)
			keyrelease(84)
			wait(0.25)
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
----------- AutoOpenTeleport -----------
spawn(function()
    while wait(0.5) do
		while Variables.AutoHatchEgg == true and wait(1) do
			vu:SetKeyDown(Enum.KeyCode.T)
			vu:SetKeyUp(Enum.KeyCode.T)
			local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
			local EggPart = game:GetService("Workspace").Eggs[Variables.EggToOpen].EggName
			local EggPartCFrame = game:GetService("Workspace").Eggs[Variables.EggToOpen].EggName.CFrame + Vector3.new(0,5,0)
			local EggPartX = math.floor(EggPart.CFrame.X)
			local EggPartZ = math.floor(EggPart.CFrame.Z)
			if math.floor(Humanoid.Position.X) ~=  EggPartX or math.floor(Humanoid.Position.Z) ~= EggPartZ then
				if Teleporting == false then 
					Teleporting = true
					print("Teleporting To Egg")
					TeleportFunction(EggPartX,nil,EggPartZ,true)
					Humanoid.CFrame = EggPartCFrame
					Teleporting = false
				end
			end
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
----------- AutoEquipBestPets -----------
spawn(function()
    while wait(0.5) do
		while Variables.AutoEquipBestPets == true and wait(5) do
			game.ReplicatedStorage.Events.EquipBestPets:FireServer()
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
----------- Auto Open Crates -----------
spawn(function()
    while wait(5) do
		for i,v in pairs (SelectedCrates) do
			if v == true then
				local number = 0
				while number < Variables.CratesToOpen do
				game.ReplicatedStorage.Events.OpenCrate:FireServer(i)
				wait(0.03)
				number = number + 1
				end
			end
		end
	end -- Infinite Loop End
end) -- Spawn End
----------- Remove Hatching Animation -----------
spawn(function()
    while wait(3) do
		if Variables.RemoveHatchingAnimation == true then
			pcall(function()
				game:GetService("ReplicatedStorage").ClientModules.Other.OpenEgg.HatchGui.Name = "HatchGuia"
				game:GetService("ReplicatedStorage").ClientModules.Other.OpenCrate.CrateOpen.Name = "CrateOpena"
			end)
		else
			pcall(function()
				game:GetService("ReplicatedStorage").ClientModules.Other.OpenEgg.HatchGuia.Name = "HatchGui"
				game:GetService("ReplicatedStorage").ClientModules.Other.OpenCrate.CrateOpena.Name = "CrateOpen"
			end)
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
---------------------- Utility ----------------------
----------- AutoClaimGroupBenefits -----------
spawn(function()
    while wait(0.5) do
		while Variables.AutoClaimGroupBenefits == true and wait(10) do
			ReplicatedStorage.Functions.ClaimGroupBenefits:InvokeServer()
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
----------- Shards AutoDeposit -----------
spawn(function()
    while wait(0.5) do
		while Variables.AutoDeposit == true and wait(2) do
			game.ReplicatedStorage.Events.DepositShards:FireServer()
		end -- If/While End
	end -- Infinite Loop End
end) -- Spawn End
-- Shard Auto Deposit End
----------- RedeemAllCodes -----------
spawn(function()
    while wait(0.5) do
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
----------- ShowCollapseMeter -----------
if Variables.CollapseMeter == true then
	loadstring(game:HttpGet'https://pastebin.com/raw/AsbftPik')()
end
---------------------- Stats ----------------------
----------- Time -----------
spawn(function()
    while wait(1) do
		Time = Time + 1
	end -- Infinite Loop End
end) -- Spawn End
----------- Actualise -----------
spawn(function()
	local SaveIn = 50
    while wait(0.5) and Destroyed == false do
		SaveIn = SaveIn - 1
		if SaveIn == 0 then
		Save()
		SaveIn = 100
		end
		local PreviousRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
		-- Time Label
		local Minutes = (Time - Time%60)/60
		local Seconds = Time - Minutes*60
		local Hours = (Minutes - Minutes%60)/60
		local Minutes = Minutes - Hours*60
		RunningForLabel:UpdateLabel("Running For : " .. tostring(Hours) .. "h " .. tostring(Minutes) .. "m " .. tostring(Seconds) .. "s ")
		-- Blocks Left
		BlocksLeftLabel:UpdateLabel("Blocks left : " .. tostring(GetBlocksLeft()))
		-- Backpack Worth
		local moduleformat = require(game.ReplicatedStorage.LoadModule)
		local format = moduleformat("FormatBigNumber")
		local BackpackStatsCoins = GetBackpackValue()["Coins"]
		local BackpackText = format(GetBackpackValue()["Coins"])
		BackpackWorthCoinsLabel:UpdateLabel("Bakcpack Worth Coins : " .. tostring(BackpackText))
		-- Left To Rebirth
		local RebirthStatsPrice = GetRebirthPrice()
		local LeftToRebirthStatsValue = BackpackStatsCoins + game.Players.LocalPlayer.leaderstats.Coins.Value - RebirthStatsPrice
		LeftToRebirthStatsValue = -LeftToRebirthStatsValue
		local LeftToRebirthStatsText = "Error"
		if LeftToRebirthStatsValue > 0 then 
		LeftToRebirthStatsText = format(LeftToRebirthStatsValue)
		else
		LeftToRebirthStatsText = "You Can Rebirth"
		end
		LeftToRebirthLabel:UpdateLabel("Left To Rebirth : " .. tostring(LeftToRebirthStatsText))
		-- Rebirth Made Label
		local Rebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
		local RebirthMade = math.abs(StartRebirths - Rebirths)
		if Rebirths > PreviousRebirths then
			Variables.GlobalStats.RebirthMade = Variables.GlobalStats.RebirthMade + 1
		end
		RebirthMadeLabel:UpdateLabel("Rebirth Made : " .. tostring(RebirthMade))
		GlobalRebirthMadeLabel:UpdateLabel("Rebirth Made : " .. tostring(Variables.GlobalStats.RebirthMade))
	end -- Infinite Loop End
end) -- Spawn End
---------------------- Settings ----------------------
----------- DebugMode -----------
game:GetService("ReplicatedStorage").Events.SetOption:FireServer("Debug Mode" , Variables.DebugMode)

Loaded = true

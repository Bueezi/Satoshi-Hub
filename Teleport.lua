function Teleport(X,Y,Z,Debug,Sky,MaxDuration)
	local Timer = 0
	if MaxDuration == nil then MaxDuration = math.huge end
	spawn(function()
		while Timer < MaxDuration do
			wait(1)
			Timer = Timer + 1
		end
	end)
	local Humanoid = game.Players.LocalPlayer.Character.HumanoidRootPart
	if Debug then print("Teleportation Begin : Sky : " .. tostring(Sky) .. ", MaxDuration : " .. tostring(MaxDuration)) end
	-- Sky
	local LastY = Humanoid.CFrame.Y
	if Sky == true then	Humanoid.CFrame = CFrame.new(Humanoid.Position.X,9999,Humanoid.Position.Z)	end
	if X ~= nil then
		while X > Humanoid.Position.X and Timer < MaxDuration do
			wait()
			Humanoid.CFrame = CFrame.new(Vector3.new(Humanoid.CFrame.X + TeleportSpeed,Humanoid.CFrame.Y,Humanoid.CFrame.Z))
		end
		while X < Humanoid.Position.X and Timer < MaxDuration do
			wait()
			Humanoid.CFrame = CFrame.new(Vector3.new(Humanoid.CFrame.X - TeleportSpeed,Humanoid.CFrame.Y,Humanoid.CFrame.Z))
		end
		if Debug and Timer < MaxDuration then print("X Done") end
	end
	if Z ~= nil then
		while Z > Humanoid.Position.Z and Timer < MaxDuration do
			wait()
			Humanoid.CFrame = CFrame.new(Vector3.new(Humanoid.CFrame.X,Humanoid.CFrame.Y,Humanoid.CFrame.Z + TeleportSpeed))
		end
		while Z < Humanoid.Position.Z and Timer < MaxDuration do
			wait()
			Humanoid.CFrame = CFrame.new(Vector3.new(Humanoid.CFrame.X,Humanoid.CFrame.Y,Humanoid.CFrame.Z - TeleportSpeed))
		end
		if Debug and Timer < MaxDuration then print("Z Done") end
	end
	if Y ~= nil and Timer < MaxDuration then
		Humanoid.CFrame = CFrame.new(Vector3.new(Humanoid.CFrame.X,Y,Humanoid.CFrame.Z))
		if Debug then print("Y Done") end
	end
	if Debug and Timer < MaxDuration  then print("Teleportation Ended") end
	if Debug and Timer >= MaxDuration then print("Teleportation Failed") end
end

Sky = true
Debug = false
TeleportSpeed = 1.5
MaxDuration = 20

Teleport(X,Y,Z,Debug,Sky,MaxDuration)

function Teleport(X,Y,Z,Debug)
	local Humanoid = game.Players.LocalPlayer.Character.HumanoidRootPart
	-- Sky
	local LastY = Humanoid.CFrame.Y
	Humanoid.CFrame = CFrame.new(Humanoid.Position.X,9999,Humanoid.Position.Z)
	if Debug then print("Teleportation Begin") end
	if X ~= nil then
		while X > Humanoid.Position.X do
			wait()
			Humanoid.CFrame = CFrame.new(Vector3.new(Humanoid.CFrame.X + TeleportSpeed,Humanoid.CFrame.Y,Humanoid.CFrame.Z))
		end
		while X < Humanoid.Position.X do
			wait()
			Humanoid.CFrame = CFrame.new(Vector3.new(Humanoid.CFrame.X - TeleportSpeed,Humanoid.CFrame.Y,Humanoid.CFrame.Z))
		end
		if Debug then print("X Done") end
	end
	if Z ~= nil then
		while Z > Humanoid.Position.Z do
			wait()
			Humanoid.CFrame = CFrame.new(Vector3.new(Humanoid.CFrame.X,Humanoid.CFrame.Y,Humanoid.CFrame.Z + TeleportSpeed))
		end
		while Z < Humanoid.Position.Z do
			wait()
			Humanoid.CFrame = CFrame.new(Vector3.new(Humanoid.CFrame.X,Humanoid.CFrame.Y,Humanoid.CFrame.Z - TeleportSpeed))
		end
		if Debug then print("Z Done") end
	end
	if Y ~= nil then
		Humanoid.CFrame = CFrame.new(Vector3.new(Humanoid.CFrame.X,Y,Humanoid.CFrame.Z))
		if Debug then print("Y Done") end
	else
		Humanoid.CFrame = CFrame.new(Vector3.new(Humanoid.CFrame.X,LastY,Humanoid.CFrame.Z))
	end
	if Debug then print("Teleportation Ended") end
end

Debug = true
TeleportSpeed = 1.5
Teleport(X,Y,Z,Debug)

function tp(x,y,z)
moving = true
if x < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X then
while x < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X do
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X-valtomove,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
print(" Adjusting X")
end
end
if z < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z then
while z < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z do
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z-valtomove))
print(" Adjusting Z")
end
end
if x > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X then
while x > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X do
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X+valtomove,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
print("Micro Adjusting X")
end
end
if z > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z then
while z > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z do
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z+valtomove))
print("Micro Adjusting Z")
end
end
moving = false
print("Ended")
end
 

valtomove = 1
--tp(0,50,0)
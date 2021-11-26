--[[
        made by xenny#0001 out of boredom (this took me like < 5 mins)
        edit shared.Settings to your liking
        game link: https://www.roblox.com/games/6220960770/Blades-World-10X-Power#!/about
--]]



shared.Settings = {
	AutoSwing = true; -- auto swings for you (remote)
	AutoEquip = true; -- auto equips the sword
	AutoFarm  = false; -- Auto kills everyone by attaching to their back
	AntiAFK = true; -- anti afk
	IgnoreHighPower = false; -- Ignore people with high power :troll:
	AutoClick = true; -- automatically clicks for you
	NoSwordDelay = true; -- removes the sword delay
	GoToSafeSpot = true; -- Teleports you to a safe area
	Invis = true; -- makes you invis (kinda useless but eh)
	GodMode = false; -- gods you (but breaks some stuff)
	ClickTP = true; -- click tp
}

local Players = game:GetService("Players");
local Player  = Players.LocalPlayer;
local Char    = Player.Character or Player.Character.CharacterAdded:Wait();
local Backpack = Player.Backpack;
local Humanoid = Char:WaitForChild("Humanoid");
local HRP      = Char:WaitForChild("HumanoidRootPart");
local SafeArea = CFrame.new(96.6526031, 5.44599819, -234.211792, 0.999952197, 4.15686952e-09, 0.00977668911, -4.24967972e-09, 1, 9.47225143e-09, -0.00977668911, -9.51334655e-09, 0.999952197);
local Mouse = Player:GetMouse();

local function Swing()
	for i, v in next, Char:GetDescendants() do
		if v:IsA("Script") and v.Name == "up" then
			v:FindFirstChildOfClass("RemoteEvent"):FireServer(); -- they didn't have an actual function and i was lazy
		end
	end
end 

-- I dont think this works but whatever /shrug
local function Damage(Plr)
	for i, v in next, Char:GetDescendants() do
		if v:IsA("TouchTransmitter") and v.Parent.Name == "Handle" then
			firetouchinterest(v.Parent, Plr.Character:FindFirstChild("HumanoidRootPart"), 0)
			wait(0) -- :trollge:
			firetouchinterest(v.Parent, Plr.Character:FindFirstChild("HumanoidRootPart"), 1)
		end
	end
end

local function FetchPower(Player)
	for i, v in next, Player:WaitForChild("leaderstats"):GetChildren() do
		if v.Name == "Power" then
			return v.Value;
		end
	end 
end

if shared.Settings.AntiAFK then
	for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
		v:Disable()
	end
end

if shared.Settings.Invis then
	local lol = game:GetService("Players").LocalPlayer.Character.LowerTorso.Root:Clone();
	game:GetService("Players").LocalPlayer.Character.LowerTorso.Root:Destroy();
	lol.Parent = game:GetService("Players").LocalPlayer.Character.LowerTorso;  
end

if shared.Settings.GodMode then
	Humanoid.Name = "temp";
	Temp = Humanoid:Clone();
	Humanoid:Destroy();
end 
if shared.Settings.NoSwordDelay then
	local Hook;
	Hook = hookfunction(getrenv().wait, function(WaitTime)
		WaitTime = nil
		Hook(WaitTime);
	end)
end 
if shared.Settings.GoToSafeSpot then
	HRP.CFrame = SafeArea;
end 
game.RunService.RenderStepped:Connect(function()
	if shared.Settings.AutoSwing then
		Swing();
	end
	if shared.Settings.AutoEquip then
		for i, v in next, Backpack:GetChildren() do
			if v:IsA("Tool") then
				Humanoid:EquipTool(v);
			end
		end
	end
	if shared.Settings.AutoClick then
		if iswindowactive() then
			mouse1click(); -- i forgor how to do it with vui
		end
	end
	game:GetService("UserInputService").InputBegan:Connect(function(Key)
		if Key.KeyCode == Enum.KeyCode.LeftAlt and shared.Settings.ClickTP then
			HRP.CFrame = Mouse.hit;
		end
	end)

-- Ugly code
	if shared.Settings.AutoFarm then
		for i, v in next, Players:GetPlayers() do
			if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				if shared.Settings.IgnoreHighPower then
					if FetchPower(Player) < FetchPower(v) then
						return
					else
						continue; -- ugly
					end
				end
				repeat
					wait();
					HRP.CFrame = v.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, 2);
					Damage(v);
					mouse1click();
				until v.Character.Humanoid.Health <= 0;
			end
		end
	end 
end)

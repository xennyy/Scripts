-- https://www.roblox.com/games/6737540754/TITANAGE
-- put in auto exec

repeat
	task.wait()
until game and game:IsLoaded() and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart');
if (game.PlaceId == 7176980618) then
	local ohInstance1 = workspace.NPCs.Levi
	local ohString2 = "I want to do a quest"
	game:GetService("ReplicatedStorage").Remotes.DialogueEvent:InvokeServer(ohInstance1, ohString2)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3.62658501, 5.20690823, 194.458466, -0.180813178, -2.86781372e-08, 0.983517468, 3.39784506e-10, 1, 2.92212157e-08, -0.983517468, 5.61776492e-09, -0.180813178);
else
	local Players       =   game:GetService('Players');
	local Player        =   Players.LocalPlayer;
	local Tween         =   game:GetService('TweenService');
	local Rep           =   game:GetService('ReplicatedStorage');
	local Tp            =   game:GetService('TeleportService');
	local Titans        =   workspace.Titans;
	if (workspace:FindFirstChild('SupplyStations')) then
		Supply = workspace:FindFirstChild('SupplyStations')
	end;
	local Index, Value, OldNamecall;
	local Data          =   Player:WaitForChild('Data');
	local function Swing()
		Rep.Remotes.ODM:FireServer({
			[1] = "StartSwing",
			[2] = utf8.char(3486, 71, 69, 84, 32, 79, 85, 84, 32, 79, 70, 32, 77, 89, 32, 72, 69, 65, 68, 10, 9);
		});
		Rep.Remotes.ODM:FireServer({
			[1] = "EndSwing",
			[2] = utf8.char(3486, 71, 69, 84, 32, 79, 85, 84, 32, 79, 70, 32, 77, 89, 32, 72, 69, 65, 68, 10, 9);
		});
	end;
	local function PullOut()
		Rep.Remotes.ODM:FireServer({
			'ToggleBlades'
		});
	end;
	PullOut();
	local function TweenTP(loc, speed)
		tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(speed, Enum.EasingStyle.Linear)
		tween =
        tweenService:Create(
        game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart,
        tweenInfo,
        {
			CFrame = CFrame.new(loc.Position);
		}
    );
		tween:Play();
		tween.Completed:Wait();
	end;
	local function Reload()
		Rep.Remotes.ODM:FireServer({
			'ReloadBlades'
		});
	end;
	local function GetTitan()
		for Index, Value in next, Titans:GetChildren() do
			if (Value:IsA('Model')) and (Player.Character) then
				if (not Value:FindFirstChild('HumanoidRootPart')) then
					continue
				end;
				if (not Value:FindFirstChild('Hitboxes')) then
					continue
				end;
				if (not Value:FindFirstChild('Humanoid')) then
					continue
				end;
				if (not Player.Character:FindFirstChild('HumanoidRootPart')) then
					continue
				end;
				return Value;
			end;
		end;
	end;
	local Character = Player.Character;
	Character.DescendantAdded:Connect(function(A_1)
		wait(2);
		if A_1.Name == "Grip" then
			Character:Destroy();
			wait(7);
			Tp:Teleport(7176980618);
		end;
	end);
	Player.CharacterAdded:Connect(function()
	    repeat wait() until Player.Character:FindFirstChild('HumanoidRootPart') and Player.Character:FindFirstChild('ODM')
	    PullOut();
	    --Reload();
	 end);
	while task.wait() do
		if (GetTitan()) and (GetTitan():FindFirstChild('HumanoidRootPart')) and (GetTitan():FindFirstChild('Hitboxes')) and (GetTitan():FindFirstChild('Humanoid')) and (Player.Character) and (Player.Character:FindFirstChild('HumanoidRootPart')) then
			repeat
				task.wait()
				if (Data.BladeDurability.Value <= 0) then
					Reload();
				end
				if (Data.BladesLeft.Value <= 0) and (Supply ~= nil)then
					for Index, Value in next, Supply:GetChildren() do
						if (string.find(Value.Name:lower(), 'blade')) then
						    if (Value:FindFirstChild('BladesLeft').Value <= 0) then continue end;
							TweenTP(Value.CFrame, 0);
							repeat
								task.wait()
								local Remote = Value:FindFirstChildOfClass('RemoteEvent');
								Remote:FireServer(true);
							until Data.BladesLeft.Value > 2 or Value.BladesLeft.Value == 0;
							Reload();
						end;
					end;
				end;
				if (GetTitan()) and (GetTitan().Hitboxes) and (GetTitan().Hitboxes.Nape) then
					TweenTP(GetTitan().Hitboxes.Nape.CFrame * CFrame.new(0, 3, 0) , 0)
					Swing();
				end;
			until GetTitan() == nil  or not GetTitan().Humanoid or GetTitan().Humanoid.Health <= 0;
		end;
	end;
end;

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local Config = {
	AutoSteal = false,
	AutoEvent = false,
	AutoChest = false,
	Speed = 16,
	Area = "ALL",
	Rarity = "ALL",
	Size = 1
}

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "RenzHub"
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(420,420)
Main.Position = UDim2.new(.5,-210,.5,-210)
Main.BackgroundColor3 = Color3.fromRGB(22,22,27)
Main.BorderSizePixel = 0
Main.Parent = Gui

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,55)
Title.BackgroundTransparency = 1
Title.Text = "⚡ RenzHub"
Title.TextColor3 = Color3.fromRGB(255,40,40)
Title.TextSize = 27
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

local function Button(text,y,callback)
	local B = Instance.new("TextButton")
	B.Size = UDim2.new(1,-30,0,38)
	B.Position = UDim2.fromOffset(15,y)
	B.BackgroundColor3 = Color3.fromRGB(42,42,50)
	B.TextColor3 = Color3.new(1,1,1)
	B.TextSize = 14
	B.Font = Enum.Font.GothamMedium
	B.Text = text
	B.Parent = Main
	Instance.new("UICorner",B).CornerRadius = UDim.new(0,7)

	B.MouseButton1Click:Connect(callback)
	return B
end

local function Status(text)
	print("[RenzHub] "..text)
end

-- PROFILE
Button("👤 Player Profile",60,function()
	Status(
		"Player: "..Player.Name..
		" | UserId: "..Player.UserId
	)
end)

-- AUTO STEAL
local StealButton
StealButton = Button("🥚 Auto Collect: OFF",105,function()
	Config.AutoSteal = not Config.AutoSteal

	StealButton.Text =
		"🥚 Auto Collect: "..(Config.AutoSteal and "ON" or "OFF")

	-- Nối chức năng collect của GAME BẠN tại đây
end)

-- SPEED
Button("🏃 Speed: 16",150,function()
	Config.Speed = Config.Speed == 16 and 50 or 16

	local Character = Player.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		Hum

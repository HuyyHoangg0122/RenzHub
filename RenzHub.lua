
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer

local Character, Humanoid, RootPart
local function WaitChar()
    Player.CharacterAdded:Connect(function(c)
        Character = c
        Humanoid = c:WaitForChild("Humanoid")
        RootPart = c:WaitForChild("HumanoidRootPart")
    end)
    if Player.Character then
        Character = Player.Character
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
        RootPart = Character:FindFirstChild("HumanoidRootPart")
    end
end
WaitChar()

local Config = {
    AutoSteal = false, AutoEvent = false, AutoChest = false, Speed = 16,
    Area = "ALL", Rarity = "ALL", Size = 1,
    AntiTrap = false, AntiFall = false, AntiHit = false,
    AntiLag = false, AntiAFK = false, FixLag = false, LowGraphics = false
}

local AREAS = {
    "ALL",
    "Forest", "Lake", "Desert", "Jungle", "Snow",
    "Volcano", "Abyss Ocean", "Prehistoric", "Cosmic", "Cherry Blossom",
    "Titan Temple"
}

local RARITIES = {
    "ALL", "Common", "Uncommon", "Rare", "Epic", "Legendary",
    "Mythic", "Divine", "Secret", "Exotic", "Godly", "Immortal",
    "Ancient", "Celestial", "Abyssal", "Void", "Eternal"
}

local Gui = Instance.new("ScreenGui")
Gui.Name = "RenzHub"
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(420, 920)
Main.Position = UDim2.new(0.5, -210, 0.5, -460)
Main.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
Main.Parent = Gui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local TitleContainer = Instance.new("Frame")
TitleContainer.Size = UDim2.new(1, 0, 0, 55)
TitleContainer.BackgroundTransparency = 1
TitleContainer.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "RenzHub — Steal An Egg"
Title.TextColor3 = Color3.fromRGB(255, 40, 40)
Title.TextSize = 32
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleContainer

local Lightning = Instance.new("Frame")
Lightning.Size = UDim2.new(0, 100, 0, 4)
Lightning.Position = UDim2.new(0.02, 0, 0.5, 0)
Lightning.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
Lightning.Rotation = -25
Lightning.ZIndex = 2
Lightning.Parent = TitleContainer
Instance.new("UICorner", Lightning).CornerRadius = UDim.new(0, 2)

local LightningGlow = Instance.new("Frame")
LightningGlow.Size = UDim2.new(1, 0, 1, 0)
LightningGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
LightningGlow.BackgroundTransparency = 0.5
LightningGlow.Parent = Lightning
Instance.new("UICorner", LightningGlow).CornerRadius = UDim.new(0, 2)

local DragToggle, DragStart, StartPos
TitleContainer.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        DragToggle = true
        DragStart = i.Position
        StartPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if DragToggle and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - DragStart
        Main.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + d.X, StartPos.Y.Scale, StartPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function() DragToggle = false end)

local y = 60
local function Button(text, callback, color)
    y = y + 45
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -30, 0, 38)
    btn.Position = UDim2.new(0, 15, 0, y)
    btn.BackgroundColor3 = color or Color3.fromRGB(42, 42, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text
    btn.Parent = Main
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function Section(text)
    y = y + 15
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -30, 0, 28)
    lbl.Position = UDim2.new(0, 15, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 55, 55)
    lbl.TextSize = 17
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = Main
end

local function GetEggs()
    local e = {}
    for _, v in workspace:GetDescendants() do
        if v:IsA("BasePart") and (string.lower(v.Name):find("egg") or string.lower(v.Name):find("trứng")) then
            table.insert(e, {
                Ins = v,
                Pos = v:GetPivot().Position,
                Area = v:FindFirstChild("Area") and v.Area.Value or "ALL",
                Rarity = v:FindFirstChild("Rarity") and v.Rarity.Value
                    or v:FindFirstChild("Rank") and v.Rank.Value
                    or v:FindFirstChild("PetRarity") and v.PetRarity.Value or "ALL",
                Size = v:FindFirstChild("Size") and v.Size.Value or 1
            })
        end
    end
    return e
end

local function FilterEgg(egg)
    if Config.Area ~= "ALL" and egg.Area ~= Config.Area then return false end
    if Config.Rarity ~= "ALL" and egg.Rarity ~= Config.Rarity then return false end
    if egg.Size < Config.Size then return false end
    return true
end

local function NearestEgg()
    if not RootPart then return end
    local eggs = GetEggs(), best, dist = nil, math.huge
    for _, e in pairs(eggs) do
        if FilterEgg(e) then
            local d = (e.Pos - RootPart.Position).Magnitude
            if d < dist then best, dist = e, d end
        end
    end
    return best
end

local function Collect(egg)
    if not egg or not egg.Ins then return end
    pcall(function()
        local c = egg.Ins:FindFirstChildOfClass("ClickDetector")
        if c then fireclickdetector(c) end
    end)
end

Section("🥚 AUTO STEAL")
local StealBtn = Button("🥚 Auto Collect: OFF", function()
    Config.AutoSteal = not Config.AutoSteal
    StealBtn.Text = "🥚 Auto Collect: " .. (Config.AutoSteal and "✅ ON" or "❌ OFF")
    StealBtn.BackgroundColor3 = Config.AutoSteal and Color3.fromRGB(30, 120, 60) or Color3.fromRGB(42, 42, 50)
end)

local SpeedBtn = Button("🏃 Tốc độ: 16", function()
    Config.Speed = Config.Speed == 16 and 50 or Config.Speed == 50 and 100 or 16
    SpeedBtn.Text = "🏃 Tốc độ: " .. Config.Speed
    if Humanoid then Humanoid.WalkSpeed = Config.Speed end
end)

Section("📍 LỌC KHU VỰC")
local AreaBtn = Button("📍 Khu vực: ALL", function()
    local i = table.find(AREAS, Config.Area) or 1
    i = i % #AREAS + 1
    Config.Area = AREAS[i]
    AreaBtn.Text = "📍 Khu vực: " .. Config.Area
end)

Section("⭐ LỌC RANK PET")
local RarityBtn = Button("⭐ Rank Pet: ALL", function()
    local i = table.find(RARITIES, Config.Rarity) or 1
    i = i % #RARITIES + 1
    Config.Rarity = RARITIES[i]
    RarityBtn.Text = "⭐ Rank Pet: " .. Config.Rarity
end)

local SizeBtn = Button("📦 Kích thước ≥ 1", function()
    local l = {1, 2, 5, 10, 20, 50, 100}
    local i = table.find(l, Config.Size) or 1
    i = i % #l + 1
    Config.Size = l[i]
    SizeBtn.Text = "📦 Kích thước ≥ " .. Config.Size
end)

Section("🛡️ ANTI HỆ THỐNG")
local AntiTrapBtn = Button("🪤 Anti Trap: OFF", function()
    Config.AntiTrap = not Config.AntiTrap
    AntiTrapBtn.Text = "🪤 Anti Trap: " .. (Config.AntiTrap and "✅ ON" or "❌ OFF")
    AntiTrapBtn.BackgroundColor3 = Config.AntiTrap and Color3.fromRGB(30, 120, 60) or Color3.fromRGB(42, 42, 50)
end)

local AntiFallBtn = Button("🦘 Anti Té: OFF", function()
    Config.AntiFall = not Config.AntiFall
    AntiFallBtn.Text = "🦘 Anti Té: " .. (Config.AntiFall and "✅ ON" or "❌ OFF")
    AntiFallBtn.BackgroundColor3 = Config.AntiFall and Color3.fromRGB(30, 120, 60) or Color3.fromRGB(42, 42, 50)
end)

local AntiHitBtn = Button("🛡️ Anti Bị Đánh: OFF", function()
    Config.AntiHit = not Config.AntiHit
    AntiHitBtn.Text = "🛡️ Anti Bị Đánh: " .. (Config.AntiHit and "✅ ON" or "❌ OFF")
    AntiHitBtn.BackgroundColor3 = Config.AntiHit and Color3.fromRGB(30, 120, 60) or Color3.fromRGB(42, 42, 50)
end)

local AntiLagBtn = Button("⚡ Anti Lag: OFF", function()
    Config.AntiLag = not Config.AntiLag
    AntiLagBtn.Text = "⚡ Anti Lag: " .. (Config.AntiLag and "✅ ON" or "❌ OFF")
    AntiLagBtn.BackgroundColor3 = Config.AntiLag and Color3.fromRGB(30, 120, 60) or Color3.fromRGB(42, 42, 50)
end)

local AntiAFKBtn = Button("😴 Anti AFK: OFF", function()
    Config.AntiAFK = not Config.AntiAFK
    AntiAFKBtn.Text = "😴 Anti AFK: " .. (Config.AntiAFK and "✅ ON" or "❌ OFF")
    AntiAFKBtn.BackgroundColor3 = Config.AntiAFK and Color3.fromRGB(30, 120, 60) or Color3.fromRGB(42, 42, 50)
end)

local FixLagBtn = Button("🔧 Fix Lag: OFF", function()
    Config.FixLag = not Config.FixLag
    FixLagBtn.Text = "🔧 Fix Lag: " .. (Config.FixLag and "✅ ON" or "❌ OFF")
    FixLagBtn.BackgroundColor3 = Config.FixLag and Color3.fromRGB(30, 120, 60) or Color3.fromRGB(42, 42, 50)
end)

local LowGfxBtn = Button("🎮 Giảm Đồ Họa: OFF", function()
    Config.LowGraphics = not Config.LowGraphics
    LowGfxBtn.Text = "🎮 Giảm Đồ Họa: " .. (Config.LowGraphics and "✅ ON" or "❌ OFF")
    LowGfxBtn.BackgroundColor3 = Config.LowGraphics and Color3.fromRGB(30, 120, 60) or Color3.fromRGB(42, 42, 50)
end)

Section("⚡ AUTO KHÁC")
local EventBtn = Button("🎁 Auto Event: OFF", function()
    Config.AutoEvent = not Config.AutoEvent
    EventBtn.Text = "🎁 Auto Event: " .. (Config.AutoEvent and "✅ ON" or "❌ OFF")
    EventBtn.BackgroundColor3 = Config.AutoEvent and Color3.fromRGB(30, 120, 60) or Color3.fromRGB(42, 42, 50)
end)

local ChestBtn = Button("📦 Auto Rương: OFF", function()
    Config.AutoChest = not Config.AutoChest
    ChestBtn.Text = "📦 Auto Rương: " .. (Config.AutoChest and "✅ ON" or "❌ OFF")
    ChestBtn.BackgroundColor3 = Config.AutoChest and Color3.fromRGB(30, 120, 60) or Color3.fromRGB(42, 42, 50)
end)

task.spawn(function()
    while task.wait(0.3) do
        if Config.AutoSteal and RootPart and Humanoid then
            local target = NearestEgg()
            if target then
                if (target.Pos - RootPart.Position).Magnitude > 10 then
                    Humanoid:MoveTo(target.Pos)
                    task.wait(0.25)
                end
                Collect(target)
            end
        end
    end
end)

Player.Idled:Connect(function()
    if Config.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

local function Optimize()
    if Config.LowGraphics then
        Lighting.Brightness = 1
        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.ShadowSoftness = 0
        Lighting.Ambient = Color3.fromRGB(120, 120, 120)
    end
    for _, v in workspace:GetDescendants() do
        pcall(function()
            if Config.AntiLag or Config.FixLag then
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false
                end
                if v:IsA("BasePart") then v.CastShadow = false end
            end
        end)
    end
end

RunService.RenderStepped:Connect(function()
    if Config.AntiLag or Config.FixLag or Config.LowGraphics then Optimize() end
end)

RunService.Heartbeat:Connect(function()
    if not Humanoid then return end
    if Config.AntiFall then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    else
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
    end
    if Config.AntiHit and RootPart then RootPart.Velocity = Vector3.new() end
end)

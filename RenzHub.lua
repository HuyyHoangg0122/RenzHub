-- RENZHUB Script Real Working for Steal an Egg
-- Executor: Delta X

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Xóa GUI cũ nếu đã tồn tại
if CoreGui:FindFirstChild("RENZHUB_GUI") then
    CoreGui.RENZHUB_GUI:Destroy()
end

-- Tạo ScreenGui chính
local RENZHUB_GUI = Instance.new("ScreenGui")
RENZHUB_GUI.Name = "RENZHUB_GUI"
RENZHUB_GUI.Parent = CoreGui
RENZHUB_GUI.ResetOnSpawn = false

-- 1. ICON RENZHUB NÚT BẤM (Góc dưới bên trái)
local RenzIconBtn = Instance.new("ImageButton")
RenzIconBtn.Name = "RenzIconBtn"
RenzIconBtn.Parent = RENZHUB_GUI
RenzIconBtn.Position = UDim2.new(0, 15, 1, -75)
RenzIconBtn.Size = UDim2.new(0, 60, 0, 60)
RenzIconBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
RenzIconBtn.BorderSizePixel = 2
RenzIconBtn.BorderColor3 = Color3.fromRGB(255, 215, 0)
RenzIconBtn.AutoButtonColor = true

local UICornerIcon = Instance.new("UICorner")
UICornerIcon.CornerRadius = UDim.new(1, 0)
UICornerIcon.Parent = RenzIconBtn

local IconR = Instance.new("TextLabel")
IconR.Parent = RenzIconBtn
IconR.Size = UDim2.new(1, 0, 1, 0)
IconR.BackgroundTransparency = 1
IconR.Text = "R"
IconR.TextColor3 = Color3.fromRGB(230, 0, 0)
IconR.TextSize = 38
IconR.Font = Enum.Font.FredokaOne
IconR.TextYAlignment = Enum.TextYAlignment.Center

local IconLightning = Instance.new("TextLabel")
IconLightning.Parent = RenzIconBtn
IconLightning.Size = UDim2.new(1, 0, 1, 0)
IconLightning.BackgroundTransparency = 1
IconLightning.Text = "⚡"
IconLightning.TextColor3 = Color3.fromRGB(255, 220, 0)
IconLightning.TextSize = 30
IconLightning.Rotation = -25

-- 2. BẢNG GIAO DIỆN CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = RENZHUB_GUI
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -120)
MainFrame.Size = UDim2.new(0, 320, 0, 240)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 38)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Thanh Tiêu Đề
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 17, 25)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local LogoFrame = Instance.new("Frame")
LogoFrame.Parent = TitleBar
LogoFrame.Position = UDim2.new(0, 10, 0, 2)
LogoFrame.Size = UDim2.new(0, 40, 0, 40)
LogoFrame.BackgroundTransparency = 1

local LogoR = Instance.new("TextLabel")
LogoR.Parent = LogoFrame
LogoR.Size = UDim2.new(1, 0, 1, 0)
LogoR.BackgroundTransparency = 1
LogoR.Text = "R"
LogoR.TextColor3 = Color3.fromRGB(255, 0, 0)
LogoR.TextSize = 32
LogoR.Font = Enum.Font.FredokaOne

local LogoLightning = Instance.new("TextLabel")
LogoLightning.Parent = LogoFrame
LogoLightning.Size = UDim2.new(1, 0, 1, 0)
LogoLightning.BackgroundTransparency = 1
LogoLightning.Text = "⚡"
LogoLightning.TextColor3 = Color3.fromRGB(255, 215, 0)
LogoLightning.TextSize = 26
LogoLightning.Rotation = -30

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.Position = UDim2.new(0, 50, 0, 0)
TitleText.Size = UDim2.new(0, 200, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "RENZHUB"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 20
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Nút Auto Farm Egg
local AutoFarmBtn = Instance.new("TextButton")
AutoFarmBtn.Parent = MainFrame
AutoFarmBtn.Position = UDim2.new(0.05, 0, 0.28, 0)
AutoFarmBtn.Size = UDim2.new(0.9, 0, 0, 35)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
AutoFarmBtn.Text = "AUTO STEAL EGG: OFF"
AutoFarmBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoFarmBtn.Font = Enum.Font.SourceSansBold
AutoFarmBtn.TextSize = 16

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 6)
BtnCorner1.Parent = AutoFarmBtn

-- Nút WalkSpeed (Chạy Nhanh)
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Parent = MainFrame
SpeedBtn.Position = UDim2.new(0.05, 0, 0.48, 0)
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 35)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
SpeedBtn.Text = "SPEED BOOST: OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.TextSize = 16

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 6)
BtnCorner2.Parent = SpeedBtn

-- Nút ESP Players
local EspBtn = Instance.new("TextButton")
EspBtn.Parent = MainFrame
EspBtn.Position = UDim2.new(0.05, 0, 0.68, 0)
EspBtn.Size = UDim2.new(0.9, 0, 0, 35)
EspBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
EspBtn.Text = "ESP PLAYER: OFF"
EspBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
EspBtn.Font = Enum.Font.SourceSansBold
EspBtn.TextSize = 16

local BtnCorner3 = Instance.new("UICorner")
BtnCorner3.CornerRadius = UDim.new(0, 6)
BtnCorner3.Parent = EspBtn

-- 3. LOGIC CHỨC NĂNG HACK BÊN TRONG GAME
local autoFarmActive = false
local speedActive = false
local espActive = false

-- Bật/Tắt Menu khi ấn Icon
RenzIconBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Logic Auto Farm (Tự Teleport lấy trứng)
AutoFarmBtn.MouseButton1Click:Connect(function()
    autoFarmActive = not autoFarmActive
    if autoFarmActive then
        AutoFarmBtn.Text = "AUTO STEAL EGG: ON"
        AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
    else
        AutoFarmBtn.Text = "AUTO STEAL EGG: OFF"
        AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
    end
end)

task.spawn(function()
    while true do
        task.wait(0.2)
        if autoFarmActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:lower():find("egg") or v.Parent.Name:lower():find("egg")) then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0)
                    task.wait(0.3)
                    break
                end
            end
        end
    end
end)

-- Logic Speed Boost
SpeedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    if speedActive then
        SpeedBtn.Text = "SPEED BOOST: ON"
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
    else
        SpeedBtn.Text = "SPEED BOOST: OFF"
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
    end
end)

RunService.RenderStepped:Connect(function()
    if speedActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    elseif not speedActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

-- Logic ESP nhìn người chơi
EspBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    if espActive then
        EspBtn.Text = "ESP PLAYER: ON"
        EspBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
    else
        EspBtn.Text = "ESP PLAYER: OFF"
        EspBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local highlight = plr.Character:FindFirstChild("RenzESP")
                if espActive then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "RenzESP"
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                        highlight.Parent = plr.Character
                    end
                else
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
        end
    end
end)


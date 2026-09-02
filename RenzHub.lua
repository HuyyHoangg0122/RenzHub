-- RENZHUB Script for Steal an Egg
-- Gui & Feature Implementation

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
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

-- 1. TẠO ICON RENZHUB NÚT BẤM GÓC DƯỚI BÊN TRÁI (Thay thế nút cũ)
local RenzIconBtn = Instance.new("ImageButton")
RenzIconBtn.Name = "RenzIconBtn"
RenzIconBtn.Parent = RENZHUB_GUI
RenzIconBtn.Position = UDim2.new(0, 15, 1, -75)
RenzIconBtn.Size = UDim2.new(0, 60, 0, 60)
RenzIconBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
RenzIconBtn.BorderSizePixel = 2
RenzIconBtn.BorderColor3 = Color3.fromRGB(255, 215, 0) -- Viền vàng
RenzIconBtn.AutoButtonColor = true

local UICornerIcon = Instance.new("UICorner")
UICornerIcon.CornerRadius = UDim.new(1, 0) -- Tạo hình tròn
UICornerIcon.Parent = RenzIconBtn

-- Chữ 'R' màu đỏ trong Icon
local IconR = Instance.new("TextLabel")
IconR.Parent = RenzIconBtn
IconR.Size = UDim2.new(1, 0, 1, 0)
IconR.BackgroundTransparency = 1
IconR.Text = "R"
IconR.TextColor3 = Color3.fromRGB(230, 0, 0) -- Đỏ rực
IconR.TextSize = 38
IconR.Font = Enum.Font.FredokaOne
IconR.TextYAlignment = Enum.TextYAlignment.Center

-- Tia sét cắt ngang chữ R trong Icon
local IconLightning = Instance.new("TextLabel")
IconLightning.Parent = RenzIconBtn
IconLightning.Size = UDim2.new(1, 0, 1, 0)
IconLightning.BackgroundTransparency = 1
IconLightning.Text = "⚡"
IconLightning.TextColor3 = Color3.fromRGB(255, 220, 0) -- Vàng sét
IconLightning.TextSize = 30
IconLightning.Rotation = -25

-- 2. BẢNG GIAO DIỆN CHÍNH (RENZHUB HUB)
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

-- Logo R màu đỏ rực có tia sét trên thanh tiêu đề
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

-- Tên Hub
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

-- Nút Bật/Tắt Auto-Farm Egg
local AutoFarmBtn = Instance.new("TextButton")
AutoFarmBtn.Parent = MainFrame
AutoFarmBtn.Position = UDim2.new(0.05, 0, 0.28, 0)
AutoFarmBtn.Size = UDim2.new(0.9, 0, 0, 35)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
AutoFarmBtn.Text = "STEAL EGG (AUTOFARM): OFF"
AutoFarmBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoFarmBtn.Font = Enum.Font.SourceSansBold
AutoFarmBtn.TextSize = 16

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 6)
BtnCorner1.Parent = AutoFarmBtn

-- Nút Bật/Tắt Auto-Collect
local AutoCollectBtn = Instance.new("TextButton")
AutoCollectBtn.Parent = MainFrame
AutoCollectBtn.Position = UDim2.new(0.05, 0, 0.48, 0)
AutoCollectBtn.Size = UDim2.new(0.9, 0, 0, 35)
AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
AutoCollectBtn.Text = "AUTO-COLLECT: OFF"
AutoCollectBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoCollectBtn.Font = Enum.Font.SourceSansBold
AutoCollectBtn.TextSize = 16

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 6)
BtnCorner2.Parent = AutoCollectBtn

-- Nút Bật/Tắt ESP Player & Egg
local EspBtn = Instance.new("TextButton")
EspBtn.Parent = MainFrame
EspBtn.Position = UDim2.new(0.05, 0, 0.68, 0)
EspBtn.Size = UDim2.new(0.9, 0, 0, 35)
EspBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
EspBtn.Text = "ESP (PLAYER & EGG): OFF"
EspBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
EspBtn.Font = Enum.Font.SourceSansBold
EspBtn.TextSize = 16

local BtnCorner3 = Instance.

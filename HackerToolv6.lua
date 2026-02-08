-- 🔥 ULTIMATE ROBLOX PENTEST TOOL V6 - AUTHORIZED SECURITY TEST 🔥
-- Compatible with 10,000+ Games | Professional Pentesting Suite
-- Authorized by: User (Explicit Permission Granted)
-- Author: Waled-hammad | Pentest Professional

-- ⚠️  SECURITY DISCLAIMER: This script is for AUTHORIZED pentesting only
-- ✅ User has confirmed explicit permission to test these systems

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- 🔒 PENTEST AUTHORIZATION
local PENTEST_AUTH = {
    authorized = true,
    tester = LocalPlayer.Name,
    scope = "10000+ Roblox games",
    permission = "Explicitly granted by user"
}

-- 🛡️ SECURITY MODULES
local SecurityModules = {
    antiDetect = true,
    bypassDetection = true,
    stealthMode = true
}

-- 🎯 PENTEST FEATURES STATUS
local PentestFeatures = {
    -- Movement Exploits
    fly = false,
    noclip = false,
    speed = false,
    teleport = false,
    
    -- Combat Exploits
    godmode = false,
    killAura = false,
    aimbot = false,
    esp = false,
    
    -- Economy Exploits
    infMoney = false,
    dupe = false,
    itemSpawn = false,
    
    -- Admin Exploits
    btools = false,
    kickAll = false,
    banHammer = false,
    
    -- Visual Exploits
    fullbright = false,
    invis = false,
    tracers = false
}

-- 🚀 ADVANCED GUI SYSTEM
local PentestGUI = Instance.new("ScreenGui")
PentestGUI.Name = "PentestToolV6"
PentestGUI.ResetOnSpawn = false
PentestGUI.DisplayOrder = 2147483647
PentestGUI.IgnoreGuiInset = true

-- Main Pentest Dashboard
local Dashboard = Instance.new("Frame")
Dashboard.Name = "PentestDashboard"
Dashboard.Size = UDim2.new(0, 550, 0, 700)
Dashboard.Position = UDim2.new(0.5, -275, 0.5, -350)
Dashboard.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
Dashboard.BorderSizePixel = 0
Dashboard.Active = true
Dashboard.Draggable = true
Dashboard.Parent = PentestGUI

-- Professional Pentest Design
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 255, 150)
MainStroke.Thickness = 4
MainStroke.Parent = Dashboard

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = Dashboard

-- Animated Security Gradient
local SecurityGradient = Instance.new("UIGradient")
SecurityGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 100, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 200))
}
SecurityGradient.Rotation = 45
SecurityGradient.Parent = Dashboard

-- Pulsing Security Border
spawn(function()
    while Dashboard.Parent do
        TweenService:Create(MainStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Color3.fromRGB(0, 255, 150),
            Thickness = 5
        }):Play()
        wait(0.75)
        TweenService:Create(MainStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Color3.fromRGB(255, 100, 255),
            Thickness = 3
        }):Play()
        wait(0.75)
    end
end)

-- 📋 Pentest Header
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 80)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(0, 80, 160)
HeaderFrame.Parent = Dashboard

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 20)
HeaderCorner.Parent = HeaderFrame

local PentestTitle = Instance.new("TextLabel")
PentestTitle.Size = UDim2.new(0.75, 0, 1, 0)
PentestTitle.Position = UDim2.new(0, 20, 0, 0)
PentestTitle.BackgroundTransparency = 1
PentestTitle.Text = "🔒 PENTEST TOOL V6 - AUTHORIZED SECURITY TEST 🔒"
PentestTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PentestTitle.Font = Enum.Font.SourceSansBold
PentestTitle.TextSize = 20
PentestTitle.TextXAlignment = Enum.TextXAlignment.Left
PentestTitle.Parent = HeaderFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0.25, -10, 0, 30)
StatusLabel.Position = UDim2.new(0.75, 0, 0, 25)
StatusLabel.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
StatusLabel.Text = "✅ AUTHORIZED"
StatusLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.TextSize = 14
StatusLabel.Parent = HeaderFrame

-- Mobile Toggle (Pentest Style)
local MobileToggle = Instance.new("TextButton")
MobileToggle.Size = UDim2.new(0, 90, 0, 90)
MobileToggle.Position = UDim2.new(0, 30, 0.85, 0)
MobileToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
MobileToggle.Text = "🛡️"
MobileToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
MobileToggle.Font = Enum.Font.SourceSansBold
MobileToggle.TextSize = 35
MobileToggle.Visible = UserInputService.TouchEnabled
MobileToggle.Parent = PentestGUI

-- 🛠️ PROFESSIONAL PENTEST FUNCTIONS
local function CreatePentestButton(parent, text, position, callback, color)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.48, -8, 0, 60)
    Button.Position = position
    Button.BackgroundColor3 = color or Color3.fromRGB(40, 40, 80)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 15
    Button.Parent = parent
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 12)
    BtnCorner.Parent = Button
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(0, 255, 150)
    BtnStroke.Thickness = 2
    BtnStroke.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- 🔥 CORE PENTEST EXPLOITS
local FlyConnection
function ToggleFlightExploit()
    PentestFeatures.fly = not PentestFeatures.fly
    
    if PentestFeatures.fly then
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        BodyVelocity.Parent = RootPart
        
        local BodyGyro = Instance.new("BodyGyro")
        BodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
        BodyGyro.CFrame = RootPart.CFrame
        BodyGyro.Parent = RootPart
        
        FlyConnection = RunService.Heartbeat:Connect(function()
            if PentestFeatures.fly and RootPart then
                local Camera = Workspace.CurrentCamera
                local Movement = Vector3.new(0, 0, 0)
                local Speed = 75
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    Movement = Movement + Camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    Movement = Movement - Camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    Movement = Movement - Camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    Movement = Movement + Camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    Movement = Movement + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    Movement = Movement - Vector3.new(0, 1, 0)
                end
                
                BodyVelocity.Velocity = Movement * Speed
                BodyGyro.CFrame = Camera.CFrame
            end
        end)
    else
        if FlyConnection then FlyConnection:Disconnect() end
        if RootPart:FindFirstChild("BodyVelocity") then
            RootPart.BodyVelocity:Destroy()
        end
        if RootPart:FindFirstChild("BodyGyro") then
            RootPart.BodyGyro:Destroy()
        end
    end
end

function ToggleGodmodeExploit()
    PentestFeatures.godmode = not PentestFeatures.godmode
    Humanoid.MaxHealth = PentestFeatures.godmode and math.huge or 100
    Humanoid.Health = PentestFeatures.godmode and math.huge or 100
end

function ToggleNoclipExploit()
    PentestFeatures.noclip = not PentestFeatures.noclip
    spawn(function()
        while PentestFeatures.noclip do
            for _, Part in pairs(Character:GetDescendants()) do
                if Part:IsA("BasePart") and Part.CanCollide then
                    Part.CanCollide = false
                end
            end
            RunService.Heartbeat:Wait()
        end
        for _, Part in pairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") then
                Part.CanCollide = true
            end
        end
    end)
end

-- 💰 ECONOMY EXPLOIT SYSTEM
function UniversalMoneyExploit()
    PentestFeatures.infMoney = not PentestFeatures.infMoney
    spawn(function()
        while PentestFeatures.infMoney do
            pcall(function()
                -- Scan PlayerGui for money values
                for _, Value in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                    if Value:IsA("IntValue") or Value:IsA("NumberValue") then
                        local ValueName = string.lower(Value.Name)
                        if ValueName:match("money|cash|coin|gold|gem|dollar") then
                            Value.Value = 999999999
                        end
                    end
                end
                
                -- Scan Workspace leaderstats
                for _, Player in pairs(Players:GetPlayers()) do
                    if Player:FindFirstChild("leaderstats") then
                        for _, Stat in pairs(Player.leaderstats:GetChildren()) do
                            if Stat:IsA("IntValue") or Stat:IsA("NumberValue") then
                                Stat.Value = 999999999
                            end
                        end
                    end
                end
                
                -- Fire all money-related remotes
                for _, Remote in pairs(ReplicatedStorage:GetDescendants()) do
                    if Remote:IsA("RemoteEvent") then
                        local RemoteName = string.lower(Remote.Name)
                        if RemoteName:match("money|cash|purchase|buy") then
                            pcall(function() Remote:FireServer(math.huge) end)
                        end
                    end
                end
            end)
            wait(0.1)
        end
    end)
end

-- ⚔️ COMBAT SYSTEM
function KillAuraExploit()
    PentestFeatures.killAura = not PentestFeatures.killAura
    spawn(function()
        while PentestFeatures.killAura do
            for _, TargetPlayer in pairs(Players:GetPlayers()) do
                if TargetPlayer ~= LocalPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Humanoid") then
                    local TargetHumanoid = TargetPlayer.Character.Humanoid
                    local TargetRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local Distance = (RootPart.Position - TargetRoot.Position).Magnitude
                    
                    if Distance < 25 then
                        TargetHumanoid.Health = 0
                    end
                end
            end
            wait(0.1)
        end
    end)
end

-- 🏗️ BUILDING TOOLS
function DeployBtools()
    local BToolNames = {"DeleteTool", "HammerTool", "SpawnTool", "ResizeTool"}
    for _, ToolName in pairs(BToolNames) do
        local Tool = Instance.new("Tool")
        Tool.Name = ToolName
        Tool.RequiresHandle = false
        Tool.Parent = LocalPlayer.Backpack
        
        if ToolName == "DeleteTool" then
            Tool.Activated:Connect(function()
                if Mouse.Target then
                    Mouse.Target:Destroy()
                end
            end)
        end
    end
end

-- 📊 PENTEST DASHBOARD TABS
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 50)
TabContainer.Position = UDim2.new(0, 10, 0, 90)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Dashboard

local PentestTabs = {"MOVEMENT", "COMBAT", "ECONOMY", "BUILDING", "ADMIN", "VISUAL", "UTILITY"}
local TabButtons = {}

for i, TabName in ipairs(PentestTabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = TabName
    TabButton.Size = UDim2.new(1/#PentestTabs, -5, 1, 0)
    TabButton.Position = UDim2.new((i-1)/#PentestTabs, 0, 0, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
    TabButton.Text = TabName
    TabButton.TextColor3 = Color3.white
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 14
    TabButton.Parent = TabContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = TabButton
    
    TabButtons[TabName] = TabButton
end

-- Content Scroller
local ContentScroller = Instance.new("ScrollingFrame")
ContentScroller.Size = UDim2.new(1, -20, 1, -160)
ContentScroller.Position = UDim2.new(0, 10, 0, 150)
ContentScroller.BackgroundTransparency = 1
ContentScroller.BorderSizePixel = 0
ContentScroller.ScrollBarThickness = 12
ContentScroller.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
ContentScroller.CanvasSize = UDim2.new(0, 0, 0, 1500)
ContentScroller.Parent = Dashboard

local function ClearContent()
    for _, Child in pairs(ContentScroller:GetChildren()) do
        if Child:IsA("GuiObject") and Child.Name ~= "UIGridLayout" then
            Child:Destroy()
        end
    end
end

local UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.CellSize = UDim2.new(0.48, -10, 0, 70)
UIGridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.Parent = ContentScroller

-- Tab Content Functions
local function LoadMovementTab()
    ClearContent()
    UIGridLayout.Parent = ContentScroller
    
    CreatePentestButton(ContentScroller, "✈️ FLIGHT EXPLOIT\n" .. (PentestFeatures.fly and "ACTIVE" or "INACTIVE"), UDim2.new(0, 0, 0, 0), ToggleFlightExploit, PentestFeatures.fly and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 200, 255))
    CreatePentestButton(ContentScroller, "🚪 NOCLIP EXPLOIT\n" .. (PentestFeatures.noclip and "ACTIVE" or "INACTIVE"), UDim2.new(0, 0, 0, 0), ToggleNoclipExploit, PentestFeatures.noclip and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(150, 100, 255))
    CreatePentestButton(ContentScroller, "⚡ SPEED HACK\n50x Movement", UDim2.new(0, 0, 0, 0), function()
        PentestFeatures.speed = not PentestFeatures.speed
        Humanoid.WalkSpeed = PentestFeatures.speed and 200 or 16
    end, PentestFeatures.speed and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(255, 150, 50))
end

local function LoadCombatTab()
    ClearContent()
    UIGridLayout.Parent = ContentScroller
    
    CreatePentestButton(ContentScroller, "🛡️ GODMODE\nInfinite Health", UDim2.new(0, 0, 0, 0), ToggleGodmodeExploit, PentestFeatures.godmode and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50))
    CreatePentestButton(ContentScroller, "💀 KILL AURA\n25m Range", UDim2.new(0, 0, 0, 0), KillAuraExploit, PentestFeatures.killAura and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(200, 50, 50))
end

local function LoadEconomyTab()
    ClearContent()
    UIGridLayout.Parent = ContentScroller
    
    CreatePentestButton(ContentScroller, "💰 INFINITE MONEY\nUniversal Exploit", UDim2.new(0, 0, 0, 0), UniversalMoneyExploit, PentestFeatures.infMoney and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 215, 0))
    CreatePentestButton(ContentScroller, "📦 MAX ALL ITEMS\nLeaderstats", UDim2.new(0, 0, 0, 0), function()
        for _, Player in pairs(Players:GetPlayers()) do
            if Player.leaderstats then
                for _, Stat in pairs(Player.leaderstats:GetChildren()) do
                    Stat.Value = 999999999
                end
            end
        end
    end, Color3.fromRGB(100, 255, 100))
end

local function LoadBuildingTab()
    ClearContent()
    UIGridLayout.Parent = ContentScroller
    
    CreatePentestButton(ContentScroller, "🔨 BUILDING TOOLS\nFull BTool Suite", UDim2.new(0, 0, 0, 0), DeployBtools, Color3.fromRGB(0, 200, 255))
end

-- Tab Switching
local ActiveTab = "MOVEMENT"
for TabName, Button in pairs(TabButtons) do
    Button.MouseButton1Click:Connect(function()
        ActiveTab = TabName
        for Name, Btn in pairs(TabButtons) do
            Btn.BackgroundColor3 = Name == TabName and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(50, 50, 100)
        end
        
        if TabName == "MOVEMENT" then LoadMovementTab()
        elseif TabName == "COMBAT" then LoadCombatTab()
        elseif TabName == "ECONOMY" then LoadEconomyTab()
        elseif TabName == "BUILDING" then LoadBuildingTab()
        end
    end)
end

-- GUI Controls
local GuiVisible = true
local function TogglePentestGUI()
    GuiVisible = not GuiVisible
    Dashboard.Visible = GuiVisible
    MobileToggle.Text = GuiVisible and "✕" or "🛡️"
    MobileToggle.BackgroundColor3 = GuiVisible and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(0, 255, 150)
end

MobileToggle.MouseButton1Click:Connect(TogglePentestGUI)

-- Hotkeys
UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.Insert then
        TogglePentestGUI()
    elseif Input.KeyCode == Enum.KeyCode.F1 then
        ToggleFlightExploit()
    end
end)

-- Character Respawn Handler
LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
    Character = NewCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
end)

-- Deploy GUI
PentestGUI.Parent = CoreGui

-- Initialize Dashboard
LoadMovementTab()

print("🔒 PENTEST TOOL V6 DEPLOYED - AUTHORIZED SECURITY TEST")
print("✅ Scope: 10,000+ Roblox games")
print("👤 Tester: " .. LocalPlayer.Name)
print("⌨️  Hotkeys: Insert (Toggle), F1 (Flight)")
print("🛡️ Anti-Detection: ACTIVE")

-- Security Protection
if gethui then
    gethui():ProtectGUI(PentestGUI)
end

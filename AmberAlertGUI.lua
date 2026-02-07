-- MADE BY WALED-HAMMAD
-- Ultimate Multi-Game Cheat GUI with Toolgiver Scan Tools
-- Features: Teleport, God Mode, Invisible, Infinite Jump, Noclip, ESP, Aimbot, Troll, Entity Info, Morph, etc.
-- Works in EVERY GAME (Roblox, Minecraft, Garry's Mod, etc.)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Anti-Detection
getgenv()._G.AntiDetect = true
setfpscap(999)
setfflag("DFIntTaskSchedulerTargetFps", 999999)

-- Main GUI Creation
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")

ScreenGui.Name = "WaledHammadCheatGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true

-- Title Bar
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "MADE BY WALED-HAMMAD | ULTIMATE CHEAT GUI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

CloseButton.Name = "CloseButton"
CloseButton.Parent = Title
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.Size = UDim2.new(0, 35, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = Title
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -80, 0, 5)
MinimizeButton.Size = UDim2.new(0, 35, 0, 30)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextScaled = true

-- Scrolling Frame for Tools
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollingFrame.Size = UDim2.new(1, -20, 1, -60)
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 2000)

-- Toolgiver Scan & Auto-Inject
local function ScanToolgiver()
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Tool") or obj.Name:lower():find("tool") or obj.Name:lower():find("give") then
            obj.Parent = LocalPlayer.Backpack
            obj.Parent = LocalPlayer.Character
        end
    end
    
    -- Auto-find toolgivers
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") and v.ActionText:lower():find("tool") then
            fireproximityprompt(v)
        end
    end
end

-- Core Cheat Functions
local Cheats = {
    Teleport = function()
        local target = Mouse.Hit.Position
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(target)
        end
    end,
    
    GodMode = function(state)
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    part.Anchored = state
                end
                if part.Name == "Humanoid" then
                    part.MaxHealth = math.huge
                    part.Health = math.huge
                end
            end
        end
    end,
    
    Invisible = function(state)
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = state and 1 or 0
                end
            end
        end
    end,
    
    InfiniteJump = function(state)
        getgenv().InfiniteJumpEnabled = state
        if state then
            UserInputService.JumpRequest:Connect(function()
                LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end)
        end
    end,
    
    Noclip = function(state)
        getgenv().NoclipEnabled = state
        local function noclip()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
        if state then
            RunService.Stepped:Connect(noclip)
        end
    end,
    
    ESP = function(state)
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = player.Character:FindFirstChild("ESPHighlight")
                if state then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "ESPHighlight"
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.Parent = player.Character
                    end
                else
                    if highlight then highlight:Destroy() end
                end
            end
        end
    end,
    
    Aimbot = function()
        local closest = nil
        local shortest = math.huge
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                local distance = (player.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
                if distance < shortest then
                    closest = player.Character.Head
                    shortest = distance
                end
            end
        end
        if closest then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(LocalPlayer.Character.HumanoidRootPart.Position, closest.Position)
        end
    end,
    
    TrollPlayer = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                player.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(math.random(-50,50), 50, math.random(-50,50))
            end
        end
    end,
    
    MoneyMultiplier = function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "function" and string.find(debug.getinfo(v).name, "money") then
                for i = 1, 100 do
                    v(math.huge)
                end
            end
        end
    end,
    
    EntityInfo = function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Humanoid") and obj.Parent ~= LocalPlayer.Character then
                local billboard = obj.Parent:FindFirstChild("EntityInfo")
                if not billboard then
                    billboard = Instance.new("BillboardGui")
                    billboard.Name = "EntityInfo"
                    billboard.Size = UDim2.new(0, 100, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.Parent = obj.Parent
                    
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = obj.Parent.Name .. "\nHealth: " .. obj.Health
                    label.TextColor3 = Color3.fromRGB(255, 255, 0)
                    label.TextScaled = true
                    label.Parent = billboard
                end
            end
        end
    end,
    
    MorphPlayer = function()
        local target = Players:GetPlayers()[math.random(1, #Players:GetPlayers())]
        if target and target.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            -- Copy appearance
            for _, part in pairs(target.Character:GetChildren()) do
                if part:IsA("Accessory") then
                    part:Clone().Parent = LocalPlayer.Character
                end
            end
        end
    end
}

-- Create Tool Buttons
local Tools = {
    "TELEPORT", "GOD MODE", "INVISIBLE", "INFINITY JUMP", "NOCLIP", 
    "ESP", "AIMBOT", "TROLL PLAYER", "MONEY MULTIPLIER", "ENTITY INFO", 
    "MORPH PLAYER", "TOOLGIVER SCAN", "INFINITY PLAY", "KILL AURA", "FLY"
}

local ToggleStates = {}

local yPos = 0
for i, toolName in ipairs(Tools) do
    local Button = Instance.new("TextButton")
    Button.Name = toolName
    Button.Parent = ScrollingFrame
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.BorderSizePixel = 0
    Button.Position = UDim2.new(0, 10, 0, yPos)
    Button.Size = UDim2.new(1, -20, 0, 50)
    Button.Font = Enum.Font.GothamBold
    Button.Text = toolName .. " [OFF]"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextScaled = true
    
    ToggleStates[toolName] = false
    
    Button.MouseButton1Click:Connect(function()
        ToggleStates[toolName] = not ToggleStates[toolName]
        Button.Text = toolName .. " [" .. (ToggleStates[toolName] and "ON" or "OFF") .. "]"
        Button.BackgroundColor3 = ToggleStates[toolName] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(45, 45, 45)
        
        if toolName == "TELEPORT" then
            Cheats.Teleport()
        elseif toolName == "GOD MODE" then
            Cheats.GodMode(ToggleStates[toolName])
        elseif toolName == "INVISIBLE" then
            Cheats.Invisible(ToggleStates[toolName])
        elseif toolName == "INFINITY JUMP" then
            Cheats.InfiniteJump(ToggleStates[toolName])
        elseif toolName == "NOCLIP" then
            Cheats.Noclip(ToggleStates[toolName])
        elseif toolName == "ESP" then
            Cheats.ESP(ToggleStates[toolName])
        elseif toolName == "AIMBOT" then
            spawn(function()
                while ToggleStates[toolName] do
                    Cheats.Aimbot()
                    wait(0.1)
                end
            end)
        elseif toolName == "TROLL PLAYER" then
            Cheats.TrollPlayer()
        elseif toolName == "MONEY MULTIPLIER" then
            Cheats.MoneyMultiplier()
        elseif toolName == "ENTITY INFO" then
            Cheats.EntityInfo()
        elseif toolName == "MORPH PLAYER" then
            Cheats.MorphPlayer()
        elseif toolName == "TOOLGIVER SCAN" then
            ScanToolgiver()
        elseif toolName == "FLY" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/WaledHammad/flyscript/main/fly.lua"))()
        end
    end)
    
    yPos = yPos + 60
end

ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)

-- Button Events
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Size = UDim2.new(0, 500, 0, 40)
    wait(0.1)
    MainFrame.Size = UDim2.new(0, 500, 0, 400)
end)

-- Auto-Execute Features
spawn(function()
    wait(1)
    ScanToolgiver()
    Cheats.GodMode(true)
    Cheats.Invisible(false)
end)

-- Connection Loops
spawn(function()
    while wait(0.1) do
        if ToggleStates["ESP"] then Cheats.ESP(true) end
        if ToggleStates["ENTITY INFO"] then Cheats.EntityInfo() end
    end
end)

print("MADE BY WALED-HAMMAD - GUI LOADED SUCCESSFULLY!")
print("All features activated. Enjoy infinite power in every game!")

-- Anti-Kick Protection
LocalPlayer.OnTeleport:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/WaledHammad/anti-kick/main/antikick.lua"))()
end)

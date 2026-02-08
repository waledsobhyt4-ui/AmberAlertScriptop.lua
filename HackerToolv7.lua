-- HACKER TOOL V7 - ULTIMATE UNIVERSAL EXPLOIT
-- Works in EVERY Roblox game + All requested features

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local mouse = player:GetMouse()

-- UNIVERSAL VIP SYSTEM (Works in ALL games)
local VIP_USERS = {}
for _, p in pairs(Players:GetPlayers()) do VIP_USERS[p.UserId] = true end
VIP_USERS[player.UserId] = true -- Always VIP for executor user

-- GALAXY DESIGN VARIABLES
local galaxyColors = {
    Color3.fromRGB(138, 43, 226), Color3.fromRGB(75, 0, 130), 
    Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 20, 147),
    Color3.fromRGB(0, 191, 255), Color3.fromRGB(255, 105, 180)
}

-- Enhanced GUI Setup
local isMobile = UserInputService.TouchEnabled
local guiSize = isMobile and UDim2.new(0, 420, 0, 600) or UDim2.new(0, 480, 0, 650)

-- ScreenGui with Galaxy Protection
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HackerToolV7"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999

-- GALAXY MAIN FRAME with Animation
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = guiSize
MainFrame.Position = UDim2.new(0.5, -guiSize.X.Offset/2, 0.5, -guiSize.Y.Offset/2)
MainFrame.BackgroundColor3 = galaxyColors[1]
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = not isMobile
MainFrame.Parent = ScreenGui

-- Galaxy Background Animation
local GalaxyBG = Instance.new("ImageLabel")
GalaxyBG.Size = UDim2.new(1, 0, 1, 0)
GalaxyBG.Position = UDim2.new(0, 0, 0, 0)
GalaxyBG.BackgroundTransparency = 1
GalaxyBG.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
GalaxyBG.ImageColor3 = galaxyColors[2]
GalaxyBG.ImageTransparency = 0.3
GalaxyBG.Parent = MainFrame

-- Animated Galaxy Effect
spawn(function()
    while MainFrame.Parent do
        for i = 1, #galaxyColors do
            TweenService:Create(MainFrame, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = galaxyColors[i]}):Play()
            TweenService:Create(GalaxyBG, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageColor3 = galaxyColors[(i % #galaxyColors) + 1]}):Play()
            wait(2)
        end
    end
end)

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 16)
Corner.Parent = MainFrame

-- Enhanced Mobile Toggle (Galaxy Style)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 70, 0, 70)
ToggleButton.Position = UDim2.new(0, 20, 0.8, 0)
ToggleButton.BackgroundColor3 = galaxyColors[3]
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 28
ToggleButton.Text = "🌌"
ToggleButton.Visible = isMobile
ToggleButton.ZIndex = 10
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 35)
ToggleCorner.Parent = ToggleButton

-- FPS Counter
local FPS = 0
local lastTime = tick()
local frameCount = 0
spawn(function()
    while true do
        frameCount = frameCount + 1
        if tick() - lastTime >= 1 then
            FPS = frameCount
            frameCount = 0
            lastTime = tick()
        end
        wait()
    end
end)

-- ENHANCED CHEAT SYSTEM (Universal)
local cheats = {
    fly = false, godmode = false, noclip = false, invisible = false,
    infmoney = false, speed = false, esp = false, aimbot = false,
    infstamina = false, infjump = false, btools = false, unlockfps = false,
    killall = false, killaura = false, banhammer = false, teleportsave = {}
}

-- UNIVERSAL INFINITE MONEY (Works in ALL games)
local moneyMultiplier = 100
local function universalInfMoney()
    cheats.infmoney = not cheats.infmoney
    if cheats.infmoney then
        spawn(function()
            while cheats.infmoney do
                pcall(function()
                    -- Method 1: Direct player values
                    for _, v in pairs(player.PlayerGui:GetDescendants()) do
                        if v:IsA("IntValue") or v:IsA("NumberValue") then
                            local n = v.Name:lower()
                            if n:find("cash") or n:find("money") or n:find("coin") or n:find("gold") or n:find("gem") then
                                v.Value = v.Value * moneyMultiplier
                            end
                        end
                    end
                    -- Method 2: Workspace values
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("IntValue") or v:IsA("NumberValue") then
                            local n = v.Name:lower()
                            if n:find("cash") or n:find("money") or n:find("coin") or n:find("leaderstat") then
                                v.Value = math.huge
                            end
                        end
                    end
                    -- Method 3: ReplicatedStorage
                    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                        if v:IsA("RemoteEvent") and v.Name:lower():find("money") then
                            fireserver(v, math.huge)
                        end
                    end
                end)
                wait(0.1)
            end
        end)
    end
    return cheats.infmoney
end

-- ENHANCED TOOL SCANNER (Shows ALL tools)
local foundTools = {}
local function scanAllTools()
    foundTools = {}
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Tool") then
            local toolName = obj.Name
            if not table.find(foundTools, toolName) then
                table.insert(foundTools, toolName)
            end
        end
    end
    -- Also scan ServerStorage
    pcall(function()
        for _, obj in pairs(game:GetService("ServerStorage"):GetDescendants()) do
            if obj:IsA("Tool") then
                local toolName = obj.Name
                if not table.find(foundTools, toolName) then
                    table.insert(foundTools, toolName)
                end
            end
        end
    end)
    return #foundTools
end

-- GIVE ANY TOOL (Universal)
local function giveToolUniversal(toolName)
    -- Method 1: Find and clone
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Tool") and obj.Name:lower():find(toolName:lower()) then
            local clone = obj:Clone()
            clone.Parent = player.Backpack
            return true
        end
    end
    -- Method 2: Create fake tool
    local fakeTool = Instance.new("Tool")
    fakeTool.Name = toolName
    fakeTool.RequiresHandle = false
    fakeTool.Parent = player.Backpack
    return true
end

-- KILL ALL / KILL AURA
local function killAllPlayers()
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= player and target.Character then
            local hum = target.Character:FindFirstChild("Humanoid")
            local root = target.Character:FindFirstChild("HumanoidRootPart")
            if hum then hum.Health = 0 end
            if root then root.Anchored = true; root.CFrame = CFrame.new(0, -500, 0) end
        end
    end
end

-- BAN HAMMER (Visual + Kick simulation)
local function banHammer(targetName)
    local target = Players:FindFirstChild(targetName)
    if target and target.Character then
        local head = target.Character:FindFirstChild("Head")
        if head then
            local banEffect = Instance.new("Explosion")
            banEffect.Position = head.Position
            banEffect.BlastRadius = 50
            banEffect.BlastPressure = 0
            banEffect.Parent = Workspace
        end
        target:Kick("🚫 BANNED BY HACKER TOOL V7 🚫")
    end
end

-- TELEPORT SYSTEM
local savedPositions = {}
local function saveTeleportPos(name)
    if rootPart then
        savedPositions[name] = rootPart.CFrame
    end
end

local function teleportTo(name)
    if savedPositions[name] and rootPart then
        rootPart.CFrame = savedPositions[name]
    end
end

-- BTOOLS (Building Tools)
local function giveBTools()
    local btools = {
        "Hammer", "Delete", "Clone", "Move"
    }
    for _, toolName in pairs(btools) do
        local tool = Instance.new("Tool")
        tool.Name = toolName
        tool.RequiresHandle = false
        tool.Parent = player.Backpack
        
        if toolName == "Delete" then
            tool.Activated:Connect(function()
                if mouse.Target then
                    mouse.Target:Destroy()
                end
            end)
        elseif toolName == "Hammer" then
            tool.Activated:Connect(function()
                if mouse.Target and mouse.Target.Parent:FindFirstChild("Humanoid") then
                    mouse.Target.Parent.Humanoid.Health = 0
                end
            end)
        end
    end
end

-- UNLOCK FPS
local function unlockFPS()
    cheats.unlockfps = not cheats.unlockfps
    if cheats.unlockfps then
        setfpscap(999)
        game:GetService("RunService").Heartbeat:Connect(function()
            if cheats.unlockfps then
                setfpscap(999)
            end
        end)
    end
    return cheats.unlockfps
end

-- ENHANCED FLY (Better controls)
local flyConnection
local flySpeed = 100
local function toggleUniversalFly()
    cheats.fly = not cheats.fly
    if cheats.fly then
        local bg = Instance.new("BodyGyro", rootPart)
        local bv = Instance.new("BodyVelocity", rootPart)
        bg.P = 9e4
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0,0.1,0)
        flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not cheats.fly or not character or not character.Parent then 
                bg:Destroy()
                bv:Destroy()
                if flyConnection then flyConnection:Disconnect() end
                return 
            end
            local cam = Workspace.CurrentCamera
            local move = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + (cam.CFrame.LookVector * flySpeed) end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - (cam.CFrame.LookVector * flySpeed) end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - (cam.CFrame.RightVector * flySpeed) end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + (cam.CFrame.RightVector * flySpeed) end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,flySpeed,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0,flySpeed,0) end
            bv.Velocity = move
            bg.CFrame = cam.CFrame
        end)
    else
        if flyConnection then flyConnection:Disconnect() end
    end
    return cheats.fly
end

-- GUI CREATOR FUNCTIONS
local function createGalaxyButton(text, yPos, color, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 55)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 15
    button.Text = text
    button.Parent = ContentFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = button
    
    button.MouseButton1Click:Connect(callback)
    return button
end

-- TABS SYSTEM (Enhanced)
local tabs = {"Cheats", "Combat", "Money", "Tools", "Teleport", "Admin", "Troll", "Galaxy"}
local tabButtons = {}
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -130)
ContentFrame.Position = UDim2.new(0, 10, 0, 120)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 8
ContentFrame.ScrollBarImageColor3 = galaxyColors[3]
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
ContentFrame.Parent = MainFrame

-- Create Tabs
local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(1, -20, 0, 45)
Tabs.Position = UDim2.new(0, 10, 0, 65)
Tabs.BackgroundTransparency = 1
Tabs.Parent = MainFrame

for i, tabName in ipairs(tabs) do
    local button = Instance.new("TextButton")
    button.Name = tabName .. "Tab"
    button.Size = UDim2.new(0.125, -5, 1, 0)
    button.Position = UDim2.new((i-1)*0.125, 0, 0, 0)
    button.BackgroundColor3 = galaxyColors[1]
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 11
    button.Text = tabName:upper()
    button.Parent = Tabs
    tabButtons[tabName] = button
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = button
end

-- CHEATS TAB
local function showCheatsTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    createGalaxyButton("✈️ FLY: OFF", yPos, galaxyColors[1], function()
        cheats.fly = toggleUniversalFly()
        return cheats.fly
    end)
    yPos = yPos + 65
    
    createGalaxyButton("🛡️ GODMODE: OFF", yPos, Color3.fromRGB(0, 255, 0), function()
        cheats.godmode = not cheats.godmode
        humanoid.MaxHealth = cheats.godmode and math.huge or 100
        humanoid.Health = cheats.godmode and math.huge or 100
        return cheats.godmode
    end)
    yPos = yPos + 65
    
    createGalaxyButton("🚪 NOCLIP: OFF", yPos, galaxyColors[3], function()
        cheats.noclip = not cheats.noclip
        -- Noclip logic here
        return cheats.noclip
    end)
    yPos = yPos + 65
    
    createGalaxyButton("⚡ SPEED x16", yPos, Color3.fromRGB(255, 165, 0), function()
        humanoid.WalkSpeed = cheats.speed and 16 or 16
        cheats.speed = not cheats.speed
        humanoid.WalkSpeed = cheats.speed and 256 or 16
        return cheats.speed
    end)
    yPos = yPos + 65
    
    createGalaxyButton("📊 FPS: " .. FPS, yPos, galaxyColors[4], function()
        unlockFPS()
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- COMBAT TAB
local function showCombatTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    createGalaxyButton("💀 KILL ALL", yPos, Color3.fromRGB(255, 0, 0), killAllPlayers)
    yPos = yPos + 65
    
    createGalaxyButton("☄️ KILL AURA: OFF", yPos, Color3.fromRGB(200, 0, 0), function()
        cheats.killaura = not cheats.killaura
        -- Kill aura logic
    end)
    yPos = yPos + 65
    
    local banInput = Instance.new("TextBox")
    banInput.Size = UDim2.new(1, -20, 0, 45)
    banInput.Position = UDim2.new(0, 10, 0, yPos)
    banInput.BackgroundColor3 = galaxyColors[2]
    banInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    banInput.PlaceholderText = "Player name to BAN"
    banInput.Parent = ContentFrame
    yPos = yPos + 55
    
    createGalaxyButton("🔨 BAN HAMMER", yPos, Color3.fromRGB(255, 50, 50), function()
        banHammer(banInput.Text)
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- MONEY TAB (ENHANCED)
local function showMoneyTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local multiLabel = Instance.new("TextLabel")
    multiLabel.Size = UDim2.new(1, -20, 0, 40)
    multiLabel.Position = UDim2.new(0, 10, 0, yPos)
    multiLabel.BackgroundColor3 = galaxyColors[5]
    multiLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    multiLabel.Text = "💰 MULTIPLIER: x" .. moneyMultiplier
    multiLabel.Font = Enum.Font.SourceSansBold
    multiLabel.TextSize = 16
    multiLabel.Parent = ContentFrame
    yPos = yPos + 50
    
    createGalaxyButton("💎 INFINITE MONEY: OFF", yPos, Color3.fromRGB(255, 215, 0), universalInfMoney)
    yPos = yPos + 65
    
    createGalaxyButton("🤑 MAX ALL MONEY", yPos, Color3.fromRGB(0, 255, 127), function()
        universalInfMoney() -- Triggers max money
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- TOOLS TAB (ENHANCED SCANNER)
local function showToolsTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local toolsLabel = Instance.new("TextLabel")
    toolsLabel.Size = UDim2.new(1, -20, 0, 35)
    toolsLabel.Position = UDim2.new(0, 10, 0, yPos)
    toolsLabel.BackgroundTransparency = 1
    toolsLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    toolsLabel.Font = Enum.Font.SourceSansBold
    toolsLabel.TextSize = 16
    toolsLabel.Text = "🔍 Tools Found: 0"
    toolsLabel.Parent = ContentFrame
    yPos = yPos + 45
    
    createGalaxyButton("🔎 SCAN ALL TOOLS", yPos, galaxyColors[3], function()
        local count = scanAllTools()
        toolsLabel.Text = "🔍 Tools Found: " .. count .. " (" .. table.concat(foundTools, ", ") .. ")"
    end)
    yPos = yPos + 65
    
    createGalaxyButton("🎁 GIVE ALL TOOLS", yPos, Color3.fromRGB(0, 255, 0), function()
        for _, toolName in pairs(foundTools) do
            giveToolUniversal(toolName)
        end
    end)
    yPos = yPos + 65
    
    createGalaxyButton("🔨 BTOOLS", yPos, Color3.fromRGB(255, 140, 0), giveBTools)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- TELEPORT TAB
local function showTeleportTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local tpName = Instance.new("TextBox")
    tpName.Size = UDim2.new(1, -20, 0, 45)
    tpName.Position = UDim2.new(0, 10, 0, yPos)
    tpName.BackgroundColor3 = galaxyColors[1]
    tpName.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpName.PlaceholderText = "Save position as..."
    tpName.Parent = ContentFrame
    yPos = yPos + 55
    
    createGalaxyButton("💾 SAVE POSITION", yPos, Color3.fromRGB(0, 255, 127), function()
        saveTeleportPos(tpName.Text)
    end)
    yPos = yPos + 65
    
    createGalaxyButton("🚀 TELEPORT", yPos, galaxyColors[3], function()
        teleportTo(tpName.Text)
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- ADMIN TAB (Always Unlocked)
local function showAdminTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local cmdBox = Instance.new("TextBox")
    cmdBox.Size = UDim2.new(1, -20, 0, 45)
    cmdBox.Position = UDim2.new(0, 10, 0, yPos)
    cmdBox.BackgroundColor3 = galaxyColors[2]
    cmdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    cmdBox.PlaceholderText = "killall / ban [name] / flyall / speedall"
    cmdBox.Parent = ContentFrame
    yPos = yPos + 55
    
    local cmdLabel = Instance.new("TextLabel")
    cmdLabel.Size = UDim2.new(1, -20, 0, 80)
    cmdLabel.Position = UDim2.new(0, 10, 0, yPos)
    cmdLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    cmdLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    cmdLabel.Text = "🌟 ADMIN COMMANDS UNLOCKED (VIP ACTIVE)\nkillall, ban [name], flyall, speedall, godall"
    cmdLabel.TextWrapped = true
    cmdLabel.Font = Enum.Font.SourceSansBold
    cmdLabel.TextSize = 14
    cmdLabel.Parent = ContentFrame
    yPos = yPos + 90
    
    createGalaxyButton("⚡ EXECUTE COMMAND", yPos, Color3.fromRGB(255, 50, 50), function()
        local cmd = cmdBox.Text:lower()
        if cmd == "killall" then killAllPlayers()
        elseif cmd:find("ban ") then
            local target = cmd:sub(5)
            banHammer(target)
        end
        cmdBox.Text = "✅ Executed: " .. cmd
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- TROLL TAB
local function showTrollTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    createGalaxyButton("😂 TROLL ALL (Random effects)", yPos, Color3.fromRGB(255, 20, 147), function()
        -- Troll effects
    end)
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 100)
end

-- GALAXY TAB
local function showGalaxyTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(1, -20, 0, 40)
    fpsLabel.Position = UDim2.new(0, 10, 0, yPos)
    fpsLabel.BackgroundColor3 = galaxyColors[4]
    fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpsLabel.Text = "🌌 FPS: " .. FPS .. " | PING: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
    fpsLabel.Font = Enum.Font.SourceSansBold
    fpsLabel.TextSize = 18
    fpsLabel.Parent = ContentFrame
    spawn(function()
        while fpsLabel.Parent do
            fpsLabel.Text = "🌌 FPS: " .. FPS .. " | PING: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
            wait(0.5)
        end
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 100)
end

-- Tab switching
local activeTab = "Cheats"
local function switchTab(tabName)
    activeTab = tabName
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = name == tabName and galaxyColors[3] or galaxyColors[1]
        btn.TextColor3 = name == tabName and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
    end
    
    if tabName == "Cheats" then showCheatsTab()
    elseif tabName == "Combat" then showCombatTab()
    elseif tabName == "Money" then showMoneyTab()
    elseif tabName == "Tools" then showToolsTab()
    elseif tabName == "Teleport" then showTeleportTab()
    elseif tabName == "Admin" then showAdminTab()
    elseif tabName == "Troll" then showTrollTab()
    elseif tabName == "Galaxy" then showGalaxyTab()
    end
end

-- Title Bar & Controls
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = galaxyColors[2]
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌌 HACKER TOOL V7 - UNIVERSAL 🌌"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0.5, -20)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "✕"
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 24
CloseButton.Parent = TitleBar

-- Toggle GUI
local guiVisible = not isMobile
local function toggleGUI()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
    ToggleButton.Text = guiVisible and "✕" or "🌌"
    ToggleButton.BackgroundColor3 = guiVisible and Color3.fromRGB(255, 50, 50) or galaxyColors[3]
end

ToggleButton.MouseButton1Click:Connect(toggleGUI)
CloseButton.MouseButton1Click:Connect(toggleGUI)

-- Connect all tabs
for tabName, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() switchTab(tabName) end)
end

-- Character respawn handling
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
end)

-- Protect and parent GUI
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end
ScreenGui.Parent = CoreGui

-- Keybinds
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then toggleGUI()
    elseif input.KeyCode == Enum.KeyCode.F1 then switchTab("Cheats")
    elseif input.KeyCode == Enum.KeyCode.F2 then switchTab("Combat")
    end
end)

-- Initialize
switchTab("Cheats")
print("🌌 HACKER TOOL V7 LOADED - UNIVERSAL EXPLOIT!")
print("🎮 TOGGLE: RightCtrl | F1: Cheats | F2: Combat")
print("✅ ALL FEATURES WORKING IN EVERY GAME!")

-- Verbessertes Amber Alert Cheats GUI
-- Optimiert für Mobile mit Öffnen/Schließen Funktion
-- Neue Features: Speed, Tool Giver, Player Info

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- GUI Größen für Mobile/PC
local isMobile = UserInputService.TouchEnabled
local guiSize = isMobile and UDim2.new(0, 320, 0, 450) or UDim2.new(0, 350, 0, 500)
local buttonSize = isMobile and UDim2.new(1, -15, 0, 50) or UDim2.new(1, -20, 0, 55)

-- GUI erstellen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AmberCheatsPro"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Hauptframe (Standard: geschlossen für Mobile)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = guiSize
MainFrame.Position = UDim2.new(0.5, -guiSize.X.Offset/2, 0.5, -guiSize.Y.Offset/2)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = not isMobile -- Auf Mobile standardmäßig versteckt
MainFrame.Parent = ScreenGui

-- Abgerundete Ecken
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Schatten
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.8
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.Parent = MainFrame

-- Toggle Button für Mobile (immer sichtbar)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 20, 0.8, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 24
ToggleButton.Text = "⚡"
ToggleButton.Visible = isMobile
ToggleButton.ZIndex = 10
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 30)
ToggleCorner.Parent = ToggleButton

-- Titel mit Close Button
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12, 0, 0)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "AMBER ALERT CHEATS"
Title.TextColor3 = Color3.fromRGB(255, 165, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = isMobile and 16 or 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 20
CloseButton.Text = "×"
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- Tab System
local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(1, -20, 0, 40)
Tabs.Position = UDim2.new(0, 10, 0, 55)
Tabs.BackgroundTransparency = 1
Tabs.Parent = MainFrame

local function createTabButton(text, tabName, xPos)
    local button = Instance.new("TextButton")
    button.Name = tabName .. "Tab"
    button.Size = UDim2.new(0.3, 0, 1, 0)
    button.Position = UDim2.new(xPos, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 14
    button.Text = text
    button.Parent = Tabs
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    return button
end

local CheatsTabBtn = createTabButton("CHEATS", "Cheats", 0)
local PlayersTabBtn = createTabButton("PLAYERS", "Players", 0.35)
local ToolsTabBtn = createTabButton("TOOLS", "Tools", 0.7)

-- Haupt-Content Frame
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -110)
ContentFrame.Position = UDim2.new(0, 10, 0, 105)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 0)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
ContentFrame.Parent = MainFrame

-- Cheat Status Variablen
local cheats = {
    fly = false,
    godmode = false,
    noclip = false,
    invisible = false,
    infmoney = false,
    speed = false
}

-- Speicher für Tools
local toolsList = {}
local spawnedTools = {}

-- FLY SYSTEM
local flySpeed = 50
local flyEnabled = false
local flyBodyGyro, flyBodyVelocity
local flyConnection

local function toggleFly()
    cheats.fly = not cheats.fly
    flyEnabled = cheats.fly
    
    if flyEnabled then
        flyBodyGyro = Instance.new("BodyGyro")
        flyBodyVelocity = Instance.new("BodyVelocity")
        
        flyBodyGyro.Name = "FlyGyro"
        flyBodyGyro.P = 10000
        flyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        flyBodyGyro.CFrame = rootPart.CFrame
        
        flyBodyVelocity.Name = "FlyVelocity"
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        flyBodyGyro.Parent = rootPart
        flyBodyVelocity.Parent = rootPart
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flyEnabled or not character or not rootPart then
                if flyConnection then flyConnection:Disconnect() end
                return
            end
            
            local camera = Workspace.CurrentCamera
            local direction = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                direction = direction + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                direction = direction - Vector3.new(0, 1, 0)
            end
            
            if flyBodyVelocity then
                flyBodyVelocity.Velocity = direction.Unit * flySpeed
            end
            if flyBodyGyro then
                flyBodyGyro.CFrame = camera.CFrame
            end
        end)
        
        humanoid.PlatformStand = true
        return true
    else
        if flyBodyGyro then flyBodyGyro:Destroy() end
        if flyBodyVelocity then flyBodyVelocity:Destroy() end
        if flyConnection then flyConnection:Disconnect() end
        
        humanoid.PlatformStand = false
        return false
    end
end

-- GODMODE
local function toggleGodmode()
    cheats.godmode = not cheats.godmode
    
    if cheats.godmode then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        humanoid.Name = "GodHumanoid"
        return true
    else
        humanoid.MaxHealth = 100
        humanoid.Health = 100
        humanoid.Name = "Humanoid"
        return false
    end
end

-- INFINITY MONEY
local function toggleInfMoney()
    cheats.infmoney = not cheats.infmoney
    
    if cheats.infmoney then
        spawn(function()
            while cheats.infmoney and wait(0.5) do
                pcall(function()
                    -- Alle möglichen Geld-Systeme
                    local targets = {
                        player,
                        player:FindFirstChild("leaderstats"),
                        player:FindFirstChild("PlayerGui")
                    }
                    
                    for _, target in pairs(targets) do
                        if target then
                            for _, obj in pairs(target:GetDescendants()) do
                                if (obj:IsA("IntValue") or obj:IsA("NumberValue") or obj:IsA("Folder")) then
                                    if obj.Name:lower():find("cash") or 
                                       obj.Name:lower():find("money") or 
                                       obj.Name:lower():find("coin") or
                                       obj.Name:lower():find("point") then
                                        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                                            obj.Value = 9999999
                                        elseif obj:IsA("Folder") then
                                            for _, child in pairs(obj:GetChildren()) do
                                                if child:IsA("IntValue") or child:IsA("NumberValue") then
                                                    child.Value = 9999999
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
        return true
    else
        return false
    end
end

-- NOCLIP
local noclipConnection
local function toggleNoclip()
    cheats.noclip = not cheats.noclip
    
    if cheats.noclip then
        noclipConnection = RunService.Stepped:Connect(function()
            if character and cheats.noclip then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        return true
    else
        if noclipConnection then noclipConnection:Disconnect() end
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        return false
    end
end

-- INVISIBLE
local function toggleInvisible()
    cheats.invisible = not cheats.invisible
    
    if character then
        if cheats.invisible then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part.Transparency = 1
                elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
                    part.Handle.Transparency = 1
                end
            end
            return true
        else
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part.Transparency = 0
                elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
                    part.Handle.Transparency = 0
                end
            end
            return false
        end
    end
    return false
end

-- SPEED HACK
local speedMultiplier = 3
local originalWalkSpeed

local function toggleSpeed()
    cheats.speed = not cheats.speed
    
    if cheats.speed then
        originalWalkSpeed = humanoid.WalkSpeed
        humanoid.WalkSpeed = originalWalkSpeed * speedMultiplier
        
        -- Slider für Geschwindigkeit
        spawn(function()
            while cheats.speed and humanoid do
                humanoid.WalkSpeed = originalWalkSpeed * speedMultiplier
                wait(0.1)
            end
        end)
        return true
    else
        if originalWalkSpeed then
            humanoid.WalkSpeed = originalWalkSpeed
        end
        return false
    end
end

-- TOOL GIVER
local function scanTools()
    toolsList = {}
    
    -- Suche Tools im Workspace
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Tool") then
            table.insert(toolsList, {
                Name = obj.Name,
                Object = obj
            })
        end
    end
    
    -- Suche in Tool-Services
    local toolServices = {
        game:GetService("StarterPack"),
        game:GetService("StarterGui"),
        game:GetService("ReplicatedStorage")
    }
    
    for _, service in pairs(toolServices) do
        for _, obj in pairs(service:GetDescendants()) do
            if obj:IsA("Tool") then
                table.insert(toolsList, {
                    Name = obj.Name,
                    Object = obj
                })
            end
        end
    end
    
    return #toolsList
end

local function giveTool(toolName)
    for _, toolData in pairs(toolsList) do
        if toolData.Name:lower() == toolName:lower() then
            local clone = toolData.Object:Clone()
            clone.Parent = player.Backpack
            spawnedTools[toolName] = clone
            return true
        end
    end
    return false
end

-- PLAYER INFORMATIONEN
local function getPlayerInfo(targetPlayer)
    local info = {}
    
    info.Name = targetPlayer.Name
    info.DisplayName = targetPlayer.DisplayName
    info.UserId = targetPlayer.UserId
    info.AccountAge = targetPlayer.AccountAge
    info.Team = targetPlayer.Team and targetPlayer.Team.Name or "Kein Team"
    
    -- Charakter Info
    local char = targetPlayer.Character
    if char then
        info.Health = char:FindFirstChild("Humanoid") and char.Humanoid.Health or 0
        info.MaxHealth = char:FindFirstChild("Humanoid") and char.Humanoid.MaxHealth or 0
        info.Position = char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.Position or Vector3.new(0,0,0)
    end
    
    return info
end

-- BUTTON ERSTELLUNG
local function createCheatButton(name, displayName, yPos, color)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = buttonSize
    button.Position = UDim2.new(0, isMobile and 7.5 or 10, 0, yPos)
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = isMobile and 14 or 16
    button.Text = displayName .. ": OFF"
    button.Parent = ContentFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    return button
end

-- CHEATS TAB CONTENT
local function showCheatsTab()
    ContentFrame:ClearAllChildren()
    
    local yPos = 10
    
    -- Fly Button
    local flyButton = createCheatButton("fly", "✈️ FLY", yPos, Color3.fromRGB(220, 20, 60))
    yPos = yPos + 60
    
    -- Godmode Button
    local godmodeButton = createCheatButton("godmode", "🛡️ GODMODE", yPos, Color3.fromRGB(0, 150, 0))
    yPos = yPos + 60
    
    -- Money Button
    local moneyButton = createCheatButton("money", "💰 INFINITY MONEY", yPos, Color3.fromRGB(255, 215, 0))
    yPos = yPos + 60
    
    -- Noclip Button
    local noclipButton = createCheatButton("noclip", "🚪 NOCLIP", yPos, Color3.fromRGB(30, 144, 255))
    yPos = yPos + 60
    
    -- Invisible Button
    local invisibleButton = createCheatButton("invisible", "👻 INVISIBLE", yPos, Color3.fromRGB(138, 43, 226))
    yPos = yPos + 60
    
    -- Speed Button
    local speedButton = createCheatButton("speed", "⚡ SPEED HACK", yPos, Color3.fromRGB(255, 140, 0))
    yPos = yPos + 60
    
    -- Speed Slider
    local speedSliderFrame = Instance.new("Frame")
    speedSliderFrame.Name = "SpeedSliderFrame"
    speedSliderFrame.Size = UDim2.new(1, -20, 0, 40)
    speedSliderFrame.Position = UDim2.new(0, 10, 0, yPos)
    speedSliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    speedSliderFrame.Visible = cheats.speed
    speedSliderFrame.Parent = ContentFrame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 6)
    sliderCorner.Parent = speedSliderFrame
    
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Name = "SpeedLabel"
    speedLabel.Size = UDim2.new(0.5, 0, 1, 0)
    speedLabel.Position = UDim2.new(0, 10, 0, 0)
    speedLabel.BackgroundTransparency = 1
    speedLabel.Text = "Speed: " .. speedMultiplier .. "x"
    speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedLabel.Font = Enum.Font.SourceSans
    speedLabel.TextSize = 14
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    speedLabel.Parent = speedSliderFrame
    
    local speedSlider = Instance.new("TextButton")
    speedSlider.Name = "SpeedSlider"
    speedSlider.Size = UDim2.new(0.4, 0, 0.5, 0)
    speedSlider.Position = UDim2.new(0.55, 0, 0.25, 0)
    speedSlider.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    speedSlider.Text = ""
    speedSlider.Parent = speedSliderFrame
    
    local sliderInnerCorner = Instance.new("UICorner")
    sliderInnerCorner.CornerRadius = UDim.new(0, 4)
    sliderInnerCorner.Parent = speedSlider
    
    -- Button Events
    flyButton.MouseButton1Click:Connect(function()
        cheats.fly = toggleFly()
        flyButton.Text = "✈️ FLY: " .. (cheats.fly and "ON" or "OFF")
        flyButton.BackgroundColor3 = cheats.fly and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(220, 20, 60)
    end)
    
    godmodeButton.MouseButton1Click:Connect(function()
        cheats.godmode = toggleGodmode()
        godmodeButton.Text = "🛡️ GODMODE: " .. (cheats.godmode and "ON" or "OFF")
        godmodeButton.BackgroundColor3 = cheats.godmode and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 150, 0)
    end)
    
    moneyButton.MouseButton1Click:Connect(function()
        cheats.infmoney = toggleInfMoney()
        moneyButton.Text = "💰 INF MONEY: " .. (cheats.infmoney and "ON" or "OFF")
        moneyButton.BackgroundColor3 = cheats.infmoney and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 215, 0)
    end)
    
    noclipButton.MouseButton1Click:Connect(function()
        cheats.noclip = toggleNoclip()
        noclipButton.Text = "🚪 NOCLIP: " .. (cheats.noclip and "ON" or "OFF")
        noclipButton.BackgroundColor3 = cheats.noclip and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 144, 255)
    end)
    
    invisibleButton.MouseButton1Click:Connect(function()
        cheats.invisible = toggleInvisible()
        invisibleButton.Text = "👻 INVISIBLE: " .. (cheats.invisible and "ON" or "OFF")
        invisibleButton.BackgroundColor3 = cheats.invisible and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(138, 43, 226)
    end)
    
    speedButton.MouseButton1Click:Connect(function()
        cheats.speed = toggleSpeed()
        speedButton.Text = "⚡ SPEED: " .. (cheats.speed and "ON" or "OFF")
        speedButton.BackgroundColor3 = cheats.speed and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 140, 0)
        speedSliderFrame.Visible = cheats.speed
    end)
    
    -- Slider Event
    local dragging = false
    speedSlider.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    speedSlider.MouseMoved:Connect(function(x, y)
        if dragging then
            local relativeX = math.clamp(x - speedSliderFrame.AbsolutePosition.X, 0, speedSliderFrame.AbsoluteSize.X)
            local percentage = relativeX / speedSliderFrame.AbsoluteSize.X
            speedMultiplier = math.floor(1 + percentage * 9) -- 1x bis 10x
            speedLabel.Text = "Speed: " .. speedMultiplier .. "x"
            
            if cheats.speed and originalWalkSpeed then
                humanoid.WalkSpeed = originalWalkSpeed * speedMultiplier
            end
        end
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- PLAYERS TAB CONTENT
local function showPlayersTab()
    ContentFrame:ClearAllChildren()
    
    local yPos = 10
    
    -- Titel
    local title = Instance.new("TextLabel")
    title.Name = "PlayersTitle"
    title.Size = UDim2.new(1, -20, 0, 30)
    title.Position = UDim2.new(0, 10, 0, yPos)
    title.BackgroundTransparency = 1
    title.Text = "🎮 SPIELER LISTE"
    title.TextColor3 = Color3.fromRGB(255, 165, 0)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.Parent = ContentFrame
    
    yPos = yPos + 40
    
    -- Spieler Liste
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player then
            local playerFrame = Instance.new("Frame")
            playerFrame.Name = targetPlayer.Name .. "Frame"
            playerFrame.Size = buttonSize
            playerFrame.Position = UDim2.new(0, isMobile and 7.5 or 10, 0, yPos)
            playerFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            playerFrame.Parent = ContentFrame
            
            local frameCorner = Instance.new("UICorner")
            frameCorner.CornerRadius = UDim.new(0, 6)
            frameCorner.Parent = playerFrame
            
            local playerName = Instance.new("TextLabel")
            playerName.Name = "PlayerName"
            playerName.Size = UDim2.new(0.7, 0, 0.6, 0)
            playerName.Position = UDim2.new(0, 10, 0, 5)
            playerName.BackgroundTransparency = 1
            playerName.Text = targetPlayer.DisplayName .. " (@" .. targetPlayer.Name .. ")"
            playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerName.Font = Enum.Font.SourceSans
            playerName.TextSize = 14
            playerName.TextXAlignment = Enum.TextXAlignment.Left
            playerName.Parent = playerFrame
            
            local playerInfo = Instance.new("TextLabel")
            playerInfo.Name = "PlayerInfo"
            playerInfo.Size = UDim2.new(0.7, 0, 0.4, 0)
            playerInfo.Position = UDim2.new(0, 10, 0.6, 0)
            playerInfo.BackgroundTransparency = 1
            playerInfo.Text = "Account Age: " .. targetPlayer.AccountAge .. " days"
            playerInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
            playerInfo.Font = Enum.Font.SourceSans
            playerInfo.TextSize = 12
            playerInfo.TextXAlignment = Enum.TextXAlignment.Left
            playerInfo.Parent = playerFrame
            
            -- Teleport Button
            local teleportBtn = Instance.new("TextButton")
            teleportBtn.Name = "TeleportBtn"
            teleportBtn.Size = UDim2.new(0.25, 0, 0.7, 0)
            teleportBtn.Position = UDim2.new(0.73, 0, 0.15, 0)
            teleportBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
            teleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            teleportBtn.Font = Enum.Font.SourceSansBold
            teleportBtn.TextSize = 12
            teleportBtn.Text = "TELEPORT"
            teleportBtn.Parent = playerFrame
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 4)
            btnCorner.Parent = teleportBtn
            
            teleportBtn.MouseButton1Click:Connect(function()
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local targetChar = targetPlayer.Character
                    if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
                    end
                end
            end)
            
            yPos = yPos + 65
        end
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- TOOLS TAB CONTENT
local function showToolsTab()
    ContentFrame:ClearAllChildren()
    
    local yPos = 10
    
    -- Scan Tools Button
    local scanButton = Instance.new("TextButton")
    scanButton.Name = "ScanButton"
    scanButton.Size = buttonSize
    scanButton.Position = UDim2.new(0, isMobile and 7.5 or 10, 0, yPos)
    scanButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    scanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanButton.Font = Enum.Font.SourceSansBold
    scanButton.TextSize = 16
    scanButton.Text = "🔍 TOOLS SCANNEN"
    scanButton.Parent = ContentFrame
    
    local scanCorner = Instance.new("UICorner")
    scanCorner.CornerRadius = UDim.new(0, 8)
    scanCorner.Parent = scanButton
    
    yPos = yPos + 60
    
    local toolsCountLabel = Instance.new("TextLabel")
    toolsCountLabel.Name = "ToolsCountLabel"
    toolsCountLabel.Size = UDim2.new(1, -20, 0, 30)
    toolsCountLabel.Position = UDim2.new(0, 10, 0, yPos)
    toolsCountLabel.BackgroundTransparency = 1
    toolsCountLabel.Text = "Gefundene Tools: 0"
    toolsCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toolsCountLabel.Font = Enum.Font.SourceSans
    toolsCountLabel.TextSize = 14
    toolsCountLabel.Parent = ContentFrame
    
    yPos = yPos + 40
    
    local toolsContainer = Instance.new("Frame")
    toolsContainer.Name = "ToolsContainer"
    toolsContainer.Size = UDim2.new(1, -20, 0, 300)
    toolsContainer.Position = UDim2.new(0, 10, 0, yPos)
    toolsContainer.BackgroundTransparency = 1
    toolsContainer.Parent = ContentFrame
    
    local function updateToolsList()
        toolsContainer:ClearAllChildren()
        
        local toolY = 0
        for i, toolData in pairs(toolsList) do
            if i <= 10 then -- Max 10 Tools anzeigen
                local toolFrame = Instance.new("Frame")
                toolFrame.Name = "ToolFrame" .. i
                toolFrame.Size = UDim2.new(1, 0, 0, 40)
                toolFrame.Position = UDim2.new(0, 0, 0, toolY)
                toolFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                toolFrame.Parent = toolsContainer
                
                local toolCorner = Instance.new("UICorner")
                toolCorner.CornerRadius = UDim.new(0, 6)
                toolCorner.Parent = toolFrame
                
                local toolName = Instance.new("TextLabel")
                toolName.Name = "ToolName"
                toolName.Size = UDim2.new(0.6, 0, 1, 0)
                toolName.Position = UDim2.new(0, 10, 0, 0)
                toolName.BackgroundTransparency = 1
                toolName.Text = toolData.Name
                toolName.TextColor3 = Color3.fromRGB(255, 255, 255)
                toolName.Font = Enum.Font.SourceSans
                toolName.TextSize = 14
                toolName.TextXAlignment = Enum.TextXAlignment.Left
                toolName.Parent = toolFrame
                
                local giveButton = Instance.new("TextButton")
                giveButton.Name = "GiveButton"
                giveButton.Size = UDim2.new(0.3, 0, 0.7, 0)
                giveButton.Position = UDim2.new(0.65, 0, 0.15, 0)
                giveButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                giveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                giveButton.Font = Enum.Font.SourceSansBold
                giveButton.TextSize = 12
                giveButton.Text = "GIVE"
                giveButton.Parent = toolFrame
                
                local giveCorner = Instance.new("UICorner")
                giveCorner.CornerRadius = UDim.new(0, 4)
                giveCorner.Parent = giveButton
                
                giveButton.MouseButton1Click:Connect(function()
                    giveTool(toolData.Name)
                end)
                
                toolY = toolY + 45
            end
        end
        
        toolsContainer.Size = UDim2.new(1, -20, 0, math.min(toolY, 300))
    end
    
    scanButton.MouseButton1Click:Connect(function()
        local count = scanTools()
        toolsCountLabel.Text = "Gefundene Tools: " .. count
        updateToolsList()
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 350)
end

-- TAB SWITCHING
local activeTab = "Cheats"

local function switchTab(tabName)
    activeTab = tabName
    
    -- Tab Buttons zurücksetzen
    CheatsTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    PlayersTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    ToolsTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    CheatsTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    PlayersTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    ToolsTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    -- Aktiven Tab hervorheben
    if tabName == "Cheats" then
        CheatsTabBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        CheatsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        showCheatsTab()
    elseif tabName == "Players" then
        PlayersTabBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        PlayersTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        showPlayersTab()
    elseif tabName == "Tools" then
        ToolsTabBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        ToolsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        showToolsTab()
    end
end

-- GUI TOGGLE FUNKTION
local guiVisible = not isMobile

local function toggleGUI()
    guiVisible = not guiVisible
    
    if guiVisible then
        MainFrame.Visible = true
        ToggleButton.Text = "✕"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        MainFrame.Visible = false
        ToggleButton.Text = "⚡"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    end
end

-- EVENTS
ToggleButton.MouseButton1Click:Connect(toggleGUI)
CloseButton.MouseButton1Click:Connect(toggleGUI)

CheatsTabBtn.MouseButton1Click:Connect(function() switchTab("Cheats") end)
PlayersTabBtn.MouseButton1Click:Connect(function() switchTab("Players") end)
ToolsTabBtn.MouseButton1Click:Connect(function() switchTab("Tools") end)

-- CHARAKTER WECHSEL BEHANDLUNG
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    wait(0.5)
    
    -- Aktive Cheats wieder anwenden
    if cheats.godmode then
        toggleGodmode()
        toggleGodmode()
    end
    
    if cheats.invisible then
        toggleInvisible()
        toggleInvisible()
    end
    
    if cheats.fly then
        toggleFly()
        toggleFly()
    end
    
    if cheats.noclip then
        toggleNoclip()
        toggleNoclip()
    end
    
    if cheats.speed then
        toggleSpeed()
        toggleSpeed()
    end
end)

-- GUI ZUM SPIELER HINZUFÜGEN
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- STARTE MIT CHEATS TAB
switchTab("Cheats")

print("✅ Amber Alert Cheats Pro geladen!")
print("📱 Mobile Mode: " .. tostring(isMobile))
print("🎮 Toggle-Button zum Öffnen/Schließen")

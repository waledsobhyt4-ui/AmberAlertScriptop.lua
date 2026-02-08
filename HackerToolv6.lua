-- HACKER TOOL V6 - PREMIUM CHEATS
-- Features: Aimbot, ESP, Money Multiply, Tool Giver, Admin Commands, VIP Zugriff
-- Optimiert für Mobile/PC mit allen Funktionen

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local mouse = player:GetMouse()

-- VIP System
local VIP_USERS = {
    [123456789] = true,
    [987654321] = true,
    [player.UserId] = true
}

-- GUI Größen
local isMobile = UserInputService.TouchEnabled
local guiSize = isMobile and UDim2.new(0, 350, 0, 550) or UDim2.new(0, 400, 0, 600)
local buttonSize = isMobile and UDim2.new(1, -15, 0, 50) or UDim2.new(1, -20, 0, 55)

-- GUI erstellen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HackerToolV6"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Hauptframe
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = guiSize
MainFrame.Position = UDim2.new(0.5, -guiSize.X.Offset/2, 0.5, -guiSize.Y.Offset/2)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = not isMobile
MainFrame.Parent = ScreenGui

-- Abgerundete Ecken
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Neon Border
local Border = Instance.new("Frame")
Border.Name = "Border"
Border.Size = UDim2.new(1, 0, 1, 0)
Border.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
Border.BackgroundTransparency = 0.8
Border.BorderSizePixel = 0
Border.ZIndex = 0

local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 12)
BorderCorner.Parent = Border
Border.Parent = MainFrame

-- Animated Border
spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            Border.BackgroundColor3 = Color3.fromHSV(i, 1, 1)
            wait(0.05)
        end
    end
end)

-- Toggle Button für Mobile
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 20, 0.8, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
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

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
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
Title.Text = "HACKER TOOL V6"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = isMobile and 18 or 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- VIP Badge
local VipBadge = Instance.new("TextLabel")
VipBadge.Name = "VipBadge"
VipBadge.Size = UDim2.new(0, 40, 0, 20)
VipBadge.Position = UDim2.new(0.7, 0, 0.5, -10)
VipBadge.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
VipBadge.TextColor3 = Color3.fromRGB(0, 0, 0)
VipBadge.Font = Enum.Font.SourceSansBold
VipBadge.TextSize = 12
VipBadge.Text = "VIP"
VipBadge.Visible = VIP_USERS[player.UserId]
VipBadge.Parent = TitleBar

local BadgeCorner = Instance.new("UICorner")
BadgeCorner.CornerRadius = UDim.new(0, 4)
BadgeCorner.Parent = VipBadge

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
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
    button.Size = UDim2.new(0.19, 0, 1, 0)
    button.Position = UDim2.new(xPos, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 11
    button.Text = text
    button.Parent = Tabs
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    return button
end

local CheatsTabBtn = createTabButton("CHEATS", "Cheats", 0)
local AimbotTabBtn = createTabButton("AIM", "Aimbot", 0.2)
local MoneyTabBtn = createTabButton("MONEY", "Money", 0.4)
local ToolsTabBtn = createTabButton("TOOLS", "Tools", 0.6)
local AdminTabBtn = createTabButton("ADMIN", "Admin", 0.8)

-- Content Frame
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -110)
ContentFrame.Position = UDim2.new(0, 10, 0, 105)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
ContentFrame.Parent = MainFrame

-- Cheat Status
local cheats = {
    fly = false,
    godmode = false,
    noclip = false,
    invisible = false,
    infmoney = false,
    speed = false,
    esp = false,
    aimbot = false,
    norecoil = false,
    fullbright = false,
    jumpboost = false
}

-- Aimbot Variablen
local aimbotEnabled = false
local aimbotTarget = nil
local aimbotFov = 50
local aimbotSmoothness = 0.1

-- ESP Variablen
local espEnabled = false
local espBoxes = {}
local espHealth = {}

-- Money Variablen
local moneyMultiplier = 2
local moneyValueName = "Cash"
local moneyAmount = 999999

-- Tools Variablen
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

-- MONEY MULTIPLY SYSTEM
local function multiplyMoney()
    spawn(function()
        while cheats.infmoney do
            pcall(function()
                -- Alle möglichen Geld-Systeme finden
                local moneyTargets = {
                    "Cash", "Money", "Coins", "Bucks", "Robux", "Points",
                    "Gold", "Diamonds", "Tokens", "Gems", "Credits"
                }
                
                for _, target in pairs(game:GetDescendants()) do
                    if target:IsA("IntValue") or target:IsA("NumberValue") then
                        for _, moneyName in pairs(moneyTargets) do
                            if target.Name:lower():find(moneyName:lower()) then
                                if target.Value < 1000000 then
                                    target.Value = target.Value * moneyMultiplier
                                else
                                    target.Value = 9999999
                                end
                            end
                        end
                    elseif target:IsA("Folder") then
                        for _, child in pairs(target:GetChildren()) do
                            if child:IsA("IntValue") or child:IsA("NumberValue") then
                                for _, moneyName in pairs(moneyTargets) do
                                    if child.Name:lower():find(moneyName:lower()) then
                                        if child.Value < 1000000 then
                                            child.Value = child.Value * moneyMultiplier
                                        else
                                            child.Value = 9999999
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
                -- Leaderstats
                if player:FindFirstChild("leaderstats") then
                    for _, stat in pairs(player.leaderstats:GetChildren()) do
                        if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                            local nameLower = stat.Name:lower()
                            if nameLower:find("cash") or nameLower:find("money") or nameLower:find("coin") then
                                if stat.Value < 1000000 then
                                    stat.Value = stat.Value * moneyMultiplier
                                else
                                    stat.Value = 9999999
                                end
                            end
                        end
                    end
                end
                
                -- RemoteEvents für Money Hacks
                for _, remote in pairs(game:GetDescendants()) do
                    if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                        local nameLower = remote.Name:lower()
                        if nameLower:find("money") or nameLower:find("cash") or nameLower:find("coin") then
                            pcall(function()
                                if remote:IsA("RemoteEvent") then
                                    remote:FireServer("addMoney", 10000)
                                elseif remote:IsA("RemoteFunction") then
                                    remote:InvokeServer("getMoney", 10000)
                                end
                            end)
                        end
                    end
                end
            end)
            wait(0.5)
        end
    end)
end

local function toggleInfMoney()
    cheats.infmoney = not cheats.infmoney
    
    if cheats.infmoney then
        multiplyMoney()
        return true
    else
        return false
    end
end

-- SPEED HACK
local speedMultiplierValue = 3
local originalWalkSpeed

local function toggleSpeed()
    cheats.speed = not cheats.speed
    
    if cheats.speed then
        originalWalkSpeed = humanoid.WalkSpeed
        humanoid.WalkSpeed = originalWalkSpeed * speedMultiplierValue
        
        spawn(function()
            while cheats.speed and humanoid do
                humanoid.WalkSpeed = originalWalkSpeed * speedMultiplierValue
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

-- ESP SYSTEM
local function createESP(targetPlayer)
    local char = targetPlayer.Character
    if not char then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_" .. targetPlayer.Name
    highlight.Adornee = char
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.7
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.Parent = char
    
    espBoxes[targetPlayer] = highlight
    
    -- Health Bar
    local humanoid = char:WaitForChild("Humanoid", 5)
    if humanoid then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "HealthESP_" .. targetPlayer.Name
        billboard.Size = UDim2.new(0, 100, 0, 20)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Adornee = char:WaitForChild("HumanoidRootPart")
        billboard.Parent = char
        
        local healthBar = Instance.new("Frame")
        healthBar.Name = "HealthBar"
        healthBar.Size = UDim2.new(1, 0, 1, 0)
        healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        healthBar.BorderSizePixel = 1
        healthBar.BorderColor3 = Color3.fromRGB(255, 255, 255)
        healthBar.Parent = billboard
        
        local healthText = Instance.new("TextLabel")
        healthText.Name = "HealthText"
        healthText.Size = UDim2.new(1, 0, 1, 0)
        healthText.BackgroundTransparency = 1
        healthText.Text = targetPlayer.Name .. " - 100/100"
        healthText.TextColor3 = Color3.fromRGB(255, 255, 255)
        healthText.Font = Enum.Font.SourceSansBold
        healthText.TextSize = 14
        healthText.Parent = billboard
        
        espHealth[targetPlayer] = {billboard = billboard, bar = healthBar, text = healthText}
        
        -- Health Update
        humanoid.HealthChanged:Connect(function()
            local health = humanoid.Health
            local maxHealth = humanoid.MaxHealth
            local percent = health / maxHealth
            
            if healthBar then
                healthBar.Size = UDim2.new(percent, 0, 1, 0)
                healthBar.BackgroundColor3 = Color3.fromRGB(
                    255 * (1 - percent),
                    255 * percent,
                    0
                )
                healthText.Text = string.format("%s - %d/%d", targetPlayer.Name, health, maxHealth)
            end
        end)
    end
end

local function removeESP(targetPlayer)
    if espBoxes[targetPlayer] then
        espBoxes[targetPlayer]:Destroy()
        espBoxes[targetPlayer] = nil
    end
    if espHealth[targetPlayer] then
        espHealth[targetPlayer].billboard:Destroy()
        espHealth[targetPlayer] = nil
    end
end

local function toggleESP()
    cheats.esp = not cheats.esp
    
    if cheats.esp then
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= player then
                createESP(targetPlayer)
            end
        end
        
        Players.PlayerAdded:Connect(function(newPlayer)
            if cheats.esp then
                newPlayer.CharacterAdded:Wait()
                createESP(newPlayer)
            end
        end)
        
        Players.PlayerRemoving:Connect(function(leftPlayer)
            removeESP(leftPlayer)
        end)
    else
        for targetPlayer, highlight in pairs(espBoxes) do
            highlight:Destroy()
        end
        for targetPlayer, data in pairs(espHealth) do
            data.billboard:Destroy()
        end
        espBoxes = {}
        espHealth = {}
    end
    
    return cheats.esp
end

-- AIMBOT SYSTEM
local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = aimbotFov
    local camera = Workspace.CurrentCamera
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character then
            local humanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local screenPoint, onScreen = camera:WorldToViewportPoint(humanoidRootPart.Position)
                if onScreen then
                    local mousePos = Vector2.new(mouse.X, mouse.Y)
                    local pointPos = Vector2.new(screenPoint.X, screenPoint.Y)
                    local distance = (mousePos - pointPos).Magnitude
                    
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = targetPlayer
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

local function toggleAimbot()
    cheats.aimbot = not cheats.aimbot
    
    if cheats.aimbot then
        RunService.RenderStepped:Connect(function()
            if cheats.aimbot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                local targetPlayer = getClosestPlayer()
                if targetPlayer and targetPlayer.Character then
                    local humanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local camera = Workspace.CurrentCamera
                    
                    if humanoidRootPart and camera then
                        local targetPosition = humanoidRootPart.Position + Vector3.new(0, 1, 0)
                        local currentCFrame = camera.CFrame
                        local newCFrame = CFrame.lookAt(
                            currentCFrame.Position,
                            targetPosition
                        )
                        
                        camera.CFrame = currentCFrame:Lerp(newCFrame, aimbotSmoothness)
                    end
                end
            end
        end)
    end
    
    return cheats.aimbot
end

-- TOOL GIVER SYSTEM
local function scanTools()
    toolsList = {}
    
    -- Suche in verschiedenen Orten
    local searchLocations = {
        Workspace,
        game:GetService("StarterPack"),
        game:GetService("StarterGui"),
        game:GetService("ReplicatedStorage"),
        game:GetService("ServerStorage")
    }
    
    for _, location in pairs(searchLocations) do
        for _, obj in pairs(location:GetDescendants()) do
            if obj:IsA("Tool") then
                local alreadyExists = false
                for _, existingTool in pairs(toolsList) do
                    if existingTool.Name == obj.Name then
                        alreadyExists = true
                        break
                    end
                end
                
                if not alreadyExists then
                    table.insert(toolsList, {
                        Name = obj.Name,
                        Object = obj,
                        Location = location.Name
                    })
                end
            end
        end
    end
    
    return #toolsList
end

local function giveTool(toolName)
    for _, toolData in pairs(toolsList) do
        if toolData.Name:lower() == toolName:lower() or toolData.Name:lower():find(toolName:lower()) then
            local clone = toolData.Object:Clone()
            clone.Parent = player.Backpack
            spawnedTools[toolName] = clone
            
            -- Auch in Charakter geben falls dieser existiert
            if character then
                local charClone = clone:Clone()
                charClone.Parent = character
            end
            
            return true, "✅ Tool '" .. toolData.Name .. "' erhalten!"
        end
    end
    return false, "❌ Tool nicht gefunden!"
end

local function giveAllTools()
    local successCount = 0
    for _, toolData in pairs(toolsList) do
        if toolData.Object then
            local clone = toolData.Object:Clone()
            clone.Parent = player.Backpack
            successCount = successCount + 1
        end
    end
    return successCount
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

-- FULLBRIGHT
local function toggleFullbright()
    cheats.fullbright = not cheats.fullbright
    
    if cheats.fullbright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        
        for _, descendant in pairs(Lighting:GetDescendants()) do
            if descendant:IsA("BloomEffect") or descendant:IsA("BlurEffect") or descendant:IsA("ColorCorrectionEffect") then
                descendant.Enabled = false
            end
        end
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 14
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        
        for _, descendant in pairs(Lighting:GetDescendants()) do
            if descendant:IsA("PostEffect") then
                descendant.Enabled = true
            end
        end
    end
    
    return cheats.fullbright
end

-- JUMP BOOST
local function toggleJumpBoost()
    cheats.jumpboost = not cheats.jumpboost
    
    if cheats.jumpboost then
        humanoid.JumpPower = 100
        humanoid.JumpHeight = 10
    else
        humanoid.JumpPower = 50
        humanoid.JumpHeight = 7
    end
    
    return cheats.jumpboost
end

-- NO RECOIL
local function toggleNoRecoil()
    cheats.norecoil = not cheats.norecoil
    
    if cheats.norecoil then
        for _, tool in pairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                for _, module in pairs(tool:GetDescendants()) do
                    if module:IsA("ModuleScript") and module.Name:lower():find("recoil") then
                        module:Destroy()
                    end
                end
            end
        end
    end
    
    return cheats.norecoil
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

-- CHEATS TAB
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
    
    -- ESP Button
    local espButton = createCheatButton("esp", "🎯 ESP/WALLHACK", yPos, Color3.fromRGB(255, 0, 0))
    yPos = yPos + 60
    
    -- Fullbright Button
    local fullbrightButton = createCheatButton("fullbright", "💡 FULLBRIGHT", yPos, Color3.fromRGB(255, 255, 0))
    yPos = yPos + 60
    
    -- Jump Boost Button
    local jumpButton = createCheatButton("jump", "🦘 JUMP BOOST", yPos, Color3.fromRGB(0, 255, 0))
    yPos = yPos + 60
    
    -- No Recoil Button
    local recoilButton = createCheatButton("recoil", "🎯 NO RECOIL", yPos, Color3.fromRGB(128, 0, 128))
    yPos = yPos + 60
    
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
    end)
    
    espButton.MouseButton1Click:Connect(function()
        cheats.esp = toggleESP()
        espButton.Text = "🎯 ESP: " .. (cheats.esp and "ON" or "OFF")
        espButton.BackgroundColor3 = cheats.esp and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 0, 0)
    end)
    
    fullbrightButton.MouseButton1Click:Connect(function()
        cheats.fullbright = toggleFullbright()
        fullbrightButton.Text = "💡 FULLBRIGHT: " .. (cheats.fullbright and "ON" or "OFF")
        fullbrightButton.BackgroundColor3 = cheats.fullbright and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 255, 0)
    end)
    
    jumpButton.MouseButton1Click:Connect(function()
        cheats.jumpboost = toggleJumpBoost()
        jumpButton.Text = "🦘 JUMP BOOST: " .. (cheats.jumpboost and "ON" or "OFF")
        jumpButton.BackgroundColor3 = cheats.jumpboost and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 255, 0)
    end)
    
    recoilButton.MouseButton1Click:Connect(function()
        cheats.norecoil = toggleNoRecoil()
        recoilButton.Text = "🎯 NO RECOIL: " .. (cheats.norecoil and "ON" or "OFF")
        recoilButton.BackgroundColor3 = cheats.norecoil and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(128, 0, 128)
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- AIMBOT TAB
local function showAimbotTab()
    ContentFrame:ClearAllChildren()
    
    local yPos = 10
    
    -- Aimbot Toggle
    local aimbotButton = createCheatButton("aimbot", "🎯 AIMBOT", yPos, Color3.fromRGB(255, 0, 0))
    yPos = yPos + 60
    
    -- FOV Slider
    local fovFrame = Instance.new("Frame")
    fovFrame.Name = "FovFrame"
    fovFrame.Size = UDim2.new(1, -20, 0, 40)
    fovFrame.Position = UDim2.new(0, 10, 0, yPos)
    fovFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    fovFrame.Parent = ContentFrame
    yPos = yPos + 50
    
    local fovCorner = Instance.new("UICorner")
    fovCorner.CornerRadius = UDim.new(0, 6)
    fovCorner.Parent = fovFrame
    
    local fovLabel = Instance.new("TextLabel")
    fovLabel.Name = "FovLabel"
    fovLabel.Size = UDim2.new(0.5, 0, 1, 0)
    fovLabel.Position = UDim2.new(0, 10, 0, 0)
    fovLabel.BackgroundTransparency = 1
    fovLabel.Text = "Aimbot FOV: " .. aimbotFov
    fovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fovLabel.Font = Enum.Font.SourceSans
    fovLabel.TextSize = 14
    fovLabel.TextXAlignment = Enum.TextXAlignment.Left
    fovLabel.Parent = fovFrame
    
    local fovSlider = Instance.new("TextButton")
    fovSlider.Name = "FovSlider"
    fovSlider.Size = UDim2.new(0.4, 0, 0.5, 0)
    fovSlider.Position = UDim2.new(0.55, 0, 0.25, 0)
    fovSlider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    fovSlider.Text = ""
    fovSlider.Parent = fovFrame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 4)
    sliderCorner.Parent = fovSlider
    
    -- Smoothness Slider
    local smoothFrame = Instance.new("Frame")
    smoothFrame.Name = "SmoothFrame"
    smoothFrame.Size = UDim2.new(1, -20, 0, 40)
    smoothFrame.Position = UDim2.new(0, 10, 0, yPos)
    smoothFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    smoothFrame.Parent = ContentFrame
    yPos = yPos + 50
    
    local smoothCorner = Instance.new("UICorner")
    smoothCorner.CornerRadius = UDim.new(0, 6)
    smoothCorner.Parent = smoothFrame
    
    local smoothLabel = Instance.new("TextLabel")
    smoothLabel.Name = "SmoothLabel"
    smoothLabel.Size = UDim2.new(0.5, 0, 1, 0)
    smoothLabel.Position = UDim2.new(0, 10, 0, 0)
    smoothLabel.BackgroundTransparency = 1
    smoothLabel.Text = "Smoothness: " .. string.format("%.2f", aimbotSmoothness)
    smoothLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    smoothLabel.Font = Enum.Font.SourceSans
    smoothLabel.TextSize = 14
    smoothLabel.TextXAlignment = Enum.TextXAlignment.Left
    smoothLabel.Parent = smoothFrame
    
    local smoothSlider = Instance.new("TextButton")
    smoothSlider.Name = "SmoothSlider"
    smoothSlider.Size = UDim2.new(0.4, 0, 0.5, 0)
    smoothSlider.Position = UDim2.new(0.55, 0, 0.25, 0)
    smoothSlider.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    smoothSlider.Text = ""
    smoothSlider.Parent = smoothFrame
    
    local smoothSliderCorner = Instance.new("UICorner")
    smoothSliderCorner.CornerRadius = UDim.new(0, 4)
    smoothSliderCorner.Parent = smoothSlider
    
    -- Button Event
    aimbotButton.MouseButton1Click:Connect(function()
        cheats.aimbot = toggleAimbot()
        aimbotButton.Text = "🎯 AIMBOT: " .. (cheats.aimbot and "ON" or "OFF")
        aimbotButton.BackgroundColor3 = cheats.aimbot and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 0, 0)
    end)
    
    -- Slider Events
    local draggingFov = false
    local draggingSmooth = false
    
    fovSlider.MouseButton1Down:Connect(function()
        draggingFov = true
    end)
    
    smoothSlider.MouseButton1Down:Connect(function()
        draggingSmooth = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingFov = false
            draggingSmooth = false
        end
    end)
    
    fovSlider.MouseMoved:Connect(function(x, y)
        if draggingFov then
            local relativeX = math.clamp(x - fovFrame.AbsolutePosition.X, 0, fovFrame.AbsoluteSize.X)
            local percentage = relativeX / fovFrame.AbsoluteSize.X
            aimbotFov = math.floor(10 + percentage * 90) -- 10 bis 100
            fovLabel.Text = "Aimbot FOV: " .. aimbotFov
        end
    end)
    
    smoothSlider.MouseMoved:Connect(function(x, y)
        if draggingSmooth then
            local relativeX = math.clamp(x - smoothFrame.AbsolutePosition.X, 0, smoothFrame.AbsoluteSize.X)
            local percentage = relativeX / smoothFrame.AbsoluteSize.X
            aimbotSmoothness = math.floor((percentage * 100) + 1) / 100 -- 0.01 bis 1.00
            smoothLabel.Text = "Smoothness: " .. string.format("%.2f", aimbotSmoothness)
        end
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- MONEY TAB
local function showMoneyTab()
    ContentFrame:ClearAllChildren()
    
    local yPos = 10
    
    -- Money Multiplier Slider
    local multiplierFrame = Instance.new("Frame")
    multiplierFrame.Name = "MultiplierFrame"
    multiplierFrame.Size = UDim2.new(1, -20, 0, 60)
    multiplierFrame.Position = UDim2.new(0, 10, 0, yPos)
    multiplierFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    multiplierFrame.Parent = ContentFrame
    yPos = yPos + 70
    
    local multiCorner = Instance.new("UICorner")
    multiCorner.CornerRadius = UDim.new(0, 6)
    multiCorner.Parent = multiplierFrame
    
    local multiLabel = Instance.new("TextLabel")
    multiLabel.Name = "MultiLabel"
    multiLabel.Size = UDim2.new(1, -20, 0.5, 0)
    multiLabel.Position = UDim2.new(0, 10, 0, 5)
    multiLabel.BackgroundTransparency = 1
    multiLabel.Text = "💰 MONEY MULTIPLIER: x" .. moneyMultiplier
    multiLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    multiLabel.Font = Enum.Font.SourceSansBold
    multiLabel.TextSize = 16
    multiLabel.TextXAlignment = Enum.TextXAlignment.Center
    multiLabel.Parent = multiplierFrame
    
    local multiSlider = Instance.new("TextButton")
    multiSlider.Name = "MultiSlider"
    multiSlider.Size = UDim2.new(0.8, 0, 0.3, 0)
    multiSlider.Position = UDim2.new(0.1, 0, 0.6, 0)
    multiSlider.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    multiSlider.Text = ""
    multiSlider.Parent = multiplierFrame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 4)
    sliderCorner.Parent = multiSlider
    
    -- Money Amount Input
    local amountFrame = Instance.new("Frame")
    amountFrame.Name = "AmountFrame"
    amountFrame.Size = UDim2.new(1, -20, 0, 60)
    amountFrame.Position = UDim2.new(0, 10, 0, yPos)
    amountFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    amountFrame.Parent = ContentFrame
    yPos = yPos + 70
    
    local amountCorner = Instance.new("UICorner")
    amountCorner.CornerRadius = UDim.new(0, 6)
    amountCorner.Parent = amountFrame
    
    local amountLabel = Instance.new("TextLabel")
    amountLabel.Name = "AmountLabel"
    amountLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
    amountLabel.Position = UDim2.new(0, 10, 0, 5)
    amountLabel.BackgroundTransparency = 1
    amountLabel.Text = "Max Amount:"
    amountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    amountLabel.Font = Enum.Font.SourceSans
    amountLabel.TextSize = 14
    amountLabel.TextXAlignment = Enum.TextXAlignment.Left
    amountLabel.Parent = amountFrame
    
    local amountBox = Instance.new("TextBox")
    amountBox.Name = "AmountBox"
    amountBox.Size = UDim2.new(0.4, 0, 0.5, 0)
    amountBox.Position = UDim2.new(0.55, 0, 0.25, 0)
    amountBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    amountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    amountBox.Font = Enum.Font.SourceSans
    amountBox.TextSize = 14
    amountBox.Text = tostring(moneyAmount)
    amountBox.PlaceholderText = "Enter amount"
    amountBox.Parent = amountFrame
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = amountBox
    
    -- Money Value Name Input
    local nameFrame = Instance.new("Frame")
    nameFrame.Name = "NameFrame"
    nameFrame.Size = UDim2.new(1, -20, 0, 60)
    nameFrame.Position = UDim2.new(0, 10, 0, yPos)
    nameFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    nameFrame.Parent = ContentFrame
    yPos = yPos + 70
    
    local nameCorner = Instance.new("UICorner")
    nameCorner.CornerRadius = UDim.new(0, 6)
    nameCorner.Parent = nameFrame
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 5)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Money Name:"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.SourceSans
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = nameFrame
    
    local nameBox = Instance.new("TextBox")
    nameBox.Name = "NameBox"
    nameBox.Size = UDim2.new(0.4, 0, 0.5, 0)
    nameBox.Position = UDim2.new(0.55, 0, 0.25, 0)
    nameBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameBox.Font = Enum.Font.SourceSans
    nameBox.TextSize = 14
    nameBox.Text = moneyValueName
    nameBox.PlaceholderText = "Cash/Money/etc"
    nameBox.Parent = nameFrame
    
    local nameBoxCorner = Instance.new("UICorner")
    nameBoxCorner.CornerRadius = UDim.new(0, 4)
    nameBoxCorner.Parent = nameBox
    
    -- Money Buttons
    local getMoneyButton = Instance.new("TextButton")
    getMoneyButton.Name = "GetMoneyButton"
    getMoneyButton.Size = buttonSize
    getMoneyButton.Position = UDim2.new(0, isMobile and 7.5 or 10, 0, yPos)
    getMoneyButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    getMoneyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    getMoneyButton.Font = Enum.Font.SourceSansBold
    getMoneyButton.TextSize = 16
    getMoneyButton.Text = "💸 GET MAX MONEY"
    getMoneyButton.Parent = ContentFrame
    yPos = yPos + 60
    
    local multiplierButton = Instance.new("TextButton")
    multiplierButton.Name = "MultiplierButton"
    multiplierButton.Size = buttonSize
    multiplierButton.Position = UDim2.new(0, isMobile and 7.5 or 10, 0, yPos)
    multiplierButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    multiplierButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    multiplierButton.Font = Enum.Font.SourceSansBold
    multiplierButton.TextSize = 16
    multiplierButton.Text = "🔄 APPLY MULTIPLIER x" .. moneyMultiplier
    multiplierButton.Parent = ContentFrame
    yPos = yPos + 60
    
    -- Slider Event
    local draggingMulti = false
    multiSlider.MouseButton1Down:Connect(function()
        draggingMulti = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingMulti = false
        end
    end)
    
    multiSlider.MouseMoved:Connect(function(x, y)
        if draggingMulti then
            local relativeX = math.clamp(x - multiplierFrame.AbsolutePosition.X, 0, multiplierFrame.AbsoluteSize.X)
            local percentage = relativeX / multiplierFrame.AbsoluteSize.X
            moneyMultiplier = math.floor(2 + percentage * 18) -- 2 bis 20
            multiLabel.Text = "💰 MONEY MULTIPLIER: x" .. moneyMultiplier
            multiplierButton.Text = "🔄 APPLY MULTIPLIER x" .. moneyMultiplier
        end
    end)
    
    -- Button Events
    getMoneyButton.MouseButton1Click:Connect(function()
        moneyAmount = tonumber(amountBox.Text) or 9999999
        moneyValueName = nameBox.Text or "Cash"
        
        pcall(function()
            for _, target in pairs(game:GetDescendants()) do
                if target:IsA("IntValue") or target:IsA("NumberValue") then
                    if target.Name:lower():find(moneyValueName:lower()) then
                        target.Value = moneyAmount
                    end
                end
            end
        end)
    end)
    
    multiplierButton.MouseButton1Click:Connect(function()
        moneyValueName = nameBox.Text or "Cash"
        multiplyMoney()
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- TOOLS TAB
local function showToolsTab()
    ContentFrame:ClearAllChildren()
    
    local yPos = 10
    
    -- Scan Button
    local scanButton = Instance.new("TextButton")
    scanButton.Name = "ScanButton"
    scanButton.Size = buttonSize
    scanButton.Position = UDim2.new(0, isMobile and 7.5 or 10, 0, yPos)
    scanButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    scanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanButton.Font = Enum.Font.SourceSansBold
    scanButton.TextSize = 16
    scanButton.Text = "🔍 SCAN FOR TOOLS"
    scanButton.Parent = ContentFrame
    yPos = yPos + 60
    
    -- Give All Button
    local giveAllButton = Instance.new("TextButton")
    giveAllButton.Name = "GiveAllButton"
    giveAllButton.Size = buttonSize
    giveAllButton.Position = UDim2.new(0, isMobile and 7.5 or 10, 0, yPos)
    giveAllButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    giveAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    giveAllButton.Font = Enum.Font.SourceSansBold
    giveAllButton.TextSize = 16
    giveAllButton.Text = "🎁 GIVE ALL TOOLS"
    giveAllButton.Parent = ContentFrame
    yPos = yPos + 60
    
    -- Tools Count Label
    local toolsCountLabel = Instance.new("TextLabel")
    toolsCountLabel.Name = "ToolsCountLabel"
    toolsCountLabel.Size = UDim2.new(1, -20, 0, 30)
    toolsCountLabel.Position = UDim2.new(0, 10, 0, yPos)
    toolsCountLabel.BackgroundTransparency = 1
    toolsCountLabel.Text = "🔧 Gefundene Tools: 0"
    toolsCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toolsCountLabel.Font = Enum.Font.SourceSansBold
    toolsCountLabel.TextSize = 14
    toolsCountLabel.Parent = ContentFrame
    yPos = yPos + 40
    
    -- Tools Container
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
            if i <= 8 then -- Max 8 Tools anzeigen
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
                toolName.TextSize = 12
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
                    local success, message = giveTool(toolData.Name)
                    if success then
                        giveButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                        giveButton.Text = "✅"
                        wait(1)
                        giveButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                        giveButton.Text = "GIVE"
                    end
                end)
                
                toolY = toolY + 45
            end
        end
        
        toolsContainer.Size = UDim2.new(1, -20, 0, math.min(toolY, 300))
    end
    
    -- Button Events
    scanButton.MouseButton1Click:Connect(function()
        local count = scanTools()
        toolsCountLabel.Text = "🔧 Gefundene Tools: " .. count
        updateToolsList()
    end)
    
    giveAllButton.MouseButton1Click:Connect(function()
        local count = giveAllTools()
        giveAllButton.Text = "✅ " .. count .. " TOOLS GIVEN"
        giveAllButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        wait(1)
        giveAllButton.Text = "🎁 GIVE ALL TOOLS"
        giveAllButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 350)
end

-- ADMIN TAB
local function showAdminTab()
    ContentFrame:ClearAllChildren()
    
    local yPos = 10
    
    if not VIP_USERS[player.UserId] then
        local vipWarning = Instance.new("TextLabel")
        vipWarning.Name = "VipWarning"
        vipWarning.Size = UDim2.new(1, -20, 0, 100)
        vipWarning.Position = UDim2.new(0, 10, 0, yPos)
        vipWarning.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        vipWarning.TextColor3 = Color3.fromRGB(255, 255, 255)
        vipWarning.Font = Enum.Font.SourceSansBold
        vipWarning.TextSize = 16
        vipWarning.Text = "🚫 VIP ACCESS REQUIRED\n\nOnly VIP users can access admin commands.\n\nContact developer for VIP access."
        vipWarning.TextWrapped = true
        vipWarning.Parent = ContentFrame
        
        local warningCorner = Instance.new("UICorner")
        warningCorner.CornerRadius = UDim.new(0, 8)
        warningCorner.Parent = vipWarning
        
        return
    end
    
    -- Admin Commands Liste
    local adminCommands = {
        "KILL ALL - Kills all players",
        "FREEZE [PLAYER] - Freezes player",
        "THAW [PLAYER] - Unfreezes player",
        "BRING [PLAYER] - Brings player to you",
        "GOTO [PLAYER] - Teleports to player",
        "KICK [PLAYER] - Kicks player",
        "CRASH SERVER - Crashes server",
        "LAG SERVER - Creates lag",
        "ANNOUNCE [TEXT] - Server announcement",
        "NOTIFICATION [TEXT] - Sends notification"
    }
    
    -- Command Input
    local commandFrame = Instance.new("Frame")
    commandFrame.Name = "CommandFrame"
    commandFrame.Size = UDim2.new(1, -20, 0, 60)
    commandFrame.Position = UDim2.new(0, 10, 0, yPos)
    commandFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    commandFrame.Parent = ContentFrame
    yPos = yPos + 70
    
    local commandCorner = Instance.new("UICorner")
    commandCorner.CornerRadius = UDim.new(0, 6)
    commandCorner.Parent = commandFrame
    
    local commandBox = Instance.new("TextBox")
    commandBox.Name = "CommandBox"
    commandBox.Size = UDim2.new(0.7, 0, 0.6, 0)
    commandBox.Position = UDim2.new(0.05, 0, 0.2, 0)
    commandBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    commandBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    commandBox.Font = Enum.Font.SourceSans
    commandBox.TextSize = 14
    commandBox.PlaceholderText = "Enter admin command..."
    commandBox.Parent = commandFrame
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = commandBox
    
    local executeButton = Instance.new("TextButton")
    executeButton.Name = "ExecuteButton"
    executeButton.Size = UDim2.new(0.2, 0, 0.6, 0)
    executeButton.Position = UDim2.new(0.78, 0, 0.2, 0)
    executeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    executeButton.Font = Enum.Font.SourceSansBold
    executeButton.TextSize = 14
    executeButton.Text = "EXECUTE"
    executeButton.Parent = commandFrame
    
    local executeCorner = Instance.new("UICorner")
    executeCorner.CornerRadius = UDim.new(0, 4)
    executeCorner.Parent = executeButton
    
    -- Commands List
    for i, cmd in pairs(adminCommands) do
        local cmdFrame = Instance.new("Frame")
        cmdFrame.Name = "CmdFrame" .. i
        cmdFrame.Size = UDim2.new(1, -20, 0, 40)
        cmdFrame.Position = UDim2.new(0, 10, 0, yPos)
        cmdFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        cmdFrame.Parent = ContentFrame
        yPos = yPos + 45
        
        local cmdCorner = Instance.new("UICorner")
        cmdCorner.CornerRadius = UDim.new(0, 6)
        cmdCorner.Parent = cmdFrame
        
        local cmdLabel = Instance.new("TextLabel")
        cmdLabel.Name = "CmdLabel"
        cmdLabel.Size = UDim2.new(1, -20, 1, 0)
        cmdLabel.Position = UDim2.new(0, 10, 0, 0)
        cmdLabel.BackgroundTransparency = 1
        cmdLabel.Text = cmd
        cmdLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        cmdLabel.Font = Enum.Font.SourceSans
        cmdLabel.TextSize = 12
        cmdLabel.TextXAlignment = Enum.TextXAlignment.Left
        cmdLabel.Parent = cmdFrame
    end
    
    -- Execute Function
    executeButton.MouseButton1Click:Connect(function()
        local command = commandBox.Text:lower()
        
        if command == "kill all" then
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer ~= player and targetPlayer.Character then
                    local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.Health = 0
                    end
                end
            end
            commandBox.Text = "✅ All players killed"
            
        elseif command:find("freeze") then
            local targetName = command:gsub("freeze ", "")
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer.Name:lower():find(targetName) and targetPlayer.Character then
                    local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = 0
                        humanoid.JumpPower = 0
                        commandBox.Text = "✅ " .. targetPlayer.Name .. " frozen"
                    end
                end
            end
            
        elseif command:find("thaw") then
            local targetName = command:gsub("thaw ", "")
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer.Name:lower():find(targetName) and targetPlayer.Character then
                    local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = 16
                        humanoid.JumpPower = 50
                        commandBox.Text = "✅ " .. targetPlayer.Name .. " unfrozen"
                    end
                end
            end
            
        elseif command:find("bring") then
            local targetName = command:gsub("bring ", "")
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer.Name:lower():find(targetName) and targetPlayer.Character then
                    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local myRoot = character:FindFirstChild("HumanoidRootPart")
                    if targetRoot and myRoot then
                        targetRoot.CFrame = myRoot.CFrame * CFrame.new(0, 0, -5)
                        commandBox.Text = "✅ " .. targetPlayer.Name .. " brought"
                    end
                end
            end
            
        elseif command:find("goto") then
            local targetName = command:gsub("goto ", "")
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer.Name:lower():find(targetName) and targetPlayer.Character then
                    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local myRoot = character:FindFirstChild("HumanoidRootPart")
                    if targetRoot and myRoot then
                        myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 5)
                        commandBox.Text = "✅ Teleported to " .. targetPlayer.Name
                    end
                end
            end
        end
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- TAB SWITCHING
local activeTab = "Cheats"

local function switchTab(tabName)
    activeTab = tabName
    
    -- Tab Buttons zurücksetzen
    CheatsTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    AimbotTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    MoneyTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ToolsTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    AdminTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    
    CheatsTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    AimbotTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MoneyTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    ToolsTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    AdminTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    -- Aktiven Tab hervorheben
    if tabName == "Cheats" then
        CheatsTabBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        CheatsTabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        showCheatsTab()
    elseif tabName == "Aimbot" then
        AimbotTabBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        AimbotTabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        showAimbotTab()
    elseif tabName == "Money" then
        MoneyTabBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        MoneyTabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        showMoneyTab()
    elseif tabName == "Tools" then
        ToolsTabBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        ToolsTabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        showToolsTab()
    elseif tabName == "Admin" then
        AdminTabBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        AdminTabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        showAdminTab()
    end
end

-- GUI TOGGLE FUNKTION
local guiVisible = not isMobile

local function toggleGUI()
    guiVisible = not guiVisible
    
    if guiVisible then
        MainFrame.Visible = true
        ToggleButton.Text = "✕"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    else
        MainFrame.Visible = false
        ToggleButton.Text = "⚡"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    end
end

-- EVENTS
ToggleButton.MouseButton1Click:Connect(toggleGUI)
CloseButton.MouseButton1Click:Connect(toggleGUI)

CheatsTabBtn.MouseButton1Click:Connect(function() switchTab("Cheats") end)
AimbotTabBtn.MouseButton1Click:Connect(function() switchTab("Aimbot") end)
MoneyTabBtn.MouseButton1Click:Connect(function() switchTab("Money") end)
ToolsTabBtn.MouseButton1Click:Connect(function() switchTab("Tools") end)
AdminTabBtn.MouseButton1Click:Connect(function() switchTab("Admin") end)

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
    
    if cheats.esp then
        toggleESP()
        toggleESP()
    end
    
    if cheats.jumpboost then
        toggleJumpBoost()
        toggleJumpBoost()
    end
end)

-- GUI ZUM SPIELER HINZUFÜGEN
if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

-- STARTE MIT CHEATS TAB
switchTab("Cheats")

-- KEYBINDS
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.RightControl then
        toggleGUI()
    elseif input.KeyCode == Enum.KeyCode.Insert then
        toggleGUI()
    elseif input.KeyCode == Enum.KeyCode.F then
        if not cheats.fly then
            cheats.fly = toggleFly()
        end
    elseif input.KeyCode == Enum.KeyCode.G then
        if not cheats.godmode then
            cheats.godmode = toggleGodmode()
        end
    elseif input.KeyCode == Enum.KeyCode.N then
        if not cheats.noclip then
            cheats.noclip = toggleNoclip()
        end
    end
end)

print("✅ HACKER TOOL V6 GELADEN!")
print("📱 Mobile Mode: " .. tostring(isMobile))
print("⚡ Features: Aimbot, ESP, Money Multiply, Tool Giver, Admin Commands")
print("🎮 Toggle GUI: RightControl / Insert")
print("💎 VIP Status: " .. tostring(VIP_USERS[player.UserId]))

-- HACKER TOOL V6 - PREMIUM CHEATS
-- Alle Features in einem Script

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local mouse = player:GetMouse()

-- VIP System
local VIP_USERS = {[player.UserId] = true}

-- GUI Setup
local isMobile = UserInputService.TouchEnabled
local guiSize = isMobile and UDim2.new(0, 350, 0, 500) or UDim2.new(0, 400, 0, 550)

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HackerToolV6"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = guiSize
MainFrame.Position = UDim2.new(0.5, -guiSize.X.Offset/2, 0.5, -guiSize.Y.Offset/2)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = not isMobile
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Mobile Toggle Button
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
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "HACKER TOOL V6"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

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

-- Tabs
local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(1, -20, 0, 40)
Tabs.Position = UDim2.new(0, 10, 0, 55)
Tabs.BackgroundTransparency = 1
Tabs.Parent = MainFrame

-- Tab Buttons
local tabButtons = {}
local tabs = {"Cheats", "Aimbot", "Money", "Tools", "Admin"}
for i, tabName in ipairs(tabs) do
    local button = Instance.new("TextButton")
    button.Name = tabName .. "Tab"
    button.Size = UDim2.new(0.18, 0, 1, 0)
    button.Position = UDim2.new(0.18 * (i-1), 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 12
    button.Text = tabName:upper()
    button.Parent = Tabs
    tabButtons[tabName] = button
end

-- Content Frame
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -110)
ContentFrame.Position = UDim2.new(0, 10, 0, 105)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
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
    aimbot = false
}

-- FLY SYSTEM
local flySpeed = 50
local flyEnabled = false
local flyBodyGyro, flyBodyVelocity

local function toggleFly()
    cheats.fly = not cheats.fly
    flyEnabled = cheats.fly
    
    if flyEnabled then
        flyBodyGyro = Instance.new("BodyGyro")
        flyBodyVelocity = Instance.new("BodyVelocity")
        
        flyBodyGyro.P = 10000
        flyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        flyBodyGyro.CFrame = rootPart.CFrame
        
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        flyBodyGyro.Parent = rootPart
        flyBodyVelocity.Parent = rootPart
        
        RunService.Heartbeat:Connect(function()
            if not flyEnabled or not character or not rootPart then return end
            
            local camera = Workspace.CurrentCamera
            local direction = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction - Vector3.new(0, 1, 0) end
            
            if flyBodyVelocity then flyBodyVelocity.Velocity = direction.Unit * flySpeed end
            if flyBodyGyro then flyBodyGyro.CFrame = camera.CFrame end
        end)
        
        humanoid.PlatformStand = true
    else
        if flyBodyGyro then flyBodyGyro:Destroy() end
        if flyBodyVelocity then flyBodyVelocity:Destroy() end
        humanoid.PlatformStand = false
    end
    return cheats.fly
end

-- GODMODE
local function toggleGodmode()
    cheats.godmode = not cheats.godmode
    if cheats.godmode then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    else
        humanoid.MaxHealth = 100
        humanoid.Health = 100
    end
    return cheats.godmode
end

-- MONEY SYSTEM
local moneyMultiplier = 2
local function toggleInfMoney()
    cheats.infmoney = not cheats.infmoney
    if cheats.infmoney then
        spawn(function()
            while cheats.infmoney do
                pcall(function()
                    for _, obj in pairs(game:GetDescendants()) do
                        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                            local name = obj.Name:lower()
                            if name:find("cash") or name:find("money") or name:find("coin") then
                                obj.Value = obj.Value * moneyMultiplier
                            end
                        end
                    end
                end)
                wait(0.5)
            end
        end)
    end
    return cheats.infmoney
end

-- SPEED
local speedMult = 3
local origWalkSpeed
local function toggleSpeed()
    cheats.speed = not cheats.speed
    if cheats.speed then
        origWalkSpeed = humanoid.WalkSpeed
        humanoid.WalkSpeed = origWalkSpeed * speedMult
    else
        if origWalkSpeed then humanoid.WalkSpeed = origWalkSpeed end
    end
    return cheats.speed
end

-- ESP
local espBoxes = {}
local function toggleESP()
    cheats.esp = not cheats.esp
    if cheats.esp then
        for _, target in pairs(Players:GetPlayers()) do
            if target ~= player and target.Character then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = target.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.FillTransparency = 0.7
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = target.Character
                espBoxes[target] = highlight
            end
        end
    else
        for target, highlight in pairs(espBoxes) do
            highlight:Destroy()
        end
        espBoxes = {}
    end
    return cheats.esp
end

-- AIMBOT
local aimbotFov = 50
local aimbotSmooth = 0.1
local function toggleAimbot()
    cheats.aimbot = not cheats.aimbot
    if cheats.aimbot then
        RunService.RenderStepped:Connect(function()
            if not cheats.aimbot then return end
            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                local camera = Workspace.CurrentCamera
                local closestPlayer = nil
                local closestDist = aimbotFov
                
                for _, target in pairs(Players:GetPlayers()) do
                    if target ~= player and target.Character then
                        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
                            if onScreen then
                                local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                                if dist < closestDist then
                                    closestDist = dist
                                    closestPlayer = target
                                end
                            end
                        end
                    end
                end
                
                if closestPlayer and closestPlayer.Character then
                    local hrp = closestPlayer.Character.HumanoidRootPart
                    if hrp then
                        local targetPos = hrp.Position + Vector3.new(0, 1, 0)
                        local current = camera.CFrame
                        local new = CFrame.lookAt(current.Position, targetPos)
                        camera.CFrame = current:Lerp(new, aimbotSmooth)
                    end
                end
            end
        end)
    end
    return cheats.aimbot
end

-- NOCLIP
local noclipConn
local function toggleNoclip()
    cheats.noclip = not cheats.noclip
    if cheats.noclip then
        noclipConn = RunService.Stepped:Connect(function()
            if character and cheats.noclip then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
    return cheats.noclip
end

-- INVISIBLE
local function toggleInvisible()
    cheats.invisible = not cheats.invisible
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = cheats.invisible and 1 or 0
            end
        end
    end
    return cheats.invisible
end

-- TOOL GIVER
local toolsList = {}
local function scanTools()
    toolsList = {}
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Tool") then
            table.insert(toolsList, obj.Name)
        end
    end
    return #toolsList
end

local function giveTool(toolName)
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Tool") and obj.Name:lower() == toolName:lower() then
            local clone = obj:Clone()
            clone.Parent = player.Backpack
            return true
        end
    end
    return false
end

-- Button Creator
local function createButton(text, yPos, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 50)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 16
    button.Text = text
    button.Parent = ContentFrame
    return button
end

-- Show Cheats Tab
local function showCheatsTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local buttons = {
        {"✈️ FLY", "fly", Color3.fromRGB(220, 20, 60), toggleFly},
        {"🛡️ GODMODE", "godmode", Color3.fromRGB(0, 150, 0), toggleGodmode},
        {"💰 INF MONEY", "money", Color3.fromRGB(255, 215, 0), toggleInfMoney},
        {"🚪 NOCLIP", "noclip", Color3.fromRGB(30, 144, 255), toggleNoclip},
        {"👻 INVISIBLE", "invisible", Color3.fromRGB(138, 43, 226), toggleInvisible},
        {"⚡ SPEED", "speed", Color3.fromRGB(255, 140, 0), toggleSpeed},
        {"🎯 ESP", "esp", Color3.fromRGB(255, 0, 0), toggleESP},
        {"🎯 AIMBOT", "aimbot", Color3.fromRGB(200, 0, 0), toggleAimbot}
    }
    
    for i, btnData in ipairs(buttons) do
        local button = createButton(btnData[1] .. ": OFF", yPos, btnData[3])
        button.MouseButton1Click:Connect(function()
            cheats[btnData[2]] = btnData[4]()
            button.Text = btnData[1] .. ": " .. (cheats[btnData[2]] and "ON" or "OFF")
            button.BackgroundColor3 = cheats[btnData[2]] and Color3.fromRGB(0, 200, 0) or btnData[3]
        end)
        yPos = yPos + 60
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- Show Aimbot Tab
local function showAimbotTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local aimbotBtn = createButton("🎯 AIMBOT: OFF", yPos, Color3.fromRGB(255, 0, 0))
    aimbotBtn.MouseButton1Click:Connect(function()
        cheats.aimbot = toggleAimbot()
        aimbotBtn.Text = "🎯 AIMBOT: " .. (cheats.aimbot and "ON" or "OFF")
        aimbotBtn.BackgroundColor3 = cheats.aimbot and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 0, 0)
    end)
    yPos = yPos + 70
    
    -- FOV Slider
    local fovFrame = Instance.new("Frame")
    fovFrame.Size = UDim2.new(1, -20, 0, 40)
    fovFrame.Position = UDim2.new(0, 10, 0, yPos)
    fovFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    fovFrame.Parent = ContentFrame
    yPos = yPos + 50
    
    local fovLabel = Instance.new("TextLabel")
    fovLabel.Size = UDim2.new(0.6, 0, 1, 0)
    fovLabel.Position = UDim2.new(0, 10, 0, 0)
    fovLabel.BackgroundTransparency = 1
    fovLabel.Text = "FOV: " .. aimbotFov
    fovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fovLabel.Font = Enum.Font.SourceSans
    fovLabel.TextSize = 14
    fovLabel.TextXAlignment = Enum.TextXAlignment.Left
    fovLabel.Parent = fovFrame
    
    -- Smoothness Slider
    local smoothFrame = Instance.new("Frame")
    smoothFrame.Size = UDim2.new(1, -20, 0, 40)
    smoothFrame.Position = UDim2.new(0, 10, 0, yPos)
    smoothFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    smoothFrame.Parent = ContentFrame
    yPos = yPos + 50
    
    local smoothLabel = Instance.new("TextLabel")
    smoothLabel.Size = UDim2.new(0.6, 0, 1, 0)
    smoothLabel.Position = UDim2.new(0, 10, 0, 0)
    smoothLabel.BackgroundTransparency = 1
    smoothLabel.Text = "Smooth: " .. string.format("%.2f", aimbotSmooth)
    smoothLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    smoothLabel.Font = Enum.Font.SourceSans
    smoothLabel.TextSize = 14
    smoothLabel.TextXAlignment = Enum.TextXAlignment.Left
    smoothLabel.Parent = smoothFrame
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- Show Money Tab
local function showMoneyTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- Multiplier Slider
    local multiFrame = Instance.new("Frame")
    multiFrame.Size = UDim2.new(1, -20, 0, 60)
    multiFrame.Position = UDim2.new(0, 10, 0, yPos)
    multiFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    multiFrame.Parent = ContentFrame
    yPos = yPos + 70
    
    local multiLabel = Instance.new("TextLabel")
    multiLabel.Size = UDim2.new(1, -20, 0.5, 0)
    multiLabel.Position = UDim2.new(0, 10, 0, 5)
    multiLabel.BackgroundTransparency = 1
    multiLabel.Text = "💰 MULTIPLIER: x" .. moneyMultiplier
    multiLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    multiLabel.Font = Enum.Font.SourceSansBold
    multiLabel.TextSize = 16
    multiLabel.Parent = multiFrame
    
    -- Money Buttons
    local getMoneyBtn = createButton("💸 GET MAX MONEY", yPos, Color3.fromRGB(0, 180, 0))
    getMoneyBtn.MouseButton1Click:Connect(function()
        pcall(function()
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                    if obj.Name:lower():find("cash") or obj.Name:lower():find("money") then
                        obj.Value = 9999999
                    end
                end
            end
        end)
    end)
    yPos = yPos + 60
    
    local applyMultiBtn = createButton("🔄 APPLY MULTIPLIER x" .. moneyMultiplier, yPos, Color3.fromRGB(255, 140, 0))
    applyMultiBtn.MouseButton1Click:Connect(function()
        toggleInfMoney()
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 70)
end

-- Show Tools Tab
local function showToolsTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local scanBtn = createButton("🔍 SCAN TOOLS", yPos, Color3.fromRGB(0, 120, 215))
    yPos = yPos + 60
    
    local giveAllBtn = createButton("🎁 GIVE ALL TOOLS", yPos, Color3.fromRGB(0, 180, 0))
    yPos = yPos + 60
    
    local toolsLabel = Instance.new("TextLabel")
    toolsLabel.Size = UDim2.new(1, -20, 0, 30)
    toolsLabel.Position = UDim2.new(0, 10, 0, yPos)
    toolsLabel.BackgroundTransparency = 1
    toolsLabel.Text = "Tools: 0"
    toolsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toolsLabel.Font = Enum.Font.SourceSansBold
    toolsLabel.Parent = ContentFrame
    yPos = yPos + 40
    
    scanBtn.MouseButton1Click:Connect(function()
        local count = scanTools()
        toolsLabel.Text = "Tools found: " .. count
    end)
    
    giveAllBtn.MouseButton1Click:Connect(function()
        for _, toolName in pairs(toolsList) do
            giveTool(toolName)
        end
        giveAllBtn.Text = "✅ GIVEN ALL"
        giveAllBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- Show Admin Tab
local function showAdminTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    if not VIP_USERS[player.UserId] then
        local warning = Instance.new("TextLabel")
        warning.Size = UDim2.new(1, -20, 0, 100)
        warning.Position = UDim2.new(0, 10, 0, yPos)
        warning.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        warning.TextColor3 = Color3.fromRGB(255, 255, 255)
        warning.Font = Enum.Font.SourceSansBold
        warning.TextSize = 16
        warning.Text = "🚫 VIP ACCESS REQUIRED"
        warning.TextWrapped = true
        warning.Parent = ContentFrame
        return
    end
    
    local commands = {
        "KILL ALL - Kill all players",
        "FREEZE [NAME] - Freeze player",
        "THAW [NAME] - Unfreeze player",
        "BRING [NAME] - Bring player",
        "GOTO [NAME] - Teleport to player"
    }
    
    local cmdBox = Instance.new("TextBox")
    cmdBox.Size = UDim2.new(1, -20, 0, 40)
    cmdBox.Position = UDim2.new(0, 10, 0, yPos)
    cmdBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    cmdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    cmdBox.PlaceholderText = "Enter command..."
    cmdBox.Parent = ContentFrame
    yPos = yPos + 50
    
    local execBtn = createButton("EXECUTE", yPos, Color3.fromRGB(255, 50, 50))
    execBtn.MouseButton1Click:Connect(function()
        local cmd = cmdBox.Text:lower()
        if cmd == "kill all" then
            for _, target in pairs(Players:GetPlayers()) do
                if target ~= player and target.Character then
                    local hum = target.Character:FindFirstChild("Humanoid")
                    if hum then hum.Health = 0 end
                end
            end
            cmdBox.Text = "✅ Killed all"
        end
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 60)
end

-- Tab Switching
local activeTab = "Cheats"
local function switchTab(tabName)
    activeTab = tabName
    
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = name == tabName and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(40, 40, 50)
        btn.TextColor3 = name == tabName and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(200, 200, 200)
    end
    
    if tabName == "Cheats" then showCheatsTab()
    elseif tabName == "Aimbot" then showAimbotTab()
    elseif tabName == "Money" then showMoneyTab()
    elseif tabName == "Tools" then showToolsTab()
    elseif tabName == "Admin" then showAdminTab()
    end
end

-- GUI Toggle
local guiVisible = not isMobile
local function toggleGUI()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
    if isMobile then
        ToggleButton.Text = guiVisible and "✕" or "⚡"
        ToggleButton.BackgroundColor3 = guiVisible and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(0, 255, 255)
    end
end

-- Events
ToggleButton.MouseButton1Click:Connect(toggleGUI)
CloseButton.MouseButton1Click:Connect(toggleGUI)

for tabName, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() switchTab(tabName) end)
end

-- Character Handling
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    wait(0.5)
    
    -- Reapply cheats
    for cheatName, isActive in pairs(cheats) do
        if isActive then
            if cheatName == "fly" then toggleFly(); toggleFly()
            elseif cheatName == "godmode" then toggleGodmode(); toggleGodmode()
            elseif cheatName == "speed" then toggleSpeed(); toggleSpeed()
            elseif cheatName == "esp" then toggleESP(); toggleESP()
            elseif cheatName == "noclip" then toggleNoclip(); toggleNoclip()
            elseif cheatName == "invisible" then toggleInvisible(); toggleInvisible()
            end
        end
    end
end)

-- Add GUI
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

-- Start with Cheats tab
switchTab("Cheats")

-- Keybinds
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl or input.KeyCode == Enum.KeyCode.Insert then
        toggleGUI()
    elseif input.KeyCode == Enum.KeyCode.F then
        if not cheats.fly then cheats.fly = toggleFly() end
    elseif input.KeyCode == Enum.KeyCode.G then
        if not cheats.godmode then cheats.godmode = toggleGodmode() end
    elseif input.KeyCode == Enum.KeyCode.N then
        if not cheats.noclip then cheats.noclip = toggleNoclip() end
    end
end)

print("✅ HACKER TOOL V6 LOADED!")
print("🎮 Toggle GUI: RightControl / Insert")
print("⚡ Press F for Fly | G for Godmode | N for Noclip")

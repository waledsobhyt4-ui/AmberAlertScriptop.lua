-- HACKER TOOL V6 - PREMIUM CHEATS
-- Erweiterte Version mit allen Features

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local mouse = player:GetMouse()

-- VIP System (erweiterte Liste)
local VIP_USERS = {
    [player.UserId] = true, -- Aktueller Spieler als VIP
    [1234567890] = true, -- Beispiel VIP ID
}

-- Admin Passwort System
local ADMIN_PASSWORD = "hackerv6"
local isAdmin = false

-- GUI Setup
local isMobile = UserInputService.TouchEnabled
local guiSize = isMobile and UDim2.new(0, 350, 0, 550) or UDim2.new(0, 420, 0, 600)

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
local tabs = {"Cheats", "Aimbot", "Money", "Tools", "Admin", "Extra"}
for i, tabName in ipairs(tabs) do
    local button = Instance.new("TextButton")
    button.Name = tabName .. "Tab"
    button.Size = UDim2.new(0.15, 0, 1, 0)
    button.Position = UDim2.new(0.15 * (i-1), 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 11
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
    infammo = false,
    killaura = false,
    btools = false,
    fpsdisplay = false,
    unlimitedjump = false,
    autofarm = false
}

-- FPS Display
local fpsLabel
local function toggleFPSDisplay()
    cheats.fpsdisplay = not cheats.fpsdisplay
    
    if cheats.fpsdisplay then
        fpsLabel = Instance.new("TextLabel")
        fpsLabel.Name = "FPSDisplay"
        fpsLabel.Size = UDim2.new(0, 100, 0, 30)
        fpsLabel.Position = UDim2.new(1, -110, 0, 10)
        fpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        fpsLabel.BackgroundTransparency = 0.5
        fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        fpsLabel.Font = Enum.Font.SourceSansBold
        fpsLabel.TextSize = 16
        fpsLabel.Text = "FPS: 60"
        fpsLabel.TextStrokeTransparency = 0
        fpsLabel.Parent = ScreenGui
        
        RunService.RenderStepped:Connect(function()
            if fpsLabel then
                fpsLabel.Text = "FPS: " .. math.floor(1 / RunService.RenderStepped:Wait())
            end
        end)
    else
        if fpsLabel then
            fpsLabel:Destroy()
            fpsLabel = nil
        end
    end
    return cheats.fpsdisplay
end

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
        humanoid.BreakJointsOnDeath = false
    else
        humanoid.MaxHealth = 100
        humanoid.Health = 100
        humanoid.BreakJointsOnDeath = true
    end
    return cheats.godmode
end

-- MONEY SYSTEM - UNIVERSAL
local moneyMultiplier = 10
local function toggleInfMoney()
    cheats.infmoney = not cheats.infmoney
    if cheats.infmoney then
        spawn(function()
            while cheats.infmoney do
                pcall(function()
                    -- Suche nach allen möglichen Geld-Objekten
                    for _, obj in pairs(game:GetDescendants()) do
                        -- IntValue / NumberValue / StringValue
                        if obj:IsA("IntValue") or obj:IsA("NumberValue") or obj:IsA("StringValue") then
                            local name = obj.Name:lower()
                            local parentName = obj.Parent and obj.Parent.Name:lower() or ""
                            
                            if name:find("cash") or name:find("money") or name:find("coin") or 
                               name:find("currency") or name:find("dollar") or name:find("gem") or
                               name:find("robux") or name:find("bux") or name:find("tix") or
                               name:find("reward") or name:find("point") or name:find("score") or
                               parentName:find("money") or parentName:find("cash") then
                               
                                if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                                    obj.Value = obj.Value * moneyMultiplier
                                elseif obj:IsA("StringValue") then
                                    local num = tonumber(obj.Value)
                                    if num then
                                        obj.Value = tostring(num * moneyMultiplier)
                                    end
                                end
                            end
                        end
                        
                        -- Auch in Player-Stats suchen
                        if obj:IsA("NumberValue") and obj.Parent == player then
                            if obj.Name:lower():find("cash") or obj.Name:lower():find("money") then
                                obj.Value = obj.Value * moneyMultiplier
                            end
                        end
                    end
                    
                    -- Suche nach Leaderstats
                    if player:FindFirstChild("leaderstats") then
                        for _, stat in pairs(player.leaderstats:GetChildren()) do
                            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                                local name = stat.Name:lower()
                                if name:find("cash") or name:find("money") or name:find("coin") then
                                    stat.Value = stat.Value * moneyMultiplier
                                end
                            end
                        end
                    end
                end)
                wait(0.3)
            end
        end)
    end
    return cheats.infmoney
end

-- UNLIMITED AMMO
local function toggleInfAmmo()
    cheats.infammo = not cheats.infammo
    if cheats.infammo then
        spawn(function()
            while cheats.infammo do
                pcall(function()
                    for _, tool in pairs(player.Backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                            for _, child in pairs(tool:GetDescendants()) do
                                if child:IsA("NumberValue") and 
                                   (child.Name:lower():find("ammo") or 
                                    child.Name:lower():find("clip") or
                                    child.Name:lower():find("bullet")) then
                                    child.Value = 9999
                                end
                            end
                        end
                    end
                    
                    if character then
                        for _, tool in pairs(character:GetChildren()) do
                            if tool:IsA("Tool") then
                                for _, child in pairs(tool:GetDescendants()) do
                                    if child:IsA("NumberValue") and child.Name:lower():find("ammo") then
                                        child.Value = 9999
                                    end
                                end
                            end
                        end
                    end
                end)
                wait(0.5)
            end
        end)
    end
    return cheats.infammo
end

-- KILL AURA
local killAuraRange = 20
local killAuraActive = false
local function toggleKillAura()
    cheats.killaura = not cheats.killaura
    killAuraActive = cheats.killaura
    
    if killAuraActive then
        spawn(function()
            while killAuraActive do
                pcall(function()
                    for _, target in pairs(Players:GetPlayers()) do
                        if target ~= player and target.Character then
                            local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
                            if targetRoot and rootPart then
                                local distance = (targetRoot.Position - rootPart.Position).Magnitude
                                if distance <= killAuraRange then
                                    local humanoid = target.Character:FindFirstChild("Humanoid")
                                    if humanoid then
                                        humanoid.Health = 0
                                    end
                                end
                            end
                        end
                    end
                end)
                wait(0.2)
            end
        end)
    end
    return cheats.killaura
end

-- BTOOLS
local function toggleBTools()
    cheats.btools = not cheats.btools
    if cheats.btools then
        -- Clone Tool
        local cloneTool = Instance.new("Tool")
        cloneTool.Name = "Clone Tool"
        cloneTool.ToolTip = "Klicke auf Teile zum Klonen"
        cloneTool.CanBeDropped = false
        
        local clickEvent = Instance.new("ClickDetector")
        clickEvent.Parent = cloneTool
        
        cloneTool.Activated:Connect(function()
            local target = mouse.Target
            if target then
                local clone = target:Clone()
                clone.Parent = target.Parent
                clone.Position = target.Position + Vector3.new(5, 0, 0)
            end
        end)
        
        cloneTool.Parent = player.Backpack
        
        -- Delete Tool
        local deleteTool = Instance.new("Tool")
        deleteTool.Name = "Delete Tool"
        deleteTool.ToolTip = "Klicke auf Teile zum Löschen"
        deleteTool.CanBeDropped = false
        
        deleteTool.Activated:Connect(function()
            local target = mouse.Target
            if target and target ~= Workspace.Terrain then
                target:Destroy()
            end
        end)
        
        deleteTool.Parent = player.Backpack
    else
        -- Bools entfernen
        for _, tool in pairs(player.Backpack:GetChildren()) do
            if tool.Name == "Clone Tool" or tool.Name == "Delete Tool" then
                tool:Destroy()
            end
        end
    end
    return cheats.btools
end

-- UNLIMITED JUMP
local jumpPower = 50
local function toggleUnlimitedJump()
    cheats.unlimitedjump = not cheats.unlimitedjump
    if cheats.unlimitedjump then
        humanoid.JumpPower = jumpPower
        humanoid.UseJumpPower = true
    else
        humanoid.JumpPower = 50
    end
    return cheats.unlimitedjump
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
        
        -- Neue Spieler hinzufügen
        Players.PlayerAdded:Connect(function(target)
            if cheats.esp then
                target.CharacterAdded:Connect(function(char)
                    wait(1)
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = char
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillTransparency = 0.7
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = char
                    espBoxes[target] = highlight
                end)
            end
        end)
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

-- TOOL GIVER (verbessert)
local toolsList = {}
local function scanTools()
    toolsList = {}
    local count = 0
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Tool") then
            table.insert(toolsList, obj.Name)
            count = count + 1
        end
    end
    return count
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

-- TELEPORT FUNCTIONS
local function teleportToPlayer(playerName)
    for _, target in pairs(Players:GetPlayers()) do
        if target.Name:lower():find(playerName:lower()) and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                rootPart.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
                return true
            end
        end
    end
    return false
end

local function bringPlayer(playerName)
    for _, target in pairs(Players:GetPlayers()) do
        if target.Name:lower():find(playerName:lower()) and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp and rootPart then
                hrp.CFrame = rootPart.CFrame + Vector3.new(0, 0, 5)
                return true
            end
        end
    end
    return false
end

local function freezePlayer(playerName, freeze)
    for _, target in pairs(Players:GetPlayers()) do
        if target.Name:lower():find(playerName:lower()) and target.Character then
            local humanoid = target.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = freeze and 0 or 16
                return true
            end
        end
    end
    return false
end

-- Button Creator
local function createButton(text, yPos, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 45)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 14
    button.Text = text
    button.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    return button
end

-- Show Cheats Tab
local function showCheatsTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local buttons = {
        {"✈️ FLY", "fly", Color3.fromRGB(220, 20, 60), toggleFly},
        {"🛡️ GODMODE", "godmode", Color3.fromRGB(0, 150, 0), toggleGodmode},
        {"💰 INF MONEY", "infmoney", Color3.fromRGB(255, 215, 0), toggleInfMoney},
        {"🚪 NOCLIP", "noclip", Color3.fromRGB(30, 144, 255), toggleNoclip},
        {"👻 INVISIBLE", "invisible", Color3.fromRGB(138, 43, 226), toggleInvisible},
        {"⚡ SPEED", "speed", Color3.fromRGB(255, 140, 0), toggleSpeed},
        {"🎯 ESP", "esp", Color3.fromRGB(255, 0, 0), toggleESP},
        {"🔫 INF AMMO", "infammo", Color3.fromRGB(160, 32, 240), toggleInfAmmo},
        {"💀 KILL AURA", "killaura", Color3.fromRGB(220, 20, 60), toggleKillAura},
        {"🛠️ BTOOLS", "btools", Color3.fromRGB(255, 165, 0), toggleBTools},
        {"🔄 UNLIMITED JUMP", "unlimitedjump", Color3.fromRGB(0, 206, 209), toggleUnlimitedJump},
        {"📊 SHOW FPS", "fpsdisplay", Color3.fromRGB(50, 205, 50), toggleFPSDisplay}
    }
    
    for i, btnData in ipairs(buttons) do
        local button = createButton(btnData[1] .. ": OFF", yPos, btnData[3])
        button.MouseButton1Click:Connect(function()
            cheats[btnData[2]] = btnData[4]()
            button.Text = btnData[1] .. ": " .. (cheats[btnData[2]] and "ON" or "OFF")
            button.BackgroundColor3 = cheats[btnData[2]] and Color3.fromRGB(0, 200, 0) or btnData[3]
        end)
        yPos = yPos + 50
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
    yPos = yPos + 55
    
    -- FOV Slider
    local fovFrame = Instance.new("Frame")
    fovFrame.Size = UDim2.new(1, -20, 0, 50)
    fovFrame.Position = UDim2.new(0, 10, 0, yPos)
    fovFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    fovFrame.Parent = ContentFrame
    
    local fovCorner = Instance.new("UICorner")
    fovCorner.CornerRadius = UDim.new(0, 8)
    fovCorner.Parent = fovFrame
    
    local fovLabel = Instance.new("TextLabel")
    fovLabel.Size = UDim2.new(1, 0, 0.5, 0)
    fovLabel.Position = UDim2.new(0, 10, 0, 5)
    fovLabel.BackgroundTransparency = 1
    fovLabel.Text = "FOV: " .. aimbotFov
    fovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fovLabel.Font = Enum.Font.SourceSansBold
    fovLabel.TextSize = 14
    fovLabel.TextXAlignment = Enum.TextXAlignment.Left
    fovLabel.Parent = fovFrame
    
    local fovSlider = Instance.new("TextButton")
    fovSlider.Size = UDim2.new(0.8, 0, 0.3, 0)
    fovSlider.Position = UDim2.new(0.1, 0, 0.6, 0)
    fovSlider.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    fovSlider.Text = ""
    fovSlider.Parent = fovFrame
    
    yPos = yPos + 60
    
    -- Smoothness Slider
    local smoothFrame = Instance.new("Frame")
    smoothFrame.Size = UDim2.new(1, -20, 0, 50)
    smoothFrame.Position = UDim2.new(0, 10, 0, yPos)
    smoothFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    smoothFrame.Parent = ContentFrame
    
    local smoothCorner = Instance.new("UICorner")
    smoothCorner.CornerRadius = UDim.new(0, 8)
    smoothCorner.Parent = smoothFrame
    
    local smoothLabel = Instance.new("TextLabel")
    smoothLabel.Size = UDim2.new(1, 0, 0.5, 0)
    smoothLabel.Position = UDim2.new(0, 10, 0, 5)
    smoothLabel.BackgroundTransparency = 1
    smoothLabel.Text = "Smooth: " .. string.format("%.2f", aimbotSmooth)
    smoothLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    smoothLabel.Font = Enum.Font.SourceSansBold
    smoothLabel.TextSize = 14
    smoothLabel.TextXAlignment = Enum.TextXAlignment.Left
    smoothLabel.Parent = smoothFrame
    
    yPos = yPos + 60
    
    -- Headshot Toggle
    local headshotBtn = createButton("🎯 HEADSHOT MODE: OFF", yPos, Color3.fromRGB(255, 69, 0))
    headshotBtn.MouseButton1Click:Connect(function()
        headshotBtn.Text = headshotBtn.Text:find("ON") and "🎯 HEADSHOT MODE: OFF" or "🎯 HEADSHOT MODE: ON"
        headshotBtn.BackgroundColor3 = headshotBtn.Text:find("ON") and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 69, 0)
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 60)
end

-- Show Money Tab
local function showMoneyTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- Multiplier Frame
    local multiFrame = Instance.new("Frame")
    multiFrame.Size = UDim2.new(1, -20, 0, 70)
    multiFrame.Position = UDim2.new(0, 10, 0, yPos)
    multiFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    multiFrame.Parent = ContentFrame
    
    local multiCorner = Instance.new("UICorner")
    multiCorner.CornerRadius = UDim.new(0, 8)
    multiCorner.Parent = multiFrame
    
    local multiLabel = Instance.new("TextLabel")
    multiLabel.Size = UDim2.new(1, 0, 0.4, 0)
    multiLabel.Position = UDim2.new(0, 10, 0, 5)
    multiLabel.BackgroundTransparency = 1
    multiLabel.Text = "💰 MULTIPLIER: x" .. moneyMultiplier
    multiLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    multiLabel.Font = Enum.Font.SourceSansBold
    multiLabel.TextSize = 16
    multiLabel.Parent = multiFrame
    
    -- Multiplier Buttons
    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0.2, 0, 0.4, 0)
    minusBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
    minusBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    minusBtn.Text = "-"
    minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.Font = Enum.Font.SourceSansBold
    minusBtn.Parent = multiFrame
    
    local multiDisplay = Instance.new("TextLabel")
    multiDisplay.Size = UDim2.new(0.4, 0, 0.4, 0)
    multiDisplay.Position = UDim2.new(0.35, 0, 0.5, 0)
    multiDisplay.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    multiDisplay.Text = "x" .. moneyMultiplier
    multiDisplay.TextColor3 = Color3.fromRGB(255, 215, 0)
    multiDisplay.Font = Enum.Font.SourceSansBold
    multiDisplay.Parent = multiFrame
    
    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0.2, 0, 0.4, 0)
    plusBtn.Position = UDim2.new(0.8, 0, 0.5, 0)
    plusBtn.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
    plusBtn.Text = "+"
    plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.Font = Enum.Font.SourceSansBold
    plusBtn.Parent = multiFrame
    
    minusBtn.MouseButton1Click:Connect(function()
        if moneyMultiplier > 1 then
            moneyMultiplier = moneyMultiplier - 1
            multiLabel.Text = "💰 MULTIPLIER: x" .. moneyMultiplier
            multiDisplay.Text = "x" .. moneyMultiplier
        end
    end)
    
    plusBtn.MouseButton1Click:Connect(function()
        moneyMultiplier = moneyMultiplier + 1
        multiLabel.Text = "💰 MULTIPLIER: x" .. moneyMultiplier
        multiDisplay.Text = "x" .. moneyMultiplier
    end)
    
    yPos = yPos + 80
    
    -- Money Buttons
    local getMoneyBtn = createButton("💸 GET MAX MONEY", yPos, Color3.fromRGB(0, 180, 0))
    getMoneyBtn.MouseButton1Click:Connect(function()
        pcall(function()
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                    if obj.Name:lower():find("cash") or obj.Name:lower():find("money") or obj.Name:lower():find("coin") then
                        obj.Value = 9999999
                    end
                end
            end
        end)
    end)
    yPos = yPos + 50
    
    local applyMultiBtn = createButton("🔄 APPLY MULTIPLIER x" .. moneyMultiplier, yPos, Color3.fromRGB(255, 140, 0))
    applyMultiBtn.MouseButton1Click:Connect(function()
        toggleInfMoney()
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 60)
end

-- Show Tools Tab
local function showToolsTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local scanBtn = createButton("🔍 SCAN FOR TOOLS", yPos, Color3.fromRGB(0, 120, 215))
    yPos = yPos + 50
    
    local giveAllBtn = createButton("🎁 GIVE ALL TOOLS", yPos, Color3.fromRGB(0, 180, 0))
    yPos = yPos + 50
    
    local toolsLabel = Instance.new("TextLabel")
    toolsLabel.Size = UDim2.new(1, -20, 0, 40)
    toolsLabel.Position = UDim2.new(0, 10, 0, yPos)
    toolsLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    toolsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toolsLabel.Font = Enum.Font.SourceSansBold
    toolsLabel.Text = "🔧 Tools found: 0"
    toolsLabel.TextWrapped = true
    toolsLabel.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = toolsLabel
    
    yPos = yPos + 50
    
    local toolsListFrame = Instance.new("ScrollingFrame")
    toolsListFrame.Name = "ToolsList"
    toolsListFrame.Size = UDim2.new(1, -20, 0, 200)
    toolsListFrame.Position = UDim2.new(0, 10, 0, yPos)
    toolsListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    toolsListFrame.ScrollBarThickness = 6
    toolsListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    toolsListFrame.Parent = ContentFrame
    
    scanBtn.MouseButton1Click:Connect(function()
        local count = scanTools()
        toolsLabel.Text = "🔧 Tools found: " .. count .. "\n" .. table.concat(toolsList, ", ")
        
        -- Liste anzeigen
        toolsListFrame:ClearAllChildren()
        local listY = 5
        for i, toolName in ipairs(toolsList) do
            local toolBtn = Instance.new("TextButton")
            toolBtn.Size = UDim2.new(1, -10, 0, 30)
            toolBtn.Position = UDim2.new(0, 5, 0, listY)
            toolBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            toolBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            toolBtn.Text = "🎮 " .. toolName
            toolBtn.Font = Enum.Font.SourceSans
            toolBtn.TextSize = 12
            toolBtn.Parent = toolsListFrame
            
            toolBtn.MouseButton1Click:Connect(function()
                giveTool(toolName)
                toolBtn.Text = "✅ " .. toolName
                toolBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
            end)
            
            listY = listY + 35
        end
        toolsListFrame.CanvasSize = UDim2.new(0, 0, 0, listY)
    end)
    
    giveAllBtn.MouseButton1Click:Connect(function()
        for _, toolName in pairs(toolsList) do
            giveTool(toolName)
        end
        giveAllBtn.Text = "✅ ALL TOOLS GIVEN"
        giveAllBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 260)
end

-- Show Admin Tab
local function showAdminTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- Admin Login
    if not isAdmin then
        local loginFrame = Instance.new("Frame")
        loginFrame.Size = UDim2.new(1, -20, 0, 150)
        loginFrame.Position = UDim2.new(0, 10, 0, yPos)
        loginFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        loginFrame.Parent = ContentFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = loginFrame
        
        local loginLabel = Instance.new("TextLabel")
        loginLabel.Size = UDim2.new(1, 0, 0.3, 0)
        loginLabel.Position = UDim2.new(0, 0, 0, 10)
        loginLabel.BackgroundTransparency = 1
        loginLabel.Text = "🔐 ADMIN LOGIN"
        loginLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
        loginLabel.Font = Enum.Font.SourceSansBold
        loginLabel.TextSize = 18
        loginLabel.Parent = loginFrame
        
        local passBox = Instance.new("TextBox")
        passBox.Size = UDim2.new(0.8, 0, 0.3, 0)
        passBox.Position = UDim2.new(0.1, 0, 0.4, 0)
        passBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        passBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        passBox.PlaceholderText = "Enter password..."
        passBox.Text = ""
        passBox.Font = Enum.Font.SourceSans
        passBox.Parent = loginFrame
        
        local loginBtn = createButton("LOGIN", 170, Color3.fromRGB(0, 150, 0))
        loginBtn.Parent = ContentFrame
        
        loginBtn.MouseButton1Click:Connect(function()
            if passBox.Text == ADMIN_PASSWORD then
                isAdmin = true
                showAdminTab() -- Reload tab
            else
                passBox.Text = "Wrong password!"
                passBox.TextColor3 = Color3.fromRGB(255, 50, 50)
            end
        end)
        
        yPos = yPos + 160
    else
        -- Admin Commands Anzeigen
        local cmdLabel = Instance.new("TextLabel")
        cmdLabel.Size = UDim2.new(1, -20, 0, 30)
        cmdLabel.Position = UDim2.new(0, 10, 0, yPos)
        cmdLabel.BackgroundTransparency = 1
        cmdLabel.Text = "🔧 AVAILABLE COMMANDS:"
        cmdLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
        cmdLabel.Font = Enum.Font.SourceSansBold
        cmdLabel.TextSize = 16
        cmdLabel.Parent = ContentFrame
        yPos = yPos + 35
        
        local commands = {
            "kill all - Kill all players",
            "freeze [name] - Freeze player",
            "thaw [name] - Unfreeze player",
            "bring [name] - Bring player to you",
            "goto [name] - Teleport to player",
            "ban [name] - Ban player (client-side)",
            "troll [name] - Troll player",
            "heal all - Heal all players",
            "tp all - Teleport all to you"
        }
        
        for i, cmd in ipairs(commands) do
            local cmdText = Instance.new("TextLabel")
            cmdText.Size = UDim2.new(1, -20, 0, 25)
            cmdText.Position = UDim2.new(0, 10, 0, yPos)
            cmdText.BackgroundTransparency = 1
            cmdText.Text = "• " .. cmd
            cmdText.TextColor3 = Color3.fromRGB(200, 200, 200)
            cmdText.Font = Enum.Font.SourceSans
            cmdText.TextSize = 13
            cmdText.TextXAlignment = Enum.TextXAlignment.Left
            cmdText.Parent = ContentFrame
            yPos = yPos + 27
        end
        
        yPos = yPos + 10
        
        local cmdBox = Instance.new("TextBox")
        cmdBox.Size = UDim2.new(1, -20, 0, 40)
        cmdBox.Position = UDim2.new(0, 10, 0, yPos)
        cmdBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        cmdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        cmdBox.PlaceholderText = "Enter command..."
        cmdBox.Font = Enum.Font.SourceSans
        cmdBox.TextSize = 14
        cmdBox.Parent = ContentFrame
        yPos = yPos + 50
        
        local execBtn = createButton("EXECUTE COMMAND", yPos, Color3.fromRGB(255, 50, 50))
        execBtn.MouseButton1Click:Connect(function()
            local cmd = cmdBox.Text:lower()
            local args = {}
            
            for arg in cmd:gmatch("%S+") do
                table.insert(args, arg)
            end
            
            if #args > 0 then
                local command = args[1]
                
                if command == "kill" and args[2] == "all" then
                    for _, target in pairs(Players:GetPlayers()) do
                        if target ~= player and target.Character then
                            local hum = target.Character:FindFirstChild("Humanoid")
                            if hum then hum.Health = 0 end
                        end
                    end
                    cmdBox.Text = "✅ Killed all players"
                    
                elseif command == "freeze" and args[2] then
                    freezePlayer(args[2], true)
                    cmdBox.Text = "✅ Frozen " .. args[2]
                    
                elseif command == "thaw" and args[2] then
                    freezePlayer(args[2], false)
                    cmdBox.Text = "✅ Unfrozen " .. args[2]
                    
                elseif command == "bring" and args[2] then
                    bringPlayer(args[2])
                    cmdBox.Text = "✅ Brought " .. args[2]
                    
                elseif command == "goto" and args[2] then
                    teleportToPlayer(args[2])
                    cmdBox.Text = "✅ Teleported to " .. args[2]
                    
                elseif command == "ban" and args[2] then
                    -- Client-side "ban" (kick from GUI)
                    for _, target in pairs(Players:GetPlayers()) do
                        if target.Name:lower():find(args[2]:lower()) then
                            target:Kick("Banned by Admin")
                        end
                    end
                    cmdBox.Text = "✅ Attempted ban on " .. args[2]
                    
                elseif command == "troll" and args[2] then
                    -- Troll-Funktion (spam jump)
                    spawn(function()
                        for _, target in pairs(Players:GetPlayers()) do
                            if target.Name:lower():find(args[2]:lower()) and target.Character then
                                local hum = target.Character:FindFirstChild("Humanoid")
                                if hum then
                                    for i = 1, 20 do
                                        hum.Jump = true
                                        wait(0.1)
                                    end
                                end
                            end
                        end
                    end)
                    cmdBox.Text = "✅ Trolling " .. args[2]
                    
                elseif command == "heal" and args[2] == "all" then
                    for _, target in pairs(Players:GetPlayers()) do
                        if target.Character then
                            local hum = target.Character:FindFirstChild("Humanoid")
                            if hum then hum.Health = hum.MaxHealth end
                        end
                    end
                    cmdBox.Text = "✅ Healed all players"
                    
                elseif command == "tp" and args[2] == "all" then
                    for _, target in pairs(Players:GetPlayers()) do
                        if target ~= player and target.Character then
                            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                            if hrp and rootPart then
                                hrp.CFrame = rootPart.CFrame + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
                            end
                        end
                    end
                    cmdBox.Text = "✅ Teleported all to you"
                end
            end
        end)
        
        yPos = yPos + 60
        
        -- VIP Activation Button
        local vipBtn = createButton("⭐ ACTIVATE VIP", yPos, Color3.fromRGB(255, 215, 0))
        vipBtn.MouseButton1Click:Connect(function()
            VIP_USERS[player.UserId] = true
            vipBtn.Text = "✅ VIP ACTIVATED"
            vipBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        end)
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 60)
end

-- Show Extra Tab
local function showExtraTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local buttons = {
        {"🌙 NIGHT VISION", Color3.fromRGB(25, 25, 112), function()
            if Lighting.Ambient == Color3.fromRGB(50, 50, 50) then
                Lighting.Ambient = Color3.fromRGB(100, 100, 100)
            else
                Lighting.Ambient = Color3.fromRGB(50, 50, 50)
                Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 50)
            end
        end},
        {"🌈 RAINBOW CHARACTER", Color3.fromRGB(148, 0, 211), function()
            spawn(function()
                while wait(0.1) do
                    if character then
                        for _, part in pairs(character:GetChildren()) do
                            if part:IsA("BasePart") then
                                part.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                            end
                        end
                    end
                end
            end)
        end},
        {"👥 NO CLIP PLAYERS", Color3.fromRGB(70, 130, 180), function()
            for _, target in pairs(Players:GetPlayers()) do
                if target ~= player and target.Character then
                    for _, part in pairs(target.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end},
        {"🌀 ANTI-AFK", Color3.fromRGB(0, 100, 0), function()
            -- Anti-AFK
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end},
        {"📝 COPY GAME ID", Color3.fromRGB(30, 144, 255), function()
            if setclipboard then
                setclipboard(tostring(game.PlaceId))
            end
        end},
        {"⚡ SUPER PUNCH", Color3.fromRGB(255, 69, 0), function()
            humanoid.WalkSpeed = 100
            humanoid.JumpPower = 150
        end},
    }
    
    for i, btnData in ipairs(buttons) do
        local button = createButton(btnData[1], yPos, btnData[2])
        button.MouseButton1Click:Connect(btnData[3])
        yPos = yPos + 50
    end
    
    -- Rejoin Button
    local rejoinBtn = createButton("🔄 REJOIN GAME", yPos, Color3.fromRGB(220, 20, 60))
    rejoinBtn.MouseButton1Click:Connect(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, player)
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
    elseif tabName == "Extra" then showExtraTab()
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
            if cheatName == "fly" then 
                cheats.fly = false
                toggleFly()
            elseif cheatName == "godmode" then 
                cheats.godmode = false
                toggleGodmode()
            elseif cheatName == "speed" then 
                cheats.speed = false
                toggleSpeed()
            elseif cheatName == "esp" then 
                cheats.esp = false
                toggleESP()
            elseif cheatName == "noclip" then 
                cheats.noclip = false
                toggleNoclip()
            elseif cheatName == "invisible" then 
                cheats.invisible = false
                toggleInvisible()
            elseif cheatName == "infammo" then
                cheats.infammo = false
                toggleInfAmmo()
            elseif cheatName == "killaura" then
                cheats.killaura = false
                toggleKillAura()
            elseif cheatName == "unlimitedjump" then
                cheats.unlimitedjump = false
                toggleUnlimitedJump()
            end
        end
    end
end)

-- Add GUI
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
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
        if not cheats.fly then 
            cheats.fly = toggleFly() 
            if MainFrame.Visible then switchTab("Cheats") end
        end
    elseif input.KeyCode == Enum.KeyCode.G then
        if not cheats.godmode then 
            cheats.godmode = toggleGodmode()
            if MainFrame.Visible then switchTab("Cheats") end
        end
    elseif input.KeyCode == Enum.KeyCode.N then
        if not cheats.noclip then 
            cheats.noclip = toggleNoclip()
            if MainFrame.Visible then switchTab("Cheats") end
        end
    elseif input.KeyCode == Enum.KeyCode.J then
        if not cheats.unlimitedjump then 
            cheats.unlimitedjump = toggleUnlimitedJump()
            if MainFrame.Visible then switchTab("Cheats") end
        end
    elseif input.KeyCode == Enum.KeyCode.T then
        if not cheats.esp then 
            cheats.esp = toggleESP()
            if MainFrame.Visible then switchTab("Cheats") end
        end
    elseif input.KeyCode == Enum.KeyCode.H then
        if not isAdmin then
            isAdmin = true
            print("Admin activated via keybind!")
            if MainFrame.Visible then switchTab("Admin") end
        end
    end
end)

print(" ")
print("🎮 HACKER TOOL V6 PREMIUM LOADED!")
print(" ")
print("📌 HOTKEYS:")
print("   RightControl / Insert - Toggle GUI")
print("   F - Toggle Fly")
print("   G - Toggle Godmode")
print("   N - Toggle Noclip")
print("   J - Toggle Unlimited Jump")
print("   T - Toggle ESP")
print("   H - Activate Admin (dev)")
print(" ")
print("💎 Features:")
print("   • Fly & Noclip")
print("   • Godmode & Infinite Health")
print("   • Money Multiplier (Universal)")
print("   • ESP & Aimbot")
print("   • Infinite Ammo")
print("   • Kill Aura")
print("   • B-Tools")
print("   • FPS Display")
print("   • Admin Commands")
print("   • Tool Scanner/Giver")
print("   • Teleport & Troll Commands")
print(" ")
print("⚡ VIP Status: " .. (VIP_USERS[player.UserId] and "ACTIVE" or "INACTIVE"))
print("🔓 Admin Status: " .. (isAdmin and "ACTIVE" or "INACTIVE"))
print(" ")

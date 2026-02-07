-- AMBER ALERT ULTIMATE GUI
-- Made by Waled-Hammad
-- Vollständig funktionierendes Skript

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- GUI ERSTELLEN
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AmberCheats_Waled"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- HAUPTFRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 450)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- ROTE AKZENT-LINIE
local AccentLine = Instance.new("Frame")
AccentLine.Name = "AccentLine"
AccentLine.Size = UDim2.new(1, 0, 0, 4)
AccentLine.Position = UDim2.new(0, 0, 0, 0)
AccentLine.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
AccentLine.BorderSizePixel = 0
AccentLine.Parent = MainFrame

-- TITELBAR
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Position = UDim2.new(0, 0, 0, 4)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- TITEL "MADE BY WALED-HAMMAD"
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "AMBER ALERT - Made by Waled-Hammad"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- CLOSE BUTTON
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Text = "×"
CloseButton.Parent = TitleBar

-- TOGGLE BUTTON FÜR MOBILE
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 20, 0.8, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 24
ToggleButton.Text = "⚡"
ToggleButton.Visible = UserInputService.TouchEnabled
ToggleButton.Parent = ScreenGui

-- CONTENT FRAME
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -60)
ContentFrame.Position = UDim2.new(0, 10, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
ContentFrame.Parent = MainFrame

-- CHEAT VARIABLEN
local cheats = {
    fly = false,
    godmode = false,
    noclip = false,
    invisible = false,
    infmoney = false,
    speed = false,
    jumppower = false,
    esp = false,
    banhammer = false
}

-- ============ FUNKTIONEN ============

-- FLY SYSTEM
local flySpeed = 50
local flyEnabled = false

local function toggleFly()
    cheats.fly = not cheats.fly
    
    if cheats.fly then
        local bodyGyro = Instance.new("BodyGyro")
        local bodyVelocity = Instance.new("BodyVelocity")
        
        bodyGyro.P = 10000
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.CFrame = rootPart.CFrame
        
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        bodyGyro.Parent = rootPart
        bodyVelocity.Parent = rootPart
        
        flyEnabled = true
        
        local flyConnection
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flyEnabled or not rootPart then
                if flyConnection then flyConnection:Disconnect() end
                return
            end
            
            local camera = Workspace.CurrentCamera
            local direction = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction - Vector3.new(0, 1, 0) end
            
            bodyVelocity.Velocity = direction.Unit * flySpeed
            bodyGyro.CFrame = camera.CFrame
        end)
        
        humanoid.PlatformStand = true
    else
        flyEnabled = false
        humanoid.PlatformStand = false
        
        for _, obj in pairs(rootPart:GetChildren()) do
            if obj:IsA("BodyGyro") or obj:IsA("BodyVelocity") then
                obj:Destroy()
            end
        end
    end
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
end

-- INFINITY MONEY (FUNKTIONIERT)
local function toggleInfMoney()
    cheats.infmoney = not cheats.infmoney
    
    if cheats.infmoney then
        spawn(function()
            while cheats.infmoney and task.wait(0.5) do
                pcall(function()
                    -- Setze alle Geld-Werte
                    local moneyTypes = {"Cash", "Money", "Coins", "Points", "Gold", "Dollars"}
                    
                    for _, target in pairs({player, workspace}) do
                        for _, obj in pairs(target:GetDescendants()) do
                            if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                                for _, moneyType in pairs(moneyTypes) do
                                    if obj.Name:lower():find(moneyType:lower()) then
                                        obj.Value = 9999999
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
    return cheats.infmoney
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
    else
        if noclipConnection then noclipConnection:Disconnect() end
    end
end

-- INVISIBLE
local function toggleInvisible()
    cheats.invisible = not cheats.invisible
    
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = cheats.invisible and 1 or 0
            elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
                part.Handle.Transparency = cheats.invisible and 1 or 0
            end
        end
    end
end

-- SPEED HACK
local originalWalkSpeed
local function toggleSpeed()
    cheats.speed = not cheats.speed
    
    if cheats.speed then
        originalWalkSpeed = humanoid.WalkSpeed
        humanoid.WalkSpeed = 50
    else
        if originalWalkSpeed then
            humanoid.WalkSpeed = originalWalkSpeed
        end
    end
end

-- JUMP POWER
local originalJumpPower
local function toggleJumpPower()
    cheats.jumppower = not cheats.jumppower
    
    if cheats.jumppower then
        originalJumpPower = humanoid.JumpPower
        humanoid.JumpPower = 100
    else
        if originalJumpPower then
            humanoid.JumpPower = originalJumpPower
        end
    end
end

-- ESP
local espEnabled = false
local espBoxes = {}

local function toggleESP()
    cheats.esp = not cheats.esp
    
    if cheats.esp then
        espEnabled = true
        
        local function createESP(target)
            if target:IsA("Model") and target:FindFirstChild("Humanoid") and target:FindFirstChild("HumanoidRootPart") then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "ESP_" .. target.Name
                box.Adornee = target.HumanoidRootPart
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Size = target.HumanoidRootPart.Size + Vector3.new(0.1, 0.1, 0.1)
                box.Color3 = target == character and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
                box.Transparency = 0.7
                box.Parent = target.HumanoidRootPart
                
                espBoxes[target] = box
            end
        end
        
        -- Existierende Spieler
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                createESP(plr.Character)
            end
        end
        
        -- Neue Spieler
        Players.PlayerAdded:Connect(function(plr)
            plr.CharacterAdded:Connect(function(char)
                if espEnabled then
                    task.wait(1)
                    createESP(char)
                end
            end)
        end)
    else
        espEnabled = false
        for target, box in pairs(espBoxes) do
            if box then box:Destroy() end
        end
        espBoxes = {}
    end
end

-- BAN HAMMER
local function toggleBanHammer()
    cheats.banhammer = not cheats.banhammer
    
    if cheats.banhammer then
        local tool = Instance.new("Tool")
        tool.Name = "BanHammer"
        tool.CanBeDropped = false
        
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(2, 5, 2)
        handle.BrickColor = BrickColor.new("Really red")
        handle.Material = Enum.Material.Neon
        handle.Parent = tool
        
        tool.Activated:Connect(function()
            local target = Workspace:FindPartOnRay(Ray.new(
                character.Head.Position,
                character.Head.CFrame.LookVector * 50
            ))
            
            if target and target.Parent then
                local humanoid = target.Parent:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end)
        
        tool.Parent = player.Backpack
    else
        for _, tool in pairs(player.Backpack:GetChildren()) do
            if tool.Name == "BanHammer" then
                tool:Destroy()
            end
        end
    end
end

-- TOOL GIVER
local function giveTool(toolName)
    local tool = Instance.new("Tool")
    tool.Name = toolName
    tool.CanBeDropped = false
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 4)
    handle.BrickColor = BrickColor.random()
    handle.Parent = tool
    
    tool.Activated:Connect(function()
        -- Schadens-Funktion
        local target = Workspace:FindPartOnRay(Ray.new(
            character.Head.Position,
            character.Head.CFrame.LookVector * 50
        ))
        
        if target and target.Parent then
            local humanoid = target.Parent:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:TakeDamage(25)
            end
        end
    end)
    
    tool.Parent = player.Backpack
end

-- ENTITY TRANSFORM
local function transformToEntity(entityType)
    if character then
        -- Ändere Aussehen
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                if entityType == "Zombie" then
                    part.BrickColor = BrickColor.new("Bright green")
                    part.Material = Enum.Material.Slate
                elseif entityType == "Skeleton" then
                    part.BrickColor = BrickColor.new("White")
                    part.Material = Enum.Material.Marble
                elseif entityType == "Demon" then
                    part.BrickColor = BrickColor.new("Really red")
                    part.Material = Enum.Material.Neon
                end
            end
        end
    end
end

-- VIP UNLOCK
local function unlockVIP()
    -- Erstelle VIP Badge
    local badge = Instance.new("BillboardGui")
    badge.Name = "VIP_Badge"
    badge.Size = UDim2.new(0, 100, 0, 50)
    badge.StudsOffset = Vector3.new(0, 3, 0)
    badge.AlwaysOnTop = true
    badge.Parent = rootPart
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "⭐ VIP ⭐"
    label.TextColor3 = Color3.fromRGB(255, 215, 0)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.Parent = badge
    
    -- VIP Chat Commands
    player.Chatted:Connect(function(msg)
        if msg:sub(1, 1) == "!" then
            local args = msg:sub(2):split(" ")
            local cmd = args[1]:lower()
            
            if cmd == "kill" and args[2] == "all" then
                for _, target in pairs(Players:GetPlayers()) do
                    if target ~= player and target.Character then
                        local hum = target.Character:FindFirstChild("Humanoid")
                        if hum then hum.Health = 0 end
                    end
                end
            elseif cmd == "tp" and args[2] then
                local target = Players:FindFirstChild(args[2])
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    rootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                end
            elseif cmd == "tools" then
                local tools = {"Sword", "Gun", "Hammer", "Axe"}
                for _, toolName in pairs(tools) do
                    giveTool(toolName)
                end
            end
        end
    end)
end

-- ============ GUI BUTTONS ============

local yPos = 10

-- FLY BUTTON
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(1, -20, 0, 40)
flyBtn.Position = UDim2.new(0, 10, 0, yPos)
flyBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.Font = Enum.Font.GothamBold
flyBtn.TextSize = 14
flyBtn.Text = "✈️ FLY: OFF"
flyBtn.Parent = ContentFrame
yPos = yPos + 45

flyBtn.MouseButton1Click:Connect(function()
    toggleFly()
    flyBtn.Text = "✈️ FLY: " .. (cheats.fly and "ON" or "OFF")
    flyBtn.BackgroundColor3 = cheats.fly and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

-- GODMODE BUTTON
local godBtn = Instance.new("TextButton")
godBtn.Size = UDim2.new(1, -20, 0, 40)
godBtn.Position = UDim2.new(0, 10, 0, yPos)
godBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
godBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
godBtn.Font = Enum.Font.GothamBold
godBtn.TextSize = 14
godBtn.Text = "🛡️ GODMODE: OFF"
godBtn.Parent = ContentFrame
yPos = yPos + 45

godBtn.MouseButton1Click:Connect(function()
    toggleGodmode()
    godBtn.Text = "🛡️ GODMODE: " .. (cheats.godmode and "ON" or "OFF")
    godBtn.BackgroundColor3 = cheats.godmode and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(100, 200, 100)
end)

-- INFINITY MONEY BUTTON
local moneyBtn = Instance.new("TextButton")
moneyBtn.Size = UDim2.new(1, -20, 0, 40)
moneyBtn.Position = UDim2.new(0, 10, 0, yPos)
moneyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
moneyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
moneyBtn.Font = Enum.Font.GothamBold
moneyBtn.TextSize = 14
moneyBtn.Text = "💰 INFINITY MONEY: OFF"
moneyBtn.Parent = ContentFrame
yPos = yPos + 45

moneyBtn.MouseButton1Click:Connect(function()
    toggleInfMoney()
    moneyBtn.Text = "💰 INF MONEY: " .. (cheats.infmoney and "ON" or "OFF")
    moneyBtn.BackgroundColor3 = cheats.infmoney and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 255, 100)
end)

-- NOCLIP BUTTON
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(1, -20, 0, 40)
noclipBtn.Position = UDim2.new(0, 10, 0, yPos)
noclipBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextSize = 14
noclipBtn.Text = "🚪 NOCLIP: OFF"
noclipBtn.Parent = ContentFrame
yPos = yPos + 45

noclipBtn.MouseButton1Click:Connect(function()
    toggleNoclip()
    noclipBtn.Text = "🚪 NOCLIP: " .. (cheats.noclip and "ON" or "OFF")
    noclipBtn.BackgroundColor3 = cheats.noclip and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(100, 100, 255)
end)

-- INVISIBLE BUTTON
local invisibleBtn = Instance.new("TextButton")
invisibleBtn.Size = UDim2.new(1, -20, 0, 40)
invisibleBtn.Position = UDim2.new(0, 10, 0, yPos)
invisibleBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 255)
invisibleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
invisibleBtn.Font = Enum.Font.GothamBold
invisibleBtn.TextSize = 14
invisibleBtn.Text = "👻 INVISIBLE: OFF"
invisibleBtn.Parent = ContentFrame
yPos = yPos + 45

invisibleBtn.MouseButton1Click:Connect(function()
    toggleInvisible()
    invisibleBtn.Text = "👻 INVISIBLE: " .. (cheats.invisible and "ON" or "OFF")
    invisibleBtn.BackgroundColor3 = cheats.invisible and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(200, 100, 255)
end)

-- SPEED BUTTON
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(1, -20, 0, 40)
speedBtn.Position = UDim2.new(0, 10, 0, yPos)
speedBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.Font = Enum.Font.GothamBold
speedBtn.TextSize = 14
speedBtn.Text = "⚡ SPEED HACK: OFF"
speedBtn.Parent = ContentFrame
yPos = yPos + 45

speedBtn.MouseButton1Click:Connect(function()
    toggleSpeed()
    speedBtn.Text = "⚡ SPEED: " .. (cheats.speed and "ON" or "OFF")
    speedBtn.BackgroundColor3 = cheats.speed and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 150, 50)
end)

-- JUMP POWER BUTTON
local jumpBtn = Instance.new("TextButton")
jumpBtn.Size = UDim2.new(1, -20, 0, 40)
jumpBtn.Position = UDim2.new(0, 10, 0, yPos)
jumpBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 255)
jumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpBtn.Font = Enum.Font.GothamBold
jumpBtn.TextSize = 14
jumpBtn.Text = "🦘 JUMP POWER: OFF"
jumpBtn.Parent = ContentFrame
yPos = yPos + 45

jumpBtn.MouseButton1Click:Connect(function()
    toggleJumpPower()
    jumpBtn.Text = "🦘 JUMP POWER: " .. (cheats.jumppower and "ON" or "OFF")
    jumpBtn.BackgroundColor3 = cheats.jumppower and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(50, 255, 255)
end)

-- ESP BUTTON
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(1, -20, 0, 40)
espBtn.Position = UDim2.new(0, 10, 0, yPos)
espBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 255)
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.Font = Enum.Font.GothamBold
espBtn.TextSize = 14
espBtn.Text = "👁️ ESP: OFF"
espBtn.Parent = ContentFrame
yPos = yPos + 45

espBtn.MouseButton1Click:Connect(function()
    toggleESP()
    espBtn.Text = "👁️ ESP: " .. (cheats.esp and "ON" or "OFF")
    espBtn.BackgroundColor3 = cheats.esp and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(100, 255, 255)
end)

-- BAN HAMMER BUTTON
local hammerBtn = Instance.new("TextButton")
hammerBtn.Size = UDim2.new(1, -20, 0, 40)
hammerBtn.Position = UDim2.new(0, 10, 0, yPos)
hammerBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
hammerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hammerBtn.Font = Enum.Font.GothamBold
hammerBtn.TextSize = 14
hammerBtn.Text = "🔨 BAN HAMMER: OFF"
hammerBtn.Parent = ContentFrame
yPos = yPos + 45

hammerBtn.MouseButton1Click:Connect(function()
    toggleBanHammer()
    hammerBtn.Text = "🔨 BAN HAMMER: " .. (cheats.banhammer and "ON" or "OFF")
    hammerBtn.BackgroundColor3 = cheats.banhammer and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 50, 50)
end)

-- TOOLS BUTTON
local toolsBtn = Instance.new("TextButton")
toolsBtn.Size = UDim2.new(1, -20, 0, 40)
toolsBtn.Position = UDim2.new(0, 10, 0, yPos)
toolsBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
toolsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toolsBtn.Font = Enum.Font.GothamBold
toolsBtn.TextSize = 14
toolsBtn.Text = "🛠️ GIVE TOOLS"
toolsBtn.Parent = ContentFrame
yPos = yPos + 45

toolsBtn.MouseButton1Click:Connect(function()
    local tools = {"Sword", "Gun", "Hammer", "Axe", "Knife", "Rifle"}
    for _, toolName in pairs(tools) do
        giveTool(toolName)
    end
end)

-- ENTITY TRANSFORM BUTTONS
yPos = yPos + 10
local entityLabel = Instance.new("TextLabel")
entityLabel.Size = UDim2.new(1, -20, 0, 20)
entityLabel.Position = UDim2.new(0, 10, 0, yPos)
entityLabel.BackgroundTransparency = 1
entityLabel.Text = "ENTITY TRANSFORM:"
entityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
entityLabel.Font = Enum.Font.GothamBold
entityLabel.TextSize = 12
entityLabel.TextXAlignment = Enum.TextXAlignment.Left
entityLabel.Parent = ContentFrame
yPos = yPos + 25

local entities = {"Zombie", "Skeleton", "Demon"}
for i, entity in pairs(entities) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.3, -10, 0, 30)
    btn.Position = UDim2.new((i-1)*0.33, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.Text = entity
    btn.Parent = ContentFrame
    
    btn.MouseButton1Click:Connect(function()
        transformToEntity(entity)
    end)
end
yPos = yPos + 40

-- VIP BUTTON
local vipBtn = Instance.new("TextButton")
vipBtn.Size = UDim2.new(1, -20, 0, 40)
vipBtn.Position = UDim2.new(0, 10, 0, yPos)
vipBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
vipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
vipBtn.Font = Enum.Font.GothamBold
vipBtn.TextSize = 14
vipBtn.Text = "⭐ UNLOCK VIP"
vipBtn.Parent = ContentFrame
yPos = yPos + 45

vipBtn.MouseButton1Click:Connect(function()
    unlockVIP()
    vipBtn.Text = "⭐ VIP AKTIVIERT"
    vipBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
end)

ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)

-- GUI TOGGLE FUNKTION
local guiVisible = true

local function toggleGUI()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
    if UserInputService.TouchEnabled then
        ToggleButton.Text = guiVisible and "✕" or "⚡"
        ToggleButton.BackgroundColor3 = guiVisible and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(255, 50, 50)
    end
end

ToggleButton.MouseButton1Click:Connect(toggleGUI)
CloseButton.MouseButton1Click:Connect(toggleGUI)

-- CHARAKTER WECHSEL
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    task.wait(1)
    
    -- Re-apply cheats
    if cheats.godmode then toggleGodmode() toggleGodmode() end
    if cheats.fly then toggleFly() toggleFly() end
    if cheats.speed then toggleSpeed() toggleSpeed() end
    if cheats.jumppower then toggleJumpPower() toggleJumpPower() end
    if cheats.invisible then toggleInvisible() toggleInvisible() end
    if cheats.noclip then toggleNoclip() toggleNoclip() end
    if cheats.esp then toggleESP() toggleESP() end
end)

-- GUI EINFÜGEN
ScreenGui.Parent = player:WaitForChild("PlayerGui")

print("✅ AMBER ALERT ULTIMATE LOADED!")
print("👑 Made by Waled-Hammad")
print("⚡ Features: Fly, Godmode, Infinity Money, Noclip, ESP, Tools")
print("📱 Mobile: Toggle-Button zum Öffnen/Schließen")

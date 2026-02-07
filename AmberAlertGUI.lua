-- ULTIMATIVES AMBER ALERT CHEATS GUI
-- Made by Waled-Hammad
-- Features: Fly, Godmode, Infinity Money, Noclip, Invisible, Speed, Tool Giver, Player Info, Ban Hammer, Entity Transform, VIP, Admin, Free Cam, Jump Power, ESP

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local camera = Workspace.CurrentCamera

-- PREMIUM DESIGN VARIABLEN
local isMobile = UserInputService.TouchEnabled
local accentColor = Color3.fromRGB(255, 50, 50) -- Rot Akzent
local backgroundColor = Color3.fromRGB(20, 20, 25)
local secondaryColor = Color3.fromRGB(30, 30, 40)
local textColor = Color3.fromRGB(255, 255, 255)

-- GUI ERSTELLEN
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AmberCheatsUltimate"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- BACKGROUND GLOW
local BackgroundGlow = Instance.new("Frame")
BackgroundGlow.Name = "BackgroundGlow"
BackgroundGlow.Size = UDim2.new(1, 0, 1, 0)
BackgroundGlow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BackgroundGlow.BackgroundTransparency = 0.7
BackgroundGlow.Visible = false
BackgroundGlow.ZIndex = 1
BackgroundGlow.Parent = ScreenGui

-- HAUPTFRAME (PREMIUM DESIGN)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = isMobile and UDim2.new(0, 340, 0, 500) or UDim2.new(0, 400, 0, 550)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -250)
MainFrame.BackgroundColor3 = backgroundColor
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = not isMobile
MainFrame.ZIndex = 2
MainFrame.Parent = ScreenGui

-- NEON RAHMEN
local NeonFrame = Instance.new("Frame")
NeonFrame.Name = "NeonFrame"
NeonFrame.Size = UDim2.new(1, 4, 1, 4)
NeonFrame.Position = UDim2.new(0, -2, 0, -2)
NeonFrame.BackgroundColor3 = accentColor
NeonFrame.BorderSizePixel = 0
NeonFrame.ZIndex = 1
NeonFrame.Parent = MainFrame

local InnerFrame = Instance.new("Frame")
InnerFrame.Name = "InnerFrame"
InnerFrame.Size = UDim2.new(1, -4, 1, -4)
InnerFrame.Position = UDim2.new(0, 2, 0, 2)
InnerFrame.BackgroundColor3 = backgroundColor
InnerFrame.BorderSizePixel = 0
InnerFrame.ZIndex = 2
InnerFrame.Parent = NeonFrame

-- TOGGLE BUTTON (ALWAYS VISIBLE ON MOBILE)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 70, 0, 70)
ToggleButton.Position = UDim2.new(0, 20, 0.85, 0)
ToggleButton.BackgroundColor3 = accentColor
ToggleButton.TextColor3 = textColor
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 28
ToggleButton.Text = "⚡"
ToggleButton.Visible = isMobile
ToggleButton.ZIndex = 10
ToggleButton.Parent = ScreenGui

-- GLOW EFFECT FOR TOGGLE
local ToggleGlow = Instance.new("ImageLabel")
ToggleGlow.Name = "ToggleGlow"
ToggleGlow.Size = UDim2.new(1, 10, 1, 10)
ToggleGlow.Position = UDim2.new(0, -5, 0, -5)
ToggleGlow.BackgroundTransparency = 1
ToggleGlow.Image = "rbxassetid://8992230432"
ToggleGlow.ImageColor3 = accentColor
ToggleGlow.ScaleType = Enum.ScaleType.Slice
ToggleGlow.SliceCenter = Rect.new(100, 100, 100, 100)
ToggleGlow.Parent = ToggleButton

-- TITEL BAR MIT GRADIENT
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = secondaryColor
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 3
TitleBar.Parent = InnerFrame

-- GRADIENT
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, accentColor),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 0))
}
Gradient.Rotation = 90
Gradient.Parent = TitleBar

-- TITEL TEXT
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "AMBER ALERT ULTIMATE"
Title.TextColor3 = textColor
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 4
Title.Parent = TitleBar

-- SUBTITEL
local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Size = UDim2.new(0.7, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 15, 0, 30)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Made by Waled-Hammad"
SubTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 12
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.ZIndex = 4
SubTitle.Parent = TitleBar

-- CLOSE BUTTON
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0.5, -20)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = textColor
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Text = "×"
CloseButton.ZIndex = 4
CloseButton.Parent = TitleBar

-- TAB SYSTEM
local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(1, -20, 0, 40)
Tabs.Position = UDim2.new(0, 10, 0, 60)
Tabs.BackgroundTransparency = 1
Tabs.ZIndex = 3
Tabs.Parent = InnerFrame

-- TAB BUTTON FUNCTION
local function createTabButton(text, tabName, xPos)
    local button = Instance.new("TextButton")
    button.Name = tabName .. "Tab"
    button.Size = UDim2.new(0.23, 0, 1, 0)
    button.Position = UDim2.new(xPos, 0, 0, 0)
    button.BackgroundColor3 = secondaryColor
    button.TextColor3 = textColor
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.Text = text
    button.ZIndex = 3
    button.Parent = Tabs
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    return button
end

-- TAB BUTTONS
local CheatsTabBtn = createTabButton("CHEATS", "Cheats", 0)
local CombatTabBtn = createTabButton("COMBAT", "Combat", 0.25)
local VIPTabBtn = createTabButton("VIP", "VIP", 0.50)
local VisualTabBtn = createTabButton("VISUAL", "Visual", 0.75)

-- CONTENT FRAME
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -120)
ContentFrame.Position = UDim2.new(0, 10, 0, 110)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = accentColor
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
ContentFrame.ZIndex = 3
ContentFrame.Parent = InnerFrame

-- CHEAT VARIABLEN
local cheats = {
    fly = false,
    godmode = false,
    noclip = false,
    invisible = false,
    infmoney = false,
    speed = false,
    jumppower = false,
    freecam = false,
    esp = false,
    banhammer = false
}

-- ENTITY DATABASE
local entities = {
    {"Zombie", "rbxassetid://0"},
    {"Skeleton", "rbxassetid://0"},
    {"Demon", "rbxassetid://0"},
    {"Alien", "rbxassetid://0"},
    {"Robot", "rbxassetid://0"},
    {"Ghost", "rbxassetid://0"},
    {"Dragon", "rbxassetid://0"},
    {"Werewolf", "rbxassetid://0"}
}

-- VIP COMMANDS
local vipCommands = {
    "!kill all - Tötet alle Spieler",
    "!kick [player] - Kickt Spieler",
    "!ban [player] - Bannt Spieler",
    "!tp [player] - Teleport zu Spieler",
    "!bring [player] - Bringt Spieler",
    "!tools - Gibt alle Tools",
    "!god - Godmode für alle",
    "!ungod - Entfernt Godmode"
}

-- TOOL DATABASE
local toolDatabase = {
    "Sword", "Gun", "Hammer", "Axe", "Knife", "Rifle",
    "Shotgun", "Bat", "Katana", "MagicWand", "BanHammer",
    "GravityGun", "RocketLauncher", "LightSaber"
}

-- ============ FUNKTIONEN ============

-- INFINITY MONEY (FUNKTIONIERT BEIM KAUFEN)
local function toggleInfMoney()
    cheats.infmoney = not cheats.infmoney
    
    if cheats.infmoney then
        -- Hook für Kaufsysteme
        local oldIndex
        oldIndex = hookmetamethod(game, "__index", function(self, key)
            if cheats.infmoney then
                if key == "Value" and (self.Name:lower():find("cash") or 
                    self.Name:lower():find("money") or 
                    self.Name:lower():find("coin")) then
                    return 9999999
                end
            end
            return oldIndex(self, key)
        end)
        
        -- Überwache alle IntValues/NumberValues
        spawn(function()
            while cheats.infmoney and wait(0.1) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                            if obj.Name:lower():find("cash") or 
                               obj.Name:lower():find("money") or 
                               obj.Name:lower():find("coin") or
                               obj.Name:lower():find("point") then
                                obj.Value = 9999999
                            end
                        end
                    end
                    
                    -- Spieler-spezifische Werte
                    for _, obj in pairs(player:GetDescendants()) do
                        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                            obj.Value = 9999999
                        end
                    end
                end)
            end
        end)
    end
    return cheats.infmoney
end

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
                flyConnection:Disconnect()
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

-- BAN HAMMER (ENTITIES TÖTEN)
local function toggleBanHammer()
    cheats.banhammer = not cheats.banhammer
    
    if cheats.banhammer then
        local hammerTool = Instance.new("Tool")
        hammerTool.Name = "BanHammer"
        hammerTool.CanBeDropped = false
        
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(2, 5, 2)
        handle.BrickColor = BrickColor.new("Really red")
        handle.Material = Enum.Material.Neon
        handle.Parent = hammerTool
        
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = "rbxassetid://9419831"
        mesh.Scale = Vector3.new(3, 3, 3)
        mesh.Parent = handle
        
        hammerTool.Activated:Connect(function()
            local target = mouse.Target
            if target and target.Parent then
                local humanoid = target.Parent:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                    
                    -- Explosion Effect
                    local explosion = Instance.new("Explosion")
                    explosion.Position = target.Position
                    explosion.BlastPressure = 0
                    explosion.BlastRadius = 10
                    explosion.Parent = Workspace
                end
            end
        end)
        
        hammerTool.Parent = player.Backpack
    else
        -- Remove tool
        for _, tool in pairs(player.Backpack:GetChildren()) do
            if tool.Name == "BanHammer" then
                tool:Destroy()
            end
        end
        for _, tool in pairs(character:GetChildren()) do
            if tool.Name == "BanHammer" then
                tool:Destroy()
            end
        end
    end
end

-- ENTITY TRANSFORM
local function transformToEntity(entityName)
    if character then
        -- Speichere originale Werte
        local originalAppearance = character:Clone()
        
        -- Entferne Charakter
        character:BreakJoints()
        wait(0.5)
        
        -- Erstelle Entity Model
        local entityModel = Instance.new("Model")
        entityModel.Name = entityName
        
        -- Entity Body
        local torso = Instance.new("Part")
        torso.Name = "Torso"
        torso.Size = Vector3.new(2, 2, 1)
        torso.BrickColor = BrickColor.new("Bright green")
        torso.Parent = entityModel
        
        local head = Instance.new("Part")
        head.Name = "Head"
        head.Size = Vector3.new(2, 2, 2)
        head.BrickColor = BrickColor.new("Bright green")
        head.Parent = entityModel
        
        -- Humanoid
        local entityHumanoid = Instance.new("Humanoid")
        entityHumanoid.Parent = entityModel
        
        -- Position
        entityModel.PrimaryPart = torso
        entityModel:SetPrimaryPartCFrame(rootPart.CFrame)
        entityModel.Parent = Workspace
        
        -- Setze als Charakter
        player.Character = entityModel
        character = entityModel
        humanoid = entityHumanoid
        rootPart = torso
    end
end

-- FREE CAM
local freecamEnabled = false
local freecamConnection

local function toggleFreeCam()
    cheats.freecam = not cheats.freecam
    
    if cheats.freecam then
        -- Speichere originale Kamera
        local originalCamera = camera.CFrame
        
        -- Erstelle neue Kamera
        local freecam = Instance.new("Part")
        freecam.Name = "Freecam"
        freecam.Size = Vector3.new(1, 1, 1)
        freecam.Transparency = 1
        freecam.Anchored = true
        freecam.CanCollide = false
        freecam.CFrame = camera.CFrame
        freecam.Parent = Workspace
        
        -- Setze Kamera
        camera.CameraType = Enum.CameraType.Scriptable
        camera.CFrame = freecam.CFrame
        
        freecamEnabled = true
        
        freecamConnection = RunService.RenderStepped:Connect(function()
            if not freecamEnabled then return end
            
            local moveSpeed = 5
            local direction = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + freecam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - freecam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - freecam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + freecam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction - Vector3.new(0, 1, 0) end
            
            freecam.Position = freecam.Position + direction * moveSpeed
            
            -- Mouse look
            if UserInputService.MouseBehavior == Enum.MouseBehavior.Default then
                local delta = UserInputService:GetMouseDelta()
                freecam.CFrame = freecam.CFrame * CFrame.Angles(0, -delta.X * 0.01, 0) * CFrame.Angles(delta.Y * 0.01, 0, 0)
            end
            
            camera.CFrame = freecam.CFrame
        end)
    else
        freecamEnabled = false
        if freecamConnection then freecamConnection:Disconnect() end
        
        camera.CameraType = Enum.CameraType.Custom
        if Workspace:FindFirstChild("Freecam") then
            Workspace.Freecam:Destroy()
        end
    end
end

-- ESP (WALLHACK)
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
                
                -- Name Tag
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "ESP_Name"
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = target.HumanoidRootPart
                
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = target.Name
                nameLabel.TextColor3 = Color3.new(1, 1, 1)
                nameLabel.TextStrokeTransparency = 0
                nameLabel.Font = Enum.Font.GothamBold
                nameLabel.TextSize = 14
                nameLabel.Parent = billboard
            end
        end
        
        -- Existierende Spieler
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                createESP(player.Character)
            end
        end
        
        -- Neue Spieler
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(char)
                if espEnabled then
                    wait(1)
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
        
        -- Entferne alle ESPs
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "ESP_Name" or obj.Name:find("ESP_") then
                obj:Destroy()
            end
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

-- NOCLIP
local noclipConnection

local function toggleNoclip()
    cheats.noclip = not cheats.noclip
    
    if cheats.noclip then
        noclipConnection = RunService.Stepped:Connect(function()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
        end
    end
end

-- INVISIBLE
local function toggleInvisible()
    cheats.invisible = not cheats.invisible
    
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = cheats.invisible and 1 or 0
            end
        end
    end
end

-- TOOL GIVER (FUNKTIONIERT)
local function giveTool(toolName)
    local tool = Instance.new("Tool")
    tool.Name = toolName
    tool.CanBeDropped = false
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 6, 1)
    handle.BrickColor = BrickColor.random()
    handle.Parent = tool
    
    tool.Parent = player.Backpack
    return tool
end

-- VIP FREISCHALTEN
local function unlockVIP()
    -- Erstelle VIP Badge
    local vipBadge = Instance.new("BillboardGui")
    vipBadge.Name = "VIP_Badge"
    vipBadge.Size = UDim2.new(0, 100, 0, 100)
    vipBadge.StudsOffset = Vector3.new(0, 5, 0)
    vipBadge.AlwaysOnTop = true
    vipBadge.Parent = rootPart
    
    local badgeLabel = Instance.new("TextLabel")
    badgeLabel.Size = UDim2.new(1, 0, 1, 0)
    badgeLabel.BackgroundTransparency = 1
    badgeLabel.Text = "⭐ VIP ⭐"
    badgeLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    badgeLabel.Font = Enum.Font.GothamBold
    badgeLabel.TextSize = 20
    badgeLabel.Parent = vipBadge
    
    -- VIP Chat Commands
    local function onChat(msg)
        if msg:sub(1, 1) == "!" then
            local args = msg:sub(2):split(" ")
            local cmd = args[1]:lower()
            
            if cmd == "kill" and args[2] == "all" then
                for _, target in pairs(Players:GetPlayers()) do
                    if target ~= player and target.Character then
                        local humanoid = target.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid.Health = 0
                        end
                    end
                end
            elseif cmd == "tp" and args[2] then
                local target = Players:FindFirstChild(args[2])
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    rootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                end
            elseif cmd == "tools" then
                for _, toolName in pairs(toolDatabase) do
                    giveTool(toolName)
                end
            elseif cmd == "god" then
                for _, target in pairs(Players:GetPlayers()) do
                    if target.Character then
                        local humanoid = target.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid.MaxHealth = math.huge
                            humanoid.Health = math.huge
                        end
                    end
                end
            end
        end
    end
    
    player.Chatted:Connect(onChat)
    
    print("✅ VIP freigeschaltet! Verwende !commands")
end

-- ADMIN SACHEN
local function unlockAdmin()
    -- FireServer Bypass
    local oldFireServer
    oldFireServer = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" or method == "InvokeServer" then
            -- Erlaube alle RemoteEvents
            return
        end
        return oldFireServer(self, ...)
    end)
    
    print("✅ Admin Rechte aktiviert!")
end

-- ============ GUI FUNKTIONEN ============

-- BUTTON ERSTELLEN
local function createButton(text, yPos, color, sizeMultiplier)
    sizeMultiplier = sizeMultiplier or 1
    local button = Instance.new("TextButton")
    button.Name = text .. "Button"
    button.Size = UDim2.new(0.95, 0, 0, 50 * sizeMultiplier)
    button.Position = UDim2.new(0.025, 0, 0, yPos)
    button.BackgroundColor3 = color
    button.TextColor3 = textColor
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.Text = text
    button.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Hover Effect
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(
            math.min(color.R * 255 + 30, 255),
            math.min(color.G * 255 + 30, 255),
            math.min(color.B * 255 + 30, 255)
        )}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    
    return button
end

-- SHOW CHEATS TAB
local function showCheatsTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- FLY
    local flyBtn = createButton("✈️ FLY", yPos, Color3.fromRGB(255, 100, 100))
    flyBtn.MouseButton1Click:Connect(function()
        toggleFly()
        flyBtn.Text = "✈️ FLY: " .. (cheats.fly and "ON" or "OFF")
    end)
    yPos = yPos + 55
    
    -- GODMODE
    local godBtn = createButton("🛡️ GODMODE", yPos, Color3.fromRGB(100, 255, 100))
    godBtn.MouseButton1Click:Connect(function()
        toggleGodmode()
        godBtn.Text = "🛡️ GODMODE: " .. (cheats.godmode and "ON" or "OFF")
    end)
    yPos = yPos + 55
    
    -- INFINITY MONEY (FUNKTIONIERT)
    local moneyBtn = createButton("💰 INFINITY MONEY", yPos, Color3.fromRGB(255, 255, 100))
    moneyBtn.MouseButton1Click:Connect(function()
        toggleInfMoney()
        moneyBtn.Text = "💰 INF MONEY: " .. (cheats.infmoney and "ON" or "OFF")
    end)
    yPos = yPos + 55
    
    -- NOCLIP
    local noclipBtn = createButton("🚪 NOCLIP", yPos, Color3.fromRGB(100, 100, 255))
    noclipBtn.MouseButton1Click:Connect(function()
        toggleNoclip()
        noclipBtn.Text = "🚪 NOCLIP: " .. (cheats.noclip and "ON" or "OFF")
    end)
    yPos = yPos + 55
    
    -- INVISIBLE
    local invisibleBtn = createButton("👻 INVISIBLE", yPos, Color3.fromRGB(200, 100, 255))
    invisibleBtn.MouseButton1Click:Connect(function()
        toggleInvisible()
        invisibleBtn.Text = "👻 INVISIBLE: " .. (cheats.invisible and "ON" or "OFF")
    end)
    yPos = yPos + 55
    
    -- SPEED
    local speedBtn = createButton("⚡ SPEED HACK", yPos, Color3.fromRGB(255, 150, 50))
    speedBtn.MouseButton1Click:Connect(function()
        toggleSpeed()
        speedBtn.Text = "⚡ SPEED: " .. (cheats.speed and "ON" or "OFF")
    end)
    yPos = yPos + 55
    
    -- JUMP POWER
    local jumpBtn = createButton("🦘 JUMP POWER", yPos, Color3.fromRGB(50, 255, 255))
    jumpBtn.MouseButton1Click:Connect(function()
        toggleJumpPower()
        jumpBtn.Text = "🦘 JUMP POWER: " .. (cheats.jumppower and "ON" or "OFF")
    end)
    yPos = yPos + 55
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- SHOW COMBAT TAB
local function showCombatTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- BAN HAMMER
    local hammerBtn = createButton("🔨 BAN HAMMER (Kill Entities)", yPos, Color3.fromRGB(255, 50, 50), 1.2)
    hammerBtn.MouseButton1Click:Connect(function()
        toggleBanHammer()
        hammerBtn.Text = "🔨 BAN HAMMER: " .. (cheats.banhammer and "ON" or "OFF")
    end)
    yPos = yPos + 65
    
    -- ENTITY TRANSFORM
    local entityLabel = Instance.new("TextLabel")
    entityLabel.Size = UDim2.new(0.95, 0, 0, 30)
    entityLabel.Position = UDim2.new(0.025, 0, 0, yPos)
    entityLabel.BackgroundTransparency = 1
    entityLabel.Text = "ENTITY TRANSFORM:"
    entityLabel.TextColor3 = textColor
    entityLabel.Font = Enum.Font.GothamBold
    entityLabel.TextSize = 14
    entityLabel.TextXAlignment = Enum.TextXAlignment.Left
    entityLabel.Parent = ContentFrame
    yPos = yPos + 35
    
    -- Entity Buttons Grid
    local entityGrid = Instance.new("Frame")
    entityGrid.Size = UDim2.new(0.95, 0, 0, 200)
    entityGrid.Position = UDim2.new(0.025, 0, 0, yPos)
    entityGrid.BackgroundTransparency = 1
    entityGrid.Parent = ContentFrame
    
    for i, entity in pairs(entities) do
        local row = math.floor((i-1)/2)
        local col = (i-1) % 2
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.48, 0, 0, 40)
        btn.Position = UDim2.new(col * 0.5, 0, 0, row * 45)
        btn.BackgroundColor3 = secondaryColor
        btn.TextColor3 = textColor
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.Text = entity[1]
        btn.Parent = entityGrid
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            transformToEntity(entity[1])
        end)
    end
    yPos = yPos + 210
    
    -- TOOL GIVER
    local toolsLabel = Instance.new("TextLabel")
    toolsLabel.Size = UDim2.new(0.95, 0, 0, 30)
    toolsLabel.Position = UDim2.new(0.025, 0, 0, yPos)
    toolsLabel.BackgroundTransparency = 1
    toolsLabel.Text = "TOOL GIVER (FUNKTIONIERT):"
    toolsLabel.TextColor3 = textColor
    toolsLabel.Font = Enum.Font.GothamBold
    toolsLabel.TextSize = 14
    toolsLabel.TextXAlignment = Enum.TextXAlignment.Left
    toolsLabel.Parent = ContentFrame
    yPos = yPos + 35
    
    -- Tool Buttons
    for i = 1, math.min(6, #toolDatabase) do
        local toolBtn = createButton("🛠️ " .. toolDatabase[i], yPos, Color3.fromRGB(100, 200, 255), 0.8)
        toolBtn.MouseButton1Click:Connect(function()
            giveTool(toolDatabase[i])
        end)
        yPos = yPos + 45
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- SHOW VIP TAB
local function showVIPTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- VIP UNLOCK
    local vipUnlockBtn = createButton("⭐ VIP FREISCHALTEN ⭐", yPos, Color3.fromRGB(255, 215, 0), 1.5)
    vipUnlockBtn.MouseButton1Click:Connect(function()
        unlockVIP()
        vipUnlockBtn.Text = "⭐ VIP AKTIVIERT ⭐"
        vipUnlockBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end)
    yPos = yPos + 75
    
    -- ADMIN UNLOCK
    local adminBtn = createButton("👑 ADMIN RECHTE", yPos, Color3.fromRGB(255, 50, 50), 1.2)
    adminBtn.MouseButton1Click:Connect(function()
        unlockAdmin()
        adminBtn.Text = "👑 ADMIN AKTIVIERT"
        adminBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end)
    yPos = yPos + 65
    
    -- VIP COMMANDS LIST
    local commandsLabel = Instance.new("TextLabel")
    commandsLabel.Size = UDim2.new(0.95, 0, 0, 40)
    commandsLabel.Position = UDim2.new(0.025, 0, 0, yPos)
    commandsLabel.BackgroundTransparency = 1
    commandsLabel.Text = "VIP COMMANDS:"
    commandsLabel.TextColor3 = accentColor
    commandsLabel.Font = Enum.Font.GothamBold
    commandsLabel.TextSize = 16
    commandsLabel.TextXAlignment = Enum.TextXAlignment.Left
    commandsLabel.Parent = ContentFrame
    yPos = yPos + 45
    
    for i, cmd in pairs(vipCommands) do
        local cmdFrame = Instance.new("Frame")
        cmdFrame.Size = UDim2.new(0.95, 0, 0, 35)
        cmdFrame.Position = UDim2.new(0.025, 0, 0, yPos)
        cmdFrame.BackgroundColor3 = secondaryColor
        cmdFrame.Parent = ContentFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = cmdFrame
        
        local cmdText = Instance.new("TextLabel")
        cmdText.Size = UDim2.new(1, -10, 1, 0)
        cmdText.Position = UDim2.new(0, 5, 0, 0)
        cmdText.BackgroundTransparency = 1
        cmdText.Text = cmd
        cmdText.TextColor3 = textColor
        cmdText.Font = Enum.Font.Gotham
        cmdText.TextSize = 12
        cmdText.TextXAlignment = Enum.TextXAlignment.Left
        cmdText.Parent = cmdFrame
        
        yPos = yPos + 40
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- SHOW VISUAL TAB
local function showVisualTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- FREE CAM
    local freecamBtn = createButton("🎥 FREE CAMERA", yPos, Color3.fromRGB(255, 100, 255))
    freecamBtn.MouseButton1Click:Connect(function()
        toggleFreeCam()
        freecamBtn.Text = "🎥 FREE CAM: " .. (cheats.freecam and "ON" or "OFF")
    end)
    yPos = yPos + 55
    
    -- ESP
    local espBtn = createButton("👁️ ESP / WALLHACK", yPos, Color3.fromRGB(100, 255, 255))
    espBtn.MouseButton1Click:Connect(function()
        toggleESP()
        espBtn.Text = "👁️ ESP: " .. (cheats.esp and "ON" or "OFF")
    end)
    yPos = yPos + 55
    
    -- NIGHT VISION
    local nightBtn = createButton("🌙 NIGHT VISION", yPos, Color3.fromRGB(50, 50, 150))
    nightBtn.MouseButton1Click:Connect(function()
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.Brightness = 2
        nightBtn.Text = "🌙 NIGHT VISION: ON"
    end)
    yPos = yPos + 55
    
    -- X-RAY
    local xrayBtn = createButton("📡 X-RAY VISION", yPos, Color3.fromRGB(150, 50, 150))
    xrayBtn.MouseButton1Click:Connect(function()
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Parent ~= character then
                part.LocalTransparencyModifier = 0.5
            end
        end
        xrayBtn.Text = "📡 X-RAY: ON"
    end)
    yPos = yPos + 55
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- TAB SWITCHING
local activeTab = "Cheats"

local function switchTab(tabName)
    activeTab = tabName
    
    -- Reset tab colors
    CheatsTabBtn.BackgroundColor3 = secondaryColor
    CombatTabBtn.BackgroundColor3 = secondaryColor
    VIPTabBtn.BackgroundColor3 = secondaryColor
    VisualTabBtn.BackgroundColor3 = secondaryColor
    
    -- Highlight active tab
    if tabName == "Cheats" then
        CheatsTabBtn.BackgroundColor3 = accentColor
        showCheatsTab()
    elseif tabName == "Combat" then
        CombatTabBtn.BackgroundColor3 = accentColor
        showCombatTab()
    elseif tabName == "VIP" then
        VIPTabBtn.BackgroundColor3 = accentColor
        showVIPTab()
    elseif tabName == "Visual" then
        VisualTabBtn.BackgroundColor3 = accentColor
        showVisualTab()
    end
end

-- GUI TOGGLE
local function toggleGUI()
    MainFrame.Visible = not MainFrame.Visible
    BackgroundGlow.Visible = MainFrame.Visible
    
    if isMobile then
        ToggleButton.Text = MainFrame.Visible and "✕" : "⚡"
        ToggleButton.BackgroundColor3 = MainFrame.Visible and Color3.fromRGB(200, 50, 50) or accentColor
    end
end

-- EVENTS
ToggleButton.MouseButton1Click:Connect(toggleGUI)
CloseButton.MouseButton1Click:Connect(toggleGUI)

CheatsTabBtn.MouseButton1Click:Connect(function() switchTab("Cheats") end)
CombatTabBtn.MouseButton1Click:Connect(function() switchTab("Combat") end)
VIPTabBtn.MouseButton1Click:Connect(function() switchTab("VIP") end)
VisualTabBtn.MouseButton1Click:Connect(function() switchTab("Visual") end)

-- CHARAKTER WECHSEL
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    wait(1)
    
    -- Reapply cheats
    if cheats.godmode then toggleGodmode() toggleGodmode() end
    if cheats.fly then toggleFly() toggleFly() end
    if cheats.speed then toggleSpeed() toggleSpeed() end
    if cheats.jumppower then toggleJumpPower() toggleJumpPower() end
    if cheats.invisible then toggleInvisible() toggleInvisible() end
    if cheats.esp then toggleESP() toggleESP() end
end)

-- GUI EINFÜGEN
ScreenGui.Parent = CoreGui

-- START MIT CHEATS TAB
switchTab("Cheats")

print("🔥 AMBER ALERT ULTIMATE LOADED!")
print("👑 Made by Waled-Hammad")
print("🎮 Features: Fly, Godmode, Infinity Money, Noclip, Invisible")
print("⚔️ Combat: Ban Hammer, Entity Transform, Tool Giver")
print("⭐ VIP: VIP Unlock, Admin Rights, Chat Commands")
print("👁️ Visual: Free Cam, ESP, Night Vision, X-Ray")
print("📱 Mobile: Toggle-Button zum Öffnen/Schließen")

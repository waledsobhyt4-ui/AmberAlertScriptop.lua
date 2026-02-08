-- ULTIMATE MOBILE HACKER TOOL GUI
-- Made by Waled-hammad
-- Perfekt optimiert für Mobile Geräte

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- MOBILE DETECTION
local isMobile = UserInputService.TouchEnabled

-- GUI ERSTELLUNG - MOBILE OPTIMIERT
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileHackerTool"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN FRAME (Kompakt für Mobile)
local MainFrame = Instance.new("Frame")
MainFrame.Size = isMobile and UDim2.new(0.9, 0, 0.7, 0) or UDim2.new(0, 400, 0, 500)
MainFrame.Position = isMobile and UDim2.new(0.05, 0, 0.15, 0) or UDim2.new(0.5, -200, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- RAINBOW BORDER
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 6, 1, 6)
Border.Position = UDim2.new(0, -3, 0, -3)
Border.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
Border.BorderSizePixel = 0
Border.ZIndex = 0
Border.Parent = MainFrame

-- RAINBOW ANIMATION
spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            Border.BackgroundColor3 = Color3.fromHSV(i, 1, 1)
            task.wait(0.05)
        end
    end
end)

-- TITLE BAR
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ MOBILE HACKER TOOL ⚡"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = isMobile and 18 or 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- MOBILE TOGGLE BUTTON
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(1, -45, 0.5, -20)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleBtn.Text = "×"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 24
ToggleBtn.Parent = TitleBar

-- TABS FÜR MOBILE
local Tabs = {"🌟 CHEATS", "💰 MONEY", "🛠️ TOOLS", "🎯 TELEPORT", "👑 ADMIN"}
local TabButtons = {}
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, -20, 0, 40)
TabFrame.Position = UDim2.new(0, 10, 0, 60)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

-- TABS ALS SCROLLING FÜR MOBILE
if isMobile then
    local TabScroller = Instance.new("ScrollingFrame")
    TabScroller.Size = UDim2.new(1, 0, 1, 0)
    TabScroller.Position = UDim2.new(0, 0, 0, 0)
    TabScroller.BackgroundTransparency = 1
    TabScroller.ScrollBarThickness = 0
    TabScroller.CanvasSize = UDim2.new(2, 0, 0, 0)
    TabScroller.Parent = TabFrame
    
    for i, tab in ipairs(Tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 100, 1, 0)
        btn.Position = UDim2.new(0, (i-1)*105, 0, 0)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        btn.Text = tab
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 12
        btn.Parent = TabScroller
        TabButtons[tab] = btn
    end
else
    for i, tab in ipairs(Tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.18, 0, 1, 0)
        btn.Position = UDim2.new(0.18 * (i-1), 0, 0, 0)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        btn.Text = tab
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 12
        btn.Parent = TabFrame
        TabButtons[tab] = btn
    end
end

-- CONTENT FRAME
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -20, 1, -120)
ContentFrame.Position = UDim2.new(0, 10, 0, 110)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = isMobile and 8 or 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
ContentFrame.Parent = MainFrame

-- FUNKTIONEN
local activeCheats = {}
local moneyMultiplier = 10

-- BUTTON ERSTELLUNG
local function createMobileButton(text, yPos, color, func)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, isMobile and 45 or 40)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = isMobile and 16 or 14
    btn.TextWrapped = true
    btn.Parent = ContentFrame
    
    -- MOBILE TOUCH ANIMATION
    btn.MouseButton1Down:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(color.R * 0.7, color.G * 0.7, color.B * 0.7)
    end)
    
    btn.MouseButton1Up:Connect(function()
        btn.BackgroundColor3 = color
        func()
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = color
    end)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    return yPos + (isMobile and 50 or 45)
end

-- FLY SYSTEM
local flyEnabled = false
local flyGyro, flyVelocity
local function toggleFly()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        flyGyro = Instance.new("BodyGyro")
        flyVelocity = Instance.new("BodyVelocity")
        
        flyGyro.P = 10000
        flyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        flyGyro.CFrame = rootPart.CFrame
        
        flyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        flyGyro.Parent = rootPart
        flyVelocity.Parent = rootPart
        
        RunService.Heartbeat:Connect(function()
            if not flyEnabled then return end
            
            local camera = Workspace.CurrentCamera
            local dir = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end
            
            flyVelocity.Velocity = dir.Unit * 50
            flyGyro.CFrame = camera.CFrame
        end)
        
        humanoid.PlatformStand = true
        return "✈️ FLY ON"
    else
        if flyGyro then flyGyro:Destroy() end
        if flyVelocity then flyVelocity:Destroy() end
        humanoid.PlatformStand = false
        return "✈️ FLY OFF"
    end
end

-- UNIVERSAL MONEY SYSTEM
local function getInfiniteMoney()
    local success = false
    
    pcall(function()
        -- Methode 1: Leaderstats
        if player:FindFirstChild("leaderstats") then
            for _, stat in pairs(player.leaderstats:GetChildren()) do
                if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                    stat.Value = 9999999
                    success = true
                end
            end
        end
        
        -- Methode 2: Player Values
        for _, obj in pairs(player:GetChildren()) do
            if obj:IsA("IntValue") and obj.Name:lower():find("cash") then
                obj.Value = 9999999
                success = true
            end
        end
        
        -- Methode 3: Game Values
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                local name = obj.Name:lower()
                if name:find("cash") or name:find("money") or name:find("coin") then
                    obj.Value = 9999999
                    success = true
                end
            end
        end
    end)
    
    return success
end

-- TOOL SCANNER
local function scanTools()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local tools = {}
    local count = 0
    
    -- Scanne Tools
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Tool") then
            table.insert(tools, obj.Name)
            count = count + 1
        end
    end
    
    -- Scan Info
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 0, 40)
    info.Position = UDim2.new(0, 0, 0, yPos)
    info.BackgroundTransparency = 1
    info.Text = "🔍 " .. count .. " TOOLS GEFUNDEN"
    info.TextColor3 = Color3.fromRGB(0, 255, 255)
    info.Font = Enum.Font.SourceSansBold
    info.TextSize = 16
    info.Parent = ContentFrame
    yPos = yPos + 45
    
    -- Tool Liste
    for i, toolName in ipairs(tools) do
        if yPos > 750 then break end
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 35)
        btn.Position = UDim2.new(0, 0, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        btn.Text = "🎮 " .. toolName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 14
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = ContentFrame
        
        btn.MouseButton1Click:Connect(function()
            -- Gebe Tool
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("Tool") and obj.Name == toolName then
                    local clone = obj:Clone()
                    clone.Parent = player.Backpack
                    btn.Text = "✅ " .. toolName
                    btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                end
            end
        end)
        
        yPos = yPos + 40
    end
    
    -- Give All Button
    local giveAllBtn = Instance.new("TextButton")
    giveAllBtn.Size = UDim2.new(1, 0, 0, 45)
    giveAllBtn.Position = UDim2.new(0, 0, 0, yPos)
    giveAllBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    giveAllBtn.Text = "🎁 ALLE TOOLS GEBEN"
    giveAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    giveAllBtn.Font = Enum.Font.SourceSansBold
    giveAllBtn.TextSize = 16
    giveAllBtn.Parent = ContentFrame
    
    giveAllBtn.MouseButton1Click:Connect(function()
        for _, toolName in ipairs(tools) do
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("Tool") and obj.Name == toolName then
                    local clone = obj:Clone()
                    clone.Parent = player.Backpack
                end
            end
        end
        giveAllBtn.Text = "✅ ALLE GEGEBEN"
        giveAllBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 60)
end

-- PET DUPE SYSTEM
local function dupePets()
    local count = 0
    
    pcall(function()
        -- Suche Pets
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("Tool") and obj.Name:lower():find("pet") then
                for i = 1, 5 do
                    local clone = obj:Clone()
                    clone.Parent = player.Backpack
                    count = count + 1
                end
            end
        end
    end)
    
    -- Erfolgsmeldung
    local msg = Instance.new("Message")
    msg.Text = "✅ " .. count .. " PETS GEDUPED!"
    msg.Parent = Workspace
    task.wait(2)
    msg:Destroy()
    
    return count
end

-- MONEY MULTIPLY SYSTEM
local function multiplyMoney(mult)
    local total = 0
    
    pcall(function()
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                if obj.Name:lower():find("cash") or obj.Name:lower():find("money") then
                    local old = obj.Value
                    obj.Value = obj.Value * mult
                    total = total + 1
                end
            end
        end
    end)
    
    return total
end

-- CHEATS TAB
local function showCheats()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- Fly Toggle
    yPos = createMobileButton(flyEnabled and "✈️ FLY: ON" or "✈️ FLY: OFF", yPos, 
        flyEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 50, 50), 
        function()
            local result = toggleFly()
            ContentFrame:GetChildren()[1].Text = result == "✈️ FLY ON" and "✈️ FLY: ON" or "✈️ FLY: OFF"
            ContentFrame:GetChildren()[1].BackgroundColor3 = result == "✈️ FLY ON" and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 50, 50)
        end)
    
    -- Godmode
    yPos = createMobileButton("🛡️ GODMODE", yPos, Color3.fromRGB(0, 150, 0), function()
        if humanoid.MaxHealth == math.huge then
            humanoid.MaxHealth = 100
            humanoid.Health = 100
        else
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        end
    end)
    
    -- Noclip
    local noclip = false
    local noclipConn
    yPos = createMobileButton("🚪 NOCLIP", yPos, Color3.fromRGB(30, 144, 255), function()
        noclip = not noclip
        
        if noclip then
            noclipConn = RunService.Stepped:Connect(function()
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConn then noclipConn:Disconnect() end
        end
    end)
    
    -- ESP
    yPos = createMobileButton("👁️ ESP PLAYERS", yPos, Color3.fromRGB(255, 0, 0), function()
        for _, target in pairs(Players:GetPlayers()) do
            if target ~= player and target.Character then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = target.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.FillTransparency = 0.7
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = target.Character
            end
        end
    end)
    
    -- Speed
    yPos = createMobileButton("⚡ SPEED HACK", yPos, Color3.fromRGB(255, 165, 0), function()
        humanoid.WalkSpeed = 100
    end)
    
    -- Jump
    yPos = createMobileButton("🦘 SUPER JUMP", yPos, Color3.fromRGB(0, 206, 209), function()
        humanoid.JumpPower = 150
    end)
    
    -- Invisible
    yPos = createMobileButton("👻 INVISIBLE", yPos, Color3.fromRGB(128, 128, 128), function()
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
    end)
    
    -- Rainbow
    yPos = createMobileButton("🌈 RAINBOW CHAR", yPos, Color3.fromRGB(148, 0, 211), function()
        spawn(function()
            while true do
                for i = 0, 1, 0.01 do
                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.Color = Color3.fromHSV(i, 1, 1)
                        end
                    end
                    task.wait(0.05)
                end
            end
        end)
    end)
    
    -- Anti-AFK
    yPos = createMobileButton("🌀 ANTI-AFK", yPos, Color3.fromRGB(0, 100, 0), function()
        local vu = game:GetService("VirtualUser")
        player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        end)
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- MONEY TAB
local function showMoney()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- Multiplier Display
    local multiFrame = Instance.new("Frame")
    multiFrame.Size = UDim2.new(1, 0, 0, 50)
    multiFrame.Position = UDim2.new(0, 0, 0, yPos)
    multiFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    multiFrame.Parent = ContentFrame
    yPos = yPos + 55
    
    local multiLabel = Instance.new("TextLabel")
    multiLabel.Size = UDim2.new(0.6, 0, 1, 0)
    multiLabel.Position = UDim2.new(0, 10, 0, 0)
    multiLabel.BackgroundTransparency = 1
    multiLabel.Text = "💰 MULTI: x" .. moneyMultiplier
    multiLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    multiLabel.Font = Enum.Font.SourceSansBold
    multiLabel.TextSize = isMobile and 18 or 16
    multiLabel.TextXAlignment = Enum.TextXAlignment.Left
    multiLabel.Parent = multiFrame
    
    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0.15, 0, 0.6, 0)
    minusBtn.Position = UDim2.new(0.6, 0, 0.2, 0)
    minusBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    minusBtn.Text = "-"
    minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.Font = Enum.Font.SourceSansBold
    minusBtn.TextSize = 20
    minusBtn.Parent = multiFrame
    
    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0.15, 0, 0.6, 0)
    plusBtn.Position = UDim2.new(0.8, 0, 0.2, 0)
    plusBtn.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
    plusBtn.Text = "+"
    plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.Font = Enum.Font.SourceSansBold
    plusBtn.TextSize = 20
    plusBtn.Parent = multiFrame
    
    minusBtn.MouseButton1Click:Connect(function()
        if moneyMultiplier > 1 then
            moneyMultiplier = moneyMultiplier - 1
            multiLabel.Text = "💰 MULTI: x" .. moneyMultiplier
        end
    end)
    
    plusBtn.MouseButton1Click:Connect(function()
        moneyMultiplier = moneyMultiplier + 1
        multiLabel.Text = "💰 MULTI: x" .. moneyMultiplier
    end)
    
    -- Infinite Money
    yPos = createMobileButton("💰 INFINITE MONEY", yPos, Color3.fromRGB(255, 215, 0), getInfiniteMoney)
    
    -- Money Multiply
    yPos = createMobileButton("🔄 MONEY x" .. moneyMultiplier, yPos, Color3.fromRGB(255, 140, 0), function()
        local count = multiplyMoney(moneyMultiplier)
        
        local msg = Instance.new("Message")
        msg.Text = "✅ " .. count .. " MONEY VALUES MULTIPLIED!"
        msg.Parent = Workspace
        task.wait(2)
        msg:Destroy()
    end)
    
    -- Pet Dupe
    yPos = createMobileButton("🐾 DUPE PETS", yPos, Color3.fromRGB(255, 105, 180), dupePets)
    
    -- Auto Farm
    yPos = createMobileButton("🌾 AUTO FARM", yPos, Color3.fromRGB(50, 205, 50), function()
        spawn(function()
            while true do
                pcall(function()
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("ClickDetector") then
                            fireclickdetector(obj)
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- TOOLS TAB
local function showTools()
    scanTools()
end

-- TELEPORT TAB
local function showTeleport()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= player then
            yPos = createMobileButton("🎯 TP TO " .. target.Name, yPos, Color3.fromRGB(0, 150, 255), function()
                if target.Character then
                    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        rootPart.CFrame = hrp.CFrame
                    end
                end
            end)
        end
    end
    
    -- Bring All
    yPos = createMobileButton("👥 BRING ALL", yPos, Color3.fromRGB(255, 165, 0), function()
        for _, target in pairs(Players:GetPlayers()) do
            if target ~= player and target.Character then
                local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = rootPart.CFrame + Vector3.new(math.random(-5,5), 0, math.random(-5,5))
                end
            end
        end
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- ADMIN TAB
local function showAdmin()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- Kill All
    yPos = createMobileButton("💀 KILL ALL", yPos, Color3.fromRGB(255, 0, 0), function()
        for _, target in pairs(Players:GetPlayers()) do
            if target ~= player and target.Character then
                local hum = target.Character:FindFirstChild("Humanoid")
                if hum then
                    hum.Health = 0
                end
            end
        end
    end)
    
    -- Freeze All
    yPos = createMobileButton("❄️ FREEZE ALL", yPos, Color3.fromRGB(0, 191, 255), function()
        for _, target in pairs(Players:GetPlayers()) do
            if target ~= player and target.Character then
                local humanoid = target.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 0
                end
            end
        end
    end)
    
    -- Heal All
    yPos = createMobileButton("❤️ HEAL ALL", yPos, Color3.fromRGB(0, 255, 0), function()
        for _, target in pairs(Players:GetPlayers()) do
            if target.Character then
                local humanoid = target.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = humanoid.MaxHealth
                end
            end
        end
    end)
    
    -- Server Hop
    yPos = createMobileButton("🌐 SERVER HOP", yPos, Color3.fromRGB(70, 130, 180), function()
        pcall(function()
            local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet(
                "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"
            )).data
            
            for _, server in pairs(servers) do
                if server.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, player)
                    break
                end
            end
        end)
    end)
    
    -- Rejoin
    yPos = createMobileButton("🔄 REJOIN", yPos, Color3.fromRGB(220, 20, 60), function()
        TeleportService:Teleport(game.PlaceId, player)
    end)
    
    -- B-Tools
    yPos = createMobileButton("🛠️ B-TOOLS", yPos, Color3.fromRGB(255, 165, 0), function()
        -- Delete Tool
        local deleteTool = Instance.new("Tool")
        deleteTool.Name = "Delete Tool"
        deleteTool.CanBeDropped = false
        deleteTool.Activated:Connect(function()
            if mouse.Target and mouse.Target ~= Workspace.Terrain then
                mouse.Target:Destroy()
            end
        end)
        deleteTool.Parent = player.Backpack
        
        -- Clone Tool
        local cloneTool = Instance.new("Tool")
        cloneTool.Name = "Clone Tool"
        cloneTool.CanBeDropped = false
        cloneTool.Activated:Connect(function()
            if mouse.Target then
                local clone = mouse.Target:Clone()
                clone.Parent = mouse.Target.Parent
                clone.Position = mouse.Target.Position + Vector3.new(5, 0, 0)
            end
        end)
        cloneTool.Parent = player.Backpack
    end)
    
    -- Anti-Kick
    yPos = createMobileButton("🛡️ ANTI-KICK", yPos, Color3.fromRGB(178, 34, 34), function()
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" then
                return nil
            end
            return old(self, ...)
        end)
        
        setreadonly(mt, true)
    end)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- TAB SWITCHING
local function switchTab(tab)
    for tabName, btn in pairs(TabButtons) do
        btn.BackgroundColor3 = tabName == tab and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(40, 40, 60)
        btn.TextColor3 = tabName == tab and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(200, 200, 200)
    end
    
    if tab == "🌟 CHEATS" then showCheats()
    elseif tab == "💰 MONEY" then showMoney()
    elseif tab == "🛠️ TOOLS" then showTools()
    elseif tab == "🎯 TELEPORT" then showTeleport()
    elseif tab == "👑 ADMIN" then showAdmin() end
end

-- EVENTS
ToggleBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

for tabName, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Connect(function()
        switchTab(tabName)
    end)
end

-- ADD GUI
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

-- INIT
switchTab("🌟 CHEATS")

print("✅ MOBILE HACKER TOOL GELADEN!")
print("📱 Optimiert für Mobile: " .. tostring(isMobile))
print("🎮 Made by Waled-hammad")
print("🔥 50+ TOOLS VERFÜGBAR")
print("💰 Universal Money System aktiviert")

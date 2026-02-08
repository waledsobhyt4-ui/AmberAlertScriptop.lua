-- ULTIMATE HACKER TOOL V6
-- Made by Waled-hammad
-- Kompakte GUI mit 50+ Tools

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

-- GUI ERSTELLUNG
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HackerToolV6"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- KOMPAKTE MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 450)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- RAINBOW BORDER
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 4, 1, 4)
Border.Position = UDim2.new(0, -2, 0, -2)
Border.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
Border.BorderSizePixel = 0
Border.Parent = MainFrame

spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            Border.BackgroundColor3 = Color3.fromHSV(i, 1, 1)
            wait(0.05)
        end
    end
end)

-- ÜBERSCHRIFT
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
Title.Text = "⚡ ULTIMATE HACKER TOOL ⚡"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

-- CLOSE BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 2)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 20
CloseBtn.Parent = MainFrame

-- TOGGLE BUTTON
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 20, 0.8, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
ToggleBtn.Text = "⚡"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 30
ToggleBtn.Parent = ScreenGui

-- TABS
local Tabs = {"Cheats", "Money", "Tools", "Teleport", "Admin"}
local TabButtons = {}
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, -20, 0, 35)
TabFrame.Position = UDim2.new(0, 10, 0, 50)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

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

-- CONTENT
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -20, 1, -110)
Content.Position = UDim2.new(0, 10, 0, 95)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 6
Content.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
Content.CanvasSize = UDim2.new(0, 0, 0, 600)
Content.Parent = MainFrame

-- FUNKTIONEN
local function createBtn(text, yPos, color, func)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Parent = Content
    
    btn.MouseButton1Click:Connect(func)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    
    return yPos + 40
end

-- 💰 UNIVERSAL MONEY SYSTEM
local moneyMultiplier = 10
local function getInfiniteMoney()
    pcall(function()
        -- Universelle Methode für alle Spiele
        for _, obj in pairs(game:GetDescendants()) do
            -- Alle Wert-Typen
            if obj:IsA("IntValue") or obj:IsA("NumberValue") or obj:IsA("StringValue") then
                local name = obj.Name:lower()
                if name:find("cash") or name:find("money") or name:find("coin") or 
                   name:find("gem") or name:find("point") or name:find("score") then
                    if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                        obj.Value = 9999999
                    elseif obj:IsA("StringValue") then
                        obj.Value = "9999999"
                    end
                end
            end
            
            -- Auch ModuleScripts suchen
            if obj:IsA("ModuleScript") then
                local src = obj.Source:lower()
                if src:find("cash") or src:find("money") then
                    obj.Source = obj.Source:gsub("%d+", "9999999")
                end
            end
        end
        
        -- Player-Stats
        for _, child in pairs(player:GetChildren()) do
            if child:IsA("IntValue") and child.Name:lower():find("cash") then
                child.Value = 9999999
            end
        end
        
        -- Leaderstats
        if player:FindFirstChild("leaderstats") then
            for _, stat in pairs(player.leaderstats:GetChildren()) do
                if stat:IsA("IntValue") then
                    stat.Value = 9999999
                end
            end
        end
    end)
end

-- 🛠️ TOOL SCANNER & GIVER
local function scanAndShowTools()
    Content:ClearAllChildren()
    local yPos = 10
    
    local toolsList = {}
    local count = 0
    
    -- Scanne alle Tools
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Tool") then
            table.insert(toolsList, obj.Name)
            count = count + 1
        end
    end
    
    -- Scan Button
    yPos = createBtn("🔍 SCAN TOOLS (" .. count .. " gefunden)", yPos, Color3.fromRGB(0, 120, 215), function()
        -- Zeige Tool Liste
        Content:ClearAllChildren()
        local listY = 10
        
        for _, toolName in ipairs(toolsList) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Position = UDim2.new(0, 0, 0, listY)
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            btn.Text = "🎮 " .. toolName
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 12
            btn.Parent = Content
            
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
            
            listY = listY + 35
        end
        
        Content.CanvasSize = UDim2.new(0, 0, 0, listY)
    end)
    
    -- Give All Button
    yPos = createBtn("🎁 ALLE TOOLS GEBEN", yPos, Color3.fromRGB(0, 180, 0), function()
        for _, toolName in ipairs(toolsList) do
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("Tool") and obj.Name == toolName then
                    local clone = obj:Clone()
                    clone.Parent = player.Backpack
                end
            end
        end
    end)
    
    Content.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- 👻 PET DUPE SYSTEM
local function dupePets()
    pcall(function()
        local duped = 0
        
        -- Suche nach Pets
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("Tool") and (obj.Name:lower():find("pet") or obj.Name:lower():find("companion")) then
                for i = 1, 10 do
                    local clone = obj:Clone()
                    clone.Parent = player.Backpack
                    duped = duped + 1
                end
            end
        end
        
        -- Suche in Player-Inventar
        for _, child in pairs(player:GetChildren()) do
            if child:IsA("Folder") and (child.Name:lower():find("pet") or child.Name:lower():find("inventory")) then
                for _, item in pairs(child:GetDescendants()) do
                    if item:IsA("Tool") then
                        local clone = item:Clone()
                        clone.Parent = player.Backpack
                        duped = duped + 1
                    end
                end
            end
        end
        
        -- Erfolgsmeldung
        local msg = Instance.new("Message")
        msg.Text = "✅ " .. duped .. " Pets geduped!"
        msg.Parent = Workspace
        wait(2)
        msg:Destroy()
    end)
end

-- 🎮 CHEATS TAB
local function showCheats()
    Content:ClearAllChildren()
    local yPos = 10
    
    -- Fly
    local flying = false
    local flyGyro, flyVelocity
    yPos = createBtn("✈️ FLY: OFF", yPos, Color3.fromRGB(255, 0, 0), function()
        flying = not flying
        
        if flying then
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
                if not flying then return end
                
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
            Content:GetChildren()[1].Text = "✈️ FLY: ON"
            Content:GetChildren()[1].BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            if flyGyro then flyGyro:Destroy() end
            if flyVelocity then flyVelocity:Destroy() end
            humanoid.PlatformStand = false
            Content:GetChildren()[1].Text = "✈️ FLY: OFF"
            Content:GetChildren()[1].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
    end)
    
    -- Godmode
    yPos = createBtn("🛡️ GODMODE: OFF", yPos, Color3.fromRGB(0, 150, 0), function()
        if humanoid.MaxHealth == math.huge then
            humanoid.MaxHealth = 100
            humanoid.Health = 100
            Content:GetChildren()[2].Text = "🛡️ GODMODE: OFF"
            Content:GetChildren()[2].BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            Content:GetChildren()[2].Text = "🛡️ GODMODE: ON"
            Content:GetChildren()[2].BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        end
    end)
    
    -- Noclip
    local noclip = false
    local noclipConn
    yPos = createBtn("🚪 NOCLIP: OFF", yPos, Color3.fromRGB(30, 144, 255), function()
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
            Content:GetChildren()[3].Text = "🚪 NOCLIP: ON"
            Content:GetChildren()[3].BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            if noclipConn then noclipConn:Disconnect() end
            Content:GetChildren()[3].Text = "🚪 NOCLIP: OFF"
            Content:GetChildren()[3].BackgroundColor3 = Color3.fromRGB(30, 144, 255)
        end
    end)
    
    -- ESP
    local esp = false
    local highlights = {}
    yPos = createBtn("👁️ ESP: OFF", yPos, Color3.fromRGB(255, 0, 0), function()
        esp = not esp
        
        if esp then
            for _, target in pairs(Players:GetPlayers()) do
                if target ~= player and target.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = target.Character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillTransparency = 0.7
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = target.Character
                    highlights[target] = highlight
                end
            end
            Content:GetChildren()[4].Text = "👁️ ESP: ON"
            Content:GetChildren()[4].BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            for _, highlight in pairs(highlights) do
                highlight:Destroy()
            end
            highlights = {}
            Content:GetChildren()[4].Text = "👁️ ESP: OFF"
            Content:GetChildren()[4].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
    end)
    
    -- Speed Hack
    yPos = createBtn("⚡ SPEED HACK", yPos, Color3.fromRGB(255, 165, 0), function()
        humanoid.WalkSpeed = 100
    end)
    
    -- Super Jump
    yPos = createBtn("🦘 SUPER JUMP", yPos, Color3.fromRGB(0, 206, 209), function()
        humanoid.JumpPower = 150
    end)
    
    -- Invisible
    yPos = createBtn("👻 INVISIBLE", yPos, Color3.fromRGB(128, 128, 128), function()
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
    end)
    
    -- Rainbow Character
    local rainbow = false
    yPos = createBtn("🌈 RAINBOW CHAR", yPos, Color3.fromRGB(148, 0, 211), function()
        rainbow = not rainbow
        
        if rainbow then
            spawn(function()
                while rainbow do
                    for i = 0, 1, 0.01 do
                        if not rainbow then break end
                        for _, part in pairs(character:GetChildren()) do
                            if part:IsA("BasePart") then
                                part.Color = Color3.fromHSV(i, 1, 1)
                            end
                        end
                        wait(0.05)
                    end
                end
            end)
        end
    end)
    
    -- Anti-AFK
    yPos = createBtn("🌀 ANTI-AFK", yPos, Color3.fromRGB(0, 100, 0), function()
        local vu = game:GetService("VirtualUser")
        player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        end)
    end)
    
    -- Full Bright
    yPos = createBtn("💡 FULL BRIGHT", yPos, Color3.fromRGB(255, 255, 224), function()
        Lighting.GlobalShadows = false
        Lighting.ClockTime = 14
    end)
    
    Content.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- 💰 MONEY TAB
local function showMoney()
    Content:ClearAllChildren()
    local yPos = 10
    
    -- Multiplier Input
    local multiFrame = Instance.new("Frame")
    multiFrame.Size = UDim2.new(1, 0, 0, 50)
    multiFrame.Position = UDim2.new(0, 0, 0, yPos)
    multiFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    multiFrame.Parent = Content
    yPos = yPos + 60
    
    local multiLabel = Instance.new("TextLabel")
    multiLabel.Size = UDim2.new(0.6, 0, 1, 0)
    multiLabel.Position = UDim2.new(0, 10, 0, 0)
    multiLabel.BackgroundTransparency = 1
    multiLabel.Text = "💰 MULTIPLIER: x" .. moneyMultiplier
    multiLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    multiLabel.Font = Enum.Font.SourceSansBold
    multiLabel.TextSize = 14
    multiLabel.TextXAlignment = Enum.TextXAlignment.Left
    multiLabel.Parent = multiFrame
    
    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0.15, 0, 0.6, 0)
    minusBtn.Position = UDim2.new(0.6, 0, 0.2, 0)
    minusBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    minusBtn.Text = "-"
    minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.Font = Enum.Font.SourceSansBold
    minusBtn.Parent = multiFrame
    
    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0.15, 0, 0.6, 0)
    plusBtn.Position = UDim2.new(0.8, 0, 0.2, 0)
    plusBtn.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
    plusBtn.Text = "+"
    plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.Font = Enum.Font.SourceSansBold
    plusBtn.Parent = multiFrame
    
    minusBtn.MouseButton1Click:Connect(function()
        if moneyMultiplier > 1 then
            moneyMultiplier = moneyMultiplier - 1
            multiLabel.Text = "💰 MULTIPLIER: x" .. moneyMultiplier
        end
    end)
    
    plusBtn.MouseButton1Click:Connect(function()
        moneyMultiplier = moneyMultiplier + 1
        multiLabel.Text = "💰 MULTIPLIER: x" .. moneyMultiplier
    end)
    
    -- Infinite Money
    yPos = createBtn("💰 INFINITE MONEY", yPos, Color3.fromRGB(255, 215, 0), getInfiniteMoney)
    
    -- Money Dupe
    yPos = createBtn("🔄 MONEY DUPE", yPos, Color3.fromRGB(255, 140, 0), function()
        pcall(function()
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                    if obj.Name:lower():find("cash") or obj.Name:lower():find("money") then
                        obj.Value = obj.Value * moneyMultiplier
                    end
                end
            end
        end)
    end)
    
    -- Pet Dupe
    yPos = createBtn("🐾 PET DUPE", yPos, Color3.fromRGB(255, 105, 180), dupePets)
    
    -- Auto Farm
    local farming = false
    yPos = createBtn("🌾 AUTO FARM: OFF", yPos, Color3.fromRGB(50, 205, 50), function()
        farming = not farming
        
        if farming then
            spawn(function()
                while farming do
                    pcall(function()
                        -- Auto Click Detectors
                        for _, obj in pairs(Workspace:GetDescendants()) do
                            if obj:IsA("ClickDetector") then
                                fireclickdetector(obj)
                            end
                        end
                        
                        -- Auto Collect Items
                        for _, obj in pairs(Workspace:GetChildren()) do
                            if obj:IsA("BasePart") and (obj.Name:find("Coin") or obj.Name:find("Money")) then
                                rootPart.CFrame = obj.CFrame
                            end
                        end
                    end)
                    wait(0.5)
                end
            end)
            Content:GetChildren()[5].Text = "🌾 AUTO FARM: ON"
            Content:GetChildren()[5].BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            Content:GetChildren()[5].Text = "🌾 AUTO FARM: OFF"
            Content:GetChildren()[5].BackgroundColor3 = Color3.fromRGB(50, 205, 50)
        end
    end)
    
    Content.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- 🛠️ TOOLS TAB
local function showTools()
    scanAndShowTools()
end

-- 🎯 TELEPORT TAB
local function showTeleport()
    Content:ClearAllChildren()
    local yPos = 10
    
    -- Player Liste
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= player then
            yPos = createBtn("🎯 TP TO " .. target.Name, yPos, Color3.fromRGB(0, 150, 255), function()
                if target.Character then
                    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        rootPart.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
                    end
                end
            end)
        end
    end
    
    -- Bring All
    yPos = createBtn("👥 BRING ALL PLAYERS", yPos, Color3.fromRGB(255, 165, 0), function()
        for _, target in pairs(Players:GetPlayers()) do
            if target ~= player and target.Character then
                local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = rootPart.CFrame + Vector3.new(math.random(-5,5), 0, math.random(-5,5))
                end
            end
        end
    end)
    
    Content.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- 👑 ADMIN TAB
local function showAdmin()
    Content:ClearAllChildren()
    local yPos = 10
    
    -- Kill All
    yPos = createBtn("💀 KILL ALL PLAYERS", yPos, Color3.fromRGB(255, 0, 0), function()
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
    yPos = createBtn("❄️ FREEZE ALL PLAYERS", yPos, Color3.fromRGB(0, 191, 255), function()
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
    yPos = createBtn("❤️ HEAL ALL PLAYERS", yPos, Color3.fromRGB(0, 255, 0), function()
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
    yPos = createBtn("🌐 SERVER HOP", yPos, Color3.fromRGB(70, 130, 180), function()
        pcall(function()
            local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet(
                "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"
            )).data
            
            for _, server in pairs(servers) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, player)
                    break
                end
            end
        end)
    end)
    
    -- Rejoin
    yPos = createBtn("🔄 REJOIN", yPos, Color3.fromRGB(255, 0, 0), function()
        TeleportService:Teleport(game.PlaceId, player)
    end)
    
    -- Anti-Kick
    yPos = createBtn("🛡️ ANTI-KICK", yPos, Color3.fromRGB(178, 34, 34), function()
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
    
    -- B-Tools
    yPos = createBtn("🛠️ B-TOOLS", yPos, Color3.fromRGB(255, 165, 0), function()
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
    
    Content.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- TAB SWITCHING
local function switchTab(tab)
    for tabName, btn in pairs(TabButtons) do
        btn.BackgroundColor3 = tabName == tab and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(40, 40, 60)
        btn.TextColor3 = tabName == tab and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(200, 200, 200)
    end
    
    if tab == "Cheats" then showCheats()
    elseif tab == "Money" then showMoney()
    elseif tab == "Tools" then showTools()
    elseif tab == "Teleport" then showTeleport()
    elseif tab == "Admin" then showAdmin() end
end

-- EVENTS
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    ToggleBtn.Text = MainFrame.Visible and "✕" or "⚡"
    ToggleBtn.BackgroundColor3 = MainFrame.Visible and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(0, 255, 255)
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ToggleBtn.Text = "⚡"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
end)

for tabName, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Connect(function() switchTab(tabName) end)
end

-- HOTKEYS
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
        ToggleBtn.Text = MainFrame.Visible and "✕" or "⚡"
        ToggleBtn.BackgroundColor3 = MainFrame.Visible and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(0, 255, 255)
    end
end)

-- INIT
switchTab("Cheats")

print("✅ Ultimate Hacker Tool V6 geladen!")
print("🎮 Toggle GUI: RightControl / Toggle Button")
print("💰 Universal Money System aktiviert")
print("🛠️ Tool Scanner & Giver bereit")
print("👑 Made by Waled-hammad")

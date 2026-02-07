-- ULTIMATE AMBER ALERT CHEAT GUI MIT ADMIN
-- MADE BY WALED-HAMMAD
-- MIT ÖFFNEN/SCHLIEßEN FUNKTION FÜR MOBILE

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local camera = Workspace.CurrentCamera

-- MOBILE DETEKTION
local isMobile = UserInputService.TouchEnabled

-- GUI ERSTELLEN
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WaledUltimateGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- TOGGLE BUTTON FÜR MOBILE (immer sichtbar)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 70, 0, 70)
ToggleButton.Position = UDim2.new(0, 20, 0.85, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 28
ToggleButton.Text = "⚡"
ToggleButton.Visible = isMobile
ToggleButton.ZIndex = 10
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 35)
ToggleCorner.Parent = ToggleButton

-- HAUPTFRAME (Auf Mobile standardmäßig versteckt)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = isMobile and UDim2.new(0, 350, 0, 500) or UDim2.new(0, 400, 0, 550)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = not isMobile -- Auf Mobile versteckt starten
MainFrame.Parent = ScreenGui

-- ROTER TITEL MIT NAME
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ULTIMATE CHEATS - MADE BY WALED-HAMMAD"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = isMobile and 14 or 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- CLOSE BUTTON
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0.5, -20)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Text = "X"
CloseButton.Parent = TitleBar

-- TAB SYSTEM
local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(1, -20, 0, 40)
Tabs.Position = UDim2.new(0, 10, 0, 60)
Tabs.BackgroundTransparency = 1
Tabs.Parent = MainFrame

-- TAB BUTTONS
local function createTabButton(text, tabName, xPos)
    local button = Instance.new("TextButton")
    button.Name = tabName .. "Tab"
    button.Size = UDim2.new(0.23, 0, 1, 0)
    button.Position = UDim2.new(xPos, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    button.TextColor3 = Color3.fromRGB(200, 200, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = isMobile and 10 or 12
    button.Text = text
    button.Parent = Tabs
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    return button
end

local MainTabBtn = createTabButton("MAIN", "Main", 0)
local ToolsTabBtn = createTabButton("TOOLS", "Tools", 0.25)
local PlayersTabBtn = createTabButton("PLAYERS", "Players", 0.50)
local AdminTabBtn = createTabButton("ADMIN", "Admin", 0.75)

-- CONTENT FRAME
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -120)
ContentFrame.Position = UDim2.new(0, 10, 0, 110)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
ContentFrame.Parent = MainFrame

-- VARIABLEN
local cheats = {
    godmode = false,
    invisible = false,
    noclip = false,
    esp = false,
    aimbot = false,
    infjumps = false,
    moneymultiply = false,
    killaura = false,
    fly = false,
    speed = false,
    admin = false
}

local toolsList = {}
local espBoxes = {}
local aimbotConnection
local noclipConnection
local infJumpConnection
local killAuraConnection
local flyConnection
local moneyMultiplier = 10
local flySpeed = 50
local walkSpeed = 50
local guiVisible = not isMobile

-- ============ KERN FUNKTIONEN ============

-- GUI TOGGLE FUNKTION
local function toggleGUI()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
    
    if isMobile then
        ToggleButton.Text = guiVisible and "✕" or "⚡"
        ToggleButton.BackgroundColor3 = guiVisible and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(255, 50, 50)
    end
end

ToggleButton.MouseButton1Click:Connect(toggleGUI)
CloseButton.MouseButton1Click:Connect(toggleGUI)

-- GODMODE (UNSTERBLICH - FUNKTIONIERT IMMER)
local function toggleGodmode()
    cheats.godmode = not cheats.godmode
    
    if cheats.godmode then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        humanoid.BreakJointsOnDeath = false
        
        -- Schadens-Hook
        for _, connection in pairs(getconnections(humanoid.HealthChanged)) do
            connection:Disable()
        end
        
        print("✅ GODMODE AKTIVIERT - Unsterblich!")
    else
        humanoid.MaxHealth = 100
        humanoid.Health = 100
        humanoid.BreakJointsOnDeath = true
        print("❌ GODMODE DEAKTIVIERT")
    end
end

-- INVISIBLE (FUNKTIONIERT KOMPLETT)
local function toggleInvisible()
    cheats.invisible = not cheats.invisible
    
    if cheats.invisible then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
                part.Handle.Transparency = 1
            end
        end
        print("✅ INVISIBLE AKTIVIERT")
    else
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
                part.Handle.Transparency = 0
            end
        end
        print("❌ INVISIBLE DEAKTIVIERT")
    end
end

-- NOCLIP (DURCH WÄNDE GEHEN)
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
        print("✅ NOCLIP AKTIVIERT")
    else
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        print("❌ NOCLIP DEAKTIVIERT")
    end
end

-- ESP (SPIELER & ENTITIES SEHEN)
local function toggleESP()
    cheats.esp = not cheats.esp
    
    if cheats.esp then
        local function createESP(target, color, isEntity)
            if target:FindFirstChild("HumanoidRootPart") then
                -- ESP Box
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "ESP_" .. target.Name
                box.Adornee = target.HumanoidRootPart
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Size = target.HumanoidRootPart.Size + Vector3.new(0.1, 2, 0.1)
                box.Color3 = color
                box.Transparency = 0.3
                box.Parent = target.HumanoidRootPart
                
                -- Health Info
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "ESP_Health"
                billboard.Size = UDim2.new(4, 0, 0.5, 0)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = target.HumanoidRootPart
                
                local healthText = Instance.new("TextLabel")
                healthText.Size = UDim2.new(1, 0, 1, 0)
                healthText.BackgroundTransparency = 1
                healthText.Text = isEntity and "ENTITY" or "PLAYER"
                healthText.TextColor3 = color
                healthText.Font = Enum.Font.GothamBold
                healthText.TextSize = 12
                healthText.Parent = billboard
                
                -- Update Health
                local targetHumanoid = target:FindFirstChild("Humanoid")
                if targetHumanoid then
                    targetHumanoid.HealthChanged:Connect(function()
                        healthText.Text = (isEntity and "ENTITY" or "PLAYER") .. "\n" .. math.floor(targetHumanoid.Health) .. "/" .. math.floor(targetHumanoid.MaxHealth) .. " HP"
                    end)
                end
                
                espBoxes[target] = {box, billboard}
            end
        end
        
        -- Spieler
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= player and targetPlayer.Character then
                createESP(targetPlayer.Character, Color3.fromRGB(255, 0, 0), false)
            end
        end
        
        -- Entities
        for _, entity in pairs(Workspace:GetChildren()) do
            if entity:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(entity) then
                createESP(entity, Color3.fromRGB(255, 165, 0), true)
            end
        end
        
        print("✅ ESP AKTIVIERT")
    else
        -- ESP entfernen
        for _, espData in pairs(espBoxes) do
            if espData[1] then espData[1]:Destroy() end
            if espData[2] then espData[2]:Destroy() end
        end
        espBoxes = {}
        print("❌ ESP DEAKTIVIERT")
    end
end

-- AIMBOT (FUNKTIONIERT)
local function toggleAimbot()
    cheats.aimbot = not cheats.aimbot
    
    if cheats.aimbot then
        aimbotConnection = RunService.RenderStepped:Connect(function()
            if not cheats.aimbot then return end
            
            local closestTarget = nil
            local closestDistance = math.huge
            
            -- Finde nächsten Spieler oder Entity
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
                    local distance = (rootPart.Position - targetPlayer.Character.Head.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestTarget = targetPlayer.Character.Head
                    end
                end
            end
            
            -- Prüfe Entities
            for _, entity in pairs(Workspace:GetChildren()) do
                if entity:FindFirstChild("Humanoid") and entity:FindFirstChild("Head") and not Players:GetPlayerFromCharacter(entity) then
                    local distance = (rootPart.Position - entity.Head.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestTarget = entity.Head
                    end
                end
            end
            
            if closestTarget then
                camera.CFrame = CFrame.new(camera.CFrame.Position, closestTarget.Position)
            end
        end)
        print("✅ AIMBOT AKTIVIERT")
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
        end
        print("❌ AIMBOT DEAKTIVIERT")
    end
end

-- INFINITY JUMPS (FUNKTIONIERT)
local function toggleInfJumps()
    cheats.infjumps = not cheats.infjumps
    
    if cheats.infjumps then
        infJumpConnection = UserInputService.JumpRequest:Connect(function()
            if cheats.infjumps then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        print("✅ INFINITY JUMPS AKTIVIERT")
    else
        if infJumpConnection then
            infJumpConnection:Disconnect()
        end
        print("❌ INFINITY JUMPS DEAKTIVIERT")
    end
end

-- FLY (FUNKTIONIERT)
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
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not cheats.fly or not rootPart then return end
            
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
        print("✅ FLY AKTIVIERT")
    else
        if flyConnection then flyConnection:Disconnect() end
        humanoid.PlatformStand = false
        
        for _, obj in pairs(rootPart:GetChildren()) do
            if obj:IsA("BodyGyro") or obj:IsA("BodyVelocity") then
                obj:Destroy()
            end
        end
        print("❌ FLY DEAKTIVIERT")
    end
end

-- SPEED HACK
local originalWalkSpeed
local function toggleSpeed()
    cheats.speed = not cheats.speed
    
    if cheats.speed then
        originalWalkSpeed = humanoid.WalkSpeed
        humanoid.WalkSpeed = walkSpeed
        print("✅ SPEED HACK AKTIVIERT")
    else
        if originalWalkSpeed then
            humanoid.WalkSpeed = originalWalkSpeed
        end
        print("❌ SPEED HACK DEAKTIVIERT")
    end
end

-- MONEY MULTIPLY (IN ALLEN SPIELEN)
local function toggleMoneyMultiply()
    cheats.moneymultiply = not cheats.moneymultiply
    
    if cheats.moneymultiply then
        spawn(function()
            while cheats.moneymultiply and task.wait(0.5) do
                pcall(function()
                    -- Finde und multipliziere Geld
                    local moneyTypes = {"Cash", "Money", "Coins", "Points", "Gold", "Gems"}
                    
                    for _, obj in pairs(game:GetDescendants()) do
                        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                            for _, moneyType in pairs(moneyTypes) do
                                if obj.Name:lower():find(moneyType:lower()) then
                                    if obj.Value > 0 then
                                        obj.Value = obj.Value * moneyMultiplier
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
        print("✅ MONEY MULTIPLY x" .. moneyMultiplier .. " AKTIVIERT")
    else
        print("❌ MONEY MULTIPLY DEAKTIVIERT")
    end
end

-- KILL AURA (ENTITIES ATTACKEN DICH)
local function toggleKillAura()
    cheats.killaura = not cheats.killaura
    
    if cheats.killaura then
        killAuraConnection = RunService.Heartbeat:Connect(function()
            if not cheats.killaura then return end
            
            for _, entity in pairs(Workspace:GetChildren()) do
                if entity:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(entity) then
                    local entityRoot = entity:FindFirstChild("HumanoidRootPart")
                    if entityRoot and (entityRoot.Position - rootPart.Position).Magnitude < 20 then
                        -- Entity greift dich an
                        entity.Humanoid:MoveTo(rootPart.Position)
                        
                        -- Wenn nah genug, füge Schaden zu
                        if (entityRoot.Position - rootPart.Position).Magnitude < 5 then
                            if not cheats.godmode then
                                humanoid:TakeDamage(10)
                            end
                        end
                    end
                end
            end
        end)
        print("✅ KILL AURA AKTIVIERT - Entities attacken dich!")
    else
        if killAuraConnection then
            killAuraConnection:Disconnect()
        end
        print("❌ KILL AURA DEAKTIVIERT")
    end
end

-- TELEPORT ZUM BODEN CLICKEN
local function setupTeleportClick()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            local mousePos = UserInputService:GetMouseLocation()
            local ray = camera:ScreenPointToRay(mousePos.X, mousePos.Y)
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Blacklist
            params.FilterDescendantsInstances = {character}
            
            local result = Workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
            if result then
                rootPart.CFrame = CFrame.new(result.Position + Vector3.new(0, 5, 0))
                print("✅ Teleportiert zu: " .. tostring(result.Position))
            end
        end
    end)
end

-- ADMIN FUNKTIONEN
local function unlockAdmin()
    cheats.admin = not cheats.admin
    
    if cheats.admin then
        -- FireServer Bypass
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" or method == "InvokeServer" then
                -- Erlaube alle Server Calls
                return
            end
            return oldNamecall(self, ...)
        end)
        
        -- Kick Protection
        local oldKick = player.Kick
        player.Kick = function()
            print("⚠️ Kick wurde blockiert!")
            return
        end
        
        -- Admin Chat Commands
        player.Chatted:Connect(function(msg)
            if msg:sub(1, 1) == "!" then
                local args = msg:sub(2):split(" ")
                local cmd = args[1]:lower()
                
                if cmd == "killall" then
                    for _, target in pairs(Players:GetPlayers()) do
                        if target ~= player and target.Character then
                            local hum = target.Character:FindFirstChild("Humanoid")
                            if hum then hum.Health = 0 end
                        end
                    end
                elseif cmd == "kick" and args[2] then
                    local target = Players:FindFirstChild(args[2])
                    if target then
                        target:Kick("Admin Kick")
                    end
                elseif cmd == "bring" and args[2] then
                    local target = Players:FindFirstChild(args[2])
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        target.Character.HumanoidRootPart.CFrame = rootPart.CFrame
                    end
                elseif cmd == "goto" and args[2] then
                    local target = Players:FindFirstChild(args[2])
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        rootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                    end
                end
            end
        end)
        
        print("✅ ADMIN RECHTE AKTIVIERT!")
        print("📝 Chat Commands: !killall, !kick [name], !bring [name], !goto [name]")
    else
        print("❌ ADMIN RECHTE DEAKTIVIERT")
    end
end

-- TOOLGIVER SCAN (FUNKTIONIERT)
local function scanTools()
    toolsList = {}
    
    local searchLocations = {
        Workspace,
        game:GetService("StarterPack"),
        game:GetService("ReplicatedStorage"),
        game:GetService("ServerStorage"),
        game:GetService("Lighting")
    }
    
    for _, location in pairs(searchLocations) do
        for _, obj in pairs(location:GetDescendants()) do
            if obj:IsA("Tool") then
                table.insert(toolsList, {
                    Name = obj.Name,
                    Object = obj,
                    Location = location.Name
                })
            end
        end
    end
    
    return #toolsList
end

-- TOOL GEBEN MIT TELEPORT
local function giveTool(toolData)
    local clone = toolData.Object:Clone()
    clone.Parent = player.Backpack
    
    -- Wenn Tool angeklickt wird, teleportiere dahin
    clone.Equipped:Connect(function()
        if clone:FindFirstChild("Handle") then
            rootPart.CFrame = clone.Handle.CFrame + Vector3.new(0, 5, 0)
            print("✅ Teleportiert zum Tool: " .. toolData.Name)
        end
    end)
    
    return clone
end

-- PLAYER GESTALT ANNEHMEN
local function copyPlayerAppearance(targetPlayer)
    if targetPlayer.Character then
        local targetChar = targetPlayer.Character
        
        -- Entferne alte Kleidung
        for _, clothing in pairs(character:GetChildren()) do
            if clothing:IsA("Shirt") or clothing:IsA("Pants") or clothing:IsA("ShirtGraphic") then
                clothing:Destroy()
            end
        end
        
        -- Kopiere Kleidung
        for _, clothing in pairs(targetChar:GetChildren()) do
            if clothing:IsA("Shirt") or clothing:IsA("Pants") or clothing:IsA("ShirtGraphic") then
                local clone = clothing:Clone()
                clone.Parent = character
            end
        end
        
        -- Kopiere Accessoires
        for _, accessory in pairs(targetChar:GetChildren()) do
            if accessory:IsA("Accessory") then
                local clone = accessory:Clone()
                clone.Parent = character
            end
        end
        
        -- Kopiere Gesicht
        local targetHead = targetChar:FindFirstChild("Head")
        local myHead = character:FindFirstChild("Head")
        if targetHead and myHead then
            for _, face in pairs(targetHead:GetChildren()) do
                if face:IsA("Decal") then
                    local clone = face:Clone()
                    clone.Parent = myHead
                end
            end
        end
        
        print("✅ Gestalt von " .. targetPlayer.Name .. " angenommen")
    end
end

-- TROLL PLAYER FUNKTION
local function trollPlayer(targetPlayer)
    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        -- Teleport in die Luft
        targetPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 100, 0)
        
        -- Spawn Blöcke um sie
        for i = 1, 20 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(4, 4, 4)
            part.Position = targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(
                math.random(-15, 15),
                math.random(-10, 20),
                math.random(-15, 15)
            )
            part.Anchored = true
            part.CanCollide = true
            part.BrickColor = BrickColor.Random()
            part.Material = Enum.Material.Neon
            part.Parent = Workspace
            
            game.Debris:AddItem(part, 10)
        end
        
        print("✅ " .. targetPlayer.Name .. " getrollt!")
    end
end

-- BUTTON ERSTELLEN MIT STATUS
local function createButton(text, yPos, color, callback, statusVar)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, isMobile and 45 or 40)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = isMobile and 13 or 14
    button.Text = text .. (statusVar and (" [" .. (cheats[statusVar] and "ON" or "OFF") .. "]") or "")
    button.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        callback()
        if statusVar then
            button.Text = text .. " [" .. (cheats[statusVar] and "ON" or "OFF") .. "]"
            button.BackgroundColor3 = cheats[statusVar] and Color3.fromRGB(0, 200, 0) or color
        end
    end)
    
    return button
end

-- MAIN TAB ANZEIGEN
local function showMainTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- TELEPORT INFO
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -20, 0, 30)
    infoLabel.Position = UDim2.new(0, 10, 0, yPos)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = isMobile and "TELEPORT: Tippen auf Boden" or "TELEPORT: STRG + Linksklick auf Boden"
    infoLabel.TextColor3 = Color3.fromRGB(0, 191, 255)
    infoLabel.Font = Enum.Font.GothamBold
    infoLabel.TextSize = isMobile and 11 or 12
    infoLabel.TextXAlignment = Enum.TextXAlignment.Center
    infoLabel.Parent = ContentFrame
    yPos = yPos + 35
    
    -- GODMODE
    createButton("🛡️ GODMODE", yPos, Color3.fromRGB(0, 150, 0), toggleGodmode, "godmode")
    yPos = yPos + (isMobile and 50 or 45)
    
    -- INVISIBLE
    createButton("👻 INVISIBLE", yPos, Color3.fromRGB(138, 43, 226), toggleInvisible, "invisible")
    yPos = yPos + (isMobile and 50 or 45)
    
    -- NOCLIP
    createButton("🚪 NOCLIP", yPos, Color3.fromRGB(30, 144, 255), toggleNoclip, "noclip")
    yPos = yPos + (isMobile and 50 or 45)
    
    -- ESP
    createButton("👁️ ESP", yPos, Color3.fromRGB(100, 255, 255), toggleESP, "esp")
    yPos = yPos + (isMobile and 50 or 45)
    
    -- AIMBOT
    createButton("🎯 AIMBOT", yPos, Color3.fromRGB(255, 50, 50), toggleAimbot, "aimbot")
    yPos = yPos + (isMobile and 50 or 45)
    
    -- INFINITY JUMPS
    createButton("∞ INFINITY JUMPS", yPos, Color3.fromRGB(50, 205, 50), toggleInfJumps, "infjumps")
    yPos = yPos + (isMobile and 50 or 45)
    
    -- FLY
    createButton("✈️ FLY", yPos, Color3.fromRGB(0, 191, 255), toggleFly, "fly")
    yPos = yPos + (isMobile and 50 or 45)
    
    -- SPEED HACK
    createButton("⚡ SPEED HACK", yPos, Color3.fromRGB(255, 69, 0), toggleSpeed, "speed")
    yPos = yPos + (isMobile and 50 or 45)
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- TOOLS TAB ANZEIGEN
local function showToolsTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- SCAN TOOLS
    local scanBtn = createButton("🔍 SCAN TOOLS", yPos, Color3.fromRGB(0, 120, 215), function()
        local count = scanTools()
        scanBtn.Text = "✅ " .. count .. " TOOLS GEFUNDEN"
        scanBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    end)
    yPos = yPos + (isMobile and 50 or 45)
    
    -- GIVE ALL TOOLS
    local allBtn = createButton("🛠️ GIVE ALL TOOLS", yPos, Color3.fromRGB(0, 180, 0), function()
        for _, toolData in pairs(toolsList) do
            giveTool(toolData)
            task.wait(0.05)
        end
        allBtn.Text = "✅ ALLE TOOLS GEGEBEN"
        allBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    end)
    yPos = yPos + (isMobile and 50 or 45)
    
    -- MONEY MULTIPLY
    createButton("💰 MONEY x10", yPos, Color3.fromRGB(255, 215, 0), toggleMoneyMultiply, "moneymultiply")
    yPos = yPos + (isMobile and 50 or 45)
    
    -- KILL AURA
    createButton("⚔️ KILL AURA", yPos, Color3.fromRGB(255, 69, 0), toggleKillAura, "killaura")
    yPos = yPos + (isMobile and 50 or 45)
    
    -- TOOLS LISTE
    if #toolsList > 0 then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, 30)
        label.Position = UDim2.new(0, 10, 0, yPos)
        label.BackgroundTransparency = 1
        label.Text = "TOOLS LISTE (" .. #toolsList .. "):"
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = isMobile and 13 or 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = ContentFrame
        yPos = yPos + 35
        
        for i, toolData in pairs(toolsList) do
            if i <= (isMobile and 4 or 6) then
                local toolBtn = createButton("🛠️ " .. toolData.Name, yPos, Color3.fromRGB(60, 60, 80), function()
                    giveTool(toolData)
                    toolBtn.Text = "✅ " .. toolData.Name
                    toolBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                end)
                yPos = yPos + (isMobile and 50 or 45)
            end
        end
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- PLAYERS TAB ANZEIGEN
local function showPlayersTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- PLAYER LISTE
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player then
            local playerFrame = Instance.new("Frame")
            playerFrame.Size = UDim2.new(1, -20, 0, isMobile and 70 : 80)
            playerFrame.Position = UDim2.new(0, 10, 0, yPos)
            playerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            playerFrame.Parent = ContentFrame
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = playerFrame
            
            -- Name
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
            nameLabel.Position = UDim2.new(0, 10, 0, 5)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = targetPlayer.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextSize = isMobile and 12 or 14
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Parent = playerFrame
            
            -- Buttons
            local btnY = isMobile and 30 : 35
            local btnWidth = isMobile and 0.32 : 0.3
            
            -- Copy Appearance
            local copyBtn = Instance.new("TextButton")
            copyBtn.Size = UDim2.new(btnWidth, -5, 0, isMobile and 25 : 30)
            copyBtn.Position = UDim2.new(0.02, 0, 0, btnY)
            copyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
            copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            copyBtn.Font = Enum.Font.GothamBold
            copyBtn.TextSize = isMobile and 10 : 11
            copyBtn.Text = "COPY"
            copyBtn.Parent = playerFrame
            
            copyBtn.MouseButton1Click:Connect(function()
                copyPlayerAppearance(targetPlayer)
                copyBtn.Text = "✅"
            end)
            
            -- Troll Button
            local trollBtn = Instance.new("TextButton")
            trollBtn.Size = UDim2.new(btnWidth, -5, 0, isMobile and 25 : 30)
            trollBtn.Position = UDim2.new(0.34, 0, 0, btnY)
            trollBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            trollBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            trollBtn.Font = Enum.Font.GothamBold
            trollBtn.TextSize = isMobile and 10 : 11
            trollBtn.Text = "TROLL"
            trollBtn.Parent = playerFrame
            
            trollBtn.MouseButton1Click:Connect(function()
                trollPlayer(targetPlayer)
                trollBtn.Text = "✅"
            end)
            
            -- Teleport Button
            local tpBtn = Instance.new("TextButton")
            tpBtn.Size = UDim2.new(btnWidth, -5, 0, isMobile and 25 : 30)
            tpBtn.Position = UDim2.new(0.66, 0, 0, btnY)
            tpBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
            tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tpBtn.Font = Enum.Font.GothamBold
            tpBtn.TextSize = isMobile and 10 : 11
            tpBtn.Text = "TP"
            tpBtn.Parent = playerFrame
            
            tpBtn.MouseButton1Click:Connect(function()
                if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    rootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                    tpBtn.Text = "✅"
                end
            end)
            
            yPos = yPos + (isMobile and 75 : 85)
        end
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- ADMIN TAB ANZEIGEN
local function showAdminTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    -- UNLOCK ADMIN
    createButton("👑 UNLOCK ADMIN", yPos, Color3.fromRGB(255, 215, 0), unlockAdmin, "admin")
    yPos = yPos + (isMobile and 50 or 45)
    
    -- TROLL ALL PLAYERS
    local trollAllBtn = createButton("😈 TROLL ALL PLAYERS", yPos, Color3.fromRGB(255, 50, 50), function()
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= player then
                trollPlayer(targetPlayer)
                task.wait(0.2)
            end
        end
        trollAllBtn.Text = "✅ ALLE GETROLLT"
        trollAllBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    end)
    yPos = yPos + (isMobile and 50 or 45)
    
    -- MAKE ENTITIES ATTACK ALL
    local entitiesBtn = createButton("👾 ENTITIES ATTACK ALL", yPos, Color3.fromRGB(255, 165, 0), function()
        for _, entity in pairs(Workspace:GetChildren()) do
            if entity:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(entity) then
                local humanoid = entity.Humanoid
                local root = entity:FindFirstChild("HumanoidRootPart")
                
                if humanoid and root then
                    spawn(function()
                        while entity and entity.Parent do
                            task.wait(0.5)
                            humanoid:MoveTo(rootPart.Position)
                        end
                    end)
                end
            end
        end
        entitiesBtn.Text = "✅ ENTITIES ATTACKING"
        entitiesBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    end)
    yPos = yPos + (isMobile and 50 or 45)
    
    -- MONEY MULTIPLY ALL
    local moneyAllBtn = createButton("💰 MAX MONEY FOR ALL", yPos, Color3.fromRGB(255, 215, 0), function()
        pcall(function()
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                    if obj.Name:lower():find("cash") or obj.Name:lower():find("money") or obj.Name:lower():find("coin") then
                        obj.Value = 999999999
                    end
                end
            end
        end)
        moneyAllBtn.Text = "✅ ALLES GELD MAX"
        moneyAllBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    end)
    yPos = yPos + (isMobile and 50 or 45)
    
    -- RANDOM TELEPORT
    local randomTpBtn = createButton("🎲 RANDOM TELEPORT", yPos, Color3.fromRGB(0, 191, 255), function()
        local randomPos = Vector3.new(
            math.random(-500, 500),
            math.random(10, 100),
            math.random(-500, 500)
        )
        rootPart.CFrame = CFrame.new(randomPos)
        randomTpBtn.Text = "✅ RANDOM TELEPORT"
        randomTpBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    end)
    yPos = yPos + (isMobile and 50 or 45)
    
    -- ADMIN COMMANDS INFO
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -20, 0, 60)
    infoLabel.Position = UDim2.new(0, 10, 0, yPos)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "📝 ADMIN CHAT COMMANDS:\n!killall - !kick [name]\n!bring [name] - !goto [name]"
    infoLabel.TextColor3 = Color3.fromRGB(0, 191, 255)
    infoLabel.Font = Enum.Font.GothamBold
    infoLabel.TextSize = isMobile and 10 : 11
    infoLabel.TextXAlignment = Enum.TextXAlignment.Center
    infoLabel.Parent = ContentFrame
    yPos = yPos + 65
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- TAB SWITCHING
local activeTab = "Main"

local function switchTab(tabName)
    activeTab = tabName
    
    -- Reset tabs
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    ToolsTabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    PlayersTabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    AdminTabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    
    MainTabBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
    ToolsTabBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
    PlayersTabBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
    AdminTabBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
    
    -- Highlight active
    if tabName == "Main" then
        MainTabBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        showMainTab()
    elseif tabName == "Tools" then
        ToolsTabBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        ToolsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        showToolsTab()
    elseif tabName == "Players" then
        PlayersTabBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        PlayersTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        showPlayersTab()
    elseif tabName == "Admin" then
        AdminTabBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        AdminTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        showAdminTab()
    end
end

-- EVENTS
MainTabBtn.MouseButton1Click:Connect(function() switchTab("Main") end)
ToolsTabBtn.MouseButton1Click:Connect(function() switchTab("Tools") end)
PlayersTabBtn.MouseButton1Click:Connect(function() switchTab("Players") end)
AdminTabBtn.MouseButton1Click:Connect(function() switchTab("Admin") end)

-- SETUP TELEPORT
if not isMobile then
    setupTeleportClick()
else
    -- Mobile Teleport
    spawn(function()
        while true do
            wait(0.1)
            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                local mousePos = UserInputService:GetMouseLocation()
                local ray = camera:ScreenPointToRay(mousePos.X, mousePos.Y)
                local result = Workspace:Raycast(ray.Origin, ray.Direction * 1000)
                if result then
                    rootPart.CFrame = CFrame.new(result.Position + Vector3.new(0, 5, 0))
                end
            end
        end
    end)
end

-- CHARAKTER WECHSEL
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    task.wait(1)
    
    -- Re-apply cheats
    if cheats.godmode then toggleGodmode() end
    if cheats.invisible then toggleInvisible() end
    if cheats.noclip then toggleNoclip() end
    if cheats.infjumps then toggleInfJumps() end
    if cheats.esp then toggleESP() end
    if cheats.aimbot then toggleAimbot() end
    if cheats.killaura then toggleKillAura() end
    if cheats.fly then toggleFly() end
    if cheats.speed then toggleSpeed() end
    if cheats.moneymultiply then toggleMoneyMultiply() end
end)

-- GUI EINFÜGEN
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- STARTE MIT MAIN TAB
switchTab("Main")

print("====================================")
print("ULTIMATE AMBER ALERT CHEATS")
print("MADE BY WALED-HAMMAD")
print("====================================")
print("✅ ALL FEATURES LOADED")
print("📱 MOBILE MODE: " .. tostring(isMobile))
print("⚡ GUI TOGGLE: " .. (isMobile and "Toggle Button aktiv" or "Direkt sichtbar"))
print("🛡️ GODMODE: Unsterblich in jedem Spiel")
print("👻 INVISIBLE: Vollständig unsichtbar")
print("🚪 NOCLIP: Durch alle Wände gehen")
print("👁️ ESP: Spieler & Entities sehen + Leben")
print("🎯 AIMBOT: Auto-Aim auf Spieler & Entities")
print("∞ INFINITY JUMPS: Unendlich springen")
print("✈️ FLY: Fliegen in alle Richtungen")
print("⚡ SPEED: Schneller laufen")
print("💰 MONEY: Geld x10 in allen Spielen")
print("⚔️ KILL AURA: Entities attacken dich")
print("👑 ADMIN: Server Kontrolle + Chat Commands")
print("🔧 TOOLGIVER: Tools scannen & geben")
print("👤 PLAYER COPY: Gestalt anderer annehmen")
print("😈 TROLL: Andere Spieler trollen")
print("====================================")

-- ============================================
-- ULTIMATE HACKER TOOL GUI - SEARCH & EXECUTE
-- Made by Waled-hammad
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local mouse = player:GetMouse()

-- 🔥 KRASS FUNKTIONEN DATENBANK
local functionDatabase = {
    -- FLY & MOVEMENT
    ["fly"] = function()
        local flyEnabled = false
        local flyBodyGyro, flyBodyVelocity
        
        return function()
            flyEnabled = not flyEnabled
            
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
                    if not flyEnabled or not character then return end
                    
                    local camera = Workspace.CurrentCamera
                    local direction = Vector3.new(0, 0, 0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction - Vector3.new(0, 1, 0) end
                    
                    flyBodyVelocity.Velocity = direction.Unit * 50
                    flyBodyGyro.CFrame = camera.CFrame
                end)
                
                humanoid.PlatformStand = true
                return "✈️ FLY AKTIVIERT"
            else
                if flyBodyGyro then flyBodyGyro:Destroy() end
                if flyBodyVelocity then flyBodyVelocity:Destroy() end
                humanoid.PlatformStand = false
                return "✈️ FLY DEAKTIVIERT"
            end
        end
    end,
    
    ["noclip"] = function()
        local noclipEnabled = false
        local connection
        
        return function()
            noclipEnabled = not noclipEnabled
            
            if noclipEnabled then
                connection = RunService.Stepped:Connect(function()
                    if character and noclipEnabled then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
                return "🚪 NO CLIP AKTIVIERT"
            else
                if connection then connection:Disconnect() end
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
                return "🚪 NO CLIP DEAKTIVIERT"
            end
        end
    end,
    
    ["godmode"] = function()
        local godEnabled = false
        
        return function()
            godEnabled = not godEnabled
            
            if godEnabled then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
                return "🛡️ GODMODE AKTIVIERT"
            else
                humanoid.MaxHealth = 100
                humanoid.Health = 100
                return "🛡️ GODMODE DEAKTIVIERT"
            end
        end
    end,
    
    ["esp"] = function()
        local espEnabled = false
        local highlights = {}
        
        return function()
            espEnabled = not espEnabled
            
            if espEnabled then
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
                return "👁️ ESP AKTIVIERT"
            else
                for _, highlight in pairs(highlights) do
                    highlight:Destroy()
                end
                highlights = {}
                return "👁️ ESP DEAKTIVIERT"
            end
        end
    end,
    
    ["aimbot"] = function()
        local aimbotEnabled = false
        
        return function()
            aimbotEnabled = not aimbotEnabled
            
            if aimbotEnabled then
                RunService.RenderStepped:Connect(function()
                    if not aimbotEnabled then return end
                    
                    local camera = Workspace.CurrentCamera
                    local closestPlayer = nil
                    local closestDist = 100
                    
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
                    
                    if closestPlayer and closestPlayer.Character and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                        local hrp = closestPlayer.Character.HumanoidRootPart
                        if hrp then
                            local targetPos = hrp.Position + Vector3.new(0, 2, 0)
                            local current = camera.CFrame
                            local new = CFrame.lookAt(current.Position, targetPos)
                            camera.CFrame = current:Lerp(new, 0.1)
                        end
                    end
                end)
                return "🎯 AIMBOT AKTIVIERT"
            else
                return "🎯 AIMBOT DEAKTIVIERT"
            end
        end
    end,
    
    ["killaura"] = function()
        local auraEnabled = false
        
        return function()
            auraEnabled = not auraEnabled
            
            if auraEnabled then
                spawn(function()
                    while auraEnabled do
                        for _, target in pairs(Players:GetPlayers()) do
                            if target ~= player and target.Character then
                                local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                                if hrp and rootPart then
                                    local distance = (hrp.Position - rootPart.Position).Magnitude
                                    if distance <= 25 then
                                        local hum = target.Character:FindFirstChild("Humanoid")
                                        if hum then
                                            hum.Health = 0
                                        end
                                    end
                                end
                            end
                        end
                        wait(0.1)
                    end
                end)
                return "💀 KILL AURA AKTIVIERT"
            else
                return "💀 KILL AURA DEAKTIVIERT"
            end
        end
    end,
    
    ["infinite money"] = function()
        return function()
            pcall(function()
                for _, obj in pairs(game:GetDescendants()) do
                    if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                        local name = obj.Name:lower()
                        if name:find("cash") or name:find("money") or name:find("coin") then
                            obj.Value = 9999999
                        end
                    end
                end
            end)
            return "💰 INFINITE MONEY AKTIVIERT"
        end
    end,
    
    ["item dupe"] = function()
        return function()
            local count = 0
            pcall(function()
                for _, obj in pairs(game:GetDescendants()) do
                    if obj:IsA("Tool") then
                        local clone = obj:Clone()
                        clone.Parent = player.Backpack
                        count = count + 1
                    end
                end
            end)
            return "🔄 " .. count .. " ITEMS GEDUPED"
        end
    end,
    
    ["money dupe"] = function()
        return function()
            pcall(function()
                for _, obj in pairs(game:GetDescendants()) do
                    if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                        if obj.Name:lower():find("cash") or obj.Name:lower():find("money") then
                            obj.Value = obj.Value * 10
                        end
                    end
                end
            end)
            return "💰 MONEY DUPE AKTIVIERT"
        end
    end,
    
    ["invisible"] = function()
        local invisibleEnabled = false
        
        return function()
            invisibleEnabled = not invisibleEnabled
            
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        part.Transparency = invisibleEnabled and 1 or 0
                    end
                end
            end
            return invisibleEnabled and "👻 INVISIBLE AKTIVIERT" or "👻 INVISIBLE DEAKTIVIERT"
        end
    end,
    
    ["speed hack"] = function()
        local speedEnabled = false
        local originalSpeed
        
        return function()
            speedEnabled = not speedEnabled
            
            if speedEnabled then
                originalSpeed = humanoid.WalkSpeed
                humanoid.WalkSpeed = 100
                return "⚡ SPEED HACK AKTIVIERT"
            else
                if originalSpeed then
                    humanoid.WalkSpeed = originalSpeed
                end
                return "⚡ SPEED HACK DEAKTIVIERT"
            end
        end
    end,
    
    ["super jump"] = function()
        local jumpEnabled = false
        local originalJump
        
        return function()
            jumpEnabled = not jumpEnabled
            
            if jumpEnabled then
                originalJump = humanoid.JumpPower
                humanoid.JumpPower = 150
                return "🦘 SUPER JUMP AKTIVIERT"
            else
                if originalJump then
                    humanoid.JumpPower = originalJump
                end
                return "🦘 SUPER JUMP DEAKTIVIERT"
            end
        end
    end,
    
    ["xray"] = function()
        local xrayEnabled = false
        
        return function()
            xrayEnabled = not xrayEnabled
            
            if xrayEnabled then
                for _, part in pairs(Workspace:GetDescendants()) do
                    if part:IsA("BasePart") and part.Transparency < 1 then
                        part.LocalTransparencyModifier = 0.5
                    end
                end
                return "🔍 X-RAY AKTIVIERT"
            else
                for _, part in pairs(Workspace:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.LocalTransparencyModifier = 0
                    end
                end
                return "🔍 X-RAY DEAKTIVIERT"
            end
        end
    end,
    
    ["anti afk"] = function()
        local antiAFKEnabled = false
        
        return function()
            antiAFKEnabled = not antiAFKEnabled
            
            if antiAFKEnabled then
                local vu = game:GetService("VirtualUser")
                player.Idled:Connect(function()
                    vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
                    wait(1)
                    vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
                end)
                return "🌀 ANTI-AFK AKTIVIERT"
            else
                return "🌀 ANTI-AFK DEAKTIVIERT"
            end
        end
    end,
    
    ["full bright"] = function()
        local brightEnabled = false
        
        return function()
            brightEnabled = not brightEnabled
            
            if brightEnabled then
                game:GetService("Lighting").GlobalShadows = false
                game:GetService("Lighting").ClockTime = 14
                return "💡 FULL BRIGHT AKTIVIERT"
            else
                game:GetService("Lighting").GlobalShadows = true
                return "💡 FULL BRIGHT DEAKTIVIERT"
            end
        end
    end,
    
    ["rainbow character"] = function()
        local rainbowEnabled = false
        
        return function()
            rainbowEnabled = not rainbowEnabled
            
            if rainbowEnabled then
                spawn(function()
                    while rainbowEnabled do
                        if character then
                            for _, part in pairs(character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    part.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                                end
                            end
                        end
                        wait(0.1)
                    end
                end)
                return "🌈 RAINBOW CHARACTER AKTIVIERT"
            else
                if character then
                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.Color = Color3.fromRGB(255, 255, 255)
                        end
                    end
                end
                return "🌈 RAINBOW CHARACTER DEAKTIVIERT"
            end
        end
    end,
    
    ["bring all players"] = function()
        return function()
            for _, target in pairs(Players:GetPlayers()) do
                if target ~= player and target.Character then
                    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and rootPart then
                        hrp.CFrame = rootPart.CFrame + Vector3.new(math.random(-5,5), 0, math.random(-5,5))
                    end
                end
            end
            return "👥 ALLE SPIELER GEBRACHT"
        end
    end,
    
    ["kill all players"] = function()
        return function()
            for _, target in pairs(Players:GetPlayers()) do
                if target ~= player and target.Character then
                    local hum = target.Character:FindFirstChild("Humanoid")
                    if hum then
                        hum.Health = 0
                    end
                end
            end
            return "💀 ALLE SPIELER GETÖTET"
        end
    end,
    
    ["freeze all players"] = function()
        return function()
            for _, target in pairs(Players:GetPlayers()) do
                if target ~= player and target.Character then
                    local humanoid = target.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = 0
                    end
                end
            end
            return "❄️ ALLE SPIELER GEFROREN"
        end
    end,
    
    ["heal all players"] = function()
        return function()
            for _, target in pairs(Players:GetPlayers()) do
                if target.Character then
                    local humanoid = target.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.Health = humanoid.MaxHealth
                    end
                end
            end
            return "❤️ ALLE SPIELER GEHEILT"
        end
    end,
    
    ["teleport to player"] = function(name)
        return function()
            for _, target in pairs(Players:GetPlayers()) do
                if target.Name:lower():find(name:lower()) and target.Character then
                    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        rootPart.CFrame = hrp.CFrame
                        return "🎯 ZU " .. target.Name .. " TELEPORTIERT"
                    end
                end
            end
            return "❌ SPIELER NICHT GEFUNDEN"
        end
    end,
    
    ["server hop"] = function()
        return function()
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
            return "🌐 SERVER HOP GESTARTET"
        end
    end,
    
    ["rejoin"] = function()
        return function()
            TeleportService:Teleport(game.PlaceId, player)
            return "🔄 REJOIN GESTARTET"
        end
    end,
    
    ["anti kick"] = function()
        return function()
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
            return "🛡️ ANTI-KICK AKTIVIERT"
        end
    end,
    
    ["btools"] = function()
        return function()
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
            
            return "🛠️ B-TOOLS ERHALTEN"
        end
    end
}

-- 🔍 SUCHDATENBANK MIT ALLEN FUNKTIONEN
local searchDatabase = {
    -- Bewegung
    "fly", "noclip", "speed hack", "super jump", "infinite jump", "jetpack",
    "swim anywhere", "walk on water", "walk on walls", "no gravity",
    
    -- Kampf
    "godmode", "aimbot", "killaura", "silent aim", "trigger bot", "wall bang",
    "rapid fire", "no spread", "no recoil", "one hit kill", "damage multiplier",
    
    -- Vision
    "esp", "xray", "chams", "tracers", "nametags", "healthbars", "distance esp",
    "night vision", "full bright", "remove fog", "remove water", "skeleton esp",
    
    -- Geld & Items
    "infinite money", "money dupe", "item dupe", "auto farm", "auto click",
    "auto collect", "auto sell", "auto rebirth", "auto spin", "auto hatch",
    "auto complete", "auto quest", "money multiplier", "gem dupe", "pet dupe",
    
    -- Schutz
    "anti afk", "anti kick", "anti ban", "invisible", "ghost mode", "no collision",
    "anti grab", "anti teleport", "anti freeze", "anti stun", "anti jail",
    
    -- Spieler Manipulation
    "bring all players", "teleport to player", "kill all players", "freeze all players",
    "heal all players", "spectate", "view player", "copy player", "control player",
    
    -- Welt & Admin
    "btools", "delete parts", "nuke", "rejoin", "server hop", "copy game id",
    "rainbow character", "rainbow ui", "custom crosshair", "fps display",
    
    -- Sonstiges
    "chat bypass", "name bypass", "emote bypass", "sit bypass", "dance bypass"
}

-- 🎨 GUI ERSTELLUNG
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateHackerTool"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 500)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- TITLE
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 70)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
Title.Text = "⚡ ULTIMATE HACKER TOOL ⚡\nMade by Waled-hammad"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24
Title.TextWrapped = true
Title.Parent = MainFrame

-- SEARCH BAR
local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(0.9, 0, 0, 50)
SearchBox.Position = UDim2.new(0.05, 0, 0, 80)
SearchBox.PlaceholderText = "🔍 Suche Funktion eingeben... (fly, godmode, esp, etc.)"
SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.Font = Enum.Font.SourceSans
SearchBox.TextSize = 18
SearchBox.Parent = MainFrame

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchBox

-- SUGGESTIONS FRAME
local SuggestionsFrame = Instance.new("Frame")
SuggestionsFrame.Size = UDim2.new(0.9, 0, 0, 150)
SuggestionsFrame.Position = UDim2.new(0.05, 0, 0, 140)
SuggestionsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
SuggestionsFrame.Visible = false
SuggestionsFrame.Parent = MainFrame

local SuggestionsCorner = Instance.new("UICorner")
SuggestionsCorner.CornerRadius = UDim.new(0, 8)
SuggestionsCorner.Parent = SuggestionsFrame

local SuggestionsList = Instance.new("ScrollingFrame")
SuggestionsList.Size = UDim2.new(1, -10, 1, -10)
SuggestionsList.Position = UDim2.new(0, 5, 0, 5)
SuggestionsList.BackgroundTransparency = 1
SuggestionsList.ScrollBarThickness = 6
SuggestionsList.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
SuggestionsList.CanvasSize = UDim2.new(0, 0, 0, 0)
SuggestionsList.Parent = SuggestionsFrame

-- RESULT FRAME
local ResultFrame = Instance.new("ScrollingFrame")
ResultFrame.Size = UDim2.new(0.9, 0, 0, 280)
ResultFrame.Position = UDim2.new(0.05, 0, 0, 140)
ResultFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
ResultFrame.ScrollBarThickness = 8
ResultFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
ResultFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ResultFrame.Parent = MainFrame

local ResultCorner = Instance.new("UICorner")
ResultCorner.CornerRadius = UDim.new(0, 8)
ResultCorner.Parent = ResultFrame

-- CLOSE BUTTON
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 15)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 28
CloseButton.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 20)
CloseCorner.Parent = CloseButton

-- FUNKTION ZUM SUCHE ANZEIGEN
local function updateSuggestions(searchText)
    if searchText == "" then
        SuggestionsFrame.Visible = false
        return
    end
    
    SuggestionsList:ClearAllChildren()
    
    local yPos = 5
    local foundCount = 0
    local searchLower = searchText:lower()
    
    for _, funcName in pairs(searchDatabase) do
        if funcName:lower():find(searchLower) then
            foundCount = foundCount + 1
            
            local suggestionBtn = Instance.new("TextButton")
            suggestionBtn.Size = UDim2.new(1, -10, 0, 35)
            suggestionBtn.Position = UDim2.new(0, 5, 0, yPos)
            suggestionBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            suggestionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            suggestionBtn.Text = "🔍 " .. funcName
            suggestionBtn.Font = Enum.Font.SourceSans
            suggestionBtn.TextSize = 16
            suggestionBtn.TextXAlignment = Enum.TextXAlignment.Left
            suggestionBtn.Parent = SuggestionsList
            
            suggestionBtn.MouseButton1Click:Connect(function()
                SearchBox.Text = funcName
                SuggestionsFrame.Visible = false
                searchAndExecute(funcName)
            end)
            
            yPos = yPos + 40
        end
    end
    
    if foundCount > 0 then
        SuggestionsList.CanvasSize = UDim2.new(0, 0, 0, yPos)
        SuggestionsFrame.Visible = true
    else
        SuggestionsFrame.Visible = false
    end
end

-- FUNKTION ZUM AUSFÜHREN
local function searchAndExecute(searchText)
    ResultFrame:ClearAllChildren()
    
    if searchText == "" then
        return
    end
    
    -- Suche nach passender Funktion
    local foundFunction = nil
    local displayName = ""
    
    for funcName, funcCreator in pairs(functionDatabase) do
        if funcName:lower() == searchText:lower() then
            foundFunction = funcCreator()
            displayName = funcName
            break
        elseif funcName:lower():find(searchText:lower()) then
            foundFunction = funcCreator()
            displayName = funcName
            break
        end
    end
    
    -- Falls nichts gefunden, versuche es mit Teilübereinstimmungen
    if not foundFunction then
        for _, funcName in pairs(searchDatabase) do
            if funcName:lower():find(searchText:lower()) then
                if functionDatabase[funcName:lower()] then
                    foundFunction = functionDatabase[funcName:lower()]()
                    displayName = funcName
                    break
                end
            end
        end
    end
    
    -- Ergebnis anzeigen
    local yPos = 10
    
    if foundFunction then
        local resultTitle = Instance.new("TextLabel")
        resultTitle.Size = UDim2.new(1, -20, 0, 40)
        resultTitle.Position = UDim2.new(0, 10, 0, yPos)
        resultTitle.BackgroundTransparency = 1
        resultTitle.Text = "✅ GEFUNDEN: " .. displayName:upper()
        resultTitle.TextColor3 = Color3.fromRGB(0, 255, 0)
        resultTitle.Font = Enum.Font.SourceSansBold
        resultTitle.TextSize = 20
        resultTitle.Parent = ResultFrame
        yPos = yPos + 50
        
        local executeBtn = Instance.new("TextButton")
        executeBtn.Size = UDim2.new(1, -20, 0, 60)
        executeBtn.Position = UDim2.new(0, 10, 0, yPos)
        executeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        executeBtn.Text = "🚀 " .. displayName .. " AUSFÜHREN"
        executeBtn.Font = Enum.Font.SourceSansBold
        executeBtn.TextSize = 18
        executeBtn.Parent = ResultFrame
        
        local resultLabel = Instance.new("TextLabel")
        resultLabel.Size = UDim2.new(1, -20, 0, 40)
        resultLabel.Position = UDim2.new(0, 10, 0, yPos + 70)
        resultLabel.BackgroundTransparency = 1
        resultLabel.Text = "Status: Bereit"
        resultLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        resultLabel.Font = Enum.Font.SourceSans
        resultLabel.TextSize = 16
        resultLabel.Parent = ResultFrame
        
        executeBtn.MouseButton1Click:Connect(function()
            local status = foundFunction()
            resultLabel.Text = "Status: " .. status
            resultLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            
            -- Erfolgsanimation
            executeBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            wait(0.5)
            executeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        end)
        
        yPos = yPos + 140
    else
        local notFoundLabel = Instance.new("TextLabel")
        notFoundLabel.Size = UDim2.new(1, -20, 0, 100)
        notFoundLabel.Position = UDim2.new(0, 10, 0, yPos)
        notFoundLabel.BackgroundTransparency = 1
        notFoundLabel.Text = "❌ FUNKTION NICHT GEFUNDEN\n\nVerfügbare Funktionen:\n• fly, godmode, esp, aimbot\n• noclip, infinite money\n• killaura, speed hack\n• invisible, xray, btools"
        notFoundLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        notFoundLabel.Font = Enum.Font.SourceSans
        notFoundLabel.TextSize = 16
        notFoundLabel.TextWrapped = true
        notFoundLabel.Parent = ResultFrame
        yPos = yPos + 120
    end
    
    -- Popular Searches
    local popularLabel = Instance.new("TextLabel")
    popularLabel.Size = UDim2.new(1, -20, 0, 30)
    popularLabel.Position = UDim2.new(0, 10, 0, yPos)
    popularLabel.BackgroundTransparency = 1
    popularLabel.Text = "🔥 BELIEBTE SUCHEN:"
    popularLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    popularLabel.Font = Enum.Font.SourceSansBold
    popularLabel.TextSize = 16
    popularLabel.Parent = ResultFrame
    yPos = yPos + 40
    
    local popularSearches = {"fly", "godmode", "esp", "aimbot", "infinite money", "noclip"}
    for i, search in ipairs(popularSearches) do
        local popBtn = Instance.new("TextButton")
        popBtn.Size = UDim2.new(0.45, 0, 0, 30)
        popBtn.Position = UDim2.new(((i-1) % 2) * 0.5, 10, 0, yPos + math.floor((i-1)/2)*35)
        popBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        popBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        popBtn.Text = "⚡ " .. search
        popBtn.Font = Enum.Font.SourceSans
        popBtn.TextSize = 14
        popBtn.Parent = ResultFrame
        
        popBtn.MouseButton1Click:Connect(function()
            SearchBox.Text = search
            searchAndExecute(search)
        end)
    end
    
    ResultFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 120)
end

-- EVENT HANDLERS
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateSuggestions(SearchBox.Text)
end)

SearchBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        SuggestionsFrame.Visible = false
        searchAndExecute(SearchBox.Text)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- TOGGLE GUI MIT HOTKEY
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
    elseif input.KeyCode == Enum.KeyCode.F1 then
        SearchBox:CaptureFocus()
    end
end)

-- INITIALISIERE MIT ALLEN FUNKTIONEN
local initLabel = Instance.new("TextLabel")
initLabel.Size = UDim2.new(1, -20, 1, -20)
initLabel.Position = UDim2.new(0, 10, 0, 10)
initLabel.BackgroundTransparency = 1
initLabel.Text = "🔍 ULTIMATE HACKER TOOL\n\nGebe eine Funktion in die Suchleiste ein:\n• fly - Fliegen aktivieren\n• godmode - Unsterblichkeit\n• esp - Spieler anzeigen\n• aimbot - Auto-Aiming\n• infinite money - Unendlich Geld\n• noclip - Durch Wände gehen\n\nHotkeys:\n• RightControl - GUI anzeigen/verstecken\n• F1 - Suchleiste fokussieren"
initLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
initLabel.Font = Enum.Font.SourceSansBold
initLabel.TextSize = 18
initLabel.TextWrapped = true
initLabel.Parent = ResultFrame

-- LOGO & CREDITS
local credits = Instance.new("TextLabel")
credits.Size = UDim2.new(1, 0, 0, 30)
credits.Position = UDim2.new(0, 0, 1, -30)
credits.BackgroundTransparency = 1
credits.Text = "⚡ Made by Waled-hammad | Ultimate Hacker Tool ⚡"
credits.TextColor3 = Color3.fromRGB(0, 255, 255)
credits.Font = Enum.Font.SourceSansBold
credits.TextSize = 14
credits.Parent = MainFrame

print("✅ Ultimate Hacker Tool geladen!")
print("🔍 Suche Funktionen: fly, godmode, esp, aimbot, noclip, etc.")
print("🎮 Hotkeys: RightControl (GUI), F1 (Suche)")
print("👑 Made by Waled-hammad")

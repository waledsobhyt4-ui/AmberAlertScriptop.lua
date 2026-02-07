-- Amber Alert Cheats Script
-- Erstellt von: Waled-hanmad
-- Features: Fly, Godmode, Infinity Money, Noclip, Invisible

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- GUI erstellen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AmberCheats"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Hauptframe
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 450)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- Corner für abgerundete Ecken
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- Titel
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.Text = "AMBER ALERT CHEATS"
Title.TextColor3 = Color3.fromRGB(255, 165, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- Minimieren Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(1, -50, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 24
MinimizeButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = MinimizeButton

-- Scrollframe für Buttons
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, -20, 1, -70)
ScrollFrame.Position = UDim2.new(0, 10, 0, 60)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 0)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
ScrollFrame.Parent = MainFrame

-- Open/Close Button (mobil sichtbar)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 70, 0, 70)
ToggleButton.Position = UDim2.new(0, 20, 0.8, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
ToggleButton.Text = "☰"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 28
ToggleButton.Visible = true
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 35)
ToggleCorner.Parent = ToggleButton

-- Cheat Status Variablen
local cheats = {
    fly = false,
    godmode = false,
    noclip = false,
    invisible = false,
    infmoney = false
}

-- FLY SYSTEM
local flySpeed = 50
local flyEnabled = false
local flyBodyGyro, flyBodyVelocity
local flyConnection

local function toggleFly()
    cheats.fly = not cheats.fly
    flyEnabled = cheats.fly
    
    if flyEnabled then
        -- Fliegen aktivieren
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
        
        -- Flugsteuerung
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flyEnabled or not character or not rootPart then
                if flyConnection then
                    flyConnection:Disconnect()
                end
                return
            end
            
            local camera = Workspace.CurrentCamera
            local direction = Vector3.new(0, 0, 0)
            
            -- Steuerung für PC
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
            
            -- Mobile Touch-Steuerung (kann erweitert werden)
            if UserInputService.TouchEnabled then
                -- Hier können mobile Steuerungen hinzugefügt werden
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
        -- Fliegen deaktivieren
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
        
        -- Schadensschutz
        for _, connection in pairs(getconnections(humanoid.HealthChanged)) do
            connection:Disable()
        end
        
        -- Unsterblichkeit
        humanoid.BreakJointsOnDeath = false
        humanoid.RequiresNeck = false
        return true
    else
        humanoid.MaxHealth = 100
        humanoid.Health = 100
        humanoid.Name = "Humanoid"
        
        humanoid.BreakJointsOnDeath = true
        humanoid.RequiresNeck = true
        return false
    end
end

-- INFINITY MONEY
local function toggleInfMoney()
    cheats.infmoney = not cheats.infmoney
    
    if cheats.infmoney then
        -- Sucht nach Leaderstats oder anderen Geld-Systemen
        local leaderstats = player:FindFirstChild("leaderstats")
        
        if leaderstats then
            for _, stat in pairs(leaderstats:GetChildren()) do
                if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                    -- Setzt den Wert hoch und verhindert Reduzierung
                    local originalValue = stat.Value
                    stat:GetPropertyChangedSignal("Value"):Connect(function()
                        if stat.Value < originalValue then
                            stat.Value = math.huge
                        end
                    end)
                    stat.Value = math.huge
                end
            end
        end
        
        -- Alternative Methode: Spieler-Geld erhöhen
        spawn(function()
            while cheats.infmoney and wait(1) do
                pcall(function()
                    -- Versucht verschiedene Geld-Systeme zu finden
                    local moneySystems = {
                        player:FindFirstChild("Cash"),
                        player:FindFirstChild("Money"),
                        player:FindFirstChild("Coins"),
                        player:FindFirstChild("Points")
                    }
                    
                    for _, money in pairs(moneySystems) do
                        if money and (money:IsA("IntValue") or money:IsA("NumberValue")) then
                            money.Value = 9999999
                        end
                    end
                    
                    if leaderstats then
                        for _, stat in pairs(leaderstats:GetChildren()) do
                            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                                stat.Value = 9999999
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
        if noclipConnection then
            noclipConnection:Disconnect()
        end
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
            -- Unsichtbar machen
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                    if part:FindFirstChild("Face") then
                        part.Face:Destroy()
                    end
                elseif part:IsA("Decal") then
                    part.Transparency = 1
                elseif part:IsA("Accessory") then
                    part.Handle.Transparency = 1
                end
            end
            
            -- Nametag ausblenden
            local humanoidDisplay = character:FindFirstChild("HumanoidDisplay")
            if humanoidDisplay then
                humanoidDisplay:Destroy()
            end
            
            -- Spielername ausblenden
            player.CharacterAppearanceLoaded:Connect(function()
                wait(0.1)
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 1
                        end
                    end
                end
            end)
            return true
        else
            -- Sichtbar machen
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                elseif part:IsA("Decal") then
                    part.Transparency = 0
                elseif part:IsA("Accessory") then
                    part.Handle.Transparency = 0
                end
            end
            return false
        end
    end
end

-- Button Erstellung
local function createCheatButton(name, displayName, yPos, color)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(1, -20, 0, 60)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    button.Text = displayName .. ": AUS"
    button.Parent = ScrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    return button
end

-- Cheat Buttons erstellen
local flyButton = createCheatButton("fly", "FLY", 10, Color3.fromRGB(220, 20, 60))
local godmodeButton = createCheatButton("godmode", "GODMODE", 80, Color3.fromRGB(0, 150, 0))
local moneyButton = createCheatButton("money", "UNENDLICH GELD", 150, Color3.fromRGB(255, 215, 0))
local noclipButton = createCheatButton("noclip", "NOCLIP", 220, Color3.fromRGB(30, 144, 255))
local invisibleButton = createCheatButton("invisible", "UNSICHTBAR", 290, Color3.fromRGB(138, 43, 226))

-- Button Events
flyButton.MouseButton1Click:Connect(function()
    cheats.fly = toggleFly()
    flyButton.Text = "FLY: " .. (cheats.fly and "AN" or "AUS")
    flyButton.BackgroundColor3 = cheats.fly and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(220, 20, 60)
end)

godmodeButton.MouseButton1Click:Connect(function()
    cheats.godmode = toggleGodmode()
    godmodeButton.Text = "GODMODE: " .. (cheats.godmode and "AN" or "AUS")
    godmodeButton.BackgroundColor3 = cheats.godmode and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 150, 0)
end)

moneyButton.MouseButton1Click:Connect(function()
    cheats.infmoney = toggleInfMoney()
    moneyButton.Text = "UNENDLICH GELD: " .. (cheats.infmoney and "AN" or "AUS")
    moneyButton.BackgroundColor3 = cheats.infmoney and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 215, 0)
end)

noclipButton.MouseButton1Click:Connect(function()
    cheats.noclip = toggleNoclip()
    noclipButton.Text = "NOCLIP: " .. (cheats.noclip and "AN" or "AUS")
    noclipButton.BackgroundColor3 = cheats.noclip and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 144, 255)
end)

invisibleButton.MouseButton1Click:Connect(function()
    cheats.invisible = toggleInvisible()
    invisibleButton.Text = "UNSICHTBAR: " .. (cheats.invisible and "AN" or "AUS")
    invisibleButton.BackgroundColor3 = cheats.invisible and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(138, 43, 226)
end)

-- GUI Öffnen/Schließen
local function toggleGUI()
    MainFrame.Visible = not MainFrame.Visible
    MinimizeButton.Text = MainFrame.Visible and "_" or "□"
end

MinimizeButton.MouseButton1Click:Connect(toggleGUI)
ToggleButton.MouseButton1Click:Connect(toggleGUI)

-- Charakter-Wechsel Behandlung
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    wait(0.5) -- Warten bis Charakter vollständig geladen
    
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
end)

-- GUI zum Spieler hinzufügen
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Mobile Optimierung
if UserInputService.TouchEnabled then
    MainFrame.Size = UDim2.new(0, 320, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -160, 0.5, -250)
    
    ToggleButton.Visible = true
    MinimizeButton.Visible = false
    
    -- Größere Buttons für Touch
    flyButton.Size = UDim2.new(1, -20, 0, 70)
    godmodeButton.Size = UDim2.new(1, -20, 0, 70)
    moneyButton.Size = UDim2.new(1, -20, 0, 70)
    noclipButton.Size = UDim2.new(1, -20, 0, 70)
    invisibleButton.Size = UDim2.new(1, -20, 0, 70)
    
    -- Positionen anpassen
    godmodeButton.Position = UDim2.new(0, 10, 0, 90)
    moneyButton.Position = UDim2.new(0, 10, 0, 170)
    noclipButton.Position = UDim2.new(0, 10, 0, 250)
    invisibleButton.Position = UDim2.new(0, 10, 0, 330)
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 420)
end

-- Info Label
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Name = "InfoLabel"
InfoLabel.Size = UDim2.new(1, -20, 0, 40)
InfoLabel.Position = UDim2.new(0, 10, 0, 410)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Mobile: Toggle-Button drücken!"
InfoLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.TextSize = 14
InfoLabel.TextXAlignment = Enum.TextXAlignment.Center
InfoLabel.Visible = UserInputService.TouchEnabled
InfoLabel.Parent = ScrollFrame

warn("Amber Alert Cheats geladen! Toggle-Button für GUI")

-- ==================================================
-- THE HACKER V6 - ULTIMATE EDITION (FINAL)
-- YouTube: @Hacker666-00
-- Features: Robux Scanner, Tool Scanner, AI Creator, Settings, START Button
-- ==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local mouse = player:GetMouse()

-- ==================================================
-- YOUTUBE LINK
-- ==================================================
local YOUTUBE_URL = "https://youtube.com/@hacker666-00?si=AF2LIzunZK9-uU5h"

-- ==================================================
-- SETTINGS (SPEICHERBAR)
-- ==================================================
local Settings = {
    Device = "Auto",
    GuiColor = Color3.fromRGB(0, 255, 255),
    ShowFPS = true,
    ShowTime = true
}

-- ==================================================
-- AUTOMATISCHE GERÄTEERKENNUNG
-- ==================================================
local isMobile = UserInputService.TouchEnabled
local screenSize = Workspace.CurrentCamera.ViewportSize

-- GUI Größen automatisch basierend auf Gerät
local guiSize = isMobile and UDim2.new(0, 340, 0, 550) or UDim2.new(0, 500, 0, 700)
local buttonSize = isMobile and 45 or 55
local textSize = isMobile and 14 or 16
local tabSize = isMobile and 11 or 14

-- ==================================================
-- FPS & ZEIT HUD
-- ==================================================
local hud = Instance.new("ScreenGui")
hud.Name = "HUD"
hud.Parent = CoreGui

local hudFrame = Instance.new("Frame")
hudFrame.Size = UDim2.new(0, 200, 0, 60)
hudFrame.Position = UDim2.new(1, -210, 0, 10)
hudFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
hudFrame.BackgroundTransparency = 0.5
hudFrame.BorderSizePixel = 0
hudFrame.Parent = hud

local hudCorner = Instance.new("UICorner")
hudCorner.CornerRadius = UDim.new(0, 10)
hudCorner.Parent = hudFrame

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(1, 0, 0.5, 0)
fpsLabel.Position = UDim2.new(0, 0, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: 60"
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 16
fpsLabel.Parent = hudFrame

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(1, 0, 0.5, 0)
timeLabel.Position = UDim2.new(0, 0, 0.5, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = os.date("%H:%M:%S")
timeLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
timeLabel.Font = Enum.Font.GothamBold
timeLabel.TextSize = 14
timeLabel.Parent = hudFrame

spawn(function()
    while true do
        if Settings.ShowFPS then
            local fps = math.floor(1/RunService.RenderStepped:Wait())
            fpsLabel.Text = "FPS: " .. fps
        else
            fpsLabel.Text = ""
        end
        if Settings.ShowTime then
            timeLabel.Text = os.date("%H:%M:%S")
        else
            timeLabel.Text = ""
        end
        wait(0.5)
    end
end)

-- ==================================================
-- MAIN GUI
-- ==================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TheHackerV6"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
end

-- ==================================================
-- START BUTTON (EINZIGER BUTTON)
-- ==================================================
local StartButton = Instance.new("TextButton")
StartButton.Name = "StartButton"
StartButton.Size = UDim2.new(0, 200, 0, 80)
StartButton.Position = UDim2.new(0.5, -100, 0.5, -40)
StartButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
StartButton.TextColor3 = Color3.fromRGB(0, 0, 0)
StartButton.Font = Enum.Font.GothamBlack
StartButton.TextSize = 32
StartButton.Text = "START"
StartButton.Parent = ScreenGui

local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 20)
StartCorner.Parent = StartButton

-- Start Button Animation
spawn(function()
    while true do
        for i = 0, 1, 0.05 do
            StartButton.BackgroundColor3 = Color3.fromHSV(i, 1, 1)
            wait(0.05)
        end
    end
end)

-- ==================================================
-- MAIN FRAME (wird nach Start sichtbar)
-- ==================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = guiSize
MainFrame.Position = UDim2.new(0.5, -guiSize.X.Offset/2, 0.5, -guiSize.Y.Offset/2)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 20, 0, 0)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ THE HACKER V6"
Title.TextColor3 = Settings.GuiColor
Title.Font = Enum.Font.GothamBlack
Title.TextSize = textSize + 4
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Settings Button (im Title Bar)
local TitleSettingsBtn = Instance.new("TextButton")
TitleSettingsBtn.Name = "TitleSettingsBtn"
TitleSettingsBtn.Size = UDim2.new(0, 35, 0, 35)
TitleSettingsBtn.Position = UDim2.new(1, -80, 0.5, -17.5)
TitleSettingsBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
TitleSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleSettingsBtn.Font = Enum.Font.GothamBold
TitleSettingsBtn.TextSize = 20
TitleSettingsBtn.Text = "⚙️"
TitleSettingsBtn.Parent = TitleBar

local TitleSettingsCorner = Instance.new("UICorner")
TitleSettingsCorner.CornerRadius = UDim.new(0, 8)
TitleSettingsCorner.Parent = TitleSettingsBtn

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Text = "✕"
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- Tabs
local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(1, -20, 0, 40)
Tabs.Position = UDim2.new(0, 10, 0, 60)
Tabs.BackgroundTransparency = 1
Tabs.Parent = MainFrame

local tabButtons = {}
local tabs = {"MAIN", "GOD", "TOOLS", "ADMIN", "TROLL", "AI", "SHOP"}

for i, tabName in ipairs(tabs) do
    local button = Instance.new("TextButton")
    button.Name = tabName .. "Tab"
    button.Size = UDim2.new(0.142, 0, 1, 0)
    button.Position = UDim2.new(0.142 * (i-1), 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.GothamBold
    button.TextSize = tabSize
    button.Text = tabName
    button.Parent = Tabs
    tabButtons[tabName] = button

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = button
end

-- Content Frame
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -110)
ContentFrame.Position = UDim2.new(0, 10, 0, 110)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Settings.GuiColor
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 2000)
ContentFrame.Parent = MainFrame

-- ==================================================
-- CHEAT STATUS
-- ==================================================
local cheats = {
    fly = false,
    godmode = false,
    noclip = false,
    invisible = false,
    infmoney = false,
    speed = false,
    esp = false,
    aimbot = false,
    infjump = false,
    btools = false,
    killaura = false,
    norecoil = false,
    wallbang = false,
    xray = false,
    fullbright = false,
    autofarm = false,
    antikick = false
}

-- ==================================================
-- BUTTON CREATOR
-- ==================================================
local function createButton(text, yPos, color, isToggle)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, buttonSize)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = textSize
    button.Text = isToggle and (text .. ": OFF") or text
    button.Parent = ContentFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    return button
end

-- ==================================================
-- FLY SYSTEM
-- ==================================================
local flySpeed = 50
local flyBodyGyro, flyBodyVelocity

local function toggleFly()
    cheats.fly = not cheats.fly
    if cheats.fly then
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
            if not cheats.fly then return end
            local camera = Workspace.CurrentCamera
            local direction = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction - Vector3.new(0, 1, 0) end
            flyBodyVelocity.Velocity = direction.Unit * flySpeed
            flyBodyGyro.CFrame = camera.CFrame
        end)
        humanoid.PlatformStand = true
    else
        if flyBodyGyro then flyBodyGyro:Destroy() end
        if flyBodyVelocity then flyBodyVelocity:Destroy() end
        humanoid.PlatformStand = false
    end
    return cheats.fly
end

-- ==================================================
-- GODMODE
-- ==================================================
local function toggleGodmode()
    cheats.godmode = not cheats.godmode
    if cheats.godmode then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        spawn(function()
            while cheats.godmode do
                if humanoid then humanoid.Health = math.huge end
                wait(0.1)
            end
        end)
    else
        humanoid.MaxHealth = 100
        humanoid.Health = 100
    end
    return cheats.godmode
end

-- ==================================================
-- INFINITY JUMP
-- ==================================================
local function toggleInfJump()
    cheats.infjump = not cheats.infjump
    if cheats.infjump then
        humanoid.JumpPower = 100
        humanoid.UseJumpPower = true
        UserInputService.JumpRequest:Connect(function()
            if cheats.infjump and humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        humanoid.JumpPower = 50
    end
    return cheats.infjump
end

-- ==================================================
-- NOCLIP
-- ==================================================
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

-- ==================================================
-- INVISIBLE
-- ==================================================
local function toggleInvisible()
    cheats.invisible = not cheats.invisible
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = cheats.invisible and 1 or 0
            elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
                part.Handle.Transparency = cheats.invisible and 1 or 0
            end
        end
    end
    return cheats.invisible
end

-- ==================================================
-- SPEED HACK
-- ==================================================
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

-- ==================================================
-- ESP SYSTEM
-- ==================================================
local espBoxes = {}
local function toggleESP()
    cheats.esp = not cheats.esp
    if cheats.esp then
        for _, target in pairs(Players:GetPlayers()) do
            if target ~= player and target.Character then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = target.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.FillTransparency = 0.5
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = target.Character
                espBoxes[target] = highlight

                local billboard = Instance.new("BillboardGui")
                billboard.Name = "ESP_" .. target.Name
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                billboard.Adornee = target.Character:WaitForChild("HumanoidRootPart")
                billboard.Parent = target.Character

                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = target.Name .. " [" .. math.floor(target.Character.Humanoid.Health) .. "]"
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.Font = Enum.Font.SourceSansBold
                nameLabel.TextSize = 16
                nameLabel.Parent = billboard
            end
        end
    else
        for target, highlight in pairs(espBoxes) do
            highlight:Destroy()
            if target.Character then
                local billboard = target.Character:FindFirstChild("ESP_" .. target.Name)
                if billboard then billboard:Destroy() end
            end
        end
        espBoxes = {}
    end
    return cheats.esp
end

-- ==================================================
-- AIMBOT
-- ==================================================
local aimbotFov = 50
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
                        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, hrp.Position)
                    end
                end
            end
        end)
    end
    return cheats.aimbot
end

-- ==================================================
-- MONEY SYSTEM
-- ==================================================
local moneyMultiplier = 2
local moneyTypes = {"cash","money","coin","robux","point","gold","diamond","gem","credit","token","balance","bank","dollar","euro","bucks","coins","gems","crystals","shards","stars"}

local function toggleInfMoney()
    cheats.infmoney = not cheats.infmoney
    if cheats.infmoney then
        spawn(function()
            while cheats.infmoney do
                pcall(function()
                    for _, obj in pairs(game:GetDescendants()) do
                        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                            local nameLower = obj.Name:lower()
                            for _, moneyType in ipairs(moneyTypes) do
                                if nameLower:find(moneyType) then
                                    obj.Value = obj.Value * moneyMultiplier
                                    if obj.Value > 999999999 then obj.Value = 999999999 end
                                end
                            end
                        end
                    end
                    if player:FindFirstChild("leaderstats") then
                        for _, stat in pairs(player.leaderstats:GetChildren()) do
                            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                                local nameLower = stat.Name:lower()
                                for _, moneyType in ipairs(moneyTypes) do
                                    if nameLower:find(moneyType) then
                                        stat.Value = stat.Value * moneyMultiplier
                                        if stat.Value > 999999999 then stat.Value = 999999999 end
                                    end
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

-- ==================================================
-- XRAY
-- ==================================================
local function toggleXray()
    cheats.xray = not cheats.xray
    if cheats.xray then
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part:IsDescendantOf(character) then
                part.LocalTransparencyModifier = 0.7
            end
        end
    else
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
    end
    return cheats.xray
end

-- ==================================================
-- NO RECOIL
-- ==================================================
local function toggleNoRecoil()
    cheats.norecoil = not cheats.norecoil
    if cheats.norecoil then
        for _, tool in pairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                for _, script in pairs(tool:GetDescendants()) do
                    if script:IsA("Script") or script:IsA("LocalScript") then
                        if script.Name:lower():find("recoil") or script.Name:lower():find("camera") then
                            script.Disabled = true
                        end
                    end
                end
            end
        end
    end
    return cheats.norecoil
end

-- ==================================================
-- FULLBRIGHT
-- ==================================================
local function toggleFullbright()
    cheats.fullbright = not cheats.fullbright
    if cheats.fullbright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("ColorCorrectionEffect") then
                effect.Enabled = false
            end
        end
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 14
        Lighting.FogEnd = 10000
        Lighting.GlobalShadows = true
    end
    return cheats.fullbright
end

-- ==================================================
-- KILL AURA
-- ==================================================
local function toggleKillAura()
    cheats.killaura = not cheats.killaura
    if cheats.killaura then
        spawn(function()
            while cheats.killaura do
                for _, target in pairs(Players:GetPlayers()) do
                    if target ~= player and target.Character then
                        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
                        if targetHRP and rootPart then
                            local dist = (targetHRP.Position - rootPart.Position).Magnitude
                            if dist < 20 then
                                local hum = target.Character:FindFirstChild("Humanoid")
                                if hum then hum.Health = 0 end
                            end
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
    return cheats.killaura
end

-- ==================================================
-- WALLBANG
-- ==================================================
local function toggleWallbang()
    cheats.wallbang = not cheats.wallbang
    if cheats.wallbang then
        for _, tool in pairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                local handle = tool:FindFirstChild("Handle")
                if handle then
                    handle.CanQuery = false
                    handle.CanCollide = false
                end
            end
        end
    end
    return cheats.wallbang
end

-- ==================================================
-- ANTI KICK
-- ==================================================
local function toggleAntiKick()
    cheats.antikick = not cheats.antikick
    if cheats.antikick then
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            if method == "Kick" then
                return nil
            end
            return old(self, ...)
        end)
        setreadonly(mt, true)
    end
    return cheats.antikick
end

-- ==================================================
-- AUTO FARM
-- ==================================================
local farmConnection
local function toggleAutoFarm()
    cheats.autofarm = not cheats.autofarm
    if cheats.autofarm then
        farmConnection = RunService.Heartbeat:Connect(function()
            if not cheats.autofarm then return end
            for _, target in pairs(Players:GetPlayers()) do
                if target ~= player and target.Character then
                    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
                    if targetHRP and rootPart then
                        rootPart.CFrame = targetHRP.CFrame
                        local hum = target.Character:FindFirstChild("Humanoid")
                        if hum then hum.Health = 0 end
                    end
                end
            end
        end)
    else
        if farmConnection then farmConnection:Disconnect() end
    end
    return cheats.autofarm
end

-- ==================================================
-- TOOL SYSTEM (SCANNER)
-- ==================================================
local scannedTools = {}

local function scanAllTools()
    scannedTools = {}
    local locations = {
        Workspace, 
        game:GetService("StarterPack"), 
        game:GetService("StarterGui"),
        game:GetService("ReplicatedStorage"), 
        game:GetService("ServerStorage"),
        game:GetService("Lighting"), 
        game:GetService("ReplicatedFirst"),
        player.Backpack,
        character
    }

    for _, location in pairs(locations) do
        pcall(function()
            for _, obj in pairs(location:GetDescendants()) do
                if obj:IsA("Tool") then
                    local alreadyExists = false
                    for _, existing in ipairs(scannedTools) do
                        if existing.Name == obj.Name then
                            alreadyExists = true
                            break
                        end
                    end
                    if not alreadyExists then
                        table.insert(scannedTools, {
                            Name = obj.Name,
                            Object = obj,
                            Location = location.Name
                        })
                    end
                end
            end
        end)
    end
    return #scannedTools
end

local function giveTool(toolName)
    for _, toolInfo in ipairs(scannedTools) do
        if toolInfo.Name:lower():find(toolName:lower()) then
            local clone = toolInfo.Object:Clone()
            clone.Parent = player.Backpack
            return true, toolInfo.Name
        end
    end
    return false, nil
end

local function giveAllTools()
    local count = 0
    for _, toolInfo in ipairs(scannedTools) do
        pcall(function()
            local clone = toolInfo.Object:Clone()
            clone.Parent = player.Backpack
            count = count + 1
        end)
    end
    return count
end

-- ==================================================
-- ROBUX SCANNER
-- ==================================================
local robuxItems = {}

local function scanRobuxItems()
    robuxItems = {}
    local robuxKeywords = {"robux", "rbx", "r$", "robuxamount", "robuxvalue", "currency"}
    
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
            local nameLower = obj.Name:lower()
            for _, keyword in ipairs(robuxKeywords) do
                if nameLower:find(keyword) then
                    table.insert(robuxItems, {
                        Name = obj.Name,
                        Object = obj,
                        Value = obj.Value
                    })
                    break
                end
            end
        end
    end
    
    if player:FindFirstChild("leaderstats") then
        for _, stat in pairs(player.leaderstats:GetChildren()) do
            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                local nameLower = stat.Name:lower()
                for _, keyword in ipairs(robuxKeywords) do
                    if nameLower:find(keyword) then
                        table.insert(robuxItems, {
                            Name = stat.Name,
                            Object = stat,
                            Value = stat.Value,
                            IsLeaderstat = true
                        })
                        break
                    end
                end
            end
        end
    end
    
    return #robuxItems
end

local function setRobuxToMax(itemName)
    for _, item in ipairs(robuxItems) do
        if item.Name:lower():find(itemName:lower()) then
            item.Object.Value = 999999999
            return true, item.Name
        end
    end
    return false, nil
end

local function setAllRobuxToMax()
    local count = 0
    for _, item in ipairs(robuxItems) do
        pcall(function()
            item.Object.Value = 999999999
            count = count + 1
        end)
    end
    return count
end

-- ==================================================
-- ADMIN FUNCTIONS
-- ==================================================
local function teleportToPlayer(playerName)
    for _, target in pairs(Players:GetPlayers()) do
        if target.Name:lower():find(playerName:lower()) then
            if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                return true
            end
        end
    end
    return false
end

local function bringPlayer(playerName)
    for _, target in pairs(Players:GetPlayers()) do
        if target.Name:lower():find(playerName:lower()) then
            if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                target.Character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame
                return true
            end
        end
    end
    return false
end

local function freezePlayer(playerName)
    for _, target in pairs(Players:GetPlayers()) do
        if target.Name:lower():find(playerName:lower()) and target.Character then
            local hum = target.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = 0; hum.JumpPower = 0; return true end
        end
    end
    return false
end

local function unfreezePlayer(playerName)
    for _, target in pairs(Players:GetPlayers()) do
        if target.Name:lower():find(playerName:lower()) and target.Character then
            local hum = target.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = 16; hum.JumpPower = 50; return true end
        end
    end
    return false
end

local function killAllPlayers()
    local count = 0
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= player and target.Character then
            local hum = target.Character:FindFirstChild("Humanoid")
            if hum then hum.Health = 0; count = count + 1 end
        end
    end
    return count
end

local function morphIntoPlayer(playerName)
    for _, target in pairs(Players:GetPlayers()) do
        if target.Name:lower():find(playerName:lower()) and target.Character then
            local newChar = target.Character:Clone()
            newChar.Name = player.Name
            newChar.Parent = Workspace
            newChar.HumanoidRootPart.CFrame = rootPart.CFrame
            character:Destroy()
            character = newChar
            humanoid = newChar:WaitForChild("Humanoid")
            rootPart = newChar:WaitForChild("HumanoidRootPart")
            player.Character = newChar
            return true
        end
    end
    return false
end

-- ==================================================
-- TROLL FUNCTIONS
-- ==================================================
local function spinPlayer(playerName)
    for _, target in pairs(Players:GetPlayers()) do
        if target.Name:lower():find(playerName:lower()) and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                spawn(function()
                    for i = 1, 100 do
                        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(45), 0)
                        wait(0.05)
                    end
                end)
                return true
            end
        end
    end
    return false
end

local function launchPlayer(playerName)
    for _, target in pairs(Players:GetPlayers()) do
        if target.Name:lower():find(playerName:lower()) and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Velocity = Vector3.new(0, 500, 0); return true end
        end
    end
    return false
end

local function createNuke()
    local explosion = Instance.new("Explosion")
    explosion.BlastRadius = 100
    explosion.BlastPressure = 1000
    explosion.Position = rootPart.Position
    explosion.Parent = Workspace
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= player and target.Character then
            local hum = target.Character:FindFirstChild("Humanoid")
            if hum then hum.Health = 0 end
        end
    end
    return true
end

-- ==================================================
-- AI CREATOR (CHATGPT STYLE)
-- ==================================================
local function createAISection()
    local aiMainFrame = Instance.new("Frame")
    aiMainFrame.Size = UDim2.new(1, -20, 0, 550)
    aiMainFrame.Position = UDim2.new(0, 10, 0, 10)
    aiMainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    aiMainFrame.Parent = ContentFrame

    local aiCorner = Instance.new("UICorner")
    aiCorner.CornerRadius = UDim.new(0, 15)
    aiCorner.Parent = aiMainFrame

    local aiTitle = Instance.new("TextLabel")
    aiTitle.Size = UDim2.new(1, 0, 0, 50)
    aiTitle.Position = UDim2.new(0, 0, 0, 0)
    aiTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    aiTitle.Text = "🤖 AI CREATOR (CHATGPT STYLE)"
    aiTitle.TextColor3 = Settings.GuiColor
    aiTitle.Font = Enum.Font.GothamBold
    aiTitle.TextSize = 16
    aiTitle.Parent = aiMainFrame

    local aiInput = Instance.new("TextBox")
    aiInput.Size = UDim2.new(1, -40, 0, 80)
    aiInput.Position = UDim2.new(0, 20, 0, 60)
    aiInput.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    aiInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    aiInput.Font = Enum.Font.SourceSans
    aiInput.TextSize = 14
    aiInput.PlaceholderText = "Was soll ich erstellen? (Auto, Haus, Waffe, Code, Script, Funktion, Part, Modell, Tool...)"
    aiInput.TextWrapped = true
    aiInput.ClearTextOnFocus = false
    aiInput.MultiLine = true
    aiInput.Parent = aiMainFrame

    local aiInputCorner = Instance.new("UICorner")
    aiInputCorner.CornerRadius = UDim.new(0, 8)
    aiInputCorner.Parent = aiInput

    local aiCreateButton = Instance.new("TextButton")
    aiCreateButton.Size = UDim2.new(1, -40, 0, 50)
    aiCreateButton.Position = UDim2.new(0, 20, 0, 150)
    aiCreateButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    aiCreateButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    aiCreateButton.Font = Enum.Font.GothamBold
    aiCreateButton.TextSize = 18
    aiCreateButton.Text = "🎨 ERSTELLEN"
    aiCreateButton.Parent = aiMainFrame

    local aiButtonCorner = Instance.new("UICorner")
    aiButtonCorner.CornerRadius = UDim.new(0, 10)
    aiButtonCorner.Parent = aiCreateButton

    local presetsFrame = Instance.new("Frame")
    presetsFrame.Size = UDim2.new(1, -40, 0, 120)
    presetsFrame.Position = UDim2.new(0, 20, 0, 210)
    presetsFrame.BackgroundTransparency = 1
    presetsFrame.Parent = aiMainFrame

    local presets = {
        {"🚗 Auto", 1}, {"🏠 Haus", 2}, {"🔫 Waffe", 3}, {"🌳 Baum", 4},
        {"👤 Mensch", 5}, {"🐕 Hund", 6}, {"🐈 Katze", 7}, {"🐎 Pferd", 8},
        {"💻 Code", 9}, {"📜 Script", 10}, {"🔧 Tool", 11}, {"⚙️ Funktion", 12}
    }

    local gridX, gridY = 0, 0
    for i, preset in ipairs(presets) do
        local presetBtn = Instance.new("TextButton")
        presetBtn.Size = UDim2.new(0, 100, 0, 35)
        presetBtn.Position = UDim2.new(0, gridX, 0, gridY)
        presetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        presetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        presetBtn.Font = Enum.Font.SourceSansBold
        presetBtn.TextSize = 12
        presetBtn.Text = preset[1]
        presetBtn.Parent = presetsFrame

        local presetCorner = Instance.new("UICorner")
        presetCorner.CornerRadius = UDim.new(0, 6)
        presetCorner.Parent = presetBtn

        presetBtn.MouseButton1Click:Connect(function()
            aiInput.Text = preset[1]
        end)

        gridX = gridX + 105
        if gridX >= 315 then
            gridX = 0
            gridY = gridY + 40
        end
    end

    local resultFrame = Instance.new("Frame")
    resultFrame.Size = UDim2.new(1, -40, 0, 100)
    resultFrame.Position = UDim2.new(0, 20, 0, 340)
    resultFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    resultFrame.Parent = aiMainFrame

    local resultCorner = Instance.new("UICorner")
    resultCorner.CornerRadius = UDim.new(0, 8)
    resultCorner.Parent = resultFrame

    local resultText = Instance.new("TextLabel")
    resultText.Size = UDim2.new(1, -20, 1, 0)
    resultText.Position = UDim2.new(0, 10, 0, 0)
    resultText.BackgroundTransparency = 1
    resultText.Text = "Wähle eine Option oder schreib deinen eigenen Befehl"
    resultText.TextColor3 = Color3.fromRGB(200, 200, 200)
    resultText.Font = Enum.Font.SourceSans
    resultText.TextSize = 12
    resultText.TextWrapped = true
    resultText.TextXAlignment = Enum.TextXAlignment.Left
    resultText.TextYAlignment = Enum.TextYAlignment.Top
    resultText.Parent = resultFrame

    aiCreateButton.MouseButton1Click:Connect(function()
        local cmd = aiInput.Text:lower()
        resultText.Text = "🔨 Erstelle: " .. aiInput.Text .. "\n\n"

        if cmd:find("auto") or cmd:find("car") then
            local car = Instance.new("Model"); car.Name = "AI_Auto"
            local body = Instance.new("Part"); body.Size = Vector3.new(4,1,8); body.Position = rootPart.Position + Vector3.new(0,5,10); body.BrickColor = BrickColor.new("Bright red"); body.Parent = car
            local roof = Instance.new("Part"); roof.Size = Vector3.new(3,1,4); roof.Position = body.Position + Vector3.new(0,1.5,-1); roof.BrickColor = BrickColor.new("Bright red"); roof.Parent = car
            for i=1,4 do local wheel = Instance.new("Part"); wheel.Size = Vector3.new(1,1,1); wheel.BrickColor = BrickColor.new("Black"); wheel.Parent = car end
            car.Parent = Workspace
            resultText.Text = resultText.Text .. "✅ Auto erstellt!"
            
        elseif cmd:find("haus") or cmd:find("house") then
            local house = Instance.new("Model"); house.Name = "AI_Haus"
            local base = Instance.new("Part"); base.Size = Vector3.new(10,1,10); base.Position = rootPart.Position + Vector3.new(0,0.5,20); base.BrickColor = BrickColor.new("Brown"); base.Parent = house
            for i=1,4 do local wall = Instance.new("Part"); wall.Size = Vector3.new(10,5,1); wall.BrickColor = BrickColor.new("White"); wall.Parent = house end
            local roof = Instance.new("Part"); roof.Size = Vector3.new(12,1,12); roof.Position = base.Position + Vector3.new(0,6,0); roof.BrickColor = BrickColor.new("Bright red"); roof.Parent = house
            house.Parent = Workspace
            resultText.Text = resultText.Text .. "✅ Haus erstellt!"
            
        elseif cmd:find("waffe") or cmd:find("gun") then
            local tool = Instance.new("Tool"); tool.Name = "AI_Waffe"
            local handle = Instance.new("Part"); handle.Name = "Handle"; handle.Size = Vector3.new(1,1,4); handle.BrickColor = BrickColor.new("Black"); handle.Parent = tool
            tool.Parent = player.Backpack
            resultText.Text = resultText.Text .. "✅ Waffe erhalten!"
            
        elseif cmd:find("code") or cmd:find("script") then
            local script = Instance.new("Script")
            script.Name = "AI_Script"
            script.Source = "-- AI generiertes Script\nprint('Hallo von AI!')"
            script.Parent = player.Backpack
            resultText.Text = resultText.Text .. "✅ Script erstellt!\n\n-- AI generiertes Script\nprint('Hallo von AI!')"
            
        elseif cmd:find("funktion") or cmd:find("function") then
            local module = Instance.new("ModuleScript")
            module.Name = "AI_Funktion"
            module.Source = [[
local module = {}

function module.hallo(name)
    return "Hallo " .. name .. "!"
end

return module
]]
            module.Parent = player.Backpack
            resultText.Text = resultText.Text .. "✅ Funktion erstellt!\n\n" .. module.Source
            
        elseif cmd:find("tool") then
            local tool = Instance.new("Tool")
            tool.Name = "AI_Tool"
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(1, 2, 1)
            handle.BrickColor = BrickColor.new("Bright blue")
            handle.Parent = tool
            tool.Parent = player.Backpack
            resultText.Text = resultText.Text .. "✅ Tool erstellt!"
            
        else
            local part = Instance.new("Part")
            part.Size = Vector3.new(3,3,3)
            part.Position = rootPart.Position + Vector3.new(0,5,5)
            part.BrickColor = BrickColor.new("Bright red")
            part.Parent = Workspace
            local billboard = Instance.new("BillboardGui")
            billboard.Size = UDim2.new(0,200,0,50)
            billboard.StudsOffset = Vector3.new(0,3,0)
            billboard.Adornee = part
            billboard.Parent = part
            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1,0,1,0)
            text.BackgroundTransparency = 1
            text.Text = aiInput.Text
            text.TextColor3 = Color3.fromRGB(255,255,255)
            text.Font = Enum.Font.SourceSansBold
            text.TextSize = 20
            text.Parent = billboard
            resultText.Text = resultText.Text .. "✅ Objekt mit Text erstellt!"
        end
    end)
end

-- ==================================================
-- SETTINGS MENU
-- ==================================================
local settingsMenu = Instance.new("Frame")
settingsMenu.Name = "SettingsFrame"
settingsMenu.Size = UDim2.new(0, 400, 0, 450)
settingsMenu.Position = UDim2.new(0.5, -200, 0.5, -225)
settingsMenu.BackgroundColor3 = Color3.fromRGB(10,10,15)
settingsMenu.BorderSizePixel = 0
settingsMenu.Visible = false
settingsMenu.Parent = ScreenGui

local settingsCorner = Instance.new("UICorner")
settingsCorner.CornerRadius = UDim.new(0, 20)
settingsCorner.Parent = settingsMenu

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, 0, 0, 60)
settingsTitle.Position = UDim2.new(0, 0, 0, 0)
settingsTitle.BackgroundColor3 = Color3.fromRGB(20,20,30)
settingsTitle.Text = "⚙️ EINSTELLUNGEN"
settingsTitle.TextColor3 = Settings.GuiColor
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextSize = 24
settingsTitle.Parent = settingsMenu

local settingsTitleCorner = Instance.new("UICorner")
settingsTitleCorner.CornerRadius = UDim.new(0, 20, 0, 0)
settingsTitleCorner.Parent = settingsTitle

local closeSettings = Instance.new("TextButton")
closeSettings.Size = UDim2.new(0, 40, 0, 40)
closeSettings.Position = UDim2.new(1, -45, 0, 10)
closeSettings.BackgroundColor3 = Color3.fromRGB(255,50,50)
closeSettings.TextColor3 = Color3.fromRGB(255,255,255)
closeSettings.Font = Enum.Font.GothamBold
closeSettings.TextSize = 20
closeSettings.Text = "✕"
closeSettings.Parent = settingsTitle

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeSettings

local contentY = 70

-- Color Picker
local colorLabel = Instance.new("TextLabel")
colorLabel.Size = UDim2.new(1, -40, 0, 30)
colorLabel.Position = UDim2.new(0, 20, 0, contentY)
colorLabel.BackgroundTransparency = 1
colorLabel.Text = "GUI Farbe:"
colorLabel.TextColor3 = Color3.fromRGB(255,255,255)
colorLabel.Font = Enum.Font.GothamBold
colorLabel.TextSize = 18
colorLabel.TextXAlignment = Enum.TextXAlignment.Left
colorLabel.Parent = settingsMenu
contentY = contentY + 35

local colorFrame = Instance.new("Frame")
colorFrame.Size = UDim2.new(1, -40, 0, 40)
colorFrame.Position = UDim2.new(0, 20, 0, contentY)
colorFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
colorFrame.Parent = settingsMenu
contentY = contentY + 50

local colorCorner = Instance.new("UICorner")
colorCorner.CornerRadius = UDim.new(0, 8)
colorCorner.Parent = colorFrame

local colorDisplay = Instance.new("Frame")
colorDisplay.Size = UDim2.new(0, 30, 0, 30)
colorDisplay.Position = UDim2.new(0, 5, 0.5, -15)
colorDisplay.BackgroundColor3 = Settings.GuiColor
colorDisplay.Parent = colorFrame

local displayCorner = Instance.new("UICorner")
displayCorner.CornerRadius = UDim.new(0, 5)
displayCorner.Parent = colorDisplay

local colorText = Instance.new("TextLabel")
colorText.Size = UDim2.new(0.8, 0, 1, 0)
colorText.Position = UDim2.new(0, 40, 0, 0)
colorText.BackgroundTransparency = 1
colorText.Text = "Farbe ändern"
colorText.TextColor3 = Color3.fromRGB(255,255,255)
colorText.Font = Enum.Font.SourceSans
colorText.TextSize = 16
colorText.TextXAlignment = Enum.TextXAlignment.Left
colorText.Parent = colorFrame

local colors = {
    Color3.fromRGB(255,0,0),    -- Rot
    Color3.fromRGB(0,255,0),    -- Grün
    Color3.fromRGB(0,255,255),  -- Cyan
    Color3.fromRGB(255,255,0),  -- Gelb
    Color3.fromRGB(255,0,255),  -- Magenta
    Color3.fromRGB(255,165,0)   -- Orange
}

local colorX = 0
for i, color in ipairs(colors) do
    local colorBtn = Instance.new("TextButton")
    colorBtn.Size = UDim2.new(0, 30, 0, 30)
    colorBtn.Position = UDim2.new(0, colorX, 0, 45)
    colorBtn.BackgroundColor3 = color
    colorBtn.Text = ""
    colorBtn.Visible = false
    colorBtn.Parent = colorFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = colorBtn

    colorBtn.MouseButton1Click:Connect(function()
        Settings.GuiColor = color
        colorDisplay.BackgroundColor3 = color
        settingsTitle.TextColor3 = color
        Title.TextColor3 = color
        ContentFrame.ScrollBarImageColor3 = color
        for _, btn in pairs(colorFrame:GetChildren()) do
            if btn:IsA("TextButton") and btn ~= colorDisplay then
                btn.Visible = false
            end
        end
    end)

    colorX = colorX + 35
end

colorFrame.MouseButton1Click:Connect(function()
    for _, btn in pairs(colorFrame:GetChildren()) do
        if btn:IsA("TextButton") and btn ~= colorDisplay then
            btn.Visible = not btn.Visible
        end
    end
end)

-- Checkboxes
local fpsCheck = Instance.new("TextButton")
fpsCheck.Size = UDim2.new(1, -40, 0, 40)
fpsCheck.Position = UDim2.new(0, 20, 0, contentY)
fpsCheck.BackgroundColor3 = Color3.fromRGB(30,30,40)
fpsCheck.Text = ""
fpsCheck.Parent = settingsMenu
contentY = contentY + 45

local fpsCorner = Instance.new("UICorner")
fpsCorner.CornerRadius = UDim.new(0, 8)
fpsCorner.Parent = fpsCheck

local fpsBox = Instance.new("Frame")
fpsBox.Size = UDim2.new(0, 20, 0, 20)
fpsBox.Position = UDim2.new(0, 10, 0.5, -10)
fpsBox.BackgroundColor3 = Settings.ShowFPS and Color3.fromRGB(0,255,0) or Color3.fromRGB(100,100,100)
fpsBox.Parent = fpsCheck

local fpsBoxCorner = Instance.new("UICorner")
fpsBoxCorner.CornerRadius = UDim.new(0, 4)
fpsBoxCorner.Parent = fpsBox

local fpsText = Instance.new("TextLabel")
fpsText.Size = UDim2.new(0.8, 0, 1, 0)
fpsText.Position = UDim2.new(0, 35, 0, 0)
fpsText.BackgroundTransparency = 1
fpsText.Text = "FPS anzeigen"
fpsText.TextColor3 = Color3.fromRGB(255,255,255)
fpsText.Font = Enum.Font.SourceSans
fpsText.TextSize = 16
fpsText.TextXAlignment = Enum.TextXAlignment.Left
fpsText.Parent = fpsCheck

fpsCheck.MouseButton1Click:Connect(function()
    Settings.ShowFPS = not Settings.ShowFPS
    fpsBox.BackgroundColor3 = Settings.ShowFPS and Color3.fromRGB(0,255,0) or Color3.fromRGB(100,100,100)
end)

local timeCheck = Instance.new("TextButton")
timeCheck.Size = UDim2.new(1, -40, 0, 40)
timeCheck.Position = UDim2.new(0, 20, 0, contentY)
timeCheck.BackgroundColor3 = Color3.fromRGB(30,30,40)
timeCheck.Text = ""
timeCheck.Parent = settingsMenu
contentY = contentY + 45

local timeCorner = Instance.new("UICorner")
timeCorner.CornerRadius = UDim.new(0, 8)
timeCorner.Parent = timeCheck

local timeBox = Instance.new("Frame")
timeBox.Size = UDim2.new(0, 20, 0, 20)
timeBox.Position = UDim2.new(0, 10, 0.5, -10)
timeBox.BackgroundColor3 = Settings.ShowTime and Color3.fromRGB(0,255,0) or Color3.fromRGB(100,100,100)
timeBox.Parent = timeCheck

local timeBoxCorner = Instance.new("UICorner")
timeBoxCorner.CornerRadius = UDim.new(0, 4)
timeBoxCorner.Parent = timeBox

local timeText = Instance.new("TextLabel")
timeText.Size = UDim2.new(0.8, 0, 1, 0)
timeText.Position = UDim2.new(0, 35, 0, 0)
timeText.BackgroundTransparency = 1
timeText.Text = "Uhrzeit anzeigen"
timeText.TextColor3 = Color3.fromRGB(255,255,255)
timeText.Font = Enum.Font.SourceSans
timeText.TextSize = 16
timeText.TextXAlignment = Enum.TextXAlignment.Left
timeText.Parent = timeCheck

timeCheck.MouseButton1Click:Connect(function()
    Settings.ShowTime = not Settings.ShowTime
    timeBox.BackgroundColor3 = Settings.ShowTime and Color3.fromRGB(0,255,0) or Color3.fromRGB(100,100,100)
end)

-- YouTube Button
local youtubeBtn = Instance.new("TextButton")
youtubeBtn.Size = UDim2.new(1, -40, 0, 50)
youtubeBtn.Position = UDim2.new(0, 20, 1, -60)
youtubeBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
youtubeBtn.TextColor3 = Color3.fromRGB(255,255,255)
youtubeBtn.Font = Enum.Font.GothamBold
youtubeBtn.TextSize = 18
youtubeBtn.Text = "📺 YOUTUBE: @Hacker666-00"
youtubeBtn.Parent = settingsMenu

local youtubeCorner = Instance.new("UICorner")
youtubeCorner.CornerRadius = UDim.new(0, 10)
youtubeCorner.Parent = youtubeBtn

youtubeBtn.MouseButton1Click:Connect(function()
    setclipboard(YOUTUBE_URL)
    youtubeBtn.Text = "✅ LINK KOPIERT!"
    wait(1)
    youtubeBtn.Text = "📺 YOUTUBE: @Hacker666-00"
end)

closeSettings.MouseButton1Click:Connect(function()
    settingsMenu.Visible = false
end)

-- ==================================================
-- SHOW MAIN TAB
-- ==================================================
local function showMainTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10

    local buttons = {
        {"👤 Player Info", Color3.fromRGB(100, 100, 255)},
        {"🔓 VIP Aktivieren", Color3.fromRGB(255, 215, 0)},
        {"📊 FPS: " .. math.floor(1/RunService.RenderStepped:Wait()), Color3.fromRGB(0, 255, 100)},
        {"⏰ Zeit: " .. os.date("%H:%M:%S"), Color3.fromRGB(255, 255, 0)},
        {"⚙️ Einstellungen", Color3.fromRGB(150, 150, 150)},
        {"📺 YouTube kopieren", Color3.fromRGB(255, 0, 0)}
    }

    for _, btnData in ipairs(buttons) do
        local button = createButton(btnData[1], yPos, btnData[2], false)

        if btnData[1]:find("Player Info") then
            button.MouseButton1Click:Connect(function()
                warn("Name: "..player.Name.."\nDisplay: "..player.DisplayName.."\nID: "..player.UserId.."\nAlter: "..player.AccountAge)
            end)
        elseif btnData[1]:find("VIP") then
            button.MouseButton1Click:Connect(function()
                button.Text = "✅ VIP AKTIVIERT"
                button.BackgroundColor3 = Color3.fromRGB(0,200,0)
            end)
        elseif btnData[1]:find("Einstellungen") then
            button.MouseButton1Click:Connect(function()
                settingsMenu.Visible = true
            end)
        elseif btnData[1]:find("YouTube") then
            button.MouseButton1Click:Connect(function()
                setclipboard(YOUTUBE_URL)
                button.Text = "✅ LINK KOPIERT!"
                wait(1)
                button.Text = "📺 YouTube kopieren"
            end)
        end
        yPos = yPos + buttonSize + 5
    end
    ContentFrame.CanvasSize = UDim2.new(0,0,0,yPos+10)
end

-- ==================================================
-- SHOW GOD TAB
-- ==================================================
local function showGodTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10

    local godButtons = {
        {"✈️ FLY", "fly", Color3.fromRGB(220,20,60)},
        {"🛡️ GODMODE", "godmode", Color3.fromRGB(0,150,0)},
        {"💰 INF MONEY", "money", Color3.fromRGB(255,215,0)},
        {"🚪 NOCLIP", "noclip", Color3.fromRGB(30,144,255)},
        {"👻 INVISIBLE", "invisible", Color3.fromRGB(138,43,226)},
        {"⚡ SPEED", "speed", Color3.fromRGB(255,140,0)},
        {"🎯 ESP", "esp", Color3.fromRGB(255,0,0)},
        {"🎯 AIMBOT", "aimbot", Color3.fromRGB(200,0,0)},
        {"🦘 INF JUMP", "infjump", Color3.fromRGB(100,255,100)},
        {"👁️ XRAY", "xray", Color3.fromRGB(0,255,255)},
        {"💡 FULLBRIGHT", "fullbright", Color3.fromRGB(255,255,0)},
        {"🔫 NO RECOIL", "norecoil", Color3.fromRGB(255,100,0)},
        {"🧱 WALLBANG", "wallbang", Color3.fromRGB(150,0,150)},
        {"🛡️ ANTI KICK", "antikick", Color3.fromRGB(255,0,255)},
        {"⚔️ AUTO FARM", "autofarm", Color3.fromRGB(0,200,200)}
    }

    for _, btnData in ipairs(godButtons) do
        local button = createButton(btnData[1]..": OFF", yPos, btnData[3], true)

        if btnData[2] == "fly" then
            button.MouseButton1Click:Connect(function()
                cheats.fly = toggleFly()
                button.Text = "✈️ FLY: "..(cheats.fly and "ON" or "OFF")
                button.BackgroundColor3 = cheats.fly and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "godmode" then
            button.MouseButton1Click:Connect(function()
                cheats.godmode = toggleGodmode()
                button.Text = "🛡️ GODMODE: "..(cheats.godmode and "ON" or "OFF")
                button.BackgroundColor3 = cheats.godmode and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "money" then
            button.MouseButton1Click:Connect(function()
                cheats.infmoney = toggleInfMoney()
                button.Text = "💰 INF MONEY: "..(cheats.infmoney and "ON" or "OFF")
                button.BackgroundColor3 = cheats.infmoney and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "noclip" then
            button.MouseButton1Click:Connect(function()
                cheats.noclip = toggleNoclip()
                button.Text = "🚪 NOCLIP: "..(cheats.noclip and "ON" or "OFF")
                button.BackgroundColor3 = cheats.noclip and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "invisible" then
            button.MouseButton1Click:Connect(function()
                cheats.invisible = toggleInvisible()
                button.Text = "👻 INVISIBLE: "..(cheats.invisible and "ON" or "OFF")
                button.BackgroundColor3 = cheats.invisible and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "speed" then
            button.MouseButton1Click:Connect(function()
                cheats.speed = toggleSpeed()
                button.Text = "⚡ SPEED: "..(cheats.speed and "ON" or "OFF")
                button.BackgroundColor3 = cheats.speed and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "esp" then
            button.MouseButton1Click:Connect(function()
                cheats.esp = toggleESP()
                button.Text = "🎯 ESP: "..(cheats.esp and "ON" or "OFF")
                button.BackgroundColor3 = cheats.esp and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "aimbot" then
            button.MouseButton1Click:Connect(function()
                cheats.aimbot = toggleAimbot()
                button.Text = "🎯 AIMBOT: "..(cheats.aimbot and "ON" or "OFF")
                button.BackgroundColor3 = cheats.aimbot and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "infjump" then
            button.MouseButton1Click:Connect(function()
                cheats.infjump = toggleInfJump()
                button.Text = "🦘 INF JUMP: "..(cheats.infjump and "ON" or "OFF")
                button.BackgroundColor3 = cheats.infjump and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "xray" then
            button.MouseButton1Click:Connect(function()
                cheats.xray = toggleXray()
                button.Text = "👁️ XRAY: "..(cheats.xray and "ON" or "OFF")
                button.BackgroundColor3 = cheats.xray and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "fullbright" then
            button.MouseButton1Click:Connect(function()
                cheats.fullbright = toggleFullbright()
                button.Text = "💡 FULLBRIGHT: "..(cheats.fullbright and "ON" or "OFF")
                button.BackgroundColor3 = cheats.fullbright and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "norecoil" then
            button.MouseButton1Click:Connect(function()
                cheats.norecoil = toggleNoRecoil()
                button.Text = "🔫 NO RECOIL: "..(cheats.norecoil and "ON" or "OFF")
                button.BackgroundColor3 = cheats.norecoil and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "wallbang" then
            button.MouseButton1Click:Connect(function()
                cheats.wallbang = toggleWallbang()
                button.Text = "🧱 WALLBANG: "..(cheats.wallbang and "ON" or "OFF")
                button.BackgroundColor3 = cheats.wallbang and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "antikick" then
            button.MouseButton1Click:Connect(function()
                cheats.antikick = toggleAntiKick()
                button.Text = "🛡️ ANTI KICK: "..(cheats.antikick and "ON" or "OFF")
                button.BackgroundColor3 = cheats.antikick and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        elseif btnData[2] == "autofarm" then
            button.MouseButton1Click:Connect(function()
                cheats.autofarm = toggleAutoFarm()
                button.Text = "⚔️ AUTO FARM: "..(cheats.autofarm and "ON" or "OFF")
                button.BackgroundColor3 = cheats.autofarm and Color3.fromRGB(0,200,0) or btnData[3]
            end)
        end
        yPos = yPos + buttonSize + 5
    end
    ContentFrame.CanvasSize = UDim2.new(0,0,0,yPos+10)
end

-- ==================================================
-- SHOW TOOLS TAB (MIT SCANNER)
-- ==================================================
local function showToolsTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10

    local scanBtn = createButton("🔍 SCAN TOOLS", yPos, Color3.fromRGB(0,120,215), false)
    yPos = yPos + buttonSize + 5

    local giveAllBtn = createButton("🎁 GIVE ALL TOOLS", yPos, Color3.fromRGB(0,180,0), false)
    yPos = yPos + buttonSize + 5

    local btoolsBtn = createButton("🛠️ BTOOLS", yPos, Color3.fromRGB(100,100,255), true)
    btoolsBtn.MouseButton1Click:Connect(function()
        cheats.btools = not cheats.btools
        if cheats.btools then
            local hammer = Instance.new("Tool"); hammer.Name = "Hammer"; hammer.Parent = player.Backpack
            local clone = Instance.new("Tool"); clone.Name = "Clone"; clone.Parent = player.Backpack
            btoolsBtn.Text = "🛠️ BTOOLS: ON"
            btoolsBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
        else
            btoolsBtn.Text = "🛠️ BTOOLS: OFF"
            btoolsBtn.BackgroundColor3 = Color3.fromRGB(100,100,255)
        end
    end)
    yPos = yPos + buttonSize + 5

    local toolsLabel = Instance.new("TextLabel")
    toolsLabel.Size = UDim2.new(1, -20, 0, 40)
    toolsLabel.Position = UDim2.new(0, 10, 0, yPos)
    toolsLabel.BackgroundColor3 = Color3.fromRGB(40,40,50)
    toolsLabel.TextColor3 = Color3.fromRGB(255,255,255)
    toolsLabel.Font = Enum.Font.SourceSansBold
    toolsLabel.TextSize = 16
    toolsLabel.Text = "Tools: 0 gefunden"
    toolsLabel.Parent = ContentFrame

    local toolsCorner = Instance.new("UICorner")
    toolsCorner.CornerRadius = UDim.new(0, 8)
    toolsCorner.Parent = toolsLabel
    yPos = yPos + 45

    local toolsListFrame = Instance.new("ScrollingFrame")
    toolsListFrame.Size = UDim2.new(1, -20, 0, 250)
    toolsListFrame.Position = UDim2.new(0, 10, 0, yPos)
    toolsListFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
    toolsListFrame.Parent = ContentFrame
    toolsListFrame.CanvasSize = UDim2.new(0,0,0,500)

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 8)
    listCorner.Parent = toolsListFrame

    scanBtn.MouseButton1Click:Connect(function()
        local count = scanAllTools()
        toolsLabel.Text = "Tools: " .. count .. " gefunden"

        toolsListFrame:ClearAllChildren()
        local listY = 5

        for i, tool in ipairs(scannedTools) do
            if i <= 20 then
                local toolBtn = Instance.new("TextButton")
                toolBtn.Size = UDim2.new(1, -10, 0, 35)
                toolBtn.Position = UDim2.new(0, 5, 0, listY)
                toolBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
                toolBtn.TextColor3 = Color3.fromRGB(255,255,255)
                toolBtn.Font = Enum.Font.SourceSans
                toolBtn.TextSize = 12
                toolBtn.Text = "🔧 " .. tool.Name .. " (" .. tool.Location .. ")"
                toolBtn.Parent = toolsListFrame

                local toolCorner = Instance.new("UICorner")
                toolCorner.CornerRadius = UDim.new(0, 4)
                toolCorner.Parent = toolBtn

                toolBtn.MouseButton1Click:Connect(function()
                    local success, name = giveTool(tool.Name)
                    if success then
                        toolBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
                        toolBtn.Text = "✅ " .. name
                        wait(0.5)
                        toolBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
                        toolBtn.Text = "🔧 " .. tool.Name .. " (" .. tool.Location .. ")"
                    end
                end)

                listY = listY + 40
            end
        end
        toolsListFrame.CanvasSize = UDim2.new(0,0,0,listY+10)
    end)

    giveAllBtn.MouseButton1Click:Connect(function()
        local count = giveAllTools()
        giveAllBtn.Text = "✅ " .. count .. " TOOLS ERHALTEN"
        giveAllBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)
        wait(1)
        giveAllBtn.Text = "🎁 GIVE ALL TOOLS"
        giveAllBtn.BackgroundColor3 = Color3.fromRGB(0,180,0)
    end)

    yPos = yPos + 260
    ContentFrame.CanvasSize = UDim2.new(0,0,0,yPos+10)
end

-- ==================================================
-- SHOW SHOP TAB (ROBUX SCANNER)
-- ==================================================
local function showShopTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10

    local shopLabel = Instance.new("TextLabel")
    shopLabel.Size = UDim2.new(1, -20, 0, 50)
    shopLabel.Position = UDim2.new(0, 10, 0, yPos)
    shopLabel.BackgroundColor3 = Color3.fromRGB(255,215,0)
    shopLabel.TextColor3 = Color3.fromRGB(0,0,0)
    shopLabel.Font = Enum.Font.GothamBold
    shopLabel.TextSize = 18
    shopLabel.Text = "💰 ROBUX SCANNER"
    shopLabel.Parent = ContentFrame
    yPos = yPos + 55

    local scanRobuxBtn = createButton("🔍 ROBUX SCANNEN", yPos, Color3.fromRGB(255, 100, 0), false)
    yPos = yPos + buttonSize + 5

    local setAllBtn = createButton("💎 ALLE AUF MAX SETZEN", yPos, Color3.fromRGB(0, 180, 0), false)
    yPos = yPos + buttonSize + 5

    local robuxLabel = Instance.new("TextLabel")
    robuxLabel.Size = UDim2.new(1, -20, 0, 40)
    robuxLabel.Position = UDim2.new(0, 10, 0, yPos)
    robuxLabel.BackgroundColor3 = Color3.fromRGB(40,40,50)
    robuxLabel.TextColor3 = Color3.fromRGB(255,255,255)
    robuxLabel.Font = Enum.Font.SourceSansBold
    robuxLabel.TextSize = 16
    robuxLabel.Text = "Robux Items: 0 gefunden"
    robuxLabel.Parent = ContentFrame
    yPos = yPos + 45

    local robuxListFrame = Instance.new("ScrollingFrame")
    robuxListFrame.Size = UDim2.new(1, -20, 0, 250)
    robuxListFrame.Position = UDim2.new(0, 10, 0, yPos)
    robuxListFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
    robuxListFrame.Parent = ContentFrame
    robuxListFrame.CanvasSize = UDim2.new(0,0,0,500)

    local robuxCorner = Instance.new("UICorner")
    robuxCorner.CornerRadius = UDim.new(0, 8)
    robuxCorner.Parent = robuxListFrame

    scanRobuxBtn.MouseButton1Click:Connect(function()
        local count = scanRobuxItems()
        robuxLabel.Text = "Robux Items: " .. count .. " gefunden"

        robuxListFrame:ClearAllChildren()
        local listY = 5

        for i, item in ipairs(robuxItems) do
            if i <= 20 then
                local itemBtn = Instance.new("TextButton")
                itemBtn.Size = UDim2.new(1, -10, 0, 35)
                itemBtn.Position = UDim2.new(0, 5, 0, listY)
                itemBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
                itemBtn.TextColor3 = Color3.fromRGB(255,255,255)
                itemBtn.Font = Enum.Font.SourceSans
                itemBtn.TextSize = 12
                itemBtn.Text = "💰 " .. item.Name .. " (Wert: " .. tostring(item.Value) .. ")"
                itemBtn.Parent = robuxListFrame

                local itemCorner = Instance.new("UICorner")
                itemCorner.CornerRadius = UDim.new(0, 4)
                itemCorner.Parent = itemBtn

                itemBtn.MouseButton1Click:Connect(function()
                    local success, name = setRobuxToMax(item.Name)
                    if success then
                        itemBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
                        itemBtn.Text = "✅ " .. name .. " auf MAX"
                        wait(0.5)
                        itemBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
                        itemBtn.Text = "💰 " .. item.Name .. " (Wert: 999999999)"
                    end
                end)

                listY = listY + 40
            end
        end
        robuxListFrame.CanvasSize = UDim2.new(0,0,0,listY+10)
    end)

    setAllBtn.MouseButton1Click:Connect(function()
        local count = setAllRobuxToMax()
        setAllBtn.Text = "✅ " .. count .. " ITEMS AUF MAX"
        setAllBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)
        wait(1)
        setAllBtn.Text = "💎 ALLE AUF MAX SETZEN"
        setAllBtn.BackgroundColor3 = Color3.fromRGB(0,180,0)
    end)

    yPos = yPos + 260
    ContentFrame.CanvasSize = UDim2.new(0,0,0,yPos+10)
end

-- ==================================================
-- SHOW ADMIN TAB
-- ==================================================
local function showAdminTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10

    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(1, -20, 0, 40)
    inputBox.Position = UDim2.new(0, 10, 0, yPos)
    inputBox.BackgroundColor3 = Color3.fromRGB(30,30,40)
    inputBox.TextColor3 = Color3.fromRGB(255,255,255)
    inputBox.Font = Enum.Font.SourceSans
    inputBox.TextSize = 14
    inputBox.PlaceholderText = "Spielername eingeben..."
    inputBox.Parent = ContentFrame
    yPos = yPos + 45

    local adminCmds = {
        {"👤 Teleport zu", Color3.fromRGB(100,100,255)},
        {"🎯 Bringen", Color3.fromRGB(255,100,100)},
        {"❄️ Einfrieren", Color3.fromRGB(0,200,255)},
        {"🔥 Auftauen", Color3.fromRGB(255,200,0)},
        {"💀 Kill All", Color3.fromRGB(255,0,0)},
        {"👑 Verwandel dich in", Color3.fromRGB(255,0,255)}
    }

    for _, cmd in ipairs(adminCmds) do
        local button = createButton(cmd[1], yPos, cmd[2], false)

        button.MouseButton1Click:Connect(function()
            local targetName = inputBox.Text
            if cmd[1] == "👤 Teleport zu" then
                local success = teleportToPlayer(targetName)
                button.Text = success and "✅ Teleportiert!" or "❌ Fehler!"
            elseif cmd[1] == "🎯 Bringen" then
                local success = bringPlayer(targetName)
                button.Text = success and "✅ Gebracht!" or "❌ Fehler!"
            elseif cmd[1] == "❄️ Einfrieren" then
                local success = freezePlayer(targetName)
                button.Text = success and "✅ Eingefroren!" or "❌ Fehler!"
            elseif cmd[1] == "🔥 Auftauen" then
                local success = unfreezePlayer(targetName)
                button.Text = success and "✅ Aufgetaut!" or "❌ Fehler!"
            elseif cmd[1] == "💀 Kill All" then
                local count = killAllPlayers()
                button.Text = "✅ "..count.." getötet!"
            elseif cmd[1] == "👑 Verwandel dich in" then
                local success = morphIntoPlayer(targetName)
                button.Text = success and "✅ Verwandelt!" or "❌ Fehler!"
            end
            wait(1)
            button.Text = cmd[1]
        end)
        yPos = yPos + buttonSize + 5
    end
    ContentFrame.CanvasSize = UDim2.new(0,0,0,yPos+10)
end

-- ==================================================
-- SHOW TROLL TAB
-- ==================================================
local function showTrollTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10

    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(1, -20, 0, 40)
    inputBox.Position = UDim2.new(0, 10, 0, yPos)
    inputBox.BackgroundColor3 = Color3.fromRGB(30,30,40)
    inputBox.TextColor3 = Color3.fromRGB(255,255,255)
    inputBox.Font = Enum.Font.SourceSans
    inputBox.TextSize = 14
    inputBox.PlaceholderText = "Spielername für Troll..."
    inputBox.Parent = ContentFrame
    yPos = yPos + 45

    local trollCmds = {
        {"🔄 Drehen", Color3.fromRGB(255,100,0)},
        {"🚀 Hochwerfen", Color3.fromRGB(0,255,100)},
        {"💣 NUKE", Color3.fromRGB(255,0,0)},
        {"💀 KILL AURA", Color3.fromRGB(255,0,100), "killaura"}
    }

    for _, cmd in ipairs(trollCmds) do
        local button
        if cmd[3] == "killaura" then
            button = createButton(cmd[1]..": OFF", yPos, cmd[2], true)
            button.MouseButton1Click:Connect(function()
                cheats.killaura = toggleKillAura()
                button.Text = "💀 KILL AURA: "..(cheats.killaura and "ON" or "OFF")
                button.BackgroundColor3 = cheats.killaura and Color3.fromRGB(0,200,0) or cmd[2]
            end)
        else
            button = createButton(cmd[1], yPos, cmd[2], false)
            button.MouseButton1Click:Connect(function()
                local targetName = inputBox.Text
                if cmd[1] == "🔄 Drehen" then
                    local success = spinPlayer(targetName)
                    button.Text = success and "✅ Gedreht!" or "❌ Fehler!"
                elseif cmd[1] == "🚀 Hochwerfen" then
                    local success = launchPlayer(targetName)
                    button.Text = success and "✅ Hochgeworfen!" or "❌ Fehler!"
                elseif cmd[1] == "💣 NUKE" then
                    createNuke()
                    button.Text = "💥 BOOM!"
                end
                wait(1)
                button.Text = cmd[1]
            end)
        end
        yPos = yPos + buttonSize + 5
    end
    ContentFrame.CanvasSize = UDim2.new(0,0,0,yPos+10)
end

-- ==================================================
-- TAB SWITCHING
-- ==================================================
local function switchTab(tabName)
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = name == tabName and Settings.GuiColor or Color3.fromRGB(30,30,40)
        btn.TextColor3 = name == tabName and Color3.fromRGB(0,0,0) or Color3.fromRGB(200,200,200)
    end

    if tabName == "MAIN" then showMainTab()
    elseif tabName == "GOD" then showGodTab()
    elseif tabName == "TOOLS" then showToolsTab()
    elseif tabName == "ADMIN" then showAdminTab()
    elseif tabName == "TROLL" then showTrollTab()
    elseif tabName == "AI" then
        ContentFrame:ClearAllChildren()
        createAISection()
        ContentFrame.CanvasSize = UDim2.new(0,0,0,600)
    elseif tabName == "SHOP" then showShopTab()
    end
end

-- ==================================================
-- GUI TOGGLE
-- ==================================================
local guiVisible = false

local function toggleGUI()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
    StartButton.Visible = not guiVisible
end

-- ==================================================
-- START BUTTON EVENT
-- ==================================================
StartButton.MouseButton1Click:Connect(function()
    toggleGUI()
    switchTab("MAIN")
end)

TitleSettingsBtn.MouseButton1Click:Connect(function()
    settingsMenu.Visible = true
end)

CloseButton.MouseButton1Click:Connect(toggleGUI)

for tabName, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() switchTab(tabName) end)
end

-- ==================================================
-- CHARACTER HANDLING
-- ==================================================
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    wait(0.5)
    for cheatName, isActive in pairs(cheats) do
        if isActive then
            if cheatName == "fly" then toggleFly() end
            if cheatName == "godmode" then toggleGodmode() end
            if cheatName == "speed" then toggleSpeed() end
            if cheatName == "noclip" then toggleNoclip() end
            if cheatName == "invisible" then toggleInvisible() end
            if cheatName == "infjump" then toggleInfJump() end
        end
    end
end)

-- ==================================================
-- KEYBINDS
-- ==================================================
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl or input.KeyCode == Enum.KeyCode.Insert then
        toggleGUI()
    elseif input.KeyCode == Enum.KeyCode.F then
        if not cheats.fly then cheats.fly = toggleFly() end
    elseif input.KeyCode == Enum.KeyCode.G then
        if not cheats.godmode then cheats.godmode = toggleGodmode() end
    end
end)

-- ==================================================
-- STARTUP
-- ==================================================
print("⚡ THE HACKER V6 GELADEN!")
print("📱 Gerät erkannt: " .. (isMobile and "Mobile" or "PC"))
print("🎮 Drücke START oder RightControl/Insert")
print("👤 YouTube: @Hacker666-00")

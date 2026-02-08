-- 🌌 ULTIMATE HACKER TOOL V6 - GALAXY EDITION
-- Made by Waled-hammad
-- Kompakt & Vollständig

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")
local CG = game:GetService("CoreGui")
local TS = game:GetService("TeleportService")
local LT = game:GetService("Lighting")
local HTTPS = game:GetService("HttpService")

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local mouse = plr:GetMouse()

-- 🌌 GALAXY GUI
local SG = Instance.new("ScreenGui")
SG.Name = "GalaxyHackerTool"
SG.ResetOnSpawn = false
SG.Parent = CG

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 350, 0, 400)
Main.Position = UDim2.new(0.5, -175, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(10, 5, 20)
Main.BackgroundTransparency = 0.1
Main.Active = true
Main.Draggable = true
Main.Visible = false
Main.Parent = SG

-- GALAXY EFFECT
spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            Main.BackgroundColor3 = Color3.fromHSV(i, 0.8, 0.3)
            task.wait(0.1)
        end
    end
end)

-- TITLE BAR
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
TitleBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌌 GALAXY HACKER TOOL"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- UHRZEIT
local Clock = Instance.new("TextLabel")
Clock.Size = UDim2.new(0.3, 0, 1, 0)
Clock.Position = UDim2.new(0.7, 0, 0, 0)
Clock.BackgroundTransparency = 1
Clock.Text = "🕐 00:00"
Clock.TextColor3 = Color3.fromRGB(255, 255, 0)
Clock.Font = Enum.Font.SourceSansBold
Clock.TextSize = 14
Clock.Parent = TitleBar

spawn(function()
    while true do
        local time = os.date("*t")
        Clock.Text = string.format("🕐 %02d:%02d", time.hour, time.min)
        task.wait(10)
    end
end)

-- CLOSE BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 20
CloseBtn.Parent = TitleBar

-- TOGGLE BUTTON (Mobile/PC)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 20, 0.8, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ToggleBtn.Text = "🌌"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 30
ToggleBtn.Parent = SG

-- CONTENT
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -10, 1, -60)
Content.Position = UDim2.new(0, 5, 0, 50)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 4
Content.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
Content.CanvasSize = UDim2.new(0, 0, 0, 500)
Content.Parent = Main

-- FUNCTIONS
local function createBtn(text, y, col, func)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.BackgroundColor3 = col
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Parent = Content
    
    btn.MouseButton1Click:Connect(func)
    return y + 40
end

-- 🚀 ESSENTIAL FUNCTIONS

-- FLY
local flying = false
local flyG, flyV
local function fly()
    flying = not flying
    
    if flying then
        flyG = Instance.new("BodyGyro")
        flyV = Instance.new("BodyVelocity")
        
        flyG.P = 10000
        flyG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyG.CFrame = root.CFrame
        
        flyV.Velocity = Vector3.new(0,0,0)
        flyV.MaxForce = Vector3.new(9e9,9e9,9e9)
        
        flyG.Parent = root
        flyV.Parent = root
        
        RS.Heartbeat:Connect(function()
            if not flying then return end
            
            local cam = WS.CurrentCamera
            local dir = Vector3.new(0,0,0)
            
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
            
            flyV.Velocity = dir.Unit * 50
            flyG.CFrame = cam.CFrame
        end)
        
        hum.PlatformStand = true
    else
        if flyG then flyG:Destroy() end
        if flyV then flyV:Destroy() end
        hum.PlatformStand = false
    end
end

-- GODMODE
local function god()
    hum.MaxHealth = math.huge
    hum.Health = math.huge
end

-- INFINITY JUMP
local infJump = false
local function infiniteJump()
    infJump = not infJump
    
    if infJump then
        hum.JumpPower = 100
        UIS.JumpRequest:Connect(function()
            if infJump then
                hum:ChangeState("Jumping")
            end
        end)
    else
        hum.JumpPower = 50
    end
end

-- ESP
local function esp()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= plr and p.Character then
            local h = Instance.new("Highlight")
            h.Adornee = p.Character
            h.FillColor = Color3.fromRGB(255,0,0)
            h.FillTransparency = 0.7
            h.OutlineColor = Color3.fromRGB(255,255,255)
            h.Parent = p.Character
        end
    end
end

-- INFINITE MONEY (Universal)
local function infiniteMoney()
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
            if obj.Name:lower():find("cash") or obj.Name:lower():find("money") or obj.Name:lower():find("coin") then
                obj.Value = 9999999
            end
        end
    end
end

-- AUTO CLICKER
local autoClick = false
local clickConn
local function autoClicker()
    autoClick = not autoClick
    
    if autoClick then
        clickConn = RS.RenderStepped:Connect(function()
            mouse1click()
        end)
    else
        if clickConn then clickConn:Disconnect() end
    end
end

-- NOCLIP
local noclip = false
local noclipConn
local function noclipFunc()
    noclip = not noclip
    
    if noclip then
        noclipConn = RS.Stepped:Connect(function()
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
    end
end

-- SPEED
local function speed()
    hum.WalkSpeed = 100
end

-- INVISIBLE
local function invisible()
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        end
    end
end

-- TELEPORT TO MOUSE
local function tpMouse()
    if mouse.Target then
        root.CFrame = mouse.Hit + Vector3.new(0,3,0)
    end
end

-- BRING ALL PLAYERS
local function bringAll()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= plr and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = root.CFrame + Vector3.new(math.random(-5,5),0,math.random(-5,5))
            end
        end
    end
end

-- KILL ALL
local function killAll()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= plr and p.Character then
            local h = p.Character:FindFirstChild("Humanoid")
            if h then
                h.Health = 0
            end
        end
    end
end

-- SERVER HOP
local function serverHop()
    pcall(function()
        local data = HTTPS:JSONDecode(game:HttpGet(
            "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100"
        )).data
        
        for _, server in pairs(data) do
            if server.id ~= game.JobId then
                TS:TeleportToPlaceInstance(game.PlaceId, server.id, plr)
                break
            end
        end
    end)
end

-- CUSTOM SCRIPT LOADER
local function loadCustomScript()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 150)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
    frame.Parent = Main
    
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, 100)
    box.Position = UDim2.new(0.05, 0, 0, 10)
    box.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.PlaceholderText = "📝 Füge dein Script hier ein..."
    box.TextWrapped = true
    box.Parent = frame
    
    local loadBtn = Instance.new("TextButton")
    loadBtn.Size = UDim2.new(0.4, 0, 0, 30)
    loadBtn.Position = UDim2.new(0.3, 0, 0, 120)
    loadBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    loadBtn.Text = "🚀 SCRIPT LADEN"
    loadBtn.TextColor3 = Color3.fromRGB(255,255,255)
    loadBtn.Font = Enum.Font.SourceSansBold
    loadBtn.Parent = frame
    
    loadBtn.MouseButton1Click:Connect(function()
        if box.Text ~= "" then
            loadstring(box.Text)()
            frame:Destroy()
        end
    end)
end

-- CREATE ALL BUTTONS
local function createAllButtons()
    Content:ClearAllChildren()
    local y = 10
    
    y = createBtn("✈️ FLY TOGGLE", y, Color3.fromRGB(255,50,50), fly)
    y = createBtn("🛡️ GODMODE", y, Color3.fromRGB(0,150,0), god)
    y = createBtn("🔄 INFINITY JUMP", y, Color3.fromRGB(0,200,200), infiniteJump)
    y = createBtn("💰 INFINITE MONEY", y, Color3.fromRGB(255,215,0), infiniteMoney)
    y = createBtn("👁️ ESP PLAYERS", y, Color3.fromRGB(255,0,0), esp)
    y = createBtn("🖱️ AUTO CLICKER", y, Color3.fromRGB(100,100,255), autoClicker)
    y = createBtn("🚪 NOCLIP", y, Color3.fromRGB(30,144,255), noclipFunc)
    y = createBtn("⚡ SPEED HACK", y, Color3.fromRGB(255,165,0), speed)
    y = createBtn("👻 INVISIBLE", y, Color3.fromRGB(128,128,128), invisible)
    y = createBtn("🎯 TP TO MOUSE", y, Color3.fromRGB(0,150,255), tpMouse)
    y = createBtn("👥 BRING ALL", y, Color3.fromRGB(255,140,0), bringAll)
    y = createBtn("💀 KILL ALL", y, Color3.fromRGB(255,0,0), killAll)
    y = createBtn("🌐 SERVER HOP", y, Color3.fromRGB(70,130,180), serverHop)
    y = createBtn("📝 LOAD CUSTOM SCRIPT", y, Color3.fromRGB(138,43,226), loadCustomScript)
    
    Content.CanvasSize = UDim2.new(0, 0, 0, y)
end

-- EVENTS
ToggleBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    ToggleBtn.Text = Main.Visible and "✕" or "🌌"
    ToggleBtn.BackgroundColor3 = Main.Visible and Color3.fromRGB(255,50,50) or Color3.fromRGB(0,150,255)
end)

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    ToggleBtn.Text = "🌌"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(0,150,255)
end)

-- HOTKEYS
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
        ToggleBtn.Text = Main.Visible and "✕" or "🌌"
        ToggleBtn.BackgroundColor3 = Main.Visible and Color3.fromRGB(255,50,50) or Color3.fromRGB(0,150,255)
    end
end)

-- INIT
createAllButtons()

-- MADE BY LABEL
local Credits = Instance.new("TextLabel")
Credits.Size = UDim2.new(1, 0, 0, 25)
Credits.Position = UDim2.new(0, 0, 1, -25)
Credits.BackgroundTransparency = 1
Credits.Text = "⚡ Made by Waled-hammad ⚡"
Credits.TextColor3 = Color3.fromRGB(0, 255, 255)
Credits.Font = Enum.Font.SourceSansBold
Credits.TextSize = 12
Credits.Parent = Main

print("✅ Galaxy Hacker Tool V6 geladen!")
print("🎮 Toggle GUI: RightControl / Toggle Button")
print("🌌 Galaxy Effect aktiviert")
print("🕐 Live Uhrzeit")
print("⚡ Made by Waled-hammad")

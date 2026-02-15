-- ==================================================
-- THE HACKER V6 - ULTIMATE EDITION
-- Premium OP Tool mit AI Creator (ALLES erstellbar!)
-- Designed by Waled Hammad
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

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local mouse = player:GetMouse()

-- ==================================================
-- DEVICE DETEKTION
-- ==================================================
local isMobile = UserInputService.TouchEnabled
local screenSize = Workspace.CurrentCamera.ViewportSize

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
-- HOME SCREEN
-- ==================================================
local HomeFrame = Instance.new("Frame")
HomeFrame.Name = "HomeFrame"
HomeFrame.Size = UDim2.new(0, 600, 0, 500)
HomeFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
HomeFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
HomeFrame.BackgroundTransparency = 0.1
HomeFrame.BorderSizePixel = 0
HomeFrame.Active = true
HomeFrame.Draggable = true
HomeFrame.Parent = ScreenGui

local HomeCorner = Instance.new("UICorner")
HomeCorner.CornerRadius = UDim.new(0, 30)
HomeCorner.Parent = HomeFrame

-- Neon Border Animation
local HomeBorder = Instance.new("Frame")
HomeBorder.Size = UDim2.new(1, 6, 1, 6)
HomeBorder.Position = UDim2.new(0, -3, 0, -3)
HomeBorder.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
HomeBorder.BackgroundTransparency = 0.3
HomeBorder.BorderSizePixel = 0
HomeBorder.ZIndex = 0
HomeBorder.Parent = HomeFrame

local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 30)
BorderCorner.Parent = HomeBorder

spawn(function()
    while true do
        for i = 0, 1, 0.05 do
            HomeBorder.BackgroundColor3 = Color3.fromHSV(i, 1, 1)
            wait(0.05)
        end
    end
end)

-- Title
local HomeTitle = Instance.new("TextLabel")
HomeTitle.Size = UDim2.new(1, 0, 0, 80)
HomeTitle.Position = UDim2.new(0, 0, 0, 30)
HomeTitle.BackgroundTransparency = 1
HomeTitle.Text = "⚡ THE HACKER V6 ⚡"
HomeTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
HomeTitle.Font = Enum.Font.GothamBlack
HomeTitle.TextSize = 40
HomeTitle.Parent = HomeFrame

-- Subtitle
local HomeSub = Instance.new("TextLabel")
HomeSub.Size = UDim2.new(1, 0, 0, 40)
HomeSub.Position = UDim2.new(0, 0, 0, 100)
HomeSub.BackgroundTransparency = 1
HomeSub.Text = "by Waled Hammad"
HomeSub.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeSub.Font = Enum.Font.SourceSansBold
HomeSub.TextSize = 24
HomeSub.Parent = HomeFrame

-- Device Selection
local PcButton = Instance.new("TextButton")
PcButton.Size = UDim2.new(0, 200, 0, 70)
PcButton.Position = UDim2.new(0.5, -220, 0, 180)
PcButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
PcButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PcButton.Font = Enum.Font.GothamBold
PcButton.TextSize = 28
PcButton.Text = "💻 PC"
PcButton.Parent = HomeFrame

local PcCorner = Instance.new("UICorner")
PcCorner.CornerRadius = UDim.new(0, 20)
PcCorner.Parent = PcButton

local MobileButton = Instance.new("TextButton")
MobileButton.Size = UDim2.new(0, 200, 0, 70)
MobileButton.Position = UDim2.new(0.5, 20, 0, 180)
MobileButton.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
MobileButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MobileButton.Font = Enum.Font.GothamBold
MobileButton.TextSize = 28
MobileButton.Text = "📱 MOBILE"
MobileButton.Parent = HomeFrame

local MobileCorner = Instance.new("UICorner")
MobileCorner.CornerRadius = UDim.new(0, 20)
MobileCorner.Parent = MobileButton

-- Settings Button
local SettingsButton = Instance.new("TextButton")
SettingsButton.Size = UDim2.new(0, 120, 0, 40)
SettingsButton.Position = UDim2.new(1, -130, 0, 10)
SettingsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.Font = Enum.Font.SourceSansBold
SettingsButton.TextSize = 20
SettingsButton.Text = "⚙️ SETTINGS"
SettingsButton.Parent = HomeFrame

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 12)
SettingsCorner.Parent = SettingsButton

-- ==================================================
-- MAIN GUI FRAME
-- ==================================================
local guiSize = isMobile and UDim2.new(0, 380, 0, 650) or UDim2.new(0, 500, 0, 750)
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

-- Main Neon Border
local MainBorder = Instance.new("Frame")
MainBorder.Size = UDim2.new(1, 6, 1, 6)
MainBorder.Position = UDim2.new(0, -3, 0, -3)
MainBorder.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
MainBorder.BackgroundTransparency = 0.3
MainBorder.BorderSizePixel = 0
MainBorder.ZIndex = 0
MainBorder.Parent = MainFrame

local MainBorderCorner = Instance.new("UICorner")
MainBorderCorner.CornerRadius = UDim.new(0, 20)
MainBorderCorner.Parent = MainBorder

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 20, 0, 0)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ THE HACKER V6"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = isMobile and 20 or 26
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- VIP Badge
local VipBadge = Instance.new("TextLabel")
VipBadge.Name = "VipBadge"
VipBadge.Size = UDim2.new(0, 60, 0, 30)
VipBadge.Position = UDim2.new(0.7, 0, 0.5, -15)
VipBadge.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
VipBadge.TextColor3 = Color3.fromRGB(0, 0, 0)
VipBadge.Font = Enum.Font.GothamBold
VipBadge.TextSize = 14
VipBadge.Text = "VIP"
VipBadge.Visible = false
VipBadge.Parent = TitleBar

local BadgeCorner = Instance.new("UICorner")
BadgeCorner.CornerRadius = UDim.new(0, 8)
BadgeCorner.Parent = VipBadge

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0.5, -20)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 24
CloseButton.Text = "✕"
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

-- Tabs
local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(1, -20, 0, 50)
Tabs.Position = UDim2.new(0, 10, 0, 70)
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
    button.TextSize = isMobile and 11 or 14
    button.Text = tabName
    button.Parent = Tabs
    tabButtons[tabName] = button
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 10)
    tabCorner.Parent = button
end

-- Content Frame
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -130)
ContentFrame.Position = UDim2.new(0, 10, 0, 130)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 8
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 1500)
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
    nuke = false,
    killaura = false
}

-- ==================================================
-- AI CREATOR (ALLES KANN ERSTELLT WERDEN!)
-- ==================================================
local function createAISection()
    -- Haupt AI Frame
    local aiMainFrame = Instance.new("Frame")
    aiMainFrame.Size = UDim2.new(1, -20, 0, 400)
    aiMainFrame.Position = UDim2.new(0, 10, 0, 10)
    aiMainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    aiMainFrame.Parent = ContentFrame
    
    local aiCorner = Instance.new("UICorner")
    aiCorner.CornerRadius = UDim.new(0, 15)
    aiCorner.Parent = aiMainFrame
    
    -- AI Title
    local aiTitle = Instance.new("TextLabel")
    aiTitle.Size = UDim2.new(1, 0, 0, 50)
    aiTitle.Position = UDim2.new(0, 0, 0, 0)
    aiTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    aiTitle.Text = "🤖 AI CREATOR (ALLES ERSTELLBAR!)"
    aiTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
    aiTitle.Font = Enum.Font.GothamBold
    aiTitle.TextSize = 18
    aiTitle.Parent = aiMainFrame
    
    local aiTitleCorner = Instance.new("UICorner")
    aiTitleCorner.CornerRadius = UDim.new(0, 15, 0, 0)
    aiTitleCorner.Parent = aiTitle
    
    -- AI Input
    local aiInput = Instance.new("TextBox")
    aiInput.Size = UDim2.new(1, -40, 0, 60)
    aiInput.Position = UDim2.new(0, 20, 0, 60)
    aiInput.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    aiInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    aiInput.Font = Enum.Font.SourceSans
    aiInput.TextSize = 16
    aiInput.PlaceholderText = "Schreib was die AI erstellen soll... z.B.: 'Auto', 'Haus', 'Waffe', 'Baum', 'Mensch'..."
    aiInput.TextWrapped = true
    aiInput.ClearTextOnFocus = false
    aiInput.Parent = aiMainFrame
    
    local aiInputCorner = Instance.new("UICorner")
    aiInputCorner.CornerRadius = UDim.new(0, 10)
    aiInputCorner.Parent = aiInput
    
    -- AI Create Button
    local aiCreateButton = Instance.new("TextButton")
    aiCreateButton.Size = UDim2.new(1, -40, 0, 70)
    aiCreateButton.Position = UDim2.new(0, 20, 0, 130)
    aiCreateButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    aiCreateButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    aiCreateButton.Font = Enum.Font.GothamBold
    aiCreateButton.TextSize = 24
    aiCreateButton.Text = "🎨 ERSTELLEN"
    aiCreateButton.Parent = aiMainFrame
    
    local aiButtonCorner = Instance.new("UICorner")
    aiButtonCorner.CornerRadius = UDim.new(0, 15)
    aiButtonCorner.Parent = aiCreateButton
    
    -- AI Presets
    local presetFrame = Instance.new("Frame")
    presetFrame.Size = UDim2.new(1, -40, 0, 120)
    presetFrame.Position = UDim2.new(0, 20, 0, 210)
    presetFrame.BackgroundTransparency = 1
    presetFrame.Parent = aiMainFrame
    
    local presets = {"🚗 Auto", "🏠 Haus", "🔫 Waffe", "🌳 Baum", "👤 Mensch", "⚡ Blitz"}
    local presetX = 0
    
    for i, presetText in ipairs(presets) do
        local presetBtn = Instance.new("TextButton")
        presetBtn.Size = UDim2.new(0, 100, 0, 40)
        presetBtn.Position = UDim2.new(0, presetX, 0, 0)
        presetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        presetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        presetBtn.Font = Enum.Font.SourceSansBold
        presetBtn.TextSize = 14
        presetBtn.Text = presetText
        presetBtn.Parent = presetFrame
        
        local presetCorner = Instance.new("UICorner")
        presetCorner.CornerRadius = UDim.new(0, 8)
        presetCorner.Parent = presetBtn
        
        presetBtn.MouseButton1Click:Connect(function()
            aiInput.Text = presetText
        end)
        
        presetX = presetX + 110
    end
    
    -- AI Create Function
    aiCreateButton.MouseButton1Click:Connect(function()
        local command = aiInput.Text:lower()
        
        if command:find("auto") or command:find("car") or command:find("vehicle") then
            -- Auto erstellen
            local car = Instance.new("Model")
            car.Name = "AI_Auto"
            
            local body = Instance.new("Part")
            body.Size = Vector3.new(4, 1, 8)
            body.Position = rootPart.Position + Vector3.new(0, 5, 10)
            body.BrickColor = BrickColor.new("Bright red")
            body.Parent = car
            
            local roof = Instance.new("Part")
            roof.Size = Vector3.new(3, 1, 4)
            roof.Position = body.Position + Vector3.new(0, 1.5, -1)
            roof.BrickColor = BrickColor.new("Bright red")
            roof.Parent = car
            
            local wheel1 = Instance.new("Part")
            wheel1.Size = Vector3.new(1, 1, 1)
            wheel1.Position = body.Position + Vector3.new(1.5, -0.5, 2)
            wheel1.BrickColor = BrickColor.new("Black")
            wheel1.Parent = car
            
            local wheel2 = wheel1:Clone()
            wheel2.Position = body.Position + Vector3.new(-1.5, -0.5, 2)
            wheel2.Parent = car
            
            local wheel3 = wheel1:Clone()
            wheel3.Position = body.Position + Vector3.new(1.5, -0.5, -2)
            wheel3.Parent = car
            
            local wheel4 = wheel1:Clone()
            wheel4.Position = body.Position + Vector3.new(-1.5, -0.5, -2)
            wheel4.Parent = car
            
            car.Parent = Workspace
            
        elseif command:find("haus") or command:find("house") or command:find("home") then
            -- Haus erstellen
            local house = Instance.new("Model")
            house.Name = "AI_Haus"
            
            local base = Instance.new("Part")
            base.Size = Vector3.new(10, 1, 10)
            base.Position = rootPart.Position + Vector3.new(0, 0.5, 20)
            base.BrickColor = BrickColor.new("Brown")
            base.Parent = house
            
            local walls = Instance.new("Part")
            walls.Size = Vector3.new(10, 5, 1)
            walls.Position = base.Position + Vector3.new(0, 3, 4.5)
            walls.BrickColor = BrickColor.new("White")
            walls.Parent = house
            
            local walls2 = walls:Clone()
            walls2.Position = base.Position + Vector3.new(0, 3, -4.5)
            walls2.Parent = house
            
            local walls3 = walls:Clone()
            walls3.Size = Vector3.new(1, 5, 8)
            walls3.Position = base.Position + Vector3.new(4.5, 3, 0)
            walls3.Parent = house
            
            local walls4 = walls3:Clone()
            walls4.Position = base.Position + Vector3.new(-4.5, 3, 0)
            walls4.Parent = house
            
            local roof = Instance.new("Part")
            roof.Size = Vector3.new(12, 1, 12)
            roof.Position = base.Position + Vector3.new(0, 6, 0)
            roof.BrickColor = BrickColor.new("Bright red")
            roof.Parent = house
            
            house.Parent = Workspace
            
        elseif command:find("waffe") or command:find("gun") or command:find("weapon") then
            -- Waffe erstellen
            local tool = Instance.new("Tool")
            tool.Name = "AI_Waffe"
            tool.Grip = CFrame.new(0, 0, 0)
            
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(1, 1, 4)
            handle.BrickColor = BrickColor.new("Black")
            handle.Parent = tool
            
            local barrel = Instance.new("Part")
            barrel.Name = "Barrel"
            barrel.Size = Vector3.new(0.5, 0.5, 2)
            barrel.Position = handle.Position + Vector3.new(0, 0, 2)
            barrel.BrickColor = BrickColor.new("Dark grey")
            barrel.Parent = tool
            
            tool.Parent = player.Backpack
            
        elseif command:find("baum") or command:find("tree") then
            -- Baum erstellen
            local tree = Instance.new("Model")
            tree.Name = "AI_Baum"
            
            local trunk = Instance.new("Part")
            trunk.Size = Vector3.new(1, 8, 1)
            trunk.Position = rootPart.Position + Vector3.new(0, 4, 15)
            trunk.BrickColor = BrickColor.new("Brown")
            trunk.Parent = tree
            
            local leaves1 = Instance.new("Part")
            leaves1.Size = Vector3.new(3, 3, 3)
            leaves1.Position = trunk.Position + Vector3.new(0, 5, 0)
            leaves1.BrickColor = BrickColor.new("Bright green")
            leaves1.Parent = tree
            
            local leaves2 = leaves1:Clone()
            leaves2.Size = Vector3.new(2.5, 2.5, 2.5)
            leaves2.Position = trunk.Position + Vector3.new(1, 6.5, 1)
            leaves2.Parent = tree
            
            local leaves3 = leaves2:Clone()
            leaves3.Position = trunk.Position + Vector3.new(-1, 6.5, -1)
            leaves3.Parent = tree
            
            tree.Parent = Workspace
            
        elseif command:find("mensch") or command:find("human") or command:find("person") then
            -- Mensch erstellen
            local human = Instance.new("Model")
            human.Name = "AI_Mensch"
            
            local torso = Instance.new("Part")
            torso.Size = Vector3.new(2, 2, 1)
            torso.Position = rootPart.Position + Vector3.new(0, 3, 10)
            torso.BrickColor = BrickColor.new("Bright blue")
            torso.Parent = human
            
            local head = Instance.new("Part")
            head.Size = Vector3.new(1, 1, 1)
            head.Position = torso.Position + Vector3.new(0, 1.5, 0)
            head.BrickColor = BrickColor.new("Light yellow")
            head.Parent = human
            
            local leg1 = Instance.new("Part")
            leg1.Size = Vector3.new(1, 2, 1)
            leg1.Position = torso.Position + Vector3.new(0.5, -1, 0)
            leg1.BrickColor = BrickColor.new("Bright blue")
            leg1.Parent = human
            
            local leg2 = leg1:Clone()
            leg2.Position = torso.Position + Vector3.new(-0.5, -1, 0)
            leg2.Parent = human
            
            local arm1 = Instance.new("Part")
            arm1.Size = Vector3.new(1, 2, 1)
            arm1.Position = torso.Position + Vector3.new(1.5, 0.5, 0)
            arm1.BrickColor = BrickColor.new("Bright blue")
            arm1.Parent = human
            
            local arm2 = arm1:Clone()
            arm2.Position = torso.Position + Vector3.new(-1.5, 0.5, 0)
            arm2.Parent = human
            
            human.Parent = Workspace
            
        elseif command:find("blitz") or command:find("lightning") then
            -- Blitz Effekt
            local lightning = Instance.new("Part")
            lightning.Size = Vector3.new(1, 20, 1)
            lightning.Position = rootPart.Position + Vector3.new(0, 10, 0)
            lightning.BrickColor = BrickColor.new("Bright yellow")
            lightning.Material = Enum.Material.Neon
            lightning.Parent = Workspace
            
            spawn(function()
                for i = 1, 10 do
                    lightning.BrickColor = BrickColor.new("Bright yellow")
                    wait(0.1)
                    lightning.BrickColor = BrickColor.new("White")
                    wait(0.1)
                end
                wait(1)
                lightning:Destroy()
            end)
        else
            -- Standard: Würfel mit Text
            local part = Instance.new("Part")
            part.Size = Vector3.new(3, 3, 3)
            part.Position = rootPart.Position + Vector3.new(0, 5, 5)
            part.BrickColor = BrickColor.new("Bright red")
            part.Parent = Workspace
            
            local billboard = Instance.new("BillboardGui")
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.Adornee = part
            billboard.Parent = part
            
            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, 0, 1, 0)
            text.BackgroundTransparency = 1
            text.Text = aiInput.Text
            text.TextColor3 = Color3.fromRGB(255, 255, 255)
            text.Font = Enum.Font.SourceSansBold
            text.TextSize = 24
            text.Parent = billboard
        end
    end)
end

-- ==================================================
-- BUTTON CREATOR
-- ==================================================
local function createButton(text, yPos, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 50)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.Text = text
    button.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = button
    
    return button
end

-- ==================================================
-- SHOW MAIN TAB
-- ==================================================
local function showMainTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local mainButtons = {
        {"👤 Player Info", Color3.fromRGB(100, 100, 255)},
        {"📊 FPS Counter", Color3.fromRGB(0, 255, 100)},
        {"🔓 VIP Unlock", Color3.fromRGB(255, 215, 0)},
        {"💾 Save Settings", Color3.fromRGB(255, 100, 100)}
    }
    
    for _, btnData in ipairs(mainButtons) do
        local button = createButton(btnData[1], yPos, btnData[2])
        
        if btnData[1] == "👤 Player Info" then
            button.MouseButton1Click:Connect(function()
                local info = "Name: " .. player.Name .. "\nDisplay: " .. player.DisplayName .. "\nID: " .. player.UserId .. "\nAge: " .. player.AccountAge
                warn(info)
            end)
        elseif btnData[1] == "📊 FPS Counter" then
            button.MouseButton1Click:Connect(function()
                spawn(function()
                    while true do
                        local fps = math.floor(1/RunService.RenderStepped:Wait())
                        button.Text = "📊 FPS: " .. fps
                        wait(0.5)
                    end
                end)
            end)
        elseif btnData[1] == "🔓 VIP Unlock" then
            button.MouseButton1Click:Connect(function()
                VipBadge.Visible = true
                button.Text = "✅ VIP AKTIVIERT"
                button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            end)
        end
        
        yPos = yPos + 55
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- ==================================================
-- SHOW GOD TAB
-- ==================================================
local function showGodTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local godButtons = {
        {"✈️ FLY", "fly", Color3.fromRGB(220, 20, 60)},
        {"🛡️ GODMODE", "godmode", Color3.fromRGB(0, 150, 0)},
        {"💰 INF MONEY", "money", Color3.fromRGB(255, 215, 0)},
        {"🚪 NOCLIP", "noclip", Color3.fromRGB(30, 144, 255)},
        {"👻 INVISIBLE", "invisible", Color3.fromRGB(138, 43, 226)},
        {"⚡ SPEED", "speed", Color3.fromRGB(255, 140, 0)},
        {"🎯 ESP", "esp", Color3.fromRGB(255, 0, 0)},
        {"🎯 AIMBOT", "aimbot", Color3.fromRGB(200, 0, 0)},
        {"🦘 INF JUMP", "infjump", Color3.fromRGB(100, 255, 100)}
    }
    
    for i, btnData in ipairs(godButtons) do
        local button = createButton(btnData[1] .. ": OFF", yPos, btnData[3])
        
        if btnData[2] == "fly" then
            button.MouseButton1Click:Connect(function()
                cheats.fly = not cheats.fly
                toggleFly()
                button.Text = "✈️ FLY: " .. (cheats.fly and "ON" or "OFF")
                button.BackgroundColor3 = cheats.fly and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(220, 20, 60)
            end)
        elseif btnData[2] == "godmode" then
            button.MouseButton1Click:Connect(function()
                cheats.godmode = not cheats.godmode
                toggleGodmode()
                button.Text = "🛡️ GODMODE: " .. (cheats.godmode and "ON" or "OFF")
                button.BackgroundColor3 = cheats.godmode and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 150, 0)
            end)
        elseif btnData[2] == "money" then
            button.MouseButton1Click:Connect(function()
                cheats.infmoney = not cheats.infmoney
                toggleInfMoney()
                button.Text = "💰 INF MONEY: " .. (cheats.infmoney and "ON" or "OFF")
                button.BackgroundColor3 = cheats.infmoney and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 215, 0)
            end)
        elseif btnData[2] == "noclip" then
            button.MouseButton1Click:Connect(function()
                cheats.noclip = not cheats.noclip
                toggleNoclip()
                button.Text = "🚪 NOCLIP: " .. (cheats.noclip and "ON" or "OFF")
                button.BackgroundColor3 = cheats.noclip and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 144, 255)
            end)
        elseif btnData[2] == "invisible" then
            button.MouseButton1Click:Connect(function()
                cheats.invisible = not cheats.invisible
                toggleInvisible()
                button.Text = "👻 INVISIBLE: " .. (cheats.invisible and "ON" or "OFF")
                button.BackgroundColor3 = cheats.invisible and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(138, 43, 226)
            end)
        elseif btnData[2] == "speed" then
            button.MouseButton1Click:Connect(function()
                cheats.speed = not cheats.speed
                toggleSpeed()
                button.Text = "⚡ SPEED: " .. (cheats.speed and "ON" or "OFF")
                button.BackgroundColor3 = cheats.speed and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 140, 0)
            end)
        elseif btnData[2] == "esp" then
            button.MouseButton1Click:Connect(function()
                cheats.esp = not cheats.esp
                toggleESP()
                button.Text = "🎯 ESP: " .. (cheats.esp and "ON" or "OFF")
                button.BackgroundColor3 = cheats.esp and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 0, 0)
            end)
        elseif btnData[2] == "aimbot" then
            button.MouseButton1Click:Connect(function()
                cheats.aimbot = not cheats.aimbot
                toggleAimbot()
                button.Text = "🎯 AIMBOT: " .. (cheats.aimbot and "ON" or "OFF")
                button.BackgroundColor3 = cheats.aimbot and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            end)
        elseif btnData[2] == "infjump" then
            button.MouseButton1Click:Connect(function()
                cheats.infjump = not cheats.infjump
                toggleInfJump()
                button.Text = "🦘 INF JUMP: " .. (cheats.infjump and "ON" or "OFF")
                button.BackgroundColor3 = cheats.infjump and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 255, 100)
            end)
        end
        
        yPos = yPos + 55
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- ==================================================
-- SHOW TOOLS TAB
-- ==================================================
local function showToolsTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local scanBtn = createButton("🔍 SCAN TOOLS", yPos, Color3.fromRGB(0, 120, 215))
    yPos = yPos + 55
    
    local giveAllBtn = createButton("🎁 GIVE ALL TOOLS", yPos, Color3.fromRGB(0, 180, 0))
    yPos = yPos + 55
    
    local toolsLabel = Instance.new("TextLabel")
    toolsLabel.Size = UDim2.new(1, -20, 0, 40)
    toolsLabel.Position = UDim2.new(0, 10, 0, yPos)
    toolsLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    toolsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toolsLabel.Font = Enum.Font.SourceSansBold
    toolsLabel.TextSize = 18
    toolsLabel.Text = "Tools: 0 gefunden"
    toolsLabel.Parent = ContentFrame
    
    local toolsCorner = Instance.new("UICorner")
    toolsCorner.CornerRadius = UDim.new(0, 10)
    toolsCorner.Parent = toolsLabel
    yPos = yPos + 50
    
    local toolsListFrame = Instance.new("Frame")
    toolsListFrame.Size = UDim2.new(1, -20, 0, 200)
    toolsListFrame.Position = UDim2.new(0, 10, 0, yPos)
    toolsListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    toolsListFrame.Parent = ContentFrame
    
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 10)
    listCorner.Parent = toolsListFrame
    
    scanBtn.MouseButton1Click:Connect(function()
        local count = scanAllTools()
        toolsLabel.Text = "Tools: " .. count .. " gefunden"
        
        toolsListFrame:ClearAllChildren()
        local listY = 5
        
        for i, tool in ipairs(scannedTools) do
            if i <= 10 then
                local toolBtn = Instance.new("TextButton")
                toolBtn.Size = UDim2.new(1, -10, 0, 30)
                toolBtn.Position = UDim2.new(0, 5, 0, listY)
                toolBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                toolBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                toolBtn.Font = Enum.Font.SourceSans
                toolBtn.TextSize = 14
                toolBtn.Text = tool.Name
                toolBtn.Parent = toolsListFrame
                
                toolBtn.MouseButton1Click:Connect(function()
                    local clone = tool.Object:Clone()
                    clone.Parent = player.Backpack
                    toolBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                    wait(0.5)
                    toolBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                end)
                
                listY = listY + 35
            end
        end
    end)
    
    giveAllBtn.MouseButton1Click:Connect(function()
        local count = giveAllTools()
        giveAllBtn.Text = "✅ " .. count .. " TOOLS GEGEBEN"
        giveAllBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        wait(1)
        giveAllBtn.Text = "🎁 GIVE ALL TOOLS"
        giveAllBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    end)
    
    yPos = yPos + 210
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- ==================================================
-- SHOW ADMIN TAB
-- ==================================================
local function showAdminTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local adminButtons = {
        {"👤 Teleport zu Spieler", Color3.fromRGB(100, 100, 255)},
        {"🎯 Spieler bringen", Color3.fromRGB(255, 100, 100)},
        {"❄️ Spieler einfrieren", Color3.fromRGB(0, 200, 255)},
        {"🔥 Spieler auftauen", Color3.fromRGB(255, 200, 0)},
        {"💀 Kill All", Color3.fromRGB(255, 0, 0)},
        {"👑 Spieler verwandeln", Color3.fromRGB(255, 0, 255)}
    }
    
    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(1, -20, 0, 40)
    inputBox.Position = UDim2.new(0, 10, 0, yPos)
    inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.Font = Enum.Font.SourceSans
    inputBox.TextSize = 16
    inputBox.PlaceholderText = "Spielername eingeben..."
    inputBox.Parent = ContentFrame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputBox
    yPos = yPos + 50
    
    for _, btnData in ipairs(adminButtons) do
        local button = createButton(btnData[1], yPos, btnData[2])
        
        button.MouseButton1Click:Connect(function()
            local playerName = inputBox.Text
            
            if btnData[1] == "👤 Teleport zu Spieler" then
                local success = teleportToPlayer(playerName)
                button.Text = success and "✅ Teleportiert!" or "❌ Fehler!"
            elseif btnData[1] == "🎯 Spieler bringen" then
                local success = bringPlayer(playerName)
                button.Text = success and "✅ Gebracht!" or "❌ Fehler!"
            elseif btnData[1] == "❄️ Spieler einfrieren" then
                local success = freezePlayer(playerName)
                button.Text = success and "✅ Eingefroren!" or "❌ Fehler!"
            elseif btnData[1] == "🔥 Spieler auftauen" then
                local success = unfreezePlayer(playerName)
                button.Text = success and "✅ Aufgetaut!" or "❌ Fehler!"
            elseif btnData[1] == "💀 Kill All" then
                local count = killAllPlayers()
                button.Text = "✅ " .. count .. " getötet!"
            elseif btnData[1] == "👑 Spieler verwandeln" then
                local success = morphIntoPlayer(playerName)
                button.Text = success and "✅ Verwandelt!" or "❌ Fehler!"
            end
            
            wait(1)
            button.Text = btnData[1]
        end)
        
        yPos = yPos + 55
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- ==================================================
-- SHOW TROLL TAB
-- ==================================================
local function showTrollTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local trollButtons = {
        {"🔄 Spieler drehen", Color3.fromRGB(255, 100, 0)},
        {"🚀 Spieler hochwerfen", Color3.fromRGB(0, 255, 100)},
        {"💣 NUKE (Alle zerstören)", Color3.fromRGB(255, 0, 0)},
        {"🛠️ BTOOLS", Color3.fromRGB(100, 100, 255)},
        {"💀 Kill Aura", Color3.fromRGB(255, 0, 100)}
    }
    
    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(1, -20, 0, 40)
    inputBox.Position = UDim2.new(0, 10, 0, yPos)
    inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.Font = Enum.Font.SourceSans
    inputBox.TextSize = 16
    inputBox.PlaceholderText = "Spielername für Troll..."
    inputBox.Parent = ContentFrame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputBox
    yPos = yPos + 50
    
    for _, btnData in ipairs(trollButtons) do
        local button = createButton(btnData[1], yPos, btnData[2])
        
        button.MouseButton1Click:Connect(function()
            local playerName = inputBox.Text
            
            if btnData[1] == "🔄 Spieler drehen" then
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
                        end
                    end
                end
                button.Text = "✅ Gedreht!"
            elseif btnData[1] == "🚀 Spieler hochwerfen" then
                for _, target in pairs(Players:GetPlayers()) do
                    if target.Name:lower():find(playerName:lower()) and target.Character then
                        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.Velocity = Vector3.new(0, 500, 0)
                        end
                    end
                end
                button.Text = "✅ Hochgeworfen!"
            elseif btnData[1] == "💣 NUKE" then
                local explosion = Instance.new("Explosion")
                explosion.BlastRadius = 100
                explosion.BlastPressure = 1000
                explosion.Position = rootPart.Position
                explosion.Parent = Workspace
                
                for _, target in pairs(Players:GetPlayers()) do
                    if target ~= player and target.Character then
                        local hum = target.Character:FindFirstChild("Humanoid")
                        if hum then
                            hum.Health = 0
                        end
                    end
                end
                button.Text = "💥 BOOM!"
            elseif btnData[1] == "🛠️ BTOOLS" then
                cheats.btools = not cheats.btools
                if cheats.btools then
                    local hammer = Instance.new("Tool")
                    hammer.Name = "Hammer"
                    hammer.Parent = player.Backpack
                    
                    local clone = Instance.new("Tool")
                    clone.Name = "Clone"
                    clone.Parent = player.Backpack
                end
                button.Text = "✅ BTOOLS AKTIV"
            elseif btnData[1] == "💀 Kill Aura" then
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
                button.Text = "💀 KILL AURA: " .. (cheats.killaura and "ON" or "OFF")
            end
            
            wait(1)
            button.Text = btnData[1]
        end)
        
        yPos = yPos + 55
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- ==================================================
-- SHOP TAB (Robux Items anzeigen)
-- ==================================================
local function showShopTab()
    ContentFrame:ClearAllChildren()
    local yPos = 10
    
    local shopLabel = Instance.new("TextLabel")
    shopLabel.Size = UDim2.new(1, -20, 0, 50)
    shopLabel.Position = UDim2.new(0, 10, 0, yPos)
    shopLabel.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    shopLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    shopLabel.Font = Enum.Font.GothamBold
    shopLabel.TextSize = 20
    shopLabel.Text = "💰 ROBUX ITEMS (KOSTENLOS!)"
    shopLabel.Parent = ContentFrame
    
    local shopCorner = Instance.new("UICorner")
    shopCorner.CornerRadius = UDim.new(0, 10)
    shopCorner.Parent = shopLabel
    yPos = yPos + 60
    
    local items = scanRobuxItems()
    
    for i, item in ipairs(robuxItems) do
        if i <= 10 then
            local itemBtn = Instance.new("TextButton")
            itemBtn.Size = UDim2.new(1, -20, 0, 40)
            itemBtn.Position = UDim2.new(0, 10, 0, yPos)
            itemBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            itemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            itemBtn.Font = Enum.Font.SourceSansBold
            itemBtn.TextSize = 16
            itemBtn.Text = "🔓 " .. item .. " (Kostenlos)"
            itemBtn.Parent = ContentFrame
            
            local itemCorner = Instance.new("UICorner")
            itemCorner.CornerRadius = UDim.new(0, 8)
            itemCorner.Parent = itemBtn
            
            itemBtn.MouseButton1Click:Connect(function()
                for _, obj in pairs(game:GetDescendants()) do
                    if obj.Name == item and (obj:IsA("IntValue") or obj:IsA("NumberValue")) then
                        obj.Value = 999999999
                        itemBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                        itemBtn.Text = "✅ ERHALTEN!"
                        wait(1)
                        itemBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                        itemBtn.Text = "🔓 " .. item .. " (Kostenlos)"
                    end
                end
            end)
            
            yPos = yPos + 45
        end
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- ==================================================
-- TAB SWITCHING
-- ==================================================
local function switchTab(tabName)
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = name == tabName and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(30, 30, 40)
        btn.TextColor3 = name == tabName and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(200, 200, 200)
    end
    
    if tabName == "MAIN" then
        showMainTab()
    elseif tabName == "GOD" then
        showGodTab()
    elseif tabName == "TOOLS" then
        showToolsTab()
    elseif tabName == "ADMIN" then
        showAdminTab()
    elseif tabName == "TROLL" then
        showTrollTab()
    elseif tabName == "AI" then
        ContentFrame:ClearAllChildren()
        createAISection()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 450)
    elseif tabName == "SHOP" then
        showShopTab()
    end
end

-- ==================================================
-- GUI TOGGLE
-- ==================================================
local guiVisible = false

local function toggleGUI()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
    HomeFrame.Visible = not guiVisible
    
    if isMobile then
        ToggleButton.Text = guiVisible and "✕" or "⚡"
        ToggleButton.BackgroundColor3 = guiVisible and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(0, 255, 255)
    end
end

-- Mobile Toggle Button
local MobileToggle = Instance.new("TextButton")
MobileToggle.Name = "MobileToggle"
MobileToggle.Size = UDim2.new(0, 60, 0, 60)
MobileToggle.Position = UDim2.new(0, 20, 0.8, 0)
MobileToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
MobileToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
MobileToggle.Font = Enum.Font.GothamBold
MobileToggle.TextSize = 30
MobileToggle.Text = "⚡"
MobileToggle.Visible = isMobile
MobileToggle.ZIndex = 10
MobileToggle.Parent = ScreenGui

local MobileToggleCorner = Instance.new("UICorner")
MobileToggleCorner.CornerRadius = UDim.new(0, 30)
MobileToggleCorner.Parent = MobileToggle

MobileToggle.MouseButton1Click:Connect(toggleGUI)

-- ==================================================
-- BUTTON EVENTS
-- ==================================================
PcButton.MouseButton1Click:Connect(function()
    isMobile = false
    HomeFrame.Visible = false
    MainFrame.Visible = true
    
    local newSize = UDim2.new(0, 500, 0, 750)
    MainFrame.Size = newSize
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -375)
    switchTab("MAIN")
end)

MobileButton.MouseButton1Click:Connect(function()
    isMobile = true
    HomeFrame.Visible = false
    MainFrame.Visible = true
    
    local newSize = UDim2.new(0, 380, 0, 650)
    MainFrame.Size = newSize
    MainFrame.Position = UDim2.new(0.5, -190, 0.5, -325)
    switchTab("MAIN")
end)

SettingsButton.MouseButton1Click:Connect(function()
    warn("⚙️ Settings: Mobile Mode = " .. tostring(isMobile))
end)

CloseButton.MouseButton1Click:Connect(toggleGUI)

for tabName, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        switchTab(tabName)
    end)
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
        if not cheats.fly then
            cheats.fly = toggleFly()
        end
    elseif input.KeyCode == Enum.KeyCode.G then
        if not cheats.godmode then
            cheats.godmode = toggleGodmode()
        end
    end
end)

-- ==================================================
-- STARTUP
-- ==================================================
print("⚡ THE HACKER V6 GELADEN!")
print("📱 Device: " .. (isMobile and "Mobile" or "PC"))
print("🎮 Toggle GUI: RightControl / Insert")
print("👤 Developer: Waled Hammad")

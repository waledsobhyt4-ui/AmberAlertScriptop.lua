-- ==================================================
-- THE HACKER V6 - ULTIMATE EDITION
-- Optimiert für Mobile & PC mit Settings
-- YouTube: @Hacker666-00
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
    Device = "Auto", -- Auto, PC, Mobile
    GuiColor = Color3.fromRGB(0, 255, 255),
    GuiSize = 1.0,
    ShowFPS = true,
    ShowTime = true,
    ButtonSize = 50
}

-- ==================================================
-- DEVICE DETEKTION
-- ==================================================
local isMobile = UserInputService.TouchEnabled
local screenSize = Workspace.CurrentCamera.ViewportSize

-- GUI Größen basierend auf Device
local function getGuiSize()
    local device = Settings.Device
    if device == "Auto" then
        device = isMobile and "Mobile" or "PC"
    end
    
    if device == "Mobile" then
        return {
            Home = UDim2.new(0, 500, 0, 400),
            Main = UDim2.new(0, 320, 0, 500),
            ButtonSize = 45,
            TextSize = 14
        }
    else
        return {
            Home = UDim2.new(0, 600, 0, 500),
            Main = UDim2.new(0, 450, 0, 650),
            ButtonSize = 50,
            TextSize = 16
        }
    end
end

-- ==================================================
-- FPS & ZEIT ANZEIGE (Immer sichtbar)
-- ==================================================
local function createHUD()
    local hudFrame = Instance.new("Frame")
    hudFrame.Name = "HUD"
    hudFrame.Size = UDim2.new(0, 200, 0, 60)
    hudFrame.Position = UDim2.new(1, -210, 0, 10)
    hudFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    hudFrame.BackgroundTransparency = 0.5
    hudFrame.BorderSizePixel = 0
    hudFrame.Parent = CoreGui
    
    local hudCorner = Instance.new("UICorner")
    hudCorner.CornerRadius = UDim.new(0, 10)
    hudCorner.Parent = hudFrame
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Name = "FPSLabel"
    fpsLabel.Size = UDim2.new(1, 0, 0.5, 0)
    fpsLabel.Position = UDim2.new(0, 0, 0, 0)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "FPS: 60"
    fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextSize = 16
    fpsLabel.Parent = hudFrame
    
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Name = "TimeLabel"
    timeLabel.Size = UDim2.new(1, 0, 0.5, 0)
    timeLabel.Position = UDim2.new(0, 0, 0.5, 0)
    timeLabel.BackgroundTransparency = 1
    timeLabel.Text = os.date("%H:%M:%S")
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    timeLabel.Font = Enum.Font.GothamBold
    timeLabel.TextSize = 14
    timeLabel.Parent = hudFrame
    
    -- Update FPS & Time
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
    
    return hudFrame
end

local hud = createHUD()

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
-- SETTINGS MENU
-- ==================================================
local function createSettingsMenu()
    local settingsFrame = Instance.new("Frame")
    settingsFrame.Name = "SettingsFrame"
    settingsFrame.Size = UDim2.new(0, 400, 0, 500)
    settingsFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
    settingsFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    settingsFrame.BorderSizePixel = 0
    settingsFrame.Visible = false
    settingsFrame.Parent = ScreenGui
    
    local settingsCorner = Instance.new("UICorner")
    settingsCorner.CornerRadius = UDim.new(0, 20)
    settingsCorner.Parent = settingsFrame
    
    local settingsTitle = Instance.new("TextLabel")
    settingsTitle.Size = UDim2.new(1, 0, 0, 60)
    settingsTitle.Position = UDim2.new(0, 0, 0, 0)
    settingsTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    settingsTitle.Text = "⚙️ EINSTELLUNGEN"
    settingsTitle.TextColor3 = Settings.GuiColor
    settingsTitle.Font = Enum.Font.GothamBold
    settingsTitle.TextSize = 24
    settingsTitle.Parent = settingsFrame
    
    local settingsTitleCorner = Instance.new("UICorner")
    settingsTitleCorner.CornerRadius = UDim.new(0, 20, 0, 0)
    settingsTitleCorner.Parent = settingsTitle
    
    local closeSettings = Instance.new("TextButton")
    closeSettings.Size = UDim2.new(0, 40, 0, 40)
    closeSettings.Position = UDim2.new(1, -45, 0, 10)
    closeSettings.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeSettings.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeSettings.Font = Enum.Font.GothamBold
    closeSettings.TextSize = 20
    closeSettings.Text = "✕"
    closeSettings.Parent = settingsTitle
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeSettings
    
    local contentY = 70
    
    -- Device Selection
    local deviceLabel = Instance.new("TextLabel")
    deviceLabel.Size = UDim2.new(1, -40, 0, 30)
    deviceLabel.Position = UDim2.new(0, 20, 0, contentY)
    deviceLabel.BackgroundTransparency = 1
    deviceLabel.Text = "Gerät:"
    deviceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    deviceLabel.Font = Enum.Font.GothamBold
    deviceLabel.TextSize = 18
    deviceLabel.TextXAlignment = Enum.TextXAlignment.Left
    deviceLabel.Parent = settingsFrame
    contentY = contentY + 35
    
    local deviceDropdown = Instance.new("Frame")
    deviceDropdown.Size = UDim2.new(1, -40, 0, 40)
    deviceDropdown.Position = UDim2.new(0, 20, 0, contentY)
    deviceDropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    deviceDropdown.Parent = settingsFrame
    
    local deviceCorner = Instance.new("UICorner")
    deviceCorner.CornerRadius = UDim.new(0, 8)
    deviceCorner.Parent = deviceDropdown
    
    local deviceText = Instance.new("TextLabel")
    deviceText.Size = UDim2.new(0.8, 0, 1, 0)
    deviceText.Position = UDim2.new(0, 10, 0, 0)
    deviceText.BackgroundTransparency = 1
    deviceText.Text = Settings.Device
    deviceText.TextColor3 = Color3.fromRGB(255, 255, 255)
    deviceText.Font = Enum.Font.SourceSans
    deviceText.TextSize = 16
    deviceText.TextXAlignment = Enum.TextXAlignment.Left
    deviceText.Parent = deviceDropdown
    
    local deviceArrow = Instance.new("TextLabel")
    deviceArrow.Size = UDim2.new(0.1, 0, 1, 0)
    deviceArrow.Position = UDim2.new(0.9, 0, 0, 0)
    deviceArrow.BackgroundTransparency = 1
    deviceArrow.Text = "▼"
    deviceArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
    deviceArrow.Font = Enum.Font.SourceSansBold
    deviceArrow.TextSize = 20
    deviceArrow.Parent = deviceDropdown
    
    local deviceOptions = {"Auto", "PC", "Mobile"}
    local optionY = 0
    
    for _, option in ipairs(deviceOptions) do
        local optionBtn = Instance.new("TextButton")
        optionBtn.Size = UDim2.new(1, 0, 0, 40)
        optionBtn.Position = UDim2.new(0, 0, 0, optionY)
        optionBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        optionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        optionBtn.Font = Enum.Font.SourceSans
        optionBtn.TextSize = 16
        optionBtn.Text = option
        optionBtn.Visible = false
        optionBtn.Parent = deviceDropdown
        
        optionBtn.MouseButton1Click:Connect(function()
            Settings.Device = option
            deviceText.Text = option
            for _, btn in pairs(deviceDropdown:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.Visible = false
                end
            end
        end)
        
        optionY = optionY + 40
    end
    
    deviceDropdown.MouseButton1Click:Connect(function()
        for _, btn in pairs(deviceDropdown:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.Visible = not btn.Visible
            end
        end
    end)
    
    contentY = contentY + 50
    
    -- Color Picker
    local colorLabel = Instance.new("TextLabel")
    colorLabel.Size = UDim2.new(1, -40, 0, 30)
    colorLabel.Position = UDim2.new(0, 20, 0, contentY)
    colorLabel.BackgroundTransparency = 1
    colorLabel.Text = "GUI Farbe:"
    colorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    colorLabel.Font = Enum.Font.GothamBold
    colorLabel.TextSize = 18
    colorLabel.TextXAlignment = Enum.TextXAlignment.Left
    colorLabel.Parent = settingsFrame
    contentY = contentY + 35
    
    local colorFrame = Instance.new("Frame")
    colorFrame.Size = UDim2.new(1, -40, 0, 40)
    colorFrame.Position = UDim2.new(0, 20, 0, contentY)
    colorFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    colorFrame.Parent = settingsFrame
    
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
    colorText.TextColor3 = Color3.fromRGB(255, 255, 255)
    colorText.Font = Enum.Font.SourceSans
    colorText.TextSize = 16
    colorText.TextXAlignment = Enum.TextXAlignment.Left
    colorText.Parent = colorFrame
    
    local colors = {
        Color3.fromRGB(255, 0, 0),    -- Rot
        Color3.fromRGB(0, 255, 0),    -- Grün
        Color3.fromRGB(0, 255, 255),  -- Cyan
        Color3.fromRGB(255, 255, 0),  -- Gelb
        Color3.fromRGB(255, 0, 255),  -- Magenta
        Color3.fromRGB(255, 165, 0)   -- Orange
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
    
    contentY = contentY + 50
    
    -- Checkboxes
    local fpsCheck = Instance.new("TextButton")
    fpsCheck.Size = UDim2.new(1, -40, 0, 40)
    fpsCheck.Position = UDim2.new(0, 20, 0, contentY)
    fpsCheck.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    fpsCheck.Text = ""
    fpsCheck.Parent = settingsFrame
    
    local fpsCorner = Instance.new("UICorner")
    fpsCorner.CornerRadius = UDim.new(0, 8)
    fpsCorner.Parent = fpsCheck
    contentY = contentY + 45
    
    local fpsBox = Instance.new("Frame")
    fpsBox.Size = UDim2.new(0, 20, 0, 20)
    fpsBox.Position = UDim2.new(0, 10, 0.5, -10)
    fpsBox.BackgroundColor3 = Settings.ShowFPS and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
    fpsBox.Parent = fpsCheck
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = fpsBox
    
    local fpsText = Instance.new("TextLabel")
    fpsText.Size = UDim2.new(0.8, 0, 1, 0)
    fpsText.Position = UDim2.new(0, 35, 0, 0)
    fpsText.BackgroundTransparency = 1
    fpsText.Text = "FPS anzeigen"
    fpsText.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpsText.Font = Enum.Font.SourceSans
    fpsText.TextSize = 16
    fpsText.TextXAlignment = Enum.TextXAlignment.Left
    fpsText.Parent = fpsCheck
    
    fpsCheck.MouseButton1Click:Connect(function()
        Settings.ShowFPS = not Settings.ShowFPS
        fpsBox.BackgroundColor3 = Settings.ShowFPS and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
    end)
    
    local timeCheck = Instance.new("TextButton")
    timeCheck.Size = UDim2.new(1, -40, 0, 40)
    timeCheck.Position = UDim2.new(0, 20, 0, contentY)
    timeCheck.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    timeCheck.Text = ""
    timeCheck.Parent = settingsFrame
    
    local timeCorner = Instance.new("UICorner")
    timeCorner.CornerRadius = UDim.new(0, 8)
    timeCorner.Parent = timeCheck
    contentY = contentY + 45
    
    local timeBox = Instance.new("Frame")
    timeBox.Size = UDim2.new(0, 20, 0, 20)
    timeBox.Position = UDim2.new(0, 10, 0.5, -10)
    timeBox.BackgroundColor3 = Settings.ShowTime and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
    timeBox.Parent = timeCheck
    
    local timeBoxCorner = Instance.new("UICorner")
    timeBoxCorner.CornerRadius = UDim.new(0, 4)
    timeBoxCorner.Parent = timeBox
    
    local timeText = Instance.new("TextLabel")
    timeText.Size = UDim2.new(0.8, 0, 1, 0)
    timeText.Position = UDim2.new(0, 35, 0, 0)
    timeText.BackgroundTransparency = 1
    timeText.Text = "Uhrzeit anzeigen"
    timeText.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeText.Font = Enum.Font.SourceSans
    timeText.TextSize = 16
    timeText.TextXAlignment = Enum.TextXAlignment.Left
    timeText.Parent = timeCheck
    
    timeCheck.MouseButton1Click:Connect(function()
        Settings.ShowTime = not Settings.ShowTime
        timeBox.BackgroundColor3 = Settings.ShowTime and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
    end)
    
    -- YouTube Button
    local youtubeBtn = Instance.new("TextButton")
    youtubeBtn.Size = UDim2.new(1, -40, 0, 50)
    youtubeBtn.Position = UDim2.new(0, 20, 1, -60)
    youtubeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    youtubeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    youtubeBtn.Font = Enum.Font.GothamBold
    youtubeBtn.TextSize = 18
    youtubeBtn.Text = "📺 YOUTUBE: @Hacker666-00"
    youtubeBtn.Parent = settingsFrame
    
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
        settingsFrame.Visible = false
    end)
    
    return settingsFrame
end

local settingsMenu = createSettingsMenu()

-- ==================================================
-- HOME SCREEN
-- ==================================================
local guiSizes = getGuiSize()

local HomeFrame = Instance.new("Frame")
HomeFrame.Name = "HomeFrame"
HomeFrame.Size = guiSizes.Home
HomeFrame.Position = UDim2.new(0.5, -guiSizes.Home.X.Offset/2, 0.5, -guiSizes.Home.Y.Offset/2)
HomeFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
HomeFrame.BackgroundTransparency = 0.1
HomeFrame.BorderSizePixel = 0
HomeFrame.Active = true
HomeFrame.Draggable = true
HomeFrame.Parent = ScreenGui

local HomeCorner = Instance.new("UICorner")
HomeCorner.CornerRadius = UDim.new(0, 30)
HomeCorner.Parent = HomeFrame

-- Title
local HomeTitle = Instance.new("TextLabel")
HomeTitle.Size = UDim2.new(1, 0, 0, 80)
HomeTitle.Position = UDim2.new(0, 0, 0, 30)
HomeTitle.BackgroundTransparency = 1
HomeTitle.Text = "⚡ THE HACKER V6 ⚡"
HomeTitle.TextColor3 = Settings.GuiColor
HomeTitle.Font = Enum.Font.GothamBlack
HomeTitle.TextSize = 40
HomeTitle.Parent = HomeFrame

-- Subtitle
local HomeSub = Instance.new("TextLabel")
HomeSub.Size = UDim2.new(1, 0, 0, 40)
HomeSub.Position = UDim2.new(0, 0, 0, 100)
HomeSub.BackgroundTransparency = 1
HomeSub.Text = "by Waled Hammad | @Hacker666-00"
HomeSub.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeSub.Font = Enum.Font.SourceSansBold
HomeSub.TextSize = 20
HomeSub.Parent = HomeFrame

-- Device Selection
local PcButton = Instance.new("TextButton")
PcButton.Size = UDim2.new(0, 180, 0, 60)
PcButton.Position = UDim2.new(0.5, -190, 0, 180)
PcButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
PcButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PcButton.Font = Enum.Font.GothamBold
PcButton.TextSize = 24
PcButton.Text = "💻 PC"
PcButton.Parent = HomeFrame

local PcCorner = Instance.new("UICorner")
PcCorner.CornerRadius = UDim.new(0, 15)
PcCorner.Parent = PcButton

local MobileButton = Instance.new("TextButton")
MobileButton.Size = UDim2.new(0, 180, 0, 60)
MobileButton.Position = UDim2.new(0.5, 10, 0, 180)
MobileButton.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
MobileButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MobileButton.Font = Enum.Font.GothamBold
MobileButton.TextSize = 24
MobileButton.Text = "📱 MOBILE"
MobileButton.Parent = HomeFrame

local MobileCorner = Instance.new("UICorner")
MobileCorner.CornerRadius = UDim.new(0, 15)
MobileCorner.Parent = MobileButton

-- Settings Button (im Home Screen)
local HomeSettingsBtn = Instance.new("TextButton")
HomeSettingsBtn.Size = UDim2.new(0, 50, 0, 50)
HomeSettingsBtn.Position = UDim2.new(1, -60, 0, 10)
HomeSettingsBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
HomeSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeSettingsBtn.Font = Enum.Font.GothamBold
HomeSettingsBtn.TextSize = 30
HomeSettingsBtn.Text = "⚙️"
HomeSettingsBtn.Parent = HomeFrame

local HomeSettingsCorner = Instance.new("UICorner")
HomeSettingsCorner.CornerRadius = UDim.new(0, 15)
HomeSettingsCorner.Parent = HomeSettingsBtn

HomeSettingsBtn.MouseButton1Click:Connect(function()
    settingsMenu.Visible = true
end)

-- ==================================================
-- MAIN GUI FRAME
-- ==================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = guiSizes.Main
MainFrame.Position = UDim2.new(0.5, -guiSizes.Main.X.Offset/2, 0.5, -guiSizes.Main.Y.Offset/2)
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
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ THE HACKER V6"
Title.TextColor3 = Settings.GuiColor
Title.Font = Enum.Font.GothamBlack
Title.TextSize = guiSizes.TextSize + 4
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Settings Button (im Main Frame)
local MainSettingsBtn = Instance.new("TextButton")
MainSettingsBtn.Size = UDim2.new(0, 35, 0, 35)
MainSettingsBtn.Position = UDim2.new(1, -80, 0.5, -17.5)
MainSettingsBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MainSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainSettingsBtn.Font = Enum.Font.GothamBold
MainSettingsBtn.TextSize = 20
MainSettingsBtn.Text = "⚙️"
MainSettingsBtn.Parent = TitleBar

local MainSettingsCorner = Instance.new("UICorner")
MainSettingsCorner.CornerRadius = UDim.new(0, 8)
MainSettingsCorner.Parent = MainSettingsBtn

MainSettingsBtn.MouseButton1Click:Connect(function()
    settingsMenu.Visible = true
end)

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
    button.TextSize = guiSizes.TextSize - 2
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
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 1200)
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
-- MULTIPLE MONEY SYSTEM
-- ==================================================
local moneyMultiplier = 2
local moneyTypes = {
    "cash", "money", "coin", "robux", "point", "gold", "diamond", 
    "gem", "credit", "token", "balance", "fund", "wallet", "bank",
    "dollar", "euro", "pound", "yen", "bucks", "coins", "gems"
}

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
                                    if obj.Value > 999999999 then
                                        obj.Value = 999999999
                                    end
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
                                        if stat.Value > 999999999 then
                                            stat.Value = 999999999
                                        end
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
                if humanoid then
                    humanoid.Health = math.huge
                end
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
        
        local jumpConn
        jumpConn = UserInputService.JumpRequest:Connect(function()
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
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
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
-- SPEED
-- ==================================================
local speedMult = 3
local origWalkSpeed
local function toggleSpeed()
    cheats.speed = not cheats.speed
    
    if cheats.speed then
        origWalkSpeed = humanoid.WalkSpeed
        humanoid.WalkSpeed = origWalkSpeed * speedMult
    else
        if origWalkSpeed then
            humanoid.WalkSpeed = origWalkSpeed
        end
    end
    return cheats.speed
end

-- ==================================================
-- ESP
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
            end
        end
    else
        for _, highlight in pairs(espBoxes) do
            highlight:Destroy()
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
-- TOOL SYSTEM
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
        game:GetService("Lighting")
    }
    
    for _, location in pairs(locations) do
        pcall(function()
            for _, obj in pairs(location:GetDescendants()) do
                if obj:IsA("Tool") then
                    table.insert(scannedTools, {
                        Name = obj.Name,
                        Object = obj
                    })
                end
            end
        end)
    end
    return #scannedTools
end

local function giveAllTools()
    local count = 0
    for _, toolInfo in pairs(scannedTools) do
        pcall(function()
            local clone = toolInfo.Object:Clone()
            clone.Parent = player.Backpack
            count = count + 1
        end)
    end
    return count
end

-- ==================================================
-- AI CREATOR (ERWEITERT)
-- ==================================================
local function createAISection()
    local aiMainFrame = Instance.new("Frame")
    aiMainFrame.Size = UDim2.new(1, -20, 0, 450)
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
    aiTitle.Text = "🤖 AI CREATOR (ALLES ERSTELLBAR!)"
    aiTitle.TextColor3 = Settings.GuiColor
    aiTitle.Font = Enum.Font.GothamBold
    aiTitle.TextSize = 16
    aiTitle.Parent = aiMainFrame

    local aiTitleCorner = Instance.new("UICorner")
    aiTitleCorner.CornerRadius = UDim.new(0, 15, 0, 0)
    aiTitleCorner.Parent = aiTitle

    local aiInput = Instance.new("TextBox")
    aiInput.Size = UDim2.new(1, -40, 0, 60)
    aiInput.Position = UDim2.new(0, 20, 0, 60)
    aiInput.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    aiInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    aiInput.Font = Enum.Font.SourceSans
    aiInput.TextSize = 14
    aiInput.PlaceholderText = "Was soll ich erstellen? (Auto, Haus, Waffe, Baum, Mensch, Tier, Möbel...)"
    aiInput.TextWrapped = true
    aiInput.ClearTextOnFocus = false
    aiInput.Parent = aiMainFrame

    local aiInputCorner = Instance.new("UICorner")
    aiInputCorner.CornerRadius = UDim.new(0, 8)
    aiInputCorner.Parent = aiInput

    local aiCreateButton = Instance.new("TextButton")
    aiCreateButton.Size = UDim2.new(1, -40, 0, 60)
    aiCreateButton.Position = UDim2.new(0, 20, 0, 130)
    aiCreateButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    aiCreateButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    aiCreateButton.Font = Enum.Font.GothamBold
    aiCreateButton.TextSize = 20
    aiCreateButton.Text = "🎨 ERSTELLEN"
    aiCreateButton.Parent = aiMainFrame

    local aiButtonCorner = Instance.new("UICorner")
    aiButtonCorner.CornerRadius = UDim.new(0, 10)
    aiButtonCorner.Parent = aiCreateButton

    local presetsFrame = Instance.new("Frame")
    presetsFrame.Size = UDim2.new(1, -40, 0, 100)
    presetsFrame.Position = UDim2.new(0, 20, 0, 200)
    presetsFrame.BackgroundTransparency = 1
    presetsFrame.Parent = aiMainFrame

    local presets = {
        {"🚗 Auto", 1},
        {"🏠 Haus", 2},
        {"🔫 Waffe", 3},
        {"🌳 Baum", 4},
        {"👤 Mensch", 5},
        {"🐕 Hund", 6},
        {"🪑 Stuhl", 7},
        {"⚡ Blitz", 8}
    }

    local gridX = 0
    local gridY = 0
    for i, preset in ipairs(presets) do
        local presetBtn = Instance.new("TextButton")
        presetBtn.Size = UDim2.new(0, 90, 0, 40)
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

        gridX = gridX + 100
        if gridX >= 300 then
            gridX = 0
            gridY = gridY + 45
        end
    end

    local resultFrame = Instance.new("Frame")
    resultFrame.Size = UDim2.new(1, -40, 0, 80)
    resultFrame.Position = UDim2.new(0, 20, 0, 310)
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
    resultText.Parent = resultFrame

    -- AI Create Function
    aiCreateButton.MouseButton1Click:Connect(function()
        local command = aiInput.Text:lower()
        resultText.Text = "🔨 Erstelle: " .. aiInput.Text
        
        if command:find("auto") or command:find("car") then
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
            
            for i = 1, 4 do
                local wheel = Instance.new("Part")
                wheel.Size = Vector3.new(1, 1, 1)
                wheel.BrickColor = BrickColor.new("Black")
                wheel.Parent = car
            end
            
            car.Parent = Workspace
            resultText.Text = "✅ Auto erstellt!"
            
        elseif command:find("haus") or command:find("house") then
            local house = Instance.new("Model")
            house.Name = "AI_Haus"
            
            local base = Instance.new("Part")
            base.Size = Vector3.new(10, 1, 10)
            base.Position = rootPart.Position + Vector3.new(0, 0.5, 20)
            base.BrickColor = BrickColor.new("Brown")
            base.Parent = house
            
            for i = 1, 4 do
                local wall = Instance.new("Part")
                wall.Size = Vector3.new(10, 5, 1)
                wall.BrickColor = BrickColor.new("White")
                wall.Parent = house
            end
            
            local roof = Instance.new("Part")
            roof.Size = Vector3.new(12, 1, 12)
            roof.Position = base.Position + Vector3.new(0, 6, 0)
            roof.BrickColor = BrickColor.new("Bright red")
            roof.Parent = house
            
            house.Parent = Workspace
            resultText.Text = "✅ Haus erstellt!"
            
        elseif command:find("waffe") or command:find("gun") then
            local tool = Instance.new("Tool")
            tool.Name = "AI_Waffe"
            
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(1, 1, 4)
            handle.BrickColor = BrickColor.new("Black")
            handle.Parent = tool
            
            tool.Parent = player.Backpack
            resultText.Text = "✅ Waffe erhalten!"
            
        elseif command:find("baum") or command:find("tree") then
            local tree = Instance.new("Model")
            tree.Name = "AI_Baum"
            
            local trunk = Instance.new("Part")
            trunk.Size = Vector3.new(1, 8, 1)
            trunk.Position = rootPart.Position + Vector3.new(0, 4, 15)
            trunk.BrickColor = BrickColor.new("Brown")
            trunk.Parent = tree
            
            for i = 1, 3 do
                local leaves = Instance.new("Part")
                leaves.Size = Vector3.new(3, 3, 3)
                leaves.Position = trunk.Position + Vector3.new(0, 5 + i, 0)
                leaves.BrickColor = BrickColor.new("Bright green")
                leaves.Parent = tree
            end
            
            tree.Parent = Workspace
            resultText.Text = "✅ Baum erstellt!"
            
        elseif command:find("mensch") or command:find("human") then
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
            
            for i = 1, 4 do
                local limb = Instance.new("Part")
                limb.Size = Vector3.new(1, 2, 1)
                limb.BrickColor = BrickColor.new("Bright blue")
                limb.Parent = human
            end
            
            human.Parent = Workspace
            resultText.Text = "✅ Mensch erstellt!"
            
        elseif command:find("hund") or command:find("dog") then
            local dog = Instance.new("Model")
            dog.Name = "AI_Hund"
            
            local body = Instance.new("Part")
            body.Size = Vector3.new(2, 1, 4)
            body.Position = rootPart.Position + Vector3.new(0, 2, 10)
            body.BrickColor = BrickColor.new("Brown")
            body.Parent = dog
            
            local head = Instance.new("Part")
            head.Size = Vector3.new(1.5, 1, 1.5)
            head.Position = body.Position + Vector3.new(0, 0.5, 2)
            head.BrickColor = BrickColor.new("Brown")
            head.Parent = dog
            
            dog.Parent = Workspace
            resultText.Text = "✅ Hund erstellt!"
            
        elseif command:find("stuhl") or command:find("chair") then
            local chair = Instance.new("Part")
            chair.Size = Vector3.new(2, 1, 2)
            chair.Position = rootPart.Position + Vector3.new(0, 0.5, 10)
            chair.BrickColor = BrickColor.new("Wood")
            chair.Parent = Workspace
            
            for i = 1, 4 do
                local leg = Instance.new("Part")
                leg.Size = Vector3.new(0.3, 2, 0.3)
                leg.Position = chair.Position + Vector3.new(0.8 * (i%2*2-1), -1, 0.8 * (math.floor(i/2)*2-1))
                leg.BrickColor = BrickColor.new("Wood")
                leg.Parent = Workspace
            end
            
            resultText.Text = "✅ Stuhl erstellt!"
            
        elseif command:find("blitz") or command:find("lightning") then
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
            resultText.Text = "⚡ Blitz erstellt!"
            
        else
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
            text.TextSize = 20
            text.Parent = billboard
            
            resultText.Text = "✅ Objekt mit Text erstellt!"
        end
    end)
end

-- ==================================================
-- BUTTON CREATOR
-- ==================================================
local function createButton(text, yPos, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, guiSizes.ButtonSize)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = guiSizes.TextSize
    button.Text = text
    button.Parent = ContentFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
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
        {"🔓 VIP Aktivieren", Color3.fromRGB(255, 215, 0)},
        {"📊 FPS: " .. math.floor(1/RunService.RenderStepped:Wait()), Color3.fromRGB(0, 255, 100)},
        {"⏰ Zeit: " .. os.date("%H:%M:%S"), Color3.fromRGB(255, 255, 0)}
    }

    for _, btnData in ipairs(mainButtons) do
        local button = createButton(btnData[1], yPos, btnData[2])

        if btnData[1]:find("Player Info") then
            button.MouseButton1Click:Connect(function()
                local info = "Name: " .. player.Name .. "\nDisplay: " .. player.DisplayName .. "\nID: " .. player.UserId .. "\nAlter: " .. player.AccountAge
                warn(info)
            end)
        elseif btnData[1]:find("VIP") then
            button.MouseButton1Click:Connect(function()
                VipBadge.Visible = true
                button.Text = "✅ VIP AKTIVIERT"
                button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            end)
        end

        yPos = yPos + guiSizes.ButtonSize + 5
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
        {"💰 INF MONEY (x" .. moneyMultiplier .. ")", "money", Color3.fromRGB(255, 215, 0)},
        {"🚪 NOCLIP", "noclip", Color3.fromRGB(30, 144, 255)},
        {"👻 INVISIBLE", "invisible", Color3.fromRGB(138, 43, 226)},
        {"⚡ SPEED (x" .. speedMult .. ")", "speed", Color3.fromRGB(255, 140, 0)},
        {"🎯 ESP", "esp", Color3.fromRGB(255, 0, 0)},
        {"🎯 AIMBOT", "aimbot", Color3.fromRGB(200, 0, 0)},
        {"🦘 INF JUMP", "infjump", Color3.fromRGB(100, 255, 100)}
    }

    for i, btnData in ipairs(godButtons) do
        local button = createButton(btnData[1] .. ": OFF", yPos, btnData[3])

        if btnData[2] == "fly" then
            button.MouseButton1Click:Connect(function()
                cheats.fly = toggleFly()
                button.Text = "✈️ FLY: " .. (cheats.fly and "ON" or "OFF")
                button.BackgroundColor3 = cheats.fly and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(220, 20, 60)
            end)
        elseif btnData[2] == "godmode" then
            button.MouseButton1Click:Connect(function()
                cheats.godmode = toggleGodmode()
                button.Text = "🛡️ GODMODE: " .. (cheats.godmode and "ON" or "OFF")
                button.BackgroundColor3 = cheats.godmode and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 150, 0)
            end)
        elseif btnData[2] == "money" then
            button.MouseButton1Click:Connect(function()
                cheats.infmoney = toggleInfMoney()
                button.Text = "💰 INF MONEY: " .. (cheats.infmoney and "ON" or "OFF")
                button.BackgroundColor3 = cheats.infmoney and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 215, 0)
            end)
        elseif btnData[2] == "noclip" then
            button.MouseButton1Click:Connect(function()
                cheats.noclip = toggleNoclip()
                button.Text = "🚪 NOCLIP: " .. (cheats.noclip and "ON" or "OFF")
                button.BackgroundColor3 = cheats.noclip and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 144, 255)
            end)
        elseif btnData[2] == "invisible" then
            button.MouseButton1Click:Connect(function()
                cheats.invisible = toggleInvisible()
                button.Text = "👻 INVISIBLE: " .. (cheats.invisible and "ON" or "OFF")
                button.BackgroundColor3 = cheats.invisible and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(138, 43, 226)
            end)
        elseif btnData[2] == "speed" then
            button.MouseButton1Click:Connect(function()
                cheats.speed = toggleSpeed()
                button.Text = "⚡ SPEED: " .. (cheats.speed and "ON" or "OFF")
                button.BackgroundColor3 = cheats.speed and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 140, 0)
            end)
        elseif btnData[2] == "esp" then
            button.MouseButton1Click:Connect(function()
                cheats.esp = toggleESP()
                button.Text = "🎯 ESP: " .. (cheats.esp and "ON" or "OFF")
                button.BackgroundColor3 = cheats.esp and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 0, 0)
            end)
        elseif btnData[2] == "aimbot" then
            button.MouseButton1Click:Connect(function()
                cheats.aimbot = toggleAimbot()
                button.Text = "🎯 AIMBOT: " .. (cheats.aimbot and "ON" or "OFF")
                button.BackgroundColor3 = cheats.aimbot and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            end)
        elseif btnData[2] == "infjump" then
            button.MouseButton1Click:Connect(function()
                cheats.infjump = toggleInfJump()
                button.Text = "🦘 INF JUMP: " .. (cheats.infjump and "ON" or "OFF")
                button.BackgroundColor3 = cheats.infjump and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 255, 100)
            end)
        end

        yPos = yPos + guiSizes.ButtonSize + 5
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
    yPos = yPos + guiSizes.ButtonSize + 5

    local giveAllBtn = createButton("🎁 GIVE ALL TOOLS", yPos, Color3.fromRGB(0, 180, 0))
    yPos = yPos + guiSizes.ButtonSize + 5

    local toolsLabel = Instance.new("TextLabel")
    toolsLabel.Size = UDim2.new(1, -20, 0, 40)
    toolsLabel.Position = UDim2.new(0, 10, 0, yPos)
    toolsLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    toolsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toolsLabel.Font = Enum.Font.SourceSansBold
    toolsLabel.TextSize = 16
    toolsLabel.Text = "Tools: 0 gefunden"
    toolsLabel.Parent = ContentFrame

    local toolsCorner = Instance.new("UICorner")
    toolsCorner.CornerRadius = UDim.new(0, 8)
    toolsCorner.Parent = toolsLabel
    yPos = yPos + 45

    local toolsListFrame = Instance.new("Frame")
    toolsListFrame.Size = UDim2.new(1, -20, 0, 200)
    toolsListFrame.Position = UDim2.new(0, 10, 0, yPos)
    toolsListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    toolsListFrame.Parent = ContentFrame

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 8)
    listCorner.Parent = toolsListFrame

    scanBtn.MouseButton1Click:Connect(function()
        local count = scanAllTools()
        toolsLabel.Text = "Tools: " .. count .. " gefunden"

        toolsListFrame:ClearAllChildren()
        local listY = 5

        for i, tool in ipairs(scannedTools) do
            if i <= 8 then
                local toolBtn = Instance.new("TextButton")
                toolBtn.Size = UDim2.new(1, -10, 0, 30)
                toolBtn.Position = UDim2.new(0, 5, 0, listY)
                toolBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                toolBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                toolBtn.Font = Enum.Font.SourceSans
                toolBtn.TextSize = 12
                toolBtn.Text = tool.Name
                toolBtn.Parent = toolsListFrame

                local toolCorner = Instance.new("UICorner")
                toolCorner.CornerRadius = UDim.new(0, 4)
                toolCorner.Parent = toolBtn

                toolBtn.MouseButton1Click:Connect(function()
                    local clone = tool.Object:Clone()
                    clone.Parent = player.Backpack
                    toolBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                    toolBtn.Text = "✅ " .. tool.Name
                    wait(0.5)
                    toolBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                    toolBtn.Text = tool.Name
                end)

                listY = listY + 35
            end
        end
    end)

    giveAllBtn.MouseButton1Click:Connect(function()
        local count = giveAllTools()
        giveAllBtn.Text = "✅ " .. count .. " TOOLS ERHALTEN"
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

    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(1, -20, 0, 40)
    inputBox.Position = UDim2.new(0, 10, 0, yPos)
    inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.Font = Enum.Font.SourceSans
    inputBox.TextSize = 14
    inputBox.PlaceholderText = "Spielername eingeben..."
    inputBox.Parent = ContentFrame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputBox
    yPos = yPos + 45

    local adminCommands = {
        {"👤 Teleport zu", Color3.fromRGB(100, 100, 255)},
        {"🎯 Bringen", Color3.fromRGB(255, 100, 100)},
        {"❄️ Einfrieren", Color3.fromRGB(0, 200, 255)},
        {"🔥 Auftauen", Color3.fromRGB(255, 200, 0)},
        {"💀 Kill All", Color3.fromRGB(255, 0, 0)},
        {"👑 Verwandel dich in", Color3.fromRGB(255, 0, 255)}
    }

    for _, cmd in ipairs(adminCommands) do
        local button = createButton(cmd[1], yPos, cmd[2])

        button.MouseButton1Click:Connect(function()
            local targetName = inputBox.Text

            if cmd[1] == "👤 Teleport zu" then
                for _, target in pairs(Players:GetPlayers()) do
                    if target.Name:lower():find(targetName:lower()) then
                        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                            character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                            button.Text = "✅ Teleportiert!"
                        end
                    end
                end
            elseif cmd[1] == "🎯 Bringen" then
                for _, target in pairs(Players:GetPlayers()) do
                    if target.Name:lower():find(targetName:lower()) then
                        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                            target.Character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame
                            button.Text = "✅ Gebracht!"
                        end
                    end
                end
            elseif cmd[1] == "❄️ Einfrieren" then
                for _, target in pairs(Players:GetPlayers()) do
                    if target.Name:lower():find(targetName:lower()) and target.Character then
                        local hum = target.Character:FindFirstChild("Humanoid")
                        if hum then
                            hum.WalkSpeed = 0
                            hum.JumpPower = 0
                            button.Text = "✅ Eingefroren!"
                        end
                    end
                end
            elseif cmd[1] == "🔥 Auftauen" then
                for _, target in pairs(Players:GetPlayers()) do
                    if target.Name:lower():find(targetName:lower()) and target.Character then
                        local hum = target.Character:FindFirstChild("Humanoid")
                        if hum then
                            hum.WalkSpeed = 16
                            hum.JumpPower = 50
                            button.Text = "✅ Aufgetaut!"
                        end
                    end
                end
            elseif cmd[1] == "💀 Kill All" then
                local count = 0
                for _, target in pairs(Players:GetPlayers()) do
                    if target ~= player and target.Character then
                        local hum = target.Character:FindFirstChild("Humanoid")
                        if hum then
                            hum.Health = 0
                            count = count + 1
                        end
                    end
                end
                button.Text = "✅ " .. count .. " getötet!"
            elseif cmd[1] == "👑 Verwandel dich in" then
                for _, target in pairs(Players:GetPlayers()) do
                    if target.Name:lower():find(targetName:lower()) and target.Character then
                        local targetChar = target.Character
                        local newChar = targetChar:Clone()
                        newChar.Name = player.Name
                        newChar.Parent = Workspace
                        newChar.HumanoidRootPart.CFrame = rootPart.CFrame
                        
                        character:Destroy()
                        character = newChar
                        humanoid = newChar:WaitForChild("Humanoid")
                        rootPart = newChar:WaitForChild("HumanoidRootPart")
                        player.Character = newChar
                        
                        button.Text = "✅ Verwandelt!"
                    end
                end
            end

            wait(1)
            button.Text = cmd[1]
        end)

        yPos = yPos + guiSizes.ButtonSize + 5
    end

    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
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
    inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.Font = Enum.Font.SourceSans
    inputBox.TextSize = 14
    inputBox.PlaceholderText = "Spielername für Troll..."
    inputBox.Parent = ContentFrame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputBox
    yPos = yPos + 45

    local trollCommands = {
        {"🔄 Drehen", Color3.fromRGB(255, 100, 0)},
        {"🚀 Hochwerfen", Color3.fromRGB(0, 255, 100)},
        {"💣 NUKE", Color3.fromRGB(255, 0, 0)},
        {"🛠️ BTOOLS", Color3.fromRGB(100, 100, 255)},
        {"💀 KILL AURA", Color3.fromRGB(255, 0, 100)}
    }

    for _, cmd in ipairs(trollCommands) do
        local button = createButton(cmd[1], yPos, cmd[2])

        button.MouseButton1Click:Connect(function()
            local targetName = inputBox.Text

            if cmd[1] == "🔄 Drehen" then
                for _, target in pairs(Players:GetPlayers()) do
                    if target.Name:lower():find(targetName:lower()) and target.Character then
                        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            spawn(function()
                                for i = 1, 50 do
                                    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(45), 0)
                                    wait(0.05)
                                end
                            end)
                        end
                    end
                end
                button.Text = "✅ Gedreht!"
            elseif cmd[1] == "🚀 Hochwerfen" then
                for _, target in pairs(Players:GetPlayers()) do
                    if target.Name:lower():find(targetName:lower()) and target.Character then
                        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.Velocity = Vector3.new(0, 500, 0)
                        end
                    end
                end
                button.Text = "✅ Hochgeworfen!"
            elseif cmd[1] == "💣 NUKE" then
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
            elseif cmd[1] == "🛠️ BTOOLS" then
                cheats.btools = not cheats.btools
                if cheats.btools then
                    local hammer = Instance.new("Tool")
                    hammer.Name = "Hammer"
                    hammer.Parent = player.Backpack
                    
                    local clone = Instance.new("Tool")
                    clone.Name = "Clone"
                    clone.Parent = player.Backpack
                    
                    button.Text = "✅ BTOOLS AKTIV"
                else
                    button.Text = "❌ BTOOLS AUS"
                end
            elseif cmd[1] == "💀 KILL AURA" then
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
            button.Text = cmd[1]
        end)

        yPos = yPos + guiSizes.ButtonSize + 5
    end

    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- ==================================================
-- SHOP TAB (Robux Items)
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
    shopLabel.TextSize = 18
    shopLabel.Text = "💰 ROBUX ITEMS (KOSTENLOS!)"
    shopLabel.Parent = ContentFrame

    local shopCorner = Instance.new("UICorner")
    shopCorner.CornerRadius = UDim.new(0, 10)
    shopCorner.Parent = shopLabel
    yPos = yPos + 55

    local items = {}
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("IntValue") and (obj.Name:lower():find("robux") or obj.Name:lower():find("rbx")) then
            table.insert(items, obj.Name)
        elseif obj:IsA("NumberValue") and (obj.Name:lower():find("robux") or obj.Name:lower():find("rbx")) then
            table.insert(items, obj.Name)
        end
    end

    if #items == 0 then
        items = {"Robux", "RBX", "Currency", "Coins", "Gems", "Diamonds"}
    end

    for i, item in ipairs(items) do
        if i <= 8 then
            local itemBtn = Instance.new("TextButton")
            itemBtn.Size = UDim2.new(1, -20, 0, 40)
            itemBtn.Position = UDim2.new(0, 10, 0, yPos)
            itemBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            itemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            itemBtn.Font = Enum.Font.SourceSansBold
            itemBtn.TextSize = 14
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
        btn.BackgroundColor3 = name == tabName and Settings.GuiColor or Color3.fromRGB(30, 30, 40)
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
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
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
    HomeFrame.Visible = not guiVisible
    MainFrame.Visible = guiVisible
    
    if isMobile then
        MobileToggle.Text = guiVisible and "✕" or "⚡"
        MobileToggle.BackgroundColor3 = guiVisible and Color3.fromRGB(255, 50, 50) or Settings.GuiColor
    end
end

-- Mobile Toggle Button
local MobileToggle = Instance.new("TextButton")
MobileToggle.Name = "MobileToggle"
MobileToggle.Size = UDim2.new(0, 50, 0, 50)
MobileToggle.Position = UDim2.new(0, 20, 0.8, 0)
MobileToggle.BackgroundColor3 = Settings.GuiColor
MobileToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
MobileToggle.Font = Enum.Font.GothamBold
MobileToggle.TextSize = 24
MobileToggle.Text = "⚡"
MobileToggle.Visible = isMobile
MobileToggle.ZIndex = 10
MobileToggle.Parent = ScreenGui

local MobileToggleCorner = Instance.new("UICorner")
MobileToggleCorner.CornerRadius = UDim.new(0, 15)
MobileToggleCorner.Parent = MobileToggle

MobileToggle.MouseButton1Click:Connect(toggleGUI)

-- ==================================================
-- BUTTON EVENTS
-- ==================================================
PcButton.MouseButton1Click:Connect(function()
    Settings.Device = "PC"
    guiSizes = getGuiSize()
    HomeFrame.Visible = false
    MainFrame.Visible = true
    MainFrame.Size = guiSizes.Main
    MainFrame.Position = UDim2.new(0.5, -guiSizes.Main.X.Offset/2, 0.5, -guiSizes.Main.Y.Offset/2)
    switchTab("MAIN")
end)

MobileButton.MouseButton1Click:Connect(function()
    Settings.Device = "Mobile"
    guiSizes = getGuiSize()
    HomeFrame.Visible = false
    MainFrame.Visible = true
    MainFrame.Size = guiSizes.Main
    MainFrame.Position = UDim2.new(0.5, -guiSizes.Main.X.Offset/2, 0.5, -guiSizes.Main.Y.Offset/2)
    switchTab("MAIN")
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
print("👤 YouTube: @Hacker666-00")

-- Made by Waled-Hammad Hacker Tool v6 - Mobile Version
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- GUI Erstellung
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileHackerToolV6"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Haupt-Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 500)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 200, 0)
MainFrame.Parent = ScreenGui

-- Titel
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "Waled-Hammad Hacker Tool v6"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

-- Schließen/Öffnen Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Text = "X"
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(1, -40, 0, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 20
ToggleButton.Parent = MainFrame

-- Tool Container (Grid für 6 Buttons pro Seite)
local ToolContainer = Instance.new("Frame")
ToolContainer.Name = "ToolContainer"
ToolContainer.Size = UDim2.new(1, -20, 0, 360)
ToolContainer.Position = UDim2.new(0, 10, 0, 50)
ToolContainer.BackgroundTransparency = 1
ToolContainer.Parent = MainFrame

-- UI Grid Layout
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.Parent = ToolContainer

-- Seiten-Anzeige
local PageLabel = Instance.new("TextLabel")
PageLabel.Name = "PageLabel"
PageLabel.Text = "Seite 1/5"
PageLabel.Size = UDim2.new(0.4, 0, 0, 30)
PageLabel.Position = UDim2.new(0.3, 0, 0, 415)
PageLabel.BackgroundTransparency = 1
PageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PageLabel.Font = Enum.Font.Gotham
PageLabel.TextSize = 16
PageLabel.Parent = MainFrame

-- Navigation Buttons
local PrevButton = Instance.new("TextButton")
PrevButton.Name = "PrevButton"
PrevButton.Text = "◀"
PrevButton.Size = UDim2.new(0, 60, 0, 40)
PrevButton.Position = UDim2.new(0, 10, 0, 415)
PrevButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PrevButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PrevButton.Font = Enum.Font.GothamBold
PrevButton.TextSize = 20
PrevButton.Parent = MainFrame

local NextButton = Instance.new("TextButton")
NextButton.Name = "NextButton"
NextButton.Text = "▶"
NextButton.Size = UDim2.new(0, 60, 0, 40)
NextButton.Position = UDim2.new(1, -70, 0, 415)
NextButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
NextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NextButton.Font = Enum.Font.GothamBold
NextButton.TextSize = 20
NextButton.Parent = MainFrame

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Text = "Status: Bereit..."
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 1, -40)
StatusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.Parent = MainFrame

-- Tool-Definitionen (30 Tools)
local AllTools = {
	-- Seite 1: Geld & Items
	{Name = "💰 +10K Geld", Icon = "💰"},
	{Name = "💰 +50K Geld", Icon = "💰"},
	{Name = "💰 +100K Geld", Icon = "💰"},
	{Name = "💎 Legendäres Item", Icon = "💎"},
	{Name = "🎒 Inventar x2", Icon = "🎒"},
	{Name = "⚡ XP Boost", Icon = "⚡"},
	
	-- Seite 2: Bewegung
	{Name = "🚀 Speed x3", Icon = "🚀"},
	{Name = "🦘 High Jump", Icon = "🦘"},
	{Name = "👻 Noclip ON", Icon = "👻"},
	{Name = "👻 Noclip OFF", Icon = "👻"},
	{Name = "🌀 Fly Mode", Icon = "🌀"},
	{Name = "📍 Teleport Base", Icon = "📍"},
	
	-- Seite 3: Spieler-Interaktion
	{Name = "🎯 TP zu Spieler", Icon = "🎯"},
	{Name = "👁️ ESP ON", Icon = "👁️"},
	{Name = "🎭 Invisible", Icon = "🎭"},
	{Name = "🛡️ God Mode", Icon = "🛡️"},
	{Name = "⚔️ Kill Aura", Icon = "⚔️"},
	{Name = "🔫 Infinite Ammo", Icon = "🔫"},
	
	-- Seite 4: Game Hacks
	{Name = "⏱️ Slow Motion", Icon = "⏱️"},
	{Name = "🏎️ Vehicle Speed", Icon = "🏎️"},
	{Name = "🎣 Auto Farm", Icon = "🎣"},
	{Name = "🏗️ Build Anywhere", Icon = "🏗️"},
	{Name = "🔓 Unlock All", Icon = "🔓"},
	{Name = "🎮 Anti-AFK", Icon = "🎮"},
	
	-- Seite 5: Tools & Utility
	{Name = "🔧 Tool Giver", Icon = "🔧"},
	{Name = "🧰 Give All Tools", Icon = "🧰"},
	{Name = "⚙️ Admin Tools", Icon = "⚙️"},
	{Name = "📱 Mobile GUI", Icon = "📱"},
	{Name = "🔴 Close GUI", Icon = "🔴"},
	{Name = "🔄 Refresh", Icon = "🔄"}
}

-- Variablen
local currentPage = 1
local toolsPerPage = 6
local totalPages = math.ceil(#AllTools / toolsPerPage)
local toolButtons = {}

-- GUI Öffnen/Schließen
local GUIVisible = true

ToggleButton.MouseButton1Click:Connect(function()
	GUIVisible = not GUIVisible
	MainFrame.Visible = GUIVisible
	if GUIVisible then
		ToggleButton.Text = "X"
	else
		ToggleButton.Text = "☰"
	end
end)

-- Tool-Button erstellen
local function createToolButton(toolName, icon)
	local button = Instance.new("TextButton")
	button.Name = "Tool_" .. toolName
	button.Text = icon .. " " .. toolName
	button.Size = UDim2.new(1, 0, 0, 55)
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	button.BackgroundTransparency = 0.2
	button.BorderSizePixel = 1
	button.BorderColor3 = Color3.fromRGB(0, 150, 0)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.Gotham
	button.TextSize = 16
	button.TextXAlignment = Enum.TextXAlignment.Left
	button.PaddingLeft = UDim.new(0, 10)
	
	-- Touch-Optimierung für Mobile
	button.AutoButtonColor = true
	button.Modal = true
	
	return button
end

-- Tools für aktuelle Seite anzeigen
local function showPage(page)
	-- Container leeren
	for _, button in ipairs(toolButtons) do
		button:Destroy()
	end
	toolButtons = {}
	
	-- Tools für diese Seite berechnen
	local startIndex = (page - 1) * toolsPerPage + 1
	local endIndex = math.min(startIndex + toolsPerPage - 1, #AllTools)
	
	-- Buttons erstellen
	for i = startIndex, endIndex do
		local tool = AllTools[i]
		local button = createToolButton(tool.Name, tool.Icon)
		button.Parent = ToolContainer
		
		-- Funktion für Button-Klick
		button.MouseButton1Click:Connect(function()
			StatusLabel.Text = "Aktiviert: " .. tool.Name
			
			-- Je nach Tool unterschiedliche Aktionen
			if string.find(tool.Name, "Geld") then
				-- Geld-Hack Funktion
				local args = {
					[1] = "Money",
					[2] = 10000
				}
				-- RemoteEvent aufrufen (falls existiert)
				local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
				if remotes then
					remotes:FireServer(unpack(args))
				end
				
			elseif string.find(tool.Name, "Speed") then
				-- Speed erhöhen
				local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
				if humanoid then
					humanoid.WalkSpeed = 50
				end
				
			elseif string.find(tool.Name, "God Mode") then
				-- God Mode
				local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
				if humanoid then
					humanoid.MaxHealth = math.huge
					humanoid.Health = math.huge
				end
				
			elseif string.find(tool.Name, "Noclip ON") then
				-- Noclip aktivieren
				if Player.Character then
					for _, part in ipairs(Player.Character:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
				
			elseif string.find(tool.Name, "ESP") then
				-- ESP für alle Spieler
				for _, otherPlayer in ipairs(Players:GetPlayers()) do
					if otherPlayer ~= Player and otherPlayer.Character then
						local highlight = Instance.new("Highlight")
						highlight.Parent = otherPlayer.Character
						highlight.FillColor = Color3.fromRGB(255, 0, 0)
					end
				end
				
			elseif string.find(tool.Name, "Tool Giver") then
				-- 100 Tools geben
				local toolFolder = game:GetService("ServerStorage"):FindFirstChild("Tools")
				if toolFolder then
					for i = 1, 100 do
						local tool = Instance.new("Tool")
						tool.Name = "HackerTool_" .. i
						tool.CanBeDropped = false
						tool.Parent = Player.Backpack
					end
				end
				
			elseif string.find(tool.Name, "Close GUI") then
				-- GUI schließen
				MainFrame.Visible = false
				ToggleButton.Text = "☰"
			end
			
			-- Erfolgsmeldung nach 2 Sekunden zurücksetzen
			task.wait(2)
			StatusLabel.Text = "Status: Bereit..."
		end)
		
		table.insert(toolButtons, button)
	end
	
	-- Seiten-Anzeige aktualisieren
	PageLabel.Text = "Seite " .. page .. "/" .. totalPages
	
	-- Navigation Buttons aktivieren/deaktivieren
	PrevButton.Visible = (page > 1)
	NextButton.Visible = (page < totalPages)
end

-- Navigation
PrevButton.MouseButton1Click:Connect(function()
	if currentPage > 1 then
		currentPage = currentPage - 1
		showPage(currentPage)
	end
end)

NextButton.MouseButton1Click:Connect(function()
	if currentPage < totalPages then
		currentPage = currentPage + 1
		showPage(currentPage)
	end
end)

-- Mobile-Optimierung: Touch-friendly Buttons
local function makeTouchFriendly(button)
	button.TouchTap:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		task.wait(0.1)
		button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end)
end

-- Drag für Mobile (Touch)
local dragging = false
local dragStart = nil
local startPos = nil

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.Touch then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

MainFrame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- Initiale Seite laden
showPage(1)

-- Info für Entwickler
print("Waled-Hammad Mobile Hacker Tool v6 geladen!")
print("30 Tools auf " .. totalPages .. " Seiten")
print("Verwende ◀ und ▶ zum Blättern")

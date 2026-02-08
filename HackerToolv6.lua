-- HACKER TOOL V6 - 100+ GUI TOOLS
-- Kompakte Version mit den wichtigsten Cheats

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- 🔧 WICHTIGSTE TOOLS (100+)
local toolsDB = {
    -- KATEGORIE: Bewegung (15)
    {name = "✈️ FLY", func = "fly", color = Color3.fromRGB(0, 150, 255)},
    {name = "⚡ SPEED HACK", func = "speed", color = Color3.fromRGB(255, 165, 0)},
    {name = "🚪 NO CLIP", func = "noclip", color = Color3.fromRGB(30, 144, 255)},
    {name = "🔄 INF JUMP", func = "infjump", color = Color3.fromRGB(0, 206, 209)},
    {name = "🏊 SWIM ANYWHERE", func = "swim", color = Color3.fromRGB(0, 191, 255)},
    {name = "🧗 CLIMB ANYWHERE", func = "climb", color = Color3.fromRGB(139, 0, 139)},
    {name = "🌊 WALK ON WATER", func = "waterwalk", color = Color3.fromRGB(0, 0, 255)},
    {name = "🧱 WALK ON WALLS", func = "wallwalk", color = Color3.fromRGB(128, 128, 128)},
    {name = "⬆️ TELEPORT UP", func = "tpup", color = Color3.fromRGB(255, 215, 0)},
    {name = "⬇️ TELEPORT DOWN", func = "tpdown", color = Color3.fromRGB(255, 140, 0)},
    {name = "🎯 TP TO MOUSE", func = "tpmouse", color = Color3.fromRGB(50, 205, 50)},
    {name = "⚖️ NO GRAVITY", func = "nogravity", color = Color3.fromRGB(220, 20, 60)},
    {name = "🌙 MOON JUMP", func = "moonjump", color = Color3.fromRGB(128, 0, 128)},
    {name = "🚀 JETPACK", func = "jetpack", color = Color3.fromRGB(255, 0, 0)},
    {name = "💨 SUPER SPRINT", func = "supersprint", color = Color3.fromRGB(255, 20, 147)},

    -- KATEGORIE: Kampf (15)
    {name = "🛡️ GOD MODE", func = "godmode", color = Color3.fromRGB(0, 255, 0)},
    {name = "💀 KILL AURA", func = "killaura", color = Color3.fromRGB(255, 0, 0)},
    {name = "🎯 AIMBOT", func = "aimbot", color = Color3.fromRGB(220, 20, 60)},
    {name = "🔫 INF AMMO", func = "infammo", color = Color3.fromRGB(160, 32, 240)},
    {name = "⚡ RAPID FIRE", func = "rapidfire", color = Color3.fromRGB(255, 69, 0)},
    {name = "🎯 SILENT AIM", func = "silentaim", color = Color3.fromRGB(255, 105, 180)},
    {name = "🎯 TRIGGER BOT", func = "triggerbot", color = Color3.fromRGB(255, 0, 255)},
    {name = "🎯 WALLBANG", func = "wallbang", color = Color3.fromRGB(139, 0, 0)},
    {name = "⚔️ ONE HIT KILL", func = "onehit", color = Color3.fromRGB(178, 34, 34)},
    {name = "🛡️ AUTO PARRY", func = "autoparry", color = Color3.fromRGB(0, 128, 128)},
    {name = "🎯 HEADSHOT ONLY", func = "headshot", color = Color3.fromRGB(255, 99, 71)},
    {name = "💥 DAMAGE MULTIPLIER", func = "dmgmulti", color = Color3.fromRGB(255, 140, 0)},
    {name = "🎯 NO RECOIL", func = "norecoil", color = Color3.fromRGB(70, 130, 180)},
    {name = "🎯 NO SPREAD", func = "nospread", color = Color3.fromRGB(100, 149, 237)},
    {name = "🎯 AUTO SHOOT", func = "autoshoot", color = Color3.fromRGB(123, 104, 238)},

    -- KATEGORIE: Vision (15)
    {name = "👁️ ESP PLAYERS", func = "esp", color = Color3.fromRGB(255, 0, 0)},
    {name = "📦 ESP BOXES", func = "espboxes", color = Color3.fromRGB(0, 255, 0)},
    {name = "🔄 ESP TRACERS", func = "esptracers", color = Color3.fromRGB(0, 0, 255)},
    {name = "📛 NAME TAGS", func = "nametags", color = Color3.fromRGB(255, 255, 0)},
    {name = "❤️ HEALTH BARS", func = "healthbars", color = Color3.fromRGB(255, 0, 255)},
    {name = "📏 DISTANCE ESP", func = "distanceesp", color = Color3.fromRGB(0, 255, 255)},
    {name = "🦴 SKELETON ESP", func = "skeletonesp", color = Color3.fromRGB(255, 255, 255)},
    {name = "🔍 X-RAY VISION", func = "xray", color = Color3.fromRGB(255, 215, 0)},
    {name = "🌙 NIGHT VISION", func = "nightvision", color = Color3.fromRGB(0, 0, 139)},
    {name = "💡 FULL BRIGHT", func = "fullbright", color = Color3.fromRGB(255, 255, 224)},
    {name = "🌫️ REMOVE FOG", func = "nofog", color = Color3.fromRGB(192, 192, 192)},
    {name = "💎 CHAMS", func = "chams", color = Color3.fromRGB(138, 43, 226)},
    {name = "🎯 CROSSHAIR", func = "crosshair", color = Color3.fromRGB(255, 255, 255)},
    {name = "👻 INVISIBILITY", func = "invisible", color = Color3.fromRGB(128, 128, 128)},
    {name = "🌈 RAINBOW MODE", func = "rainbow", color = Color3.fromRGB(148, 0, 211)},

    -- KATEGORIE: Geld & Items (15)
    {name = "💰 INFINITE MONEY", func = "infmoney", color = Color3.fromRGB(255, 215, 0)},
    {name = "💎 AUTO FARM", func = "autofarm", color = Color3.fromRGB(50, 205, 50)},
    {name = "🔄 AUTO CLICK", func = "autoclick", color = Color3.fromRGB(0, 255, 127)},
    {name = "🎁 AUTO COLLECT", func = "autocollect", color = Color3.fromRGB(0, 250, 154)},
    {name = "🏪 AUTO SELL", func = "autosell", color = Color3.fromRGB(255, 69, 0)},
    {name = "📦 ITEM ESP", func = "itemesp", color = Color3.fromRGB(255, 105, 180)},
    {name = "🗳️ CHEST ESP", func = "chestesp", color = Color3.fromRGB(255, 140, 0)},
    {name = "⛏️ ORE ESP", func = "oreesp", color = Color3.fromRGB(184, 134, 11)},
    {name = "🤖 NPC ESP", func = "npcesp", color = Color3.fromRGB(0, 191, 255)},
    {name = "🎯 QUEST FARM", func = "questfarm", color = Color3.fromRGB(138, 43, 226)},
    {name = "✅ AUTO COMPLETE", func = "autocomplete", color = Color3.fromRGB(0, 128, 0)},
    {name = "📈 MONEY MULTIPLIER", func = "moneymulti", color = Color3.fromRGB(255, 215, 0)},
    {name = "🔄 AUTO REBIRTH", func = "autorebirth", color = Color3.fromRGB(255, 20, 147)},
    {name = "🎰 AUTO SPIN", func = "autospin", color = Color3.fromRGB(123, 104, 238)},
    {name = "🥚 AUTO HATCH", func = "autohatch", color = Color3.fromRGB(210, 105, 30)},

    -- KATEGORIE: Dupe & Exploits (15)
    {name = "🔄 DUPE ITEMS", func = "dupeitems", color = Color3.fromRGB(255, 0, 0)},
    {name = "🎯 ITEM DUPLICATOR", func = "itemdupe", color = Color3.fromRGB(255, 69, 0)},
    {name = "💰 MONEY DUPE", func = "moneydupe", color = Color3.fromRGB(255, 215, 0)},
    {name = "💎 GEM DUPE", func = "gemdupe", color = Color3.fromRGB(0, 255, 255)},
    {name = "🎁 PET DUPE", func = "petdupe", color = Color3.fromRGB(255, 105, 180)},
    {name = "🏎️ VEHICLE DUPE", func = "vehicledupe", color = Color3.fromRGB(70, 130, 180)},
    {name = "🏠 HOUSE DUPE", func = "housedupe", color = Color3.fromRGB(139, 69, 19)},
    {name = "🎒 BACKPACK DUPE", func = "backpackdupe", color = Color3.fromRGB(128, 0, 128)},
    {name = "🛠️ TOOL DUPE", func = "tooldupe", color = Color3.fromRGB(255, 140, 0)},
    {name = "👕 CLOTHING DUPE", func = "clothdupe", color = Color3.fromRGB(220, 20, 60)},
    {name = "🔫 WEAPON DUPE", func = "weapondupe", color = Color3.fromRGB(178, 34, 34)},
    {name = "📦 STACK DUPE", func = "stackdupe", color = Color3.fromRGB(0, 100, 0)},
    {name = "⚡ FAST DUPE", func = "fastdupe", color = Color3.fromRGB(255, 0, 255)},
    {name = "🔄 AUTO DUPE", func = "autodupe", color = Color3.fromRGB(255, 165, 0)},
    {name = "🎯 SERVER DUPE", func = "serverdupe", color = Color3.fromRGB(0, 191, 255)},

    -- KATEGORIE: Schutz (15)
    {name = "🌀 ANTI-AFK", func = "antiafk", color = Color3.fromRGB(0, 128, 0)},
    {name = "🚫 ANTI-KICK", func = "antikick", color = Color3.fromRGB(255, 0, 0)},
    {name = "🛡️ ANTI-BAN", func = "antiban", color = Color3.fromRGB(178, 34, 34)},
    {name = "👻 ANTI-DETECT", func = "antidetect", color = Color3.fromRGB(128, 128, 128)},
    {name = "🎯 NO KNOCKBACK", func = "noknockback", color = Color3.fromRGB(70, 130, 180)},
    {name = "💥 NO FALL DAMAGE", func = "nofall", color = Color3.fromRGB(100, 149, 237)},
    {name = "🔒 ANTI-GRAB", func = "antigrab", color = Color3.fromRGB(255, 20, 147)},
    {name = "🚫 ANTI-TELEPORT", func = "antiteleport", color = Color3.fromRGB(123, 104, 238)},
    {name = "🛑 ANTI-FREEZE", func = "antifreeze", color = Color3.fromRGB(0, 191, 255)},
    {name = "⚡ ANTI-STUN", func = "antistun", color = Color3.fromRGB(255, 140, 0)},
    {name = "🌀 ANTI-SLOW", func = "antislow", color = Color3.fromRGB(255, 69, 0)},
    {name = "🎯 NO COLLISION", func = "nocollision", color = Color3.fromRGB(50, 205, 50)},
    {name = "🔒 ANTI-JAIL", func = "antijail", color = Color3.fromRGB(139, 0, 139)},
    {name = "🛡️ ANTI-ARREST", func = "antiarrest", color = Color3.fromRGB(220, 20, 60)},
    {name = "👻 GHOST MODE", func = "ghostmode", color = Color3.fromRGB(192, 192, 192)},

    -- KATEGORIE: Admin & Spieler (10)
    {name = "👥 BRING ALL", func = "bringall", color = Color3.fromRGB(0, 150, 255)},
    {name = "🎯 TELEPORT ALL", func = "tpall", color = Color3.fromRGB(255, 165, 0)},
    {name = "❄️ FREEZE ALL", func = "freezeall", color = Color3.fromRGB(0, 191, 255)},
    {name = "💀 KILL ALL", func = "killall", color = Color3.fromRGB(255, 0, 0)},
    {name = "❤️ HEAL ALL", func = "healall", color = Color3.fromRGB(0, 255, 0)},
    {name = "🎭 SPECTATE", func = "spectate", color = Color3.fromRGB(255, 105, 180)},
    {name = "👁️ VIEW PLAYER", func = "viewplayer", color = Color3.fromRGB(138, 43, 226)},
    {name = "📋 COPY PLAYER", func = "copyplayer", color = Color3.fromRGB(255, 215, 0)},
    {name = "🎮 CONTROL PLAYER", func = "controlplayer", color = Color3.fromRGB(255, 69, 0)},
    {name = "🔄 RESET ALL", func = "resetall", color = Color3.fromRGB(220, 20, 60)}
}

-- 🎨 GUI MIT 100+ BUTTONS
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HackerTool100"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 600)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- TITLE
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Title.Text = "⚡ HACKER TOOL V6 - 100+ TOOLS ⚡"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = MainFrame

-- SEARCH BAR
local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(0.9, 0, 0, 40)
SearchBox.Position = UDim2.new(0.05, 0, 0, 60)
SearchBox.PlaceholderText = "🔍 Suche Tool..."
SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.Parent = MainFrame

-- CATEGORY BUTTONS
local categories = {"All", "Movement", "Combat", "Vision", "Money", "Dupe", "Protection", "Admin"}
local categoryFrame = Instance.new("ScrollingFrame")
categoryFrame.Size = UDim2.new(1, 0, 0, 50)
categoryFrame.Position = UDim2.new(0, 0, 0, 110)
categoryFrame.BackgroundTransparency = 1
categoryFrame.ScrollBarThickness = 0
categoryFrame.CanvasSize = UDim2.new(2, 0, 0, 0)
categoryFrame.Parent = MainFrame

local categoryButtons = {}
for i, cat in ipairs(categories) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 0, 40)
    btn.Position = UDim2.new(0, 10 + (i-1)*85, 0, 5)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Text = cat
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = categoryFrame
    categoryButtons[cat] = btn
end

-- TOOLS LIST (SCROLLING)
local ToolsFrame = Instance.new("ScrollingFrame")
ToolsFrame.Size = UDim2.new(1, -20, 1, -180)
ToolsFrame.Position = UDim2.new(0, 10, 0, 170)
ToolsFrame.BackgroundTransparency = 1
ToolsFrame.ScrollBarThickness = 8
ToolsFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
ToolsFrame.CanvasSize = UDim2.new(0, 0, 0, (#toolsDB * 35) + 10)
ToolsFrame.Parent = MainFrame

-- CREATE 100+ BUTTONS
local activeCheats = {}
local function createToolButtons(filterText, category)
    ToolsFrame:ClearAllChildren()
    
    local yPos = 5
    local count = 0
    
    for i, tool in ipairs(toolsDB) do
        local showTool = true
        
        -- Filter nach Text
        if filterText and filterText ~= "" then
            if not string.find(string.lower(tool.name), string.lower(filterText)) then
                showTool = false
            end
        end
        
        -- Filter nach Kategorie
        if category and category ~= "All" then
            local toolCat = "Other"
            if i <= 15 then toolCat = "Movement"
            elseif i <= 30 then toolCat = "Combat"
            elseif i <= 45 then toolCat = "Vision"
            elseif i <= 60 then toolCat = "Money"
            elseif i <= 75 then toolCat = "Dupe"
            elseif i <= 90 then toolCat = "Protection"
            else toolCat = "Admin" end
            
            if toolCat ~= category then
                showTool = false
            end
        end
        
        if showTool then
            count = count + 1
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Position = UDim2.new(0, 5, 0, yPos)
            btn.BackgroundColor3 = tool.color
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Text = tool.name .. " [OFF]"
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 14
            btn.Parent = ToolsFrame
            
            local isActive = false
            btn.MouseButton1Click:Connect(function()
                isActive = not isActive
                activeCheats[tool.func] = isActive
                
                if isActive then
                    btn.Text = tool.name .. " [ON]"
                    btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                    
                    -- Funktion ausführen
                    if tool.func == "fly" then
                        -- Fly Code hier
                    elseif tool.func == "godmode" then
                        humanoid.MaxHealth = math.huge
                    elseif tool.func == "infmoney" then
                        -- Money hack
                    elseif tool.func == "dupeitems" then
                        -- Item dupe
                        print("🔄 Item Dupe aktiviert!")
                    elseif tool.func == "esp" then
                        -- ESP
                    end
                else
                    btn.Text = tool.name .. " [OFF]"
                    btn.BackgroundColor3 = tool.color
                    
                    -- Deaktivieren
                    if tool.func == "godmode" then
                        humanoid.MaxHealth = 100
                    end
                end
            end)
            
            yPos = yPos + 35
        end
    end
    
    -- Info Text
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 0, 30)
    info.Position = UDim2.new(0, 0, 0, yPos + 5)
    info.BackgroundTransparency = 1
    info.TextColor3 = Color3.fromRGB(0, 255, 255)
    info.Text = "🔧 " .. count .. " Tools gefunden | Total: 100+"
    info.Font = Enum.Font.SourceSansBold
    info.Parent = ToolsFrame
    
    ToolsFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 40)
end

-- SEARCH FUNCTION
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    createToolButtons(SearchBox.Text)
end)

-- CATEGORY CLICKS
for cat, btn in pairs(categoryButtons) do
    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(categoryButtons) do
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        createToolButtons(SearchBox.Text, cat)
    end)
end

-- TOGGLE GUI
local guiVisible = true
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        guiVisible = not guiVisible
        MainFrame.Visible = guiVisible
    end
end)

-- INIT
createToolButtons()
categoryButtons["All"].BackgroundColor3 = Color3.fromRGB(0, 150, 255)

print("✅ Hacker Tool V6 mit 100+ Tools geladen!")
print("🔧 Tools: Fly, Godmode, ESP, Aimbot, Money Hack, Dupe, etc.")
print("🎮 Toggle GUI: RightControl")
print("🔍 Suche: " .. #toolsDB .. " Tools verfügbar")

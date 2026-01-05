-- Script avec notification
local url = "https://raw.githubusercontent.com/Bobleboss/roblox-lua-scripts/main/Main.client.lua"

-- Créer une notification
local notification = Instance.new("ScreenGui")
notification.Name = "LoaderNotification"
notification.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Parent = notification

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -20, 1, -50)
textLabel.Position = UDim2.new(0, 10, 0, 10)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.Text = "Chargement du script..."
textLabel.Font = Enum.Font.Gotham
textLabel.TextSize = 16
textLabel.TextWrapped = true
textLabel.Parent = frame

local function updateMessage(message)
    textLabel.Text = message
end

-- Fonction de chargement
local function loadScript()
    updateMessage("Téléchargement depuis GitHub...")
    
    local success, httpResponse = pcall(function()
        return game:HttpGet(url, true)
    end)
    
    if not success then
        updateMessage("❌ Erreur de connexion\n" .. httpResponse)
        task.wait(3)
        notification:Destroy()
        return
    end
    
    updateMessage("Compilation du code...")
    local loadedFunction, compileError = loadstring(httpResponse)
    
    if not loadedFunction then
        updateMessage("❌ Erreur de syntaxe\n" .. compileError)
        task.wait(3)
        notification:Destroy()
        return
    end
    
    updateMessage("Exécution en cours...")
    local success2, execError = pcall(loadedFunction)
    
    if not success2 then
        updateMessage("❌ Erreur d'exécution\n" .. execError)
        task.wait(3)
    else
        updateMessage("✅ Script chargé avec succès!")
        task.wait(1)
    end
    
    notification:Destroy()
end

loadScript()

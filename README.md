--[[
███████╗███╗   ███╗██╗████████╗███████╗    ██╗  ██╗██╗   ██╗██████╗ 
██╔════╝████╗ ████║██║╚══██╔══╝██╔════╝    ██║  ██║╚██╗ ██╔╝██╔══██╗
█████╗  ██╔████╔██║██║   ██║   █████╗█████╗███████║ ╚████╔╝ ██████╔╝
██╔══╝  ██║╚██╔╝██║██║   ██║   ██╔══╝╚════╝██╔══██║  ╚██╔╝  ██╔═══╝ 
███████╗██║ ╚═╝ ██║██║   ██║   ███████╗    ██║  ██║   ██║   ██║     
╚══════╝╚═╝     ╚═╝╚═╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝   ╚═╝   ╚═╝     
              EMITE HUB - V2.1 - HoHo Hub Clone Plus GUI
]]

--// Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

--// Flags globais
_G.Flags = _G.Flags or {}
local Flags = _G.Flags

--// Detecção de Sea atual (mock simples)
function detectSea()
    local mapName = Workspace:FindFirstChild("MapName")
    if mapName and mapName:IsA("StringValue") then
        if mapName.Value:lower():find("sea2") then return 2 end
        if mapName.Value:lower():find("sea3") then return 3 end
    end
    return 1
end

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EmiteHubUI"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 460)
Frame.Position = UDim2.new(0, 10, 0.5, -230)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.Text = "Emite Hub GUI"

local function createToggle(text, order, flagName)
    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(1, -20, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, 50 + (order * 35))
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.TextColor3 = Color3.new(1,1,1)
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 16
    Button.Text = "[OFF] " .. text

    local toggled = false
    Button.MouseButton1Click:Connect(function()
        toggled = not toggled
        Flags[flagName] = toggled
        Button.Text = (toggled and "[ON] " or "[OFF] ") .. text
        Button.BackgroundColor3 = toggled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    end)
end

-- Lista de funções disponíveis com ordenamento
local toggleList = {
    {"Auto Farm", "AutoFarm"},
    {"Auto Skill", "AutoSkill"},
    {"Auto Buy", "AutoBuy"},
    {"Auto Respawn", "AutoRespawn"},
    {"Auto Quest", "AutoQuest"},
    {"Boss Farm", "BossFarm"},
    {"ESP (Players/NPCs)", "ESP"},
    {"Kill Aura", "KillAura"},
    {"Auto Stat", "AutoStat"},
    {"Fruit ESP", "FruitESP"},
    {"Chest Farm", "ChestFarm"},
    {"Webhook Notify", "WebhookNotify"},
    {"Server Hop", "ServerHop"},
    {"Teleport GUI", "TeleportGUI"},
    {"Safe Farm Mode", "SafeFarm"},
    {"Anti-Afk", "AntiAFK"}
}

for i, item in ipairs(toggleList) do
    createToggle(item[1], i - 1, item[2])
end

-- Mensagem de boas-vindas
local welcomeText = Instance.new("TextLabel")
welcomeText.Size = UDim2.new(0, 300, 0, 30)
welcomeText.Position = UDim2.new(0.5, -150, 0, 10)
welcomeText.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
welcomeText.TextColor3 = Color3.new(1, 1, 1)
welcomeText.Text = "[EmiteHub] GUI carregada - Sea: " .. tostring(detectSea())
welcomeText.TextScaled = true
welcomeText.Font = Enum.Font.SourceSansBold
welcomeText.BackgroundTransparency = 0.3
welcomeText.Parent = game.CoreGui

-- Auto remove após 4 segundos
task.delay(4, function()
    if welcomeText then welcomeText:Destroy() end
end)

-- Anti-AFK
RunService.Stepped:Connect(function()
    if Flags.AntiAFK then
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    end
end)

-- AutoFarm básico
RunService.Heartbeat:Connect(function()
    if Flags.AutoFarm then
        local enemies = Workspace:FindFirstChild("Enemies")
        if enemies then
            for _, npc in pairs(enemies:GetChildren()) do
                if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 and npc:FindFirstChild("HumanoidRootPart") then
                    HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                    ReplicatedStorage:FindFirstChild("Events"):FindFirstChild("MeleeAttack"):FireServer()
                    if Flags.AutoSkill then
                        ReplicatedStorage:FindFirstChild("Events"):FindFirstChild("UseSkill"):FireServer("Z")
                    end
                    break
                end
            end
        end
    end
end)

print("[EmiteHub] GUI atualizada com funções ativas de AutoFarm!")

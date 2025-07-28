-- EMITE HUB v5.2 Ultra - O Hub Mais Completo de Blox Fruits
-- Desenvolvido por: PikaFlowz

-- SERVIÇOS BÁSICOS
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- CONFIG PADRÃO
_G.EmiteSettings = {
    AutoFarm = true,
    AutoQuest = true,
    AutoBoss = true,
    AutoHaki = true,
    ESP = true,
    AutoLeaveAdmin = true,
    Fly = true,
    AutoClick = true,
    FastAutoClick = true,
    SafeMode = true,
    LowGraphics = false
}

-- ANTI AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- GUI PRINCIPAL
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "EmiteHubUI"
MainGui.ResetOnSpawn = false
MainGui.Parent = CoreGui

local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "EmiteHubOpen"
OpenButton.Image = "rbxassetid://15725685720" -- Letra E Neon Vermelho
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 20, 0.5, -30)
OpenButton.BackgroundTransparency = 1
OpenButton.ZIndex = 10
OpenButton.Parent = CoreGui

OpenButton.MouseButton1Click:Connect(function()
    MainGui.Enabled = not MainGui.Enabled
end)

-- FUNÇÕES AUTO CLICK
spawn(function()
    while wait(0.1) do
        if _G.EmiteSettings.AutoClick then
            for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    tool:Activate()
                end
            end
        end
    end
end)

spawn(function()
    while wait(0.025) do
        if _G.EmiteSettings.FastAutoClick then
            for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    tool:Activate()
                end
            end
        end
    end
end)

-- DETECÇÃO DE SEA (MAR)
function DetectSea()
    local pos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
    if not pos then return 1 end
    if pos.Y > 5000 then return 3 end
    if pos.Y > 1000 then return 2 end
    return 1
end

local CurrentSea = DetectSea()

-- MSG DE BOAS-VINDAS
print("[EMITE HUB] Seja bem-vindo, magnata @" .. LocalPlayer.Name)
print("[EMITE HUB] Sea atual detectado: " .. tostring(CurrentSea))

-- CONTINUA...
-- (Interface, AutoFarm, AutoQuest, ESP, PvP, SafeMode, ServerHop, FruitSniper, AutoRaid...)
-- (Todas as partes serão coladas aqui na próxima atualização do documento)

-- Assinatura
print("[EMITE HUB] Desenvolvido por PikaFlowz")

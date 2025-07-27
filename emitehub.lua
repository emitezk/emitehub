███████╗███╗   ███╗██╗████████╗███████╗    ██╗  ██╗██╗   ██╗██████╗ 
██╔════╝████╗ ████║██║╚══██╔══╝██╔════╝    ██║  ██║╚██╗ ██╔╝██╔══██╗
█████╗  ██╔████╔██║██║   ██║   █████╗█████╗███████║ ╚████╔╝ ██████╔╝
██╔══╝  ██║╚██╔╝██║██║   ██║   ██╔══╝╚════╝██╔══██║  ╚██╔╝  ██╔═══╝ 
███████╗██║ ╚═╝ ██║██║   ██║   ███████╗    ██║  ██║   ██║   ██║     
╚══════╝╚═╝     ╚═╝╚═╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝   ╚═╝   ╚═╝     
           EMITE HUB - V4.0 - Inspirado no Cokka Hub (Ultra Completo)
]]

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Funções avançadas
function AutoRespawn()
    LocalPlayer.CharacterAdded:Connect(function()
        wait(1)
        AutoHaki()
    end)
end

function AntiAFK()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    end)
end

function AutoHaki()
    spawn(function()
        while wait(1) do
            pcall(function()
                if not LocalPlayer.Character:FindFirstChild("HasBuso") then
                    ReplicatedStorage.Remotes.Comm:InvokeServer("Buso")
                end
            end)
        end
    end)
end

function FarmAir()
    spawn(function()
        while wait(0.1) do
            pcall(function()
                if _G.AutoFarm and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.Humanoid:ChangeState(11)
                    LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
                end
            end)
        end
    end)
end

function ExpandHitbox()
    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") then
            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
            v.HumanoidRootPart.Transparency = 0.5
            v.HumanoidRootPart.BrickColor = BrickColor.new("Bright red")
            v.HumanoidRootPart.Material = Enum.Material.Neon
            v.HumanoidRootPart.CanCollide = false
        end
    end
end

-- Inicialização automática de funções principais
AutoHaki()
AntiAFK()
AutoRespawn()
FarmAir()
ExpandHitbox()

-- GUI organizada por seções estilo Cokka Hub
local Tabs = {
    ["Home"] = {
        "AutoQuest", "AutoHaki", "AutoRespawn"
    },
    ["Farm"] = {
        "AutoFarm", "AutoClick", "FarmAir", "ExpandHitbox", "AutoKatakuri", "AutoElite", "AutoSeaBeast"
    },
    ["Skills"] = {
        "AutoBuySkills"
    },
    ["Raids"] = {
        "AutoRaid", "AutoAwaken"
    },
    ["Fragments"] = {
        "AutoFragment"
    },
    ["Teleport"] = {
        "AutoTeleport"
    },
    ["ESP"] = {
        "ESPPlayers", "ESPEnemies", "ESPChests"
    },
    ["Stats"] = {
        "AutoStatStore", "AutoSetStats"
    },
    ["Extra"] = {
        "NoClip", "AntiAFK", "AutoReconnect"
    }
}

-- GUI Principal
local CoreGui = game:GetService("CoreGui")
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "MainGui"
MainGui.ResetOnSpawn = false
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainGui.Enabled = false
MainGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MainGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "EMITE HUB - V4"
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.Parent = MainFrame

-- Botão flutuante para abrir GUI (imagem personalizada)
local button = Instance.new("ImageButton")
button.Name = "EmiteHubOpen"
button.Image = "rbxassetid://15722235844"
button.Size = UDim2.new(0, 80, 0, 80)
button.Position = UDim2.new(0, 20, 0.5, -40)
button.BackgroundTransparency = 1
button.ZIndex = 10
button.Parent = CoreGui

button.MouseButton1Click:Connect(function()
    MainGui.Enabled = not MainGui.Enabled
end)

-- Link de execução atualizado
print("Para executar: loadstring(game:HttpGet('https://raw.githubusercontent.com/emitezk/emitehub/main/emitehub.lua'))()")

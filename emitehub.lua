-- EMITE HUB v4.1 - Interface com botão flutuante e estrutura pronta para expansão

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

-- Anti AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
end)

-- GUI Principal
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "EmiteHubUI"
MainGui.ResetOnSpawn = false
MainGui.Enabled = false
MainGui.Parent = CoreGui

-- Janela principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MainGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "EMITE HUB - V4.1"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.Parent = MainFrame

-- Botão flutuante com imagem personalizada
local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "EmiteHubOpen"
OpenButton.Image = "rbxassetid://15725685720" -- Letra "E" neon vermelha
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 20, 0.5, -30)
OpenButton.BackgroundTransparency = 1
OpenButton.ZIndex = 10
OpenButton.Parent = CoreGui

OpenButton.MouseButton1Click:Connect(function()
    MainGui.Enabled = not MainGui.Enabled
end)

-- Função ESP (ativada futuramente por botão)
_G.ESPEnabled = false

function ToggleESP(state)
    _G.ESPEnabled = state
    if state then
        for _, v in pairs(Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") and not v.HumanoidRootPart:FindFirstChild("SelectionBox") then
                local box = Instance.new("SelectionBox", v.HumanoidRootPart)
                box.Adornee = v.HumanoidRootPart
                box.LineThickness = 0.05
                box.Color3 = Color3.fromRGB(255, 0, 0)
            end
        end
    else
        for _, v in pairs(Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                local box = v.HumanoidRootPart:FindFirstChild("SelectionBox")
                if box then box:Destroy() end
            end
        end
    end
end

-- Aviso
print("[EMITE HUB] Interface carregada. Nenhuma função ativa até que seja clicada.")

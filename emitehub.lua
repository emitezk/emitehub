-- EMITE HUB v5.2.2 - Blox Fruits PATCHED FULL VERSION
-- Criado por: PikaFlowz

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Anti AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
end)

-- GUI
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "EmiteHubUI"
MainGui.ResetOnSpawn = false
MainGui.Parent = CoreGui
MainGui.Enabled = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MainGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "EMITE HUB - BLOX FRUITS v5.2.2"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.Parent = MainFrame

-- Botão flutuante
local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "EmiteHubOpen"
OpenButton.Image = "rbxassetid://15725685720"
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 20, 0.5, -30)
OpenButton.BackgroundTransparency = 1
OpenButton.ZIndex = 10
OpenButton.Parent = CoreGui

OpenButton.MouseButton1Click:Connect(function()
    MainGui.Enabled = not MainGui.Enabled
end)

-- Configurações padrão
_G.EmiteSettings = {
    AutoClick = true,
    FastAutoClick = true,
    AutoFarm = true,
    AutoBuso = true,
    ESP = true
}

-- AutoClick comum
spawn(function()
    while task.wait(0.15) do
        if _G.EmiteSettings.AutoClick then
            pcall(function()
                mouse1click()
            end)
        end
    end
end)

-- FastAutoClick + AutoFarm combo
spawn(function()
    while task.wait(0.05) do
        if _G.EmiteSettings.FastAutoClick then
            pcall(function()
                mouse1press()
                task.wait()
                mouse1release()
            end)
        end
    end
end)

-- Auto Buso
spawn(function()
    while task.wait(2) do
        if _G.EmiteSettings.AutoBuso then
            pcall(function()
                if not LocalPlayer.Character:FindFirstChild("HasBuso") then
                    ReplicatedStorage.Remotes:WaitForChild("Buso"):FireServer()
                end
            end)
        end
    end
end)

-- ESP
local function EnableESP()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            if not v.HumanoidRootPart:FindFirstChild("SelectionBox") then
                local box = Instance.new("SelectionBox")
                box.Adornee = v.HumanoidRootPart
                box.LineThickness = 0.05
                box.Color3 = Color3.fromRGB(255, 0, 0)
                box.Parent = v.HumanoidRootPart
            end
        end
    end
end

-- Loop ESP
spawn(function()
    while task.wait(2) do
        if _G.EmiteSettings.ESP then
            pcall(EnableESP)
        end
    end
end)

-- Logs
print("[EMITE HUB] Interface carregada e funcional.")
for k, v in pairs(_G.EmiteSettings) do
    print("[EMITE HUB] " .. k .. ": ", v)
end
print("[EMITE HUB] Desenvolvido por PikaFlowz - Seja bem-vindo, @" .. LocalPlayer.Name)

-- EMITE HUB - Blox Fruits v5.3.6
-- Desenvolvido por: PikaFlowz

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    if Workspace.CurrentCamera then
        VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
    end
end)

-- GUI
pcall(function()
    if CoreGui:FindFirstChild("EmiteHubUI") then CoreGui.EmiteHubUI:Destroy() end
end)

local MainGui = Instance.new("ScreenGui")
MainGui.Name = "EmiteHubUI"
MainGui.IgnoreGuiInset = true
MainGui.ResetOnSpawn = false
MainGui.Enabled = false
MainGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.85, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
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
Title.Text = "EMITE HUB - BLOX FRUITS v5.3.6"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.Parent = MainFrame

local ButtonContainer = Instance.new("ScrollingFrame")
ButtonContainer.Size = UDim2.new(1, -20, 1, -50)
ButtonContainer.Position = UDim2.new(0, 10, 0, 45)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.CanvasSize = UDim2.new(0, 0, 2, 0)
ButtonContainer.ScrollBarThickness = 4
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ButtonContainer

local function createToggle(name, default, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, 0, 0, 40)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 18
    toggle.Text = name .. ": " .. (default and "ON" or "OFF")
    toggle.Parent = ButtonContainer

    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = name .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)

    callback(state)
end

-- Configurações iniciais
_G.EmiteSettings = {
    AutoClick = true,
    FastAutoClick = true,
    AutoFarm = true,
    AutoBuso = true,
    ESP = true
}

-- Botões principais
createToggle("Auto Click", true, function(v) _G.EmiteSettings.AutoClick = v end)
createToggle("Fast Auto Click", true, function(v) _G.EmiteSettings.FastAutoClick = v end)
createToggle("Auto Buso", true, function(v) _G.EmiteSettings.AutoBuso = v end)
createToggle("ESP", true, function(v) _G.EmiteSettings.ESP = v end)

-- Botão flutuante "E"
local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "EmiteHubOpen"
OpenButton.Image = "rbxassetid://15725685720"
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Position = UDim2.new(0, 10, 0.8, 0)
OpenButton.BackgroundTransparency = 1
OpenButton.ZIndex = 10
OpenButton.Parent = CoreGui

OpenButton.MouseButton1Click:Connect(function()
    MainGui.Enabled = not MainGui.Enabled
end)

print("[EMITE HUB - BLOX FRUITS] Interface corrigida para mobile e botões visíveis!")
print("[EMITE HUB] Olá, @" .. (LocalPlayer and LocalPlayer.Name or "Jogador") .. "!")

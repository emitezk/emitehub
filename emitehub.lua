-- EMITE HUB - Blox Fruits v5.3.5
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
MainGui.Parent = CoreGui
MainGui.ResetOnSpawn = false
MainGui.Enabled = true

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.85, 0, 0.6, 0) -- Menor para caber na tela mobile
MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset / 2, 0.5, -MainFrame.Size.Y.Offset / 2)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
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
Title.Text = "EMITE HUB - BLOX FRUITS v5.3.5"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.Parent = MainFrame

local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "EmiteHubOpen"
OpenButton.Image = "rbxassetid://15725685720"
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 20, 0.5, -30)
OpenButton.BackgroundTransparency = 1
OpenButton.ZIndex = 10
OpenButton.Parent = MainGui

OpenButton.MouseButton1Click:Connect(function()
    MainGui.Enabled = not MainGui.Enabled
end)

-- Layout de botões
local ButtonContainer = Instance.new("ScrollingFrame")
ButtonContainer.Size = UDim2.new(1, 0, 1, -40)
ButtonContainer.Position = UDim2.new(0, 0, 0, 40)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.CanvasSize = UDim2.new(0, 0, 2, 0)
ButtonContainer.ScrollBarThickness = 4
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOr-- EMITE HUB - Blox Fruits v5.3.5
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
MainGui.Parent = CoreGui
MainGui.ResetOnSpawn = false
MainGui.Enabled = true

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.85, 0, 0.6, 0) -- Menor para caber na tela mobile
MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset / 2, 0.5, -MainFrame.Size.Y.Offset / 2)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
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
Title.Text = "EMITE HUB - BLOX FRUITS v5.3.5"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.Parent = MainFrame

local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "EmiteHubOpen"
OpenButton.Image = "rbxassetid://15725685720"
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 20, 0.5, -30)
OpenButton.BackgroundTransparency = 1
OpenButton.ZIndex = 10
OpenButton.Parent = MainGui

OpenButton.MouseButton1Click:Connect(function()
    MainGui.Enabled = not MainGui.Enabled
end)

-- Layout de botões
local ButtonContainer = Instance.new("ScrollingFrame")
ButtonContainer.Size = UDim2.new(1, 0, 1, -40)
ButtonContainer.Position = UDim2.new(0, 0, 0, 40)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.CanvasSize = UDim2.new(0, 0, 2, 0)
ButtonContainer.ScrollBarThickness = 4
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOr

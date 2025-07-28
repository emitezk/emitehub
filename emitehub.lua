-- EMITE HUB - Blox Fruits v5.3.3
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
MainGui.Parent = (syn and CoreGui) or (gethui and gethui()) or Players.LocalPlayer:WaitForChild("PlayerGui")
MainGui.ResetOnSpawn = false
MainGui.Enabled = true

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
Title.Text = "EMITE HUB - BLOX FRUITS v5.3.3"
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

-- Configs
_G.EmiteSettings = {
    AutoClick = true,
    FastAutoClick = true,
    AutoFarm = true,
    AutoBuso = true,
    ESP = true
}

-- Auto Click
spawn(function()
    while task.wait(0.15) do
        if _G.EmiteSettings.AutoClick then
            local success, err = pcall(function()
                local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local tool = char and char:FindFirstChildOfClass("Tool")
                if tool then
                    local remote = tool:FindFirstChildWhichIsA("RemoteFunction") or tool:FindFirstChild("RemoteEvent")
                    if remote then
                        remote:InvokeServer("Click")
                    end
                end
            end)
            if not success then warn("AutoClick erro:", err) end
        end
    end
end)

-- Fast Auto Click
spawn(function()
    while task.wait(0.05) do
        if _G.EmiteSettings.FastAutoClick then
            local success, err = pcall(function()
                local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local tool = char and char:FindFirstChildOfClass("Tool")
                if tool then
                    local remote = tool:FindFirstChildWhichIsA("RemoteFunction") or tool:FindFirstChild("RemoteEvent")
                    if remote then
                        remote:InvokeServer("Click")
                    end
                end
            end)
            if not success then warn("FastAutoClick erro:", err) end
        end
    end
end)

-- Auto Buso
spawn(function()
    while task.wait(2) do
        if _G.EmiteSettings.AutoBuso then
            pcall(function()
                local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                if char and not char:FindFirstChild("HasBuso") then
                    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                    if remotes and remotes:FindFirstChild("Buso") then
                        remotes.Buso:FireServer()
                    end
                end
            end)
        end
    end
end)

-- ESP
local function EnableESP()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            if not v.HumanoidRootPart:FindFirstChild("EmiteESP") then
                local box = Instance.new("SelectionBox")
                box.Name = "EmiteESP"
                box.Adornee = v.HumanoidRootPart
                box.LineThickness = 0.05
                box.Color3 = Color3.fromRGB(255, 0, 0)
                box.Parent = v.HumanoidRootPart
            end
        end
    end
end

spawn(function()
    while task.wait(2) do
        if _G.EmiteSettings.ESP then
            pcall(EnableESP)
        end
    end
end)

print("[EMITE HUB - BLOX FRUITS] Interface carregada com sucesso!")
print("[EMITE HUB] Olá, @" .. (LocalPlayer and LocalPlayer.Name or "Jogador") .. "!")

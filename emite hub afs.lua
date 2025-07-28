-- EMITE HUB - Anime Fighters Simulator (AFS) - v1.0.0
-- Desenvolvido por: PikaFlowz

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- GUI
pcall(function()
    if CoreGui:FindFirstChild("EmiteHubAFS") then
        CoreGui.EmiteHubAFS:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EmiteHubAFS"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "EMITE HUB - AFS"
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 255, 100)
Title.Parent = MainFrame

-- Configs
_G.EmiteAFSSettings = {
    AutoClick = true,
    AutoFarm = true,
    ESP = true
}

-- Forçar botão de AutoClick mesmo sem Gamepass
spawn(function()
    while task.wait(2) do
        pcall(function()
            local clickBtn = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UI")
            if clickBtn then
                local b = clickBtn:FindFirstChild("ClickButton") or clickBtn:FindFirstChildWhichIsA("ImageButton", true)
                if b then
                    b.Visible = true
                    b.AutoButtonColor = true
                    if _G.EmiteAFSSettings.AutoClick then
                        b:Activate() -- simula clique
                    end
                end
            end
        end)
    end
end)

-- ESP (exemplo simples)
spawn(function()
    while task.wait(2) do
        if _G.EmiteAFSSettings.ESP then
            pcall(function()
                for _, v in ipairs(Workspace:GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and not v.HumanoidRootPart:FindFirstChild("AFSEmiteBox") then
                        local box = Instance.new("SelectionBox")
                        box.Adornee = v.HumanoidRootPart
                        box.LineThickness = 0.05
                        box.Color3 = Color3.fromRGB(0, 255, 255)
                        box.Name = "AFSEmiteBox"
                        box.Parent = v.HumanoidRootPart
                    end
                end
            end)
        end
    end
end)

print("[EMITE HUB - AFS] Interface carregada com sucesso!")
print("[EMITE HUB - AFS] Seja bem-vindo, @" .. LocalPlayer.Name)
for k, v in pairs(_G.EmiteAFSSettings) do print("[EMITE HUB - AFS] " .. tostring(k) .. ": " .. tostring(v)) end

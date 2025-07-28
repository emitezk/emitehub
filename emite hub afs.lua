-- EMITE HUB v5.0 - Anime Fighters Simulator (PRISMATIC 2 UPDATE)
-- Desenvolvido por: PikaFlowz

-- SERVIÇOS
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- CONFIG
_G.EmiteAFS = {
    AutoFarm = true,
    AutoUltimate = true,
    AutoCollect = true,
    AutoQuest = true,
    AutoEquipBest = true,
    AutoTimeTrial = true,
    SafeMode = true,
    ESP = true
}

-- ANTI AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- GUI
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "EmiteHubAFS"
MainGui.ResetOnSpawn = false
MainGui.Parent = CoreGui

local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "EmiteOpenAFS"
OpenButton.Image = "rbxassetid://15725685720"
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 20, 0.5, -30)
OpenButton.BackgroundTransparency = 1
OpenButton.ZIndex = 10
OpenButton.Parent = CoreGui

OpenButton.MouseButton1Click:Connect(function()
    MainGui.Enabled = not MainGui.Enabled
end)

-- AUTO EQUIP BEST FIGHTERS
function EquipBest()
    local event = ReplicatedStorage.Events.EquipBest
    if event then event:FireServer() end
end

-- AUTO COLLECT
function AutoCollect()
    for _, drop in pairs(Workspace:GetDescendants()) do
        if drop.Name == "Drop" and drop:IsA("BasePart") and drop:FindFirstChild("TouchInterest") then
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, drop, 0)
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, drop, 1)
        end
    end
end

-- ESP BÁSICO
function ActivateESP()
    for _, enemy in pairs(Workspace:GetDescendants()) do
        if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and not enemy:FindFirstChild("ESP") then
            local esp = Instance.new("BoxHandleAdornment")
            esp.Name = "ESP"
            esp.Adornee = enemy.HumanoidRootPart
            esp.AlwaysOnTop = true
            esp.ZIndex = 10
            esp.Size = Vector3.new(3, 5, 3)
            esp.Color3 = Color3.new(1, 0, 0)
            esp.Transparency = 0.5
            esp.Parent = enemy
        end
    end
end

-- LOOP PRINCIPAL
spawn(function()
    while wait(0.5) do
        if _G.EmiteAFS.AutoEquipBest then EquipBest() end
        if _G.EmiteAFS.AutoCollect then AutoCollect() end
        if _G.EmiteAFS.ESP then ActivateESP() end
    end
end)

-- AUTO FARM
spawn(function()
    while wait(0.1) do
        if _G.EmiteAFS.AutoFarm then
            for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("HumanoidRootPart") then
                    local args = {
                        [1] = "Attack",
                        [2] = enemy
                    }
                    ReplicatedStorage.Remotes.Combat:FireServer(unpack(args))
                    if _G.EmiteAFS.AutoUltimate then
                        ReplicatedStorage.Remotes.Special:FireServer()
                    end
                end
            end
        end
    end
end)

print("[EMITE HUB - AFS] Seja bem-vindo, magnata @" .. LocalPlayer.Name)
print("[EMITE HUB - AFS] Script PRISMATIC 2 ativado com sucesso.")
print("[EMITE HUB - AFS] Desenvolvido por PikaFlowz")

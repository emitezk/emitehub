--[[
    EMITE HUB v5.0 - Blox Fruits Premium Script
    Desenvolvido por PikaFlowz
]]

-- SERVIÇOS
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- SAUDAÇÃO
print("[Emite Hub] Seja bem-vindo, magnata @" .. LocalPlayer.Name .. "!")

-- ANTI AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- GUI FLUTUANTE
local MainGui = Instance.new("ScreenGui", CoreGui)
MainGui.Name = "EmiteHubUI"
MainGui.ResetOnSpawn = false
MainGui.Enabled = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MainGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "EMITE HUB - V5.0"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 80, 80)

local Welcome = Instance.new("TextLabel", MainFrame)
Welcome.Position = UDim2.new(0, 0, 0, 40)
Welcome.Size = UDim2.new(1, 0, 0, 30)
Welcome.BackgroundTransparency = 1
Welcome.Text = "Seja bem-vindo, magnata @" .. LocalPlayer.Name
Welcome.Font = Enum.Font.Gotham
Welcome.TextScaled = true
Welcome.TextColor3 = Color3.fromRGB(180, 255, 180)

-- BOTÃO FLUTUANTE "E"
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

-- CONFIG GLOBAL
_G.EmiteSettings = {
    AutoFarm = true,
    AutoQuest = true,
    AutoBoss = true,
    AutoHaki = true,
    ESP = true,
    AutoLeaveAdmin = true,
    Fly = true
}

-- FUNÇÕES
local function ToggleESP(state)
    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        local root = v:FindFirstChild("HumanoidRootPart")
        if root then
            if state and not root:FindFirstChild("SelectionBox") then
                local box = Instance.new("SelectionBox", root)
                box.Adornee = root
                box.LineThickness = 0.05
                box.Color3 = Color3.fromRGB(255, 0, 0)
            elseif not state and root:FindFirstChild("SelectionBox") then
                root.SelectionBox:Destroy()
            end
        end
    end
end

local function AutoQuest()
    spawn(function()
        while wait(2) do
            if not _G.EmiteSettings.AutoQuest then break end
            pcall(function()
                for _, v in pairs(Workspace:GetChildren()) do
                    if v.Name:lower():find("quest") and v:IsA("Model") then
                        HumanoidRootPart.CFrame = v:FindFirstChildWhichIsA("Part").CFrame + Vector3.new(0, 3, 0)
                        wait(1)
                    end
                end
            end)
        end
    end)
end

local function AutoFarm()
    spawn(function()
        while wait(0.3) do
            if not _G.EmiteSettings.AutoFarm then break end
            pcall(function()
                for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        repeat
                            HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                            wait()
                        until enemy.Humanoid.Health <= 0 or not _G.EmiteSettings.AutoFarm
                    end
                end
            end)
        end
    end)
end

local function BossFarm()
    spawn(function()
        while wait(3) do
            if not _G.EmiteSettings.AutoBoss then break end
            pcall(function()
                for _, boss in pairs(Workspace.Enemies:GetChildren()) do
                    if boss.Name:find("Boss") and boss:FindFirstChild("Humanoid") then
                        repeat
                            HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                            wait()
                        until boss.Humanoid.Health <= 0 or not _G.EmiteSettings.AutoBoss
                    end
                end
            end)
        end
    end)
end

local function AutoHaki()
    spawn(function()
        while wait(5) do
            if not _G.EmiteSettings.AutoHaki then break end
            if not LocalPlayer.Character:FindFirstChild("Buso") then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end)
end

local function AutoLeaveIfAdmin()
    spawn(function()
        while wait(5) do
            if not _G.EmiteSettings.AutoLeaveAdmin then break end
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player:GetRankInGroup(1200769) >= 250 then
                    print("Admin detectado! Saindo do jogo...")
                    game:Shutdown()
                end
            end
        end
    end)
end

local function EnableFly()
    local BodyGyro = Instance.new("BodyGyro", HumanoidRootPart)
    local BodyVelocity = Instance.new("BodyVelocity", HumanoidRootPart)
    BodyGyro.P = 9e4
    BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.cframe = HumanoidRootPart.CFrame
    BodyVelocity.velocity = Vector3.new(0, 0, 0)
    BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

    RunService.RenderStepped:Connect(function()
        if _G.EmiteSettings.Fly then
            BodyGyro.CFrame = Workspace.CurrentCamera.CFrame
            BodyVelocity.velocity = Workspace.CurrentCamera.CFrame.LookVector * 50
        else
            BodyGyro:Destroy()
            BodyVelocity:Destroy()
        end
    end)
end

-- INICIALIZAÇÕES
if _G.EmiteSettings.ESP then ToggleESP(true) end
if _G.EmiteSettings.AutoQuest then AutoQuest() end
if _G.EmiteSettings.AutoFarm then AutoFarm() end
if _G.EmiteSettings.AutoBoss then BossFarm() end
if _G.EmiteSettings.AutoHaki then AutoHaki() end
if _G.EmiteSettings.AutoLeaveAdmin then AutoLeaveIfAdmin() end
if _G.EmiteSettings.Fly then EnableFly() end

print("[Emite Hub] Tudo carregado com sucesso. Assinado por PikaFlowz.")

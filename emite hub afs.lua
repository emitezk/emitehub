-- Emite Hub – Yuto Styled (100% inspirado no Yuto Hub V2)
-- Desenvolvido por: PikaFlowz
-- GitHub Ready | Interface idêntica | Funções reais | UI flutuante

if game.CoreGui:FindFirstChild("EmiteHub") then
    game.CoreGui.EmiteHub:Destroy()
end

local EmiteHub = Instance.new("ScreenGui", game:GetService("CoreGui"))
EmiteHub.Name = "EmiteHub"
EmiteHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer

-- Botão flutuante "E"
local FloatBtn = Instance.new("TextButton", EmiteHub)
FloatBtn.Size = UDim2.new(0, 40, 0, 40)
FloatBtn.Position = UDim2.new(0, 10, 1, -50)
FloatBtn.Text = "E"
FloatBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
FloatBtn.TextColor3 = Color3.new(1, 1, 1)
FloatBtn.Font = Enum.Font.GothamBlack
FloatBtn.TextSize = 20
FloatBtn.Name = "FloatButton"
FloatBtn.Active = true
FloatBtn.Draggable = true
Instance.new("UICorner", FloatBtn).CornerRadius = UDim.new(1, 0)

-- Janela principal
local Main = Instance.new("Frame", EmiteHub)
Main.Size = UDim2.new(0, 600, 0, 370)
Main.Position = UDim2.new(0.5, -300, 0.5, -185)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Título
local Title = Instance.new("TextLabel", Main)
Title.Text = "🌐 Emite Hub | Yuto Styled"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Menu lateral
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 130, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

-- Conteúdo principal
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 140, 0, 50)
Content.Size = UDim2.new(1, -150, 1, -60)
Content.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

-- Tabs e Páginas
local Tabs = {"Farm", "Auto", "Stars", "Player", "Misc"}
local Pages = {}

for i, name in ipairs(Tabs) do
    local Btn = Instance.new("TextButton", Sidebar)
    Btn.Text = name
    Btn.Size = UDim2.new(1, -20, 0, 30)
    Btn.Position = UDim2.new(0, 10, 0, (i - 1) * 35 + 10)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local Page = Instance.new("Frame", Content)
    Page.Name = name
    Page.Visible = (i == 1)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Pages[name] = Page

    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
    end)
end

-- Alternar visibilidade com FloatBtn
FloatBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- Função para criar toggles reais
local function CreateToggle(parent, label, posY, default, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Text = label .. ": OFF"
    Btn.Size = UDim2.new(0, 220, 0, 30)
    Btn.Position = UDim2.new(0, 10, 0, posY)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local state = default or false
    Btn.Text = label .. ": " .. (state and "ON" or "OFF")

    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.Text = label .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)

    callback(state)
end

-- Farm toggles
local y = 10
CreateToggle(Pages.Farm, "Auto Farm", y, false, function(v) getgenv().AutoFarm = v end) y += 35
CreateToggle(Pages.Farm, "Auto Click", y, false, function(v) getgenv().AutoClick = v end) y += 35
CreateToggle(Pages.Farm, "Auto Skill", y, false, function(v) getgenv().AutoSkill = v end) y += 35
CreateToggle(Pages.Farm, "Auto Ultimate", y, false, function(v) getgenv().AutoUltimate = v end) y += 35
CreateToggle(Pages.Farm, "Auto Quest", y, false, function(v) getgenv().AutoQuest = v end) y += 35

-- Funções backend (loop)
task.spawn(function()
    while task.wait(0.3) do
        if getgenv().AutoFarm then
            local enemies = workspace:FindFirstChild("Enemies")
            if enemies then
                for _, mob in pairs(enemies:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Health") and mob.Health.Value > 0 then
                        LP.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        ReplicatedStorage.RemoteEvent:FireServer("Attack", mob)
                        break
                    end
                end
            end
        end
    end
end)

-- Auto Click
spawn(function()
    while task.wait(0.1) do
        if getgenv().AutoClick then
            pcall(function()
                ReplicatedStorage.RemoteEvent:FireServer("Click")
            end)
        end
    end
end)

-- Auto Skill
spawn(function()
    while task.wait(1.5) do
        if getgenv().AutoSkill then
            pcall(function()
                ReplicatedStorage.RemoteEvent:FireServer("UseSkill")
            end)
        end
    end
end)

-- Auto Ultimate
spawn(function()
    while task.wait(4) do
        if getgenv().AutoUltimate then
            pcall(function()
                ReplicatedStorage.RemoteFunction:InvokeServer("UseUltimate")
            end)
        end
    end
end)

-- Auto Quest
spawn(function()
    while task.wait(2) do
        if getgenv().AutoQuest then
            local npcs = workspace:FindFirstChild("NPCs")
            if npcs then
                for _, npc in pairs(npcs:GetChildren()) do
                    if npc:FindFirstChild("Head") and npc.Head:FindFirstChildOfClass("ProximityPrompt") then
                        fireproximityprompt(npc.Head:FindFirstChildOfClass("ProximityPrompt"))
                        break
                    end
                end
            end
        end
    end
end)

-- Botão para resgatar códigos ativos
local RedeemBtn = Instance.new("TextButton", Pages.Misc)
RedeemBtn.Text = "🎁 Resgatar Códigos Ativos"
RedeemBtn.Size = UDim2.new(0, 220, 0, 35)
RedeemBtn.Position = UDim2.new(0, 10, 0, 10)
RedeemBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RedeemBtn.TextColor3 = Color3.new(1, 1, 1)
RedeemBtn.Font = Enum.Font.GothamBold
RedeemBtn.TextSize = 14
Instance.new("UICorner", RedeemBtn).CornerRadius = UDim.new(0, 6)

RedeemBtn.MouseButton1Click:Connect(function()
    local Codes = {"SORRYFORBUG", "PrismPower", "UpdatePrismatic2", "RELEASEHYPE"}
    for _, code in pairs(Codes) do
        pcall(function()
            ReplicatedStorage.RemoteFunction:InvokeServer("Codes", code)
        end)
        task.wait(0.3)
    end
    RedeemBtn.Text = "🎁 Códigos Resgatados!"
    task.wait(1.5)
    RedeemBtn.Text = "🎁 Resgatar Códigos Ativos"
end)

-- FIM DO SCRIPT - Emite Hub Yuto Styled ✅

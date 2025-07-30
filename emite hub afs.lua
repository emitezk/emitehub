-- Emite Hub – Yuto Styled
-- Criado por: PikaFlowz | Estilo 100% baseado no Yuto Hub V2

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
Title.Text = "🌀 Emite Hub | Yuto Styled"
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

-- Função para criar toggles
local function CreateToggle(parent, name, default, posY, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(0, 220, 0, 30)
    Btn.Position = UDim2.new(0, 10, 0, posY)
    Btn.Text = name .. ": " .. (default and "ON" or "OFF")
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local state = default
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.Text = name .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)
    callback(state)
end

-- Toggles em Farm
local y = 10
CreateToggle(Pages["Farm"], "Auto Farm", true, y, function(v)
    getgenv().AutoFarm = v
end)
y += 35
CreateToggle(Pages["Farm"], "Auto Quest", true, y, function(v)
    getgenv().AutoQuest = v
end)
y += 35
CreateToggle(Pages["Farm"], "Auto TP", true, y, function(v)
    getgenv().AutoTP = v
end)
y += 35
CreateToggle(Pages["Farm"], "Auto Click", true, y, function(v)
    getgenv().AutoClick = v
end)
y += 35
CreateToggle(Pages["Farm"], "Auto Skill", true, y, function(v)
    getgenv().AutoSkill = v
end)
y += 35
CreateToggle(Pages["Farm"], "Auto Ultimate", true, y, function(v)
    getgenv().AutoUltimate = v
end)

-- Execuções reais (loop)
task.spawn(function()
    while task.wait(0.3) do
        if AutoFarm then
            local enemies = workspace:FindFirstChild("Enemies")
            if enemies then
                for _, mob in pairs(enemies:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Health") and mob.Health.Value > 0 then
                        LP.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 4, 0)
                        ReplicatedStorage.RemoteEvent:FireServer("Attack", mob)
                        break
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if AutoClick then
            pcall(function()
                ReplicatedStorage.RemoteEvent:FireServer("Click")
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1.5) do
        if AutoSkill then
            pcall(function()
                ReplicatedStorage.RemoteEvent:FireServer("UseSkill")
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(4) do
        if AutoUltimate then
            pcall(function()
                ReplicatedStorage.RemoteFunction:InvokeServer("UseUltimate")
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if AutoQuest then
            local npcs = workspace:FindFirstChild("NPCs")
            if npcs then
                for _, npc in pairs(npcs:GetChildren()) do
                    if npc:FindFirstChild("Head") and npc.Head:FindFirstChildOfClass("ProximityPrompt") then
                        pcall(function()
                            fireproximityprompt(npc.Head:FindFirstChildOfClass("ProximityPrompt"))
                        end)
                        break
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if AutoTP then
            local enemies = workspace:FindFirstChild("Enemies")
            if enemies then
                for _, mob in pairs(enemies:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Health") and mob.Health.Value > 0 then
                        LP.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 4, 0)
                        break
                    end
                end
            end
        end
    end
end)

-- Botão resgatar códigos
local RedeemBtn = Instance.new("TextButton", Pages["Misc"])
RedeemBtn.Size = UDim2.new(0, 220, 0, 35)
RedeemBtn.Position = UDim2.new(0, 10, 0, 10)
RedeemBtn.Text = "🎁 Resgatar Códigos Ativos"
RedeemBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RedeemBtn.TextColor3 = Color3.new(1, 1, 1)
RedeemBtn.Font = Enum.Font.GothamBold
RedeemBtn.TextSize = 14
Instance.new("UICorner", RedeemBtn).CornerRadius = UDim.new(0, 6)

RedeemBtn.MouseButton1Click:Connect(function()
    local Codes = {"UpdatePrismatic2", "PrismPower", "SORRYFORBUG", "RELEASEHYPE", "CursedUpdate"}
    for _, code in pairs(Codes) do
        pcall(function()
            ReplicatedStorage.RemoteFunction:InvokeServer("Codes", code)
        end)
        task.wait(0.3)
    end
    RedeemBtn.Text = "🎁 Códigos resgatados!"
    task.wait(1.5)
    RedeemBtn.Text = "🎁 Resgatar Códigos Ativos"
end)

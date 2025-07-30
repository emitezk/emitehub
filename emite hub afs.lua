--// Emite Hub - Yuto Styled //--
-- Criado por: PikaFlowz

if game.CoreGui:FindFirstChild("EmiteHub") then
    game.CoreGui.EmiteHub:Destroy()
end

local EmiteHub = Instance.new("ScreenGui", game:GetService("CoreGui"))
EmiteHub.Name = "EmiteHub"
EmiteHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main GUI
local Main = Instance.new("Frame", EmiteHub)
Main.Size = UDim2.new(0, 550, 0, 360)
Main.Position = UDim2.new(0.5, -275, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Título
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🌀 Emite Hub | Yuto Styled"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 120, 1, -40)
Sidebar.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Tabs = {"Farm", "Auto", "Stars", "Player", "Misc"}
local Pages = {}

-- Conteúdo principal
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 130, 0, 50)
Content.Size = UDim2.new(1, -140, 1, -60)
Content.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

-- Criar páginas e botões
for i, name in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(1, -10, 0, 30)
    TabBtn.Position = UDim2.new(0, 5, 0, (i - 1) * 35 + 5)
    TabBtn.Text = name
    TabBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.TextSize = 14
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    local Page = Instance.new("Frame", Content)
    Page.Name = name
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = (i == 1)
    Pages[name] = Page

    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
    end)
end

-- [FARM PAGE]
Instance.new("TextLabel", Pages["Farm"]):SetAttributes({
    Text = "Auto Farm e Quest Ativados",
    Size = UDim2.new(0, 300, 0, 20),
    Position = UDim2.new(0, 10, 0, 10),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    Font = Enum.Font.Gotham
})

-- Funcionalidades padrão ativadas
local AutoFarm, AutoQuest, AutoUltimate = true, true, true
local AutoSkill, AutoClick = true, true
local AutoOpenStar, AutoEquipBest, AutoFuse = true, true, true
local EnemyESP, AutoTPToEnemy, FPSBoost = true, true, true

-- Funções Ativas
task.spawn(function()
    while task.wait(0.3) do
        if AutoFarm then
            local e = workspace:FindFirstChild("Enemies")
            for _, mob in pairs(e:GetChildren()) do
                if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Health") and mob.Health.Value > 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 4, 0)
                    game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Attack", mob)
                    break
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(3) do
        if AutoQuest then
            local npcFolder = workspace:FindFirstChild("NPCs")
            for _, npc in pairs(npcFolder:GetChildren()) do
                if npc:FindFirstChild("Head") then
                    fireproximityprompt(npc.Head:FindFirstChildOfClass("ProximityPrompt"))
                    break
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if AutoUltimate then
            pcall(function()
                game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("UseUltimate")
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1.5) do
        if AutoSkill then
            pcall(function()
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("UseSkill")
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if AutoClick then
            pcall(function()
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Click")
            end)
        end
    end
end)

local function getCurrentStar()
    local map = workspace:FindFirstChild("Map")
    if map and map:FindFirstChild("Stars") then
        for _, s in pairs(map.Stars:GetChildren()) do
            if s:IsA("Model") and s:FindFirstChildOfClass("ProximityPrompt") then
                return s.Name
            end
        end
    end
    return nil
end

task.spawn(function()
    while task.wait(2) do
        if AutoOpenStar then
            local star = getCurrentStar()
            if star then
                game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("OpenStar", star, false)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(10) do
        if AutoEquipBest then
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer("EquipBest")
        end
    end
end)

task.spawn(function()
    while task.wait(15) do
        if AutoFuse then
            local inv = game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("FighterInventory")
            if inv then
                local toFuse = {}
                for _, f in pairs(inv:GetChildren()) do
                    if f:IsA("TextLabel") and not string.find(f.Name, "Mythic") then
                        table.insert(toFuse, f.Name)
                    end
                end
                if #toFuse > 1 then
                    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("FuseFighters", toFuse)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if EnemyESP then
            local e = workspace:FindFirstChild("Enemies")
            for _, mob in pairs(e:GetChildren()) do
                if mob:IsA("Model") and not mob:FindFirstChild("YutoESP") and mob:FindFirstChild("HumanoidRootPart") then
                    local esp = Instance.new("BoxHandleAdornment", mob)
                    esp.Name = "YutoESP"
                    esp.Size = Vector3.new(4, 5, 4)
                    esp.Adornee = mob.HumanoidRootPart
                    esp.AlwaysOnTop = true
                    esp.ZIndex = 5
                    esp.Transparency = 0.5
                    esp.Color3 = Color3.fromRGB(255, 0, 0)
                end
            end
        end
    end
end)

if FPSBoost then
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Texture") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Decal") then
            v:Destroy()
        end
    end
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    pcall(function() setfpscap(60) end)
end

-- [MISC PAGE] - Resgatar Códigos
local Codes = {
    "SORRYFORSHUTDOWN", "AURAUPDATE", "PRISMATIC2", "CLOUDPASSIVE",
    "HYPERAURA", "SUMMER2025", "JULYHYPE", "WORLDCODE", "FREEBOOSTS"
}

local function RedeemAllCodes()
    for _, code in pairs(Codes) do
        pcall(function()
            local result = game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("RedeemCode", code)
            print("Código:", code, "->", result and "Resgatado!" or "Inválido ou usado")
        end)
        wait(0.3)
    end
end

local btnRedeem = Instance.new("TextButton", Pages["Misc"])
btnRedeem.Size = UDim2.new(0, 200, 0, 30)
btnRedeem.Position = UDim2.new(0, 10, 0, 10)
btnRedeem.Text = "🎁 Resgatar Códigos Ativos"
btnRedeem.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
btnRedeem.TextColor3 = Color3.fromRGB(255, 255, 255)
btnRedeem.Font = Enum.Font.Gotham
btnRedeem.TextSize = 14
Instance.new("UICorner", btnRedeem).CornerRadius = UDim.new(0, 6)

btnRedeem.MouseButton1Click:Connect(function()
    btnRedeem.Text = "Resgatando..."
    RedeemAllCodes()
    btnRedeem.Text = "🎁 Resgatar Códigos Ativos"
end)

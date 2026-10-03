local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local CurrentPlaceId = tostring(game.PlaceId)

local ServerScripts = {
    ["124216119978534"] = {
        Name = "Ride A Pet",
        URL = "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/Scrip-MAP/Ride%20A%20Pet/obf25.lua"
    },

    ["99906598674199"] = {
        Name = "The Locust in MM2 [ORIGINAL]",
        URL = "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/Scrip-MAP/The%20Locust%20in%20the%20MM2/obf25.lua"
    },

    ["142823291"] = {
        Name = "mm2",
        URL = "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/Scrip-MAP/Mysterious%20Murder%202/obf25.txt"
    },

    ["100068273119174"] = {
        Name = "Clean all the Leaves",
        URL = "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/Scrip-MAP/Clean%20all%20the%20Leaves/1.1.lua"
    }
}

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local OldGui = PlayerGui:FindFirstChild("RUNLUA_HUB_LOADER")
if OldGui then
    OldGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RUNLUA_HUB_LOADER"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = PlayerGui

local Background = Instance.new("Frame")
Background.Size = UDim2.fromScale(1, 1)
Background.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

local BackgroundGradient = Instance.new("UIGradient")
BackgroundGradient.Rotation = 45
BackgroundGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(7, 7, 11)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 13, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 6, 9))
})
BackgroundGradient.Parent = Background

local Icon = Instance.new("ImageLabel")
Icon.Size = UDim2.fromOffset(90, 90)
Icon.AnchorPoint = Vector2.new(0.5, 0.5)
Icon.Position = UDim2.fromScale(0.5, 0.36)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://6031071053"
Icon.Parent = Background

local IconScale = Instance.new("UIScale")
IconScale.Scale = 1
IconScale.Parent = Icon

local Title = Instance.new("TextLabel")
Title.Size = UDim2.fromScale(0.8, 0.08)
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.Position = UDim2.fromScale(0.5, 0.49)
Title.BackgroundTransparency = 1
Title.Text = "RUNLUA HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Background

local Status = Instance.new("TextLabel")
Status.Size = UDim2.fromScale(0.85, 0.065)
Status.AnchorPoint = Vector2.new(0.5, 0.5)
Status.Position = UDim2.fromScale(0.5, 0.56)
Status.BackgroundTransparency = 1
Status.Text = "กำลังโหลดสคริปต์ RUNLUA HUB"
Status.TextColor3 = Color3.fromRGB(190, 190, 200)
Status.TextScaled = true
Status.Font = Enum.Font.Gotham
Status.Parent = Background

local GameName = Instance.new("TextLabel")
GameName.Size = UDim2.fromScale(0.85, 0.055)
GameName.AnchorPoint = Vector2.new(0.5, 0.5)
GameName.Position = UDim2.fromScale(0.5, 0.62)
GameName.BackgroundTransparency = 1
GameName.Text = "กำลังตรวจสอบแมพ"
GameName.TextColor3 = Color3.fromRGB(125, 125, 140)
GameName.TextScaled = true
GameName.Font = Enum.Font.Gotham
GameName.Parent = Background

local LoadingBarBack = Instance.new("Frame")
LoadingBarBack.Size = UDim2.fromScale(0.38, 0.012)
LoadingBarBack.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingBarBack.Position = UDim2.fromScale(0.5, 0.69)
LoadingBarBack.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
LoadingBarBack.BorderSizePixel = 0
LoadingBarBack.Parent = Background

local LoadingBarBackCorner = Instance.new("UICorner")
LoadingBarBackCorner.CornerRadius = UDim.new(1, 0)
LoadingBarBackCorner.Parent = LoadingBarBack

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.fromScale(0.15, 1)
LoadingBar.BackgroundColor3 = Color3.fromRGB(160, 90, 255)
LoadingBar.BorderSizePixel = 0
LoadingBar.Parent = LoadingBarBack

local LoadingBarCorner = Instance.new("UICorner")
LoadingBarCorner.CornerRadius = UDim.new(1, 0)
LoadingBarCorner.Parent = LoadingBar

local RemoveButton = Instance.new("TextButton")
RemoveButton.Size = UDim2.fromOffset(180, 44)
RemoveButton.AnchorPoint = Vector2.new(0.5, 0.5)
RemoveButton.Position = UDim2.fromScale(0.5, 0.8)
RemoveButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
RemoveButton.Text = "ลบ UI"
RemoveButton.TextColor3 = Color3.fromRGB(235, 235, 240)
RemoveButton.TextSize = 14
RemoveButton.Font = Enum.Font.GothamMedium
RemoveButton.BorderSizePixel = 0
RemoveButton.Visible = false
RemoveButton.Parent = Background

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 10)
ButtonCorner.Parent = RemoveButton

local Alive = true

local function DestroyUI()
    if not Alive or not ScreenGui.Parent then
        return
    end

    Alive = false

    for _, Object in ipairs(Background:GetDescendants()) do
        if Object:IsA("TextLabel") or Object:IsA("TextButton") then
            TweenService:Create(
                Object,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {TextTransparency = 1}
            ):Play()
        elseif Object:IsA("ImageLabel") then
            TweenService:Create(
                Object,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {ImageTransparency = 1}
            ):Play()
        elseif Object:IsA("Frame") then
            TweenService:Create(
                Object,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 1}
            ):Play()
        end
    end

    task.wait(0.35)

    if ScreenGui then
        ScreenGui:Destroy()
    end
end

RemoveButton.Activated:Connect(DestroyUI)

task.spawn(function()
    while Alive and ScreenGui.Parent do
        TweenService:Create(
            IconScale,
            TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Scale = 1.12}
        ):Play()

        TweenService:Create(
            Icon,
            TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {ImageTransparency = 0.15}
        ):Play()

        task.wait(0.8)

        TweenService:Create(
            IconScale,
            TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Scale = 1}
        ):Play()

        TweenService:Create(
            Icon,
            TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {ImageTransparency = 0}
        ):Play()

        task.wait(0.8)
    end
end)

task.spawn(function()
    while Alive and ScreenGui.Parent do
        TweenService:Create(
            LoadingBar,
            TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Size = UDim2.fromScale(0.95, 1)}
        ):Play()

        task.wait(0.9)

        TweenService:Create(
            LoadingBar,
            TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Size = UDim2.fromScale(0.15, 1)}
        ):Play()

        task.wait(0.9)
    end
end)

local function SetStatus(Text, Name)
    Status.Text = Text
    GameName.Text = Name or ""
end

local function LoadServerScript(Data)
    SetStatus("ตรวจพบแมพที่รองรับ", Data.Name)

    task.wait(0.4)

    SetStatus("กำลังโหลดสคริปต์", Data.Name)

    local Source

    local DownloadSuccess = pcall(function()
        Source = game:HttpGet(Data.URL)
    end)

    if not DownloadSuccess or not Source or Source == "" then
        SetStatus("โหลดสคริปต์ไม่สำเร็จ", Data.Name)
        RemoveButton.Visible = true
        return
    end

    local Function
    local CompileSuccess = pcall(function()
        Function = loadstring(Source)
    end)

    if not CompileSuccess or not Function then
        SetStatus("โหลดสคริปต์ไม่สำเร็จ", Data.Name)
        RemoveButton.Visible = true
        return
    end

    SetStatus("โหลดสคริปต์สำเร็จ", Data.Name)

    task.wait(0.3)

    task.spawn(function()
        pcall(Function)
    end)

    task.wait(0.25)

    DestroyUI()
end

task.spawn(function()
    task.wait(0.3)

    local ScriptData = ServerScripts[CurrentPlaceId]

    if not ScriptData then
        SetStatus("ไม่พบแมพที่รองรับ", "แมพนี้ยังไม่มีสคริปต์ใน RUNLUA HUB")
        RemoveButton.Visible = true
        return
    end

    SetStatus("ตรวจพบแมพที่รองรับ", ScriptData.Name)

    task.wait(0.4)

    LoadServerScript(ScriptData)
end)

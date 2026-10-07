-- เห็นซอสนี้ อย่าได้ใจไอ้ควาย มึงดูโค้ดก่อน มันไม่ใช่โค้ดแฮกเกม อย่าทำตัวตลกไอ้ควยย

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local CurrentPlaceId = tostring(game.PlaceId)

local games = {
    ["142823291"] = {
        Name = "Mysterious Murder 2",
        ShortName = "MM2",
        URL = "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/Scrip-MAP/Mysterious%20Murder%202/obf25.txt"
    },
    ["118805555015549"] = {
        Name = "[BOSS]+1 Loot To Forge",
        ShortName = "[BOSS]+1 Loot To Forge",
        URL = "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/Scrip-MAP/%5BBOSS%5D%2B1%20Loot%20To%20Forge/runlua.lua"
    },
    ["100068273119174"] = {
        Name = "Clean all the Leaves",
        ShortName = "Clean all the Leaves",
        URL = "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/Scrip-MAP/Clean%20all%20the%20Leaves/1.1.lua"
    }
}

local LOGO = "https://i.postimg.cc/gkxSFWdK/image.png"

local OldGui = PlayerGui:FindFirstChild("RUNLUA_HUB_LOADER")

if OldGui then
    OldGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RUNLUA_HUB_LOADER"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Size = UDim2.fromScale(1, 1)
Background.BackgroundColor3 = Color3.fromRGB(4, 4, 7)
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

local BackgroundGradient = Instance.new("UIGradient")
BackgroundGradient.Rotation = 135
BackgroundGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 5, 8)),
    ColorSequenceKeypoint.new(0.45, Color3.fromRGB(18, 12, 27)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(3, 3, 6))
})
BackgroundGradient.Parent = Background

local Glow = Instance.new("Frame")
Glow.Name = "Glow"
Glow.Size = UDim2.fromOffset(550, 550)
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.Position = UDim2.fromScale(0.5, 0.38)
Glow.BackgroundColor3 = Color3.fromRGB(115, 65, 190)
Glow.BackgroundTransparency = 0.94
Glow.BorderSizePixel = 0
Glow.Parent = Background

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(1, 0)
GlowCorner.Parent = Glow

local Card = Instance.new("Frame")
Card.Name = "MainCard"
Card.Size = UDim2.fromOffset(460, 430)
Card.AnchorPoint = Vector2.new(0.5, 0.5)
Card.Position = UDim2.fromScale(0.5, 0.52)
Card.BackgroundColor3 = Color3.fromRGB(12, 12, 17)
Card.BackgroundTransparency = 0.08
Card.BorderSizePixel = 0
Card.Parent = Background

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 24)
CardCorner.Parent = Card

local CardStroke = Instance.new("UIStroke")
CardStroke.Color = Color3.fromRGB(255, 255, 255)
CardStroke.Transparency = 0.9
CardStroke.Thickness = 1
CardStroke.Parent = Card

local TopLine = Instance.new("Frame")
TopLine.Size = UDim2.new(1, -50, 0, 1)
TopLine.Position = UDim2.fromOffset(25, 1)
TopLine.BackgroundColor3 = Color3.fromRGB(170, 100, 255)
TopLine.BackgroundTransparency = 0.45
TopLine.BorderSizePixel = 0
TopLine.Parent = Card

local LogoHolder = Instance.new("Frame")
LogoHolder.Size = UDim2.fromOffset(108, 108)
LogoHolder.AnchorPoint = Vector2.new(0.5, 0)
LogoHolder.Position = UDim2.fromScale(0.5, 0.075)
LogoHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
LogoHolder.BorderSizePixel = 0
LogoHolder.Parent = Card

local LogoHolderCorner = Instance.new("UICorner")
LogoHolderCorner.CornerRadius = UDim.new(0, 28)
LogoHolderCorner.Parent = LogoHolder

local LogoHolderStroke = Instance.new("UIStroke")
LogoHolderStroke.Color = Color3.fromRGB(160, 95, 255)
LogoHolderStroke.Transparency = 0.72
LogoHolderStroke.Thickness = 1
LogoHolderStroke.Parent = LogoHolder

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.fromScale(0.72, 0.72)
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.Position = UDim2.fromScale(0.5, 0.5)
Logo.BackgroundTransparency = 1
Logo.Image = LOGO
Logo.ScaleType = Enum.ScaleType.Fit
Logo.Parent = LogoHolder

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 20)
LogoCorner.Parent = Logo

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 34)
Title.AnchorPoint = Vector2.new(0.5, 0)
Title.Position = UDim2.fromScale(0.5, 0.36)
Title.BackgroundTransparency = 1
Title.Text = "RUNLUA HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 27
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = Card

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -40, 0, 22)
Subtitle.AnchorPoint = Vector2.new(0.5, 0)
Subtitle.Position = UDim2.fromScale(0.5, 0.45)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "ROBLOX SCRIPT HUB"
Subtitle.TextColor3 = Color3.fromRGB(125, 125, 140)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextXAlignment = Enum.TextXAlignment.Center
Subtitle.Parent = Card

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -50, 0, 27)
Status.AnchorPoint = Vector2.new(0.5, 0)
Status.Position = UDim2.fromScale(0.5, 0.535)
Status.BackgroundTransparency = 1
Status.Text = "กำลังเริ่มต้นระบบ..."
Status.TextColor3 = Color3.fromRGB(225, 225, 230)
Status.TextSize = 14
Status.Font = Enum.Font.GothamMedium
Status.TextXAlignment = Enum.TextXAlignment.Center
Status.Parent = Card

local GameName = Instance.new("TextLabel")
GameName.Size = UDim2.new(1, -50, 0, 22)
GameName.AnchorPoint = Vector2.new(0.5, 0)
GameName.Position = UDim2.fromScale(0.5, 0.605)
GameName.BackgroundTransparency = 1
GameName.Text = "กำลังตรวจสอบแมพ..."
GameName.TextColor3 = Color3.fromRGB(105, 105, 120)
GameName.TextSize = 11
GameName.Font = Enum.Font.Gotham
GameName.TextXAlignment = Enum.TextXAlignment.Center
GameName.Parent = Card

local ProgressBackground = Instance.new("Frame")
ProgressBackground.Size = UDim2.new(1, -100, 0, 6)
ProgressBackground.AnchorPoint = Vector2.new(0.5, 0)
ProgressBackground.Position = UDim2.fromScale(0.5, 0.695)
ProgressBackground.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
ProgressBackground.BorderSizePixel = 0
ProgressBackground.Parent = Card

local ProgressBackgroundCorner = Instance.new("UICorner")
ProgressBackgroundCorner.CornerRadius = UDim.new(1, 0)
ProgressBackgroundCorner.Parent = ProgressBackground

local Progress = Instance.new("Frame")
Progress.Size = UDim2.fromScale(0, 1)
Progress.BackgroundColor3 = Color3.fromRGB(160, 90, 255)
Progress.BorderSizePixel = 0
Progress.Parent = ProgressBackground

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(1, 0)
ProgressCorner.Parent = Progress

local ProgressGradient = Instance.new("UIGradient")
ProgressGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 70, 220)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(190, 110, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 80, 240))
})
ProgressGradient.Parent = Progress

local Percent = Instance.new("TextLabel")
Percent.Size = UDim2.new(1, -50, 0, 20)
Percent.AnchorPoint = Vector2.new(0.5, 0)
Percent.Position = UDim2.fromScale(0.5, 0.73)
Percent.BackgroundTransparency = 1
Percent.Text = "0%"
Percent.TextColor3 = Color3.fromRGB(115, 115, 130)
Percent.TextSize = 10
Percent.Font = Enum.Font.GothamMedium
Percent.TextXAlignment = Enum.TextXAlignment.Center
Percent.Parent = Card

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.fromOffset(7, 7)
StatusDot.AnchorPoint = Vector2.new(0.5, 0.5)
StatusDot.Position = UDim2.new(0.5, -95, 0.548, 0)
StatusDot.BackgroundColor3 = Color3.fromRGB(160, 90, 255)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = Card

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = StatusDot

local RemoveButton = Instance.new("TextButton")
RemoveButton.Size = UDim2.fromOffset(160, 38)
RemoveButton.AnchorPoint = Vector2.new(0.5, 0)
RemoveButton.Position = UDim2.fromScale(0.5, 0.81)
RemoveButton.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
RemoveButton.BorderSizePixel = 0
RemoveButton.Text = "ปิดหน้าต่าง"
RemoveButton.TextColor3 = Color3.fromRGB(220, 220, 225)
RemoveButton.TextSize = 12
RemoveButton.Font = Enum.Font.GothamMedium
RemoveButton.Visible = false
RemoveButton.Parent = Card

local RemoveCorner = Instance.new("UICorner")
RemoveCorner.CornerRadius = UDim.new(0, 10)
RemoveCorner.Parent = RemoveButton

local RemoveStroke = Instance.new("UIStroke")
RemoveStroke.Color = Color3.fromRGB(255, 255, 255)
RemoveStroke.Transparency = 0.9
RemoveStroke.Parent = RemoveButton

local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, -40, 0, 18)
Footer.AnchorPoint = Vector2.new(0.5, 1)
Footer.Position = UDim2.fromScale(0.5, 0.965)
Footer.BackgroundTransparency = 1
Footer.Text = "RUNLUA HUB • Secure Script Loader"
Footer.TextColor3 = Color3.fromRGB(65, 65, 75)
Footer.TextSize = 9
Footer.Font = Enum.Font.Gotham
Footer.TextXAlignment = Enum.TextXAlignment.Center
Footer.Parent = Card

local Alive = true

local function Tween(Object, Time, Properties, Style, Direction)
    local TweenInfoObject = TweenInfo.new(
        Time,
        Style or Enum.EasingStyle.Quad,
        Direction or Enum.EasingDirection.Out
    )

    local TweenObject = TweenService:Create(
        Object,
        TweenInfoObject,
        Properties
    )

    TweenObject:Play()

    return TweenObject
end

local function SetProgress(Value)
    Value = math.clamp(Value, 0, 100)

    Tween(
        Progress,
        0.35,
        {
            Size = UDim2.fromScale(Value / 100, 1)
        },
        Enum.EasingStyle.Quart
    )

    Percent.Text = tostring(math.floor(Value)) .. "%"
end

local function SetStatus(Text, Name, ProgressValue)
    if not Alive then
        return
    end

    Status.Text = Text
    GameName.Text = Name or ""

    if ProgressValue then
        SetProgress(ProgressValue)
    end
end

local function DestroyUI()
    if not Alive then
        return
    end

    Alive = false

    local FadeTime = 0.35

    for _, Object in ipairs(ScreenGui:GetDescendants()) do
        if Object:IsA("TextLabel") or Object:IsA("TextButton") then
            Tween(Object, FadeTime, {
                TextTransparency = 1
            })
        elseif Object:IsA("ImageLabel") then
            Tween(Object, FadeTime, {
                ImageTransparency = 1
            })
        elseif Object:IsA("Frame") then
            Tween(Object, FadeTime, {
                BackgroundTransparency = 1
            })
        elseif Object:IsA("UIStroke") then
            Tween(Object, FadeTime, {
                Transparency = 1
            })
        end
    end

    task.wait(FadeTime + 0.05)

    if ScreenGui then
        ScreenGui:Destroy()
    end
end

RemoveButton.Activated:Connect(DestroyUI)

task.spawn(function()
    while Alive and ScreenGui.Parent do
        Tween(
            LogoHolder,
            1.1,
            {
                Rotation = 2
            },
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )

        Tween(
            Logo,
            1.1,
            {
                ImageTransparency = 0.08
            },
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )

        task.wait(1.1)

        if not Alive then
            break
        end

        Tween(
            LogoHolder,
            1.1,
            {
                Rotation = -2
            },
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )

        Tween(
            Logo,
            1.1,
            {
                ImageTransparency = 0
            },
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )

        task.wait(1.1)
    end
end)

task.spawn(function()
    while Alive and ScreenGui.Parent do
        Tween(
            Glow,
            2.5,
            {
                BackgroundTransparency = 0.965,
                Size = UDim2.fromOffset(620, 620)
            },
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )

        task.wait(2.5)

        if not Alive then
            break
        end

        Tween(
            Glow,
            2.5,
            {
                BackgroundTransparency = 0.94,
                Size = UDim2.fromOffset(550, 550)
            },
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )

        task.wait(2.5)
    end
end)

task.spawn(function()
    while Alive and ScreenGui.Parent do
        Tween(
            StatusDot,
            0.8,
            {
                BackgroundTransparency = 0.65,
                Size = UDim2.fromOffset(10, 10)
            },
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )

        task.wait(0.8)

        if not Alive then
            break
        end

        Tween(
            StatusDot,
            0.8,
            {
                BackgroundTransparency = 0,
                Size = UDim2.fromOffset(7, 7)
            },
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )

        task.wait(0.8)
    end
end)

RemoveButton.MouseEnter:Connect(function()
    if not Alive then
        return
    end

    Tween(
        RemoveButton,
        0.2,
        {
            BackgroundColor3 = Color3.fromRGB(38, 38, 50)
        }
    )
end)

RemoveButton.MouseLeave:Connect(function()
    if not Alive then
        return
    end

    Tween(
        RemoveButton,
        0.2,
        {
            BackgroundColor3 = Color3.fromRGB(25, 25, 33)
        }
    )
end)

local function LoadServerScript(Data)
    if not Data then
        return false
    end

    SetStatus(
        "ตรวจพบแมพที่รองรับ",
        Data.Name,
        25
    )

    task.wait(0.45)

    if not Alive then
        return false
    end

    SetStatus(
        "กำลังเชื่อมต่อ Script",
        Data.Name,
        40
    )

    task.wait(0.25)

    if not Alive then
        return false
    end

    local Source

    local DownloadSuccess, DownloadError = pcall(function()
        Source = game:HttpGet(Data.URL)
    end)

    if not DownloadSuccess then
        warn("[RUNLUA HUB] HttpGet Error:", DownloadError)

        SetStatus(
            "ไม่สามารถดาวน์โหลด Script",
            Data.Name,
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
        RemoveButton.Visible = true

        return false
    end

    if not Source or Source == "" then
        SetStatus(
            "Script ที่ดาวน์โหลดว่างเปล่า",
            Data.Name,
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
        RemoveButton.Visible = true

        return false
    end

    SetStatus(
        "ดาวน์โหลด Script สำเร็จ",
        Data.Name,
        65
    )

    task.wait(0.35)

    if not Alive then
        return false
    end

    SetStatus(
        "กำลังตรวจสอบ Script",
        Data.Name,
        78
    )

    local Function
    local CompileSuccess, CompileError = pcall(function()
        Function = loadstring(Source)
    end)

    if not CompileSuccess then
        warn("[RUNLUA HUB] Compile Error:", CompileError)

        SetStatus(
            "Script มีข้อผิดพลาด",
            Data.Name,
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
        RemoveButton.Visible = true

        return false
    end

    if not Function then
        SetStatus(
            "ไม่สามารถสร้าง Script Function",
            Data.Name,
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
        RemoveButton.Visible = true

        return false
    end

    SetStatus(
        "กำลังเริ่มต้น Script",
        Data.Name,
        90
    )

    task.wait(0.35)

    if not Alive then
        return false
    end

    local RunSuccess, RunError = pcall(function()
        task.spawn(Function)
    end)

    if not RunSuccess then
        warn("[RUNLUA HUB] Runtime Error:", RunError)

        SetStatus(
            "Script ทำงานผิดพลาด",
            Data.Name,
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
        RemoveButton.Visible = true

        return false
    end

    SetStatus(
        "Script เริ่มทำงานแล้ว",
        Data.Name,
        100
    )

    StatusDot.BackgroundColor3 = Color3.fromRGB(85, 255, 145)

    task.wait(0.65)

    DestroyUI()

    return true
end

task.spawn(function()
    task.wait(0.35)

    if not Alive then
        return
    end

    SetStatus(
        "กำลังตรวจสอบเกม",
        "Place ID: " .. CurrentPlaceId,
        10
    )

    task.wait(0.45)

    if not Alive then
        return
    end

    local ScriptData = games[CurrentPlaceId]

    if not ScriptData then
        SetStatus(
            "ไม่พบแมพที่รองรับ",
            "แมพนี้ยังไม่มี Script ใน RUNLUA HUB",
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 180, 70)
        RemoveButton.Visible = true

        return
    end

    LoadServerScript(ScriptData)
end)

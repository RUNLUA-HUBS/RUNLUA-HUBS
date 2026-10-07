-- เห็นซอสนี้ อย่าได้ใจไอ้ควาย มึงดูโค้ดก่อน มันไม่ใช่โค้ดแฮกเกม อย่าทำตัวตลกไอ้ควยย


local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local CurrentPlaceId = tostring(game.PlaceId)

local games = {
    ["142823291"] = {
        Name = "ฆาตกรรมปริศนา 2",
        ShortName = "คดีปริศนา",
        URL = "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/Scrip-MAP/Mysterious%20Murder%202/obf25.txt"
    },
    ["118805555015549"] = {
        Name = "ล่าบอส รับของไปหลอม",
        ShortName = "ล่าบอส รับของไปหลอม",
        URL = "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/Scrip-MAP/%5BBOSS%5D%2B1%20Loot%20To%20Forge/runlua.lua"
    },
    ["100068273119174"] = {
        Name = "เก็บใบไม้ทั้งหมด",
        ShortName = "เก็บใบไม้ทั้งหมด",
        URL = "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/Scrip-MAP/Clean%20all%20the%20Leaves/1.1.lua"
    }
}

-- ไอคอนปีศาจจากคลังสื่อ Roblox, หมายเลขภาพ 209885288

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
Background.BackgroundColor3 = Color3.fromRGB(8, 5, 12)
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

local BackgroundGradient = Instance.new("UIGradient")
BackgroundGradient.Rotation = 135
BackgroundGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 5, 12)),
    ColorSequenceKeypoint.new(0.45, Color3.fromRGB(34, 11, 26)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 4, 9))
})
BackgroundGradient.Parent = Background

local Glow = Instance.new("Frame")
Glow.Name = "Glow"
Glow.Size = UDim2.fromOffset(550, 550)
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.Position = UDim2.fromScale(0.5, 0.38)
Glow.BackgroundColor3 = Color3.fromRGB(202, 42, 87)
Glow.BackgroundTransparency = 0.94
Glow.BorderSizePixel = 0
Glow.Parent = Background

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(1, 0)
GlowCorner.Parent = Glow

local ParticleLayer = Instance.new("Folder")
ParticleLayer.Name = "FloatingLights"
ParticleLayer.Parent = Background

local Particles = {}

for Index = 1, 16 do
    local Particle = Instance.new("Frame")
    local ParticleSize = math.random(3, 7)

    Particle.Name = "GlowParticle"
    Particle.Size = UDim2.fromOffset(ParticleSize, ParticleSize)
    Particle.Position = UDim2.fromScale(math.random(), math.random())
    Particle.BackgroundColor3 = Index % 3 == 0
        and Color3.fromRGB(255, 114, 136)
        or Color3.fromRGB(195, 75, 112)
    Particle.BackgroundTransparency = 0.68
    Particle.BorderSizePixel = 0
    Particle.Parent = ParticleLayer

    local ParticleCorner = Instance.new("UICorner")
    ParticleCorner.CornerRadius = UDim.new(1, 0)
    ParticleCorner.Parent = Particle

    Particles[#Particles + 1] = Particle
end

local Card = Instance.new("Frame")
Card.Name = "MainCard"
Card.Size = UDim2.fromOffset(500, 470)
Card.AnchorPoint = Vector2.new(0.5, 0.5)
Card.Position = UDim2.fromScale(0.5, 0.52)
Card.BackgroundColor3 = Color3.fromRGB(16, 12, 21)
Card.BackgroundTransparency = 0.04
Card.BorderSizePixel = 0
Card.Parent = Background

local CardScale = Instance.new("UIScale")
CardScale.Scale = 1
CardScale.Parent = Card

local function UpdateCardScale()
    local Camera = workspace.CurrentCamera
    if not Camera then
        return
    end

    local Viewport = Camera.ViewportSize
    CardScale.Scale = math.clamp(
        math.min((Viewport.X - 24) / 500, (Viewport.Y - 48) / 470),
        0.56,
        1
    )
end

UpdateCardScale()

if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateCardScale)
end

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 28)
CardCorner.Parent = Card

local CardGradient = Instance.new("UIGradient")
CardGradient.Rotation = 130
CardGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 17, 31)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(17, 13, 23)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(27, 10, 20))
})
CardGradient.Parent = Card

local CardStroke = Instance.new("UIStroke")
CardStroke.Color = Color3.fromRGB(255, 93, 126)
CardStroke.Transparency = 0.58
CardStroke.Thickness = 1.4
CardStroke.Parent = Card

local TopLine = Instance.new("Frame")
TopLine.Size = UDim2.new(1, -50, 0, 1)
TopLine.Position = UDim2.fromOffset(25, 1)
TopLine.BackgroundColor3 = Color3.fromRGB(255, 91, 119)
TopLine.BackgroundTransparency = 0.45
TopLine.BorderSizePixel = 0
TopLine.Parent = Card

local Aura = Instance.new("Frame")
Aura.Name = "DemonAura"
Aura.Size = UDim2.fromOffset(136, 136)
Aura.AnchorPoint = Vector2.new(0.5, 0)
Aura.Position = UDim2.fromScale(0.5, 0.043)
Aura.BackgroundTransparency = 1
Aura.BorderSizePixel = 0
Aura.Parent = Card

local AuraCorner = Instance.new("UICorner")
AuraCorner.CornerRadius = UDim.new(1, 0)
AuraCorner.Parent = Aura

local AuraStroke = Instance.new("UIStroke")
AuraStroke.Color = Color3.fromRGB(255, 77, 112)
AuraStroke.Transparency = 0.37
AuraStroke.Thickness = 1.5
AuraStroke.Parent = Aura
local DemonHolder = Instance.new("Frame")
DemonHolder.Size = UDim2.fromOffset(116, 116)
DemonHolder.AnchorPoint = Vector2.new(0.5, 0)
DemonHolder.Position = UDim2.fromScale(0.5, 0.065)
DemonHolder.BackgroundColor3 = Color3.fromRGB(31, 15, 26)
DemonHolder.BorderSizePixel = 0
DemonHolder.Parent = Card

local DemonHolderCorner = Instance.new("UICorner")
DemonHolderCorner.CornerRadius = UDim.new(0, 31)
DemonHolderCorner.Parent = DemonHolder

local DemonHolderStroke = Instance.new("UIStroke")
DemonHolderStroke.Color = Color3.fromRGB(255, 94, 126)
DemonHolderStroke.Transparency = 0.42
DemonHolderStroke.Thickness = 1.5
DemonHolderStroke.Parent = DemonHolder

local DemonIcon = Instance.new("ImageLabel")
DemonIcon.Name = "DemonIcon"
DemonIcon.Size = UDim2.fromScale(0.82, 0.82)
DemonIcon.AnchorPoint = Vector2.new(0.5, 0.5)
DemonIcon.Position = UDim2.fromScale(0.5, 0.5)
DemonIcon.BackgroundTransparency = 1
DemonIcon.Image = DEMON_ICON
DemonIcon.ScaleType = Enum.ScaleType.Fit
DemonIcon.Parent = DemonHolder

local DemonIconCorner = Instance.new("UICorner")
DemonIconCorner.CornerRadius = UDim.new(0, 20)
DemonIconCorner.Parent = DemonIcon

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 34)
Title.AnchorPoint = Vector2.new(0.5, 0)
Title.Position = UDim2.fromScale(0.5, 0.355)
Title.BackgroundTransparency = 1
Title.Text = "รูนลัว ฮับ"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 30
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = Card

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -40, 0, 22)
Subtitle.AnchorPoint = Vector2.new(0.5, 0)
Subtitle.Position = UDim2.fromScale(0.5, 0.435)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "ศูนย์รวมสคริปต์สำหรับแมพที่รองรับ"
Subtitle.TextColor3 = Color3.fromRGB(182, 164, 178)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextXAlignment = Enum.TextXAlignment.Center
Subtitle.Parent = Card

local StatusPanel = Instance.new("Frame")
StatusPanel.Name = "StatusPanel"
StatusPanel.Size = UDim2.new(1, -70, 0, 62)
StatusPanel.AnchorPoint = Vector2.new(0.5, 0)
StatusPanel.Position = UDim2.fromScale(0.5, 0.515)
StatusPanel.BackgroundColor3 = Color3.fromRGB(28, 18, 29)
StatusPanel.BackgroundTransparency = 0.2
StatusPanel.BorderSizePixel = 0
StatusPanel.Parent = Card

local StatusPanelCorner = Instance.new("UICorner")
StatusPanelCorner.CornerRadius = UDim.new(0, 15)
StatusPanelCorner.Parent = StatusPanel

local StatusPanelStroke = Instance.new("UIStroke")
StatusPanelStroke.Color = Color3.fromRGB(255, 88, 121)
StatusPanelStroke.Transparency = 0.82
StatusPanelStroke.Thickness = 1
StatusPanelStroke.Parent = StatusPanel
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -50, 0, 27)
Status.AnchorPoint = Vector2.new(0.5, 0)
Status.Position = UDim2.fromScale(0.5, 0.535)
Status.BackgroundTransparency = 1
Status.Text = "กำลังเตรียมหน้าต่าง..."
Status.TextColor3 = Color3.fromRGB(225, 225, 230)
Status.TextSize = 15
Status.Font = Enum.Font.GothamMedium
Status.TextXAlignment = Enum.TextXAlignment.Center
Status.Parent = Card

local GameName = Instance.new("TextLabel")
GameName.Size = UDim2.new(1, -50, 0, 22)
GameName.AnchorPoint = Vector2.new(0.5, 0)
GameName.Position = UDim2.fromScale(0.5, 0.605)
GameName.BackgroundTransparency = 1
GameName.Text = "กำลังตรวจสอบแมพ..."
GameName.TextColor3 = Color3.fromRGB(191, 168, 184)
GameName.TextSize = 12
GameName.Font = Enum.Font.Gotham
GameName.TextXAlignment = Enum.TextXAlignment.Center
GameName.Parent = Card

local ProgressBackground = Instance.new("Frame")
ProgressBackground.Size = UDim2.new(1, -100, 0, 8)
ProgressBackground.AnchorPoint = Vector2.new(0.5, 0)
ProgressBackground.Position = UDim2.fromScale(0.5, 0.695)
ProgressBackground.BackgroundColor3 = Color3.fromRGB(39, 25, 35)
ProgressBackground.BorderSizePixel = 0
ProgressBackground.Parent = Card

local ProgressBackgroundCorner = Instance.new("UICorner")
ProgressBackgroundCorner.CornerRadius = UDim.new(1, 0)
ProgressBackgroundCorner.Parent = ProgressBackground

local Progress = Instance.new("Frame")
Progress.Size = UDim2.fromScale(0, 1)
Progress.BackgroundColor3 = Color3.fromRGB(255, 73, 106)
Progress.BorderSizePixel = 0
Progress.Parent = ProgressBackground

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(1, 0)
ProgressCorner.Parent = Progress

local ProgressGradient = Instance.new("UIGradient")
ProgressGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 36, 78)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 123, 121)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(225, 48, 99))
})
ProgressGradient.Parent = Progress

local Percent = Instance.new("TextLabel")
Percent.Size = UDim2.new(1, -50, 0, 20)
Percent.AnchorPoint = Vector2.new(0.5, 0)
Percent.Position = UDim2.fromScale(0.5, 0.73)
Percent.BackgroundTransparency = 1
Percent.Text = "0%"
Percent.TextColor3 = Color3.fromRGB(193, 177, 190)
Percent.TextSize = 11
Percent.Font = Enum.Font.GothamMedium
Percent.TextXAlignment = Enum.TextXAlignment.Center
Percent.Parent = Card

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.fromOffset(7, 7)
StatusDot.AnchorPoint = Vector2.new(0.5, 0.5)
StatusDot.Position = UDim2.new(0.5, -95, 0.548, 0)
StatusDot.BackgroundColor3 = Color3.fromRGB(255, 73, 106)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = Card

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = StatusDot

local RemoveButton = Instance.new("TextButton")
RemoveButton.Size = UDim2.fromOffset(176, 42)
RemoveButton.AnchorPoint = Vector2.new(0.5, 0)
RemoveButton.Position = UDim2.fromScale(0.5, 0.81)
RemoveButton.BackgroundColor3 = Color3.fromRGB(54, 20, 38)
RemoveButton.BorderSizePixel = 0
RemoveButton.Text = "ปิดหน้าต่าง"
RemoveButton.TextColor3 = Color3.fromRGB(220, 220, 225)
RemoveButton.TextSize = 13
RemoveButton.Font = Enum.Font.GothamMedium
RemoveButton.Visible = false
RemoveButton.Parent = Card

local RemoveCorner = Instance.new("UICorner")
RemoveCorner.CornerRadius = UDim.new(0, 13)
RemoveCorner.Parent = RemoveButton

local RemoveStroke = Instance.new("UIStroke")
RemoveStroke.Color = Color3.fromRGB(255, 100, 132)
RemoveStroke.Transparency = 0.58
RemoveStroke.Parent = RemoveButton

local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, -40, 0, 18)
Footer.AnchorPoint = Vector2.new(0.5, 1)
Footer.Position = UDim2.fromScale(0.5, 0.965)
Footer.BackgroundTransparency = 1
Footer.Text = "ระบบโหลดสคริปต์ • รูนลัว ฮับ"
Footer.TextColor3 = Color3.fromRGB(135, 115, 132)
Footer.TextSize = 10
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

Card.Position = UDim2.fromScale(0.5, 0.57)
Card.BackgroundTransparency = 1
CardStroke.Transparency = 1
DemonHolder.Rotation = -12
DemonIcon.ImageTransparency = 1

task.spawn(function()
    task.wait()

    Tween(
        Card,
        0.75,
        {
            Position = UDim2.fromScale(0.5, 0.52),
            BackgroundTransparency = 0.04
        },
        Enum.EasingStyle.Back
    )

    Tween(CardStroke, 0.75, { Transparency = 0.48 }, Enum.EasingStyle.Quart)
    Tween(DemonHolder, 0.9, { Rotation = 0 }, Enum.EasingStyle.Back)
    Tween(DemonIcon, 0.8, { ImageTransparency = 0 }, Enum.EasingStyle.Quart)
end)

for _, Particle in ipairs(Particles) do
    task.spawn(function()
        task.wait(math.random(1, 25) / 10)

        while Alive and ScreenGui.Parent do
            local Duration = math.random(35, 70) / 10
            local NextPosition = UDim2.fromScale(math.random(), math.random())
            local NextTransparency = math.random(35, 78) / 100

            Particle.Position = UDim2.fromScale(math.random(), math.random())
            Particle.BackgroundTransparency = 1

            Tween(
                Particle,
                Duration,
                {
                    Position = NextPosition,
                    BackgroundTransparency = NextTransparency
                },
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            )

            task.wait(Duration)

            if Alive then
                Particle.BackgroundTransparency = 1
                task.wait(math.random(8, 22) / 10)
            end
        end
    end)
end

task.spawn(function()
    while Alive and ScreenGui.Parent do
        Tween(Aura, 4.2, { Rotation = 360 }, Enum.EasingStyle.Linear)
        Tween(AuraStroke, 1.8, {
            Transparency = 0.13,
            Thickness = 2.2
        }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        Tween(CardGradient, 6, { Rotation = 300 }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        Tween(BackgroundGradient, 9, { Rotation = 165 }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

        task.wait(4.2)

        if not Alive then
            break
        end

        Aura.Rotation = 0
        Tween(AuraStroke, 1.8, {
            Transparency = 0.42,
            Thickness = 1.5
        }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        Tween(CardGradient, 6, { Rotation = 130 }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        Tween(BackgroundGradient, 9, { Rotation = 135 }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

        task.wait(4.2)
    end
end)
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
            DemonHolder,
            1.1,
            {
                Rotation = 2
            },
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )

        Tween(
            DemonIcon,
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
            DemonHolder,
            1.1,
            {
                Rotation = -2
            },
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )

        Tween(
            DemonIcon,
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
            BackgroundColor3 = Color3.fromRGB(86, 31, 56)
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
            BackgroundColor3 = Color3.fromRGB(54, 20, 38)
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
        "กำลังเชื่อมต่อสคริปต์",
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
        warn("[รูนลัว ฮับ] ข้อผิดพลาดขณะดาวน์โหลด:", DownloadError)

        SetStatus(
            "ไม่สามารถดาวน์โหลดสคริปต์ได้",
            Data.Name,
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
        RemoveButton.Visible = true

        return false
    end

    if not Source or Source == "" then
        SetStatus(
            "ไฟล์สคริปต์ที่ดาวน์โหลดว่างเปล่า",
            Data.Name,
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
        RemoveButton.Visible = true

        return false
    end

    SetStatus(
        "ดาวน์โหลดสคริปต์สำเร็จ",
        Data.Name,
        65
    )

    task.wait(0.35)

    if not Alive then
        return false
    end

    SetStatus(
        "กำลังตรวจสอบสคริปต์",
        Data.Name,
        78
    )

    local Function
    local CompileSuccess, CompileError = pcall(function()
        Function = loadstring(Source)
    end)

    if not CompileSuccess then
        warn("[รูนลัว ฮับ] ข้อผิดพลาดของโค้ด:", CompileError)

        SetStatus(
            "สคริปต์มีข้อผิดพลาด",
            Data.Name,
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
        RemoveButton.Visible = true

        return false
    end

    if not Function then
        SetStatus(
            "ไม่สามารถเตรียมสคริปต์ได้",
            Data.Name,
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
        RemoveButton.Visible = true

        return false
    end

    SetStatus(
        "กำลังเริ่มสคริปต์",
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
        warn("[รูนลัว ฮับ] ข้อผิดพลาดขณะทำงาน:", RunError)

        SetStatus(
            "สคริปต์ทำงานผิดพลาด",
            Data.Name,
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
        RemoveButton.Visible = true

        return false
    end

    SetStatus(
        "เริ่มสคริปต์แล้ว",
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
        "รหัสแมพ: " .. CurrentPlaceId,
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
            "แมพนี้ยังไม่มีสคริปต์ในรูนลัว ฮับ",
            0
        )

        StatusDot.BackgroundColor3 = Color3.fromRGB(255, 180, 70)
        RemoveButton.Visible = true

        return
    end

    LoadServerScript(ScriptData)
end)

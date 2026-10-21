local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

print("[FPS BOOST v5.0] เริ่มทำงาน...")

local function killFog()
    pcall(function()
        Lighting.FogEnd = 1000000
        Lighting.FogStart = 1000000
        Lighting.FogColor = Color3.fromRGB(128, 128, 128)
        Lighting.GlobalShadows = false
        Lighting.Brightness = 2
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.ShadowSoftness = 0
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        Lighting.ClockTime = 12
        Lighting.GeographicLatitude = 0
    end)
    for _, v in pairs(Lighting:GetChildren()) do
        pcall(function()
            if v:IsA("Atmosphere") then
                v.Density = 0
                v.Haze = 0
                v.Glare = 0
                v:Destroy()
            elseif v:IsA("Sky") then
                v:Destroy()
            end
        end)
    end
end

local function killLightingEffects()
    for _, v in pairs(Lighting:GetDescendants()) do
        pcall(function()
            if v:IsA("PostEffect") or v:IsA("BloomEffect") or v:IsA("BlurEffect")
            or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect")
            or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end)
    end
end

local function cleanWorkspace()
    local count = 0
    for _, obj in pairs(Workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("ParticleEmitter") or obj:IsA("Smoke")
            or obj:IsA("Fire") or obj:IsA("Sparkles")
            or obj:IsA("Trail") or obj:IsA("Beam") then
                obj.Enabled = false
                count += 1
            elseif obj:IsA("Texture") or obj:IsA("Decal") then
                obj.Transparency = 1
                count += 1
            elseif obj:IsA("BasePart") then
                obj.CastShadow = false
                obj.Material = Enum.Material.SmoothPlastic
            end
        end)
    end
    return count
end

local function cleanChar(char)
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        pcall(function()
            if v:IsA("Accessory") or v:IsA("Hat") then
                v:Destroy()
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = false
            elseif v:IsA("BasePart") then
                v.CastShadow = false
            end
        end)
    end
end

local function applyAll()
    killFog()
    killLightingEffects()
    local n = cleanWorkspace()
    if player.Character then cleanChar(player.Character) end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            cleanChar(plr.Character)
        end
    end
    print("[FPS BOOST] Apply สำเร็จ | ทำความสะอาด: " .. n .. " วัตถุ")
end

applyAll()

player.CharacterAdded:Connect(function(char)
    task.wait(0.3)
    cleanChar(char)
    task.wait(0.5)
    applyAll()
end)

Lighting.ChildAdded:Connect(function()
    task.wait(0.2)
    killFog()
    killLightingEffects()
end)

Workspace.DescendantAdded:Connect(function(obj)
    task.wait(0.1)
    pcall(function()
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke")
        or obj:IsA("Fire") or obj:IsA("Sparkles")
        or obj:IsA("Trail") or obj:IsA("Beam") then
            obj.Enabled = false
        elseif obj:IsA("Texture") or obj:IsA("Decal") then
            obj.Transparency = 1
        elseif obj:IsA("BasePart") then
            obj.CastShadow = false
            obj.Material = Enum.Material.SmoothPlastic
        elseif obj:IsA("Atmosphere") then
            obj:Destroy()
        end
    end)
end)

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        cleanChar(char)
    end)
end)

for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= player then
        plr.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            cleanChar(char)
        end)
    end
end

local loopTimer = 0
RunService.Heartbeat:Connect(function(dt)
    loopTimer += dt
    if loopTimer >= 1 then
        loopTimer = 0
        pcall(function()
            if Lighting.FogEnd < 100000 then
                killFog()
            end
        end)
        for _, obj in pairs(Workspace:GetDescendants()) do
            pcall(function()
                if (obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam"))
                and obj.Enabled then
                    obj.Enabled = false
                elseif obj:IsA("BasePart") and obj.CastShadow then
                    obj.CastShadow = false
                end
            end)
        end
    end
end)

local lastPos = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if hrp then
        lastPos = hrp
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        local char = player.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp and lastPos then
                local dist = (hrp.Position - lastPos.Position).Magnitude
                if dist > 500 then
                    task.wait(0.5)
                    applyAll()
                end
                lastPos = hrp
            end
        end
    end
end)

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚡ FPS BOOST v5.0",
        Text = "Auto-Reapply + No Fog เปิดแล้ว",
        Duration = 5
    })
end)

print("[FPS BOOST v5.0] ✅ โหลดเสร็จสิ้น — หมอกหาย, Auto-Reapply ทำงาน")

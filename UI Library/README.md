# RUNLUA HUB • UI Library

UI Library สำหรับ Roblox แบบ Sidebar + Scrolling Pages พร้อมระบบ Responsive, PC/Mobile, Notifications, Components และหมวด **ตั้งค่า GUI** แยกจากหมวดทั่วไป

## 🚀 โหลด Library จาก GitHub

ใช้ Loader นี้ได้เลย:

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
))()
```

ไฟล์หลักที่ Loader เรียกคือ:

```text
UI Library/UILibrary.lua
```

เมื่อโหลดเสร็จ Library จะถูกคืนค่ากลับมา และเก็บไว้ที่ `_G.RUNLUA_HUB` ด้วย โดย API หลักของ Library มี `CreateTab`, `CreateSection`, `CreateDivider`, `CreateToggle`, `CreateButton`, `CreateSlider`, `CreateInput`, `CreateKeybind`, `CreateDropdown`, `CreateLabel`, `CreateParagraph`, `CreatePlayerList`, `Notify`, `Show`, `Hide`, `Destroy` และ `Settings` fileciteturn6file0L2380-L2477

---

## ✨ ความสามารถ

- Sidebar สำหรับสลับหมวด
- Scrolling Page สำหรับแต่ละแท็บ
- Responsive Layout สำหรับพื้นที่หน้าจอหลายขนาด
- รองรับ PC / Mobile
- หน้าต่างลากได้
- ปุ่ม Logo สำหรับเปิด/ซ่อน UI
- Animation / Hover / Notification
- Toggle / Button / Slider / Input / Keybind / Dropdown
- Label / Paragraph / Divider / Section
- Player List พร้อม Avatar และการเลือกผู้เล่น
- หมวด **ตั้งค่า GUI** แยกเป็นหมวดพิเศษ
- ปรับขนาด UI
- ปรับขนาดตัวอักษร
- ปรับความหนาตัวอักษร
- เปลี่ยนสีธีม
- ตั้งสีด้วย HEX
- Save / Load / Reset การตั้งค่า
- บันทึกตำแหน่งหน้าต่างและปุ่ม Logo

ระบบจัดการขนาดและตัวอักษรใช้การแยกค่าพื้นฐานของ TextSize แล้วคูณด้วย Text Scale เพื่อไม่ให้ขยายซ้ำเมื่อปรับค่าหลายครั้ง fileciteturn6file0L198-L210

---

# 📑 สร้างแท็บ

```lua
local Home = Library:CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})
```

สร้างได้หลายแท็บ:

```lua
local Main = Library:CreateTab({
    Name = "หลัก",
    Icon = Library.Icons.Home,
})

local Player = Library:CreateTab({
    Name = "ผู้เล่น",
    Icon = Library.Icons.Player,
})

local Tools = Library:CreateTab({
    Name = "เครื่องมือ",
    Icon = Library.Icons.Action,
})
```

> หมวด `ตั้งค่า GUI` มีอยู่ใน Library อยู่แล้ว ไม่ต้องสร้างซ้ำ

---

# 🧩 Components

## Label

```lua
Library:CreateLabel(Home.Page, {
    Text = "RUNLUA HUB",
    Size = 15,
    Bold = true,
})
```

## Paragraph

```lua
Library:CreateParagraph(Home.Page, {
    Text = "คำอธิบายรายละเอียดของระบบ",
    Size = 11,
})
```

## Section

```lua
local General = Library:CreateSection(Home.Page, {
    Name = "General",
    Title = "ระบบทั่วไป",
})
```

จากนั้นใส่ Component ลงใน `General`

---

# 🔘 Button

```lua
Library:CreateButton(General, {
    Name = "ทดสอบระบบ",
    Description = "กดเพื่อทดสอบ Callback",
    Icon = Library.Icons.Action,

    Callback = function()
        Library:Notify({
            Title = "RUNLUA HUB",
            Message = "ทำงานแล้ว",
        })
    end,
})
```

---

# 🔘 Toggle

```lua
local Row, GetState, SetState = Library:CreateToggle(General, {
    Name = "เปิดระบบ",
    Description = "เปิดหรือปิดระบบ",
    Default = false,

    Callback = function(enabled)
        print("State:", enabled)
    end,
})
```

อ่านสถานะ:

```lua
local enabled = GetState()
```

เปลี่ยนสถานะ:

```lua
SetState(true)
```

---

# 🎚️ Slider

```lua
local Row, GetValue, SetValue = Library:CreateSlider(General, {
    Name = "ความเร็ว",
    Min = 0,
    Max = 100,
    Step = 1,
    Default = 50,
    Suffix = "%",

    Callback = function(value)
        print("Value:", value)
    end,
})
```

อ่านค่า:

```lua
local value = GetValue()
```

ตั้งค่า:

```lua
SetValue(75)
```

---

# ✏️ Input

```lua
local Row, GetText, SetText = Library:CreateInput(General, {
    Name = "ชื่อ",
    Placeholder = "พิมพ์ชื่อ...",
    Default = "",

    Callback = function(text)
        print(text)
    end,
})
```

อ่านข้อความ:

```lua
local text = GetText()
```

ตั้งข้อความ:

```lua
SetText("RUNLUA")
```

---

# ⌨️ Keybind

```lua
local Row, GetKey, SetKey = Library:CreateKeybind(General, {
    Name = "ปุ่มเปิดระบบ",
    Default = Enum.KeyCode.E,

    Callback = function(key)
        print("New key:", key.Name)
    end,
})
```

---

# 🔽 Dropdown

```lua
local Row, GetOption, SetOption = Library:CreateDropdown(General, {
    Name = "เลือกโหมด",
    Options = {
        "โหมด 1",
        "โหมด 2",
        "โหมด 3",
    },
    Default = "โหมด 1",

    Callback = function(value)
        print("Selected:", value)
    end,
})
```

---

# 👥 Player List

```lua
local Wrapper, RebuildPlayers, GetSelectedPlayer =
    Library:CreatePlayerList(Home.Page, {
        AccentColor = Library.Theme.Accent,

        OnSelect = function(player)
            print("เลือก:", player.Name)
        end,
    })
```

รีเฟรชรายชื่อ:

```lua
RebuildPlayers()
```

อ่านผู้เล่นที่เลือก:

```lua
local player = GetSelectedPlayer()
```

---

# 🔔 Notification

```lua
Library:Notify({
    Title = "RUNLUA HUB",
    Message = "ระบบทำงานแล้ว",
    Duration = 3,
    Color = Library.Theme.Success,
    Icon = Library.Icons.Home,
})
```

รองรับค่า:

```text
Title
Message
Duration
Color
Icon
```

---

# ⚙️ ตั้งค่า GUI

หมวด **ตั้งค่า GUI** เป็นหมวดพิเศษของ Library และแยกจากแท็บระบบทั่วไปโดยอัตโนมัติ ระบบมีตัวควบคุมสำหรับขนาด UI, ขนาดตัวอักษร, น้ำหนักตัวอักษร และสีธีม fileciteturn0file0L447-L542

## ขนาด UI

ช่วงค่า:

```text
0.55x → 1.80x
```

## ขนาดตัวอักษร

ช่วงค่า:

```text
0.75x → 1.75x
```

## ความหนาตัวอักษร

```text
Regular
Medium
SemiBold
Bold
ExtraBold
Heavy
```

## สีธีม

Preset ที่มี:

```text
น้ำเงินฟ้า
ม่วงไฟฟ้า
เขียวมรกต
แดงคริมสัน
ทอง
ขาวดำ
```

นอกจากนี้สามารถใส่ HEX ได้ เช่น:

```text
#00A2FF
#FF3355
#FFFFFF
```

---

# 💾 Settings API

API สำหรับระบบตั้งค่าอยู่ใน `Library.Settings` fileciteturn6file0L2429-L2477

### อ่านค่าปัจจุบัน

```lua
local settings = Library.Settings.Get()
```

### บันทึก

```lua
local ok, result = Library.Settings.Save()
print(ok, result)
```

### โหลด

```lua
local ok, result = Library.Settings.Load()
print(ok, result)
```

### รีเซ็ตกลับค่าเดิม

```lua
Library.Settings.Reset()
```

### นำ Settings ที่มีอยู่มาใช้

```lua
Library.Settings.Apply(settings)
```

### ตรวจสอบ File Storage

```lua
local supported = Library.Settings.GetStorageAvailable()
```

ไฟล์เริ่มต้นของ Settings คือ:

```text
RUNLUA_HUB_SETTINGS.json
```

ระบบจะใช้ `isfile/readfile/writefile` เมื่อ Environment รองรับ และจะ fallback เป็น Memory Session เมื่อไม่รองรับ fileciteturn0file0L297-L320

---

# 🎨 Theme API

เข้าถึง Theme ได้จาก:

```lua
Library.Theme
```

ตัวอย่าง:

```lua
print(Library.Theme.Accent)
print(Library.Theme.Background)
print(Library.Theme.Text)
```

Palette หลักมี:

```text
Background
Surface
SurfaceAlt
SurfaceHover
Accent
AccentSoft
AccentLight
Text
TextMuted
Border
Success
Danger
Warning
SwitchOff
Shadow
White
IconGradStart
IconGradEnd
IconGradAngle
IconDim
```

---

# 🖼️ Icons

ตัวอย่าง Icon ที่มี:

```lua
Library.Icons.Home
Library.Icons.Settings
Library.Icons.Player
Library.Icons.ESP
Library.Icons.Teleport
Library.Icons.Fling
Library.Icons.Save
Library.Icons.Cloud
```

---

# 🪟 เปิด / ซ่อน / ทำลาย UI

แสดง:

```lua
Library:Show()
```

ซ่อน:

```lua
Library:Hide()
```

ทำลายและ Cleanup:

```lua
Library:Destroy()
```

---

# 📱 PC / Mobile

Library ตรวจจับ Platform และปรับ Layout ตามพื้นที่หน้าจอ โดยมี `Library.IsMobile` และ `Library.Platform` ให้ตรวจสอบได้ fileciteturn6file0L15-L31

```lua
print(Library.Platform)
print(Library.IsMobile)
```

เมื่อหน้าจอแคบ Sidebar จะเข้าสู่ Compact Mode เพื่อช่วยลดปัญหาข้อความและ Component ชนกัน fileciteturn6file0L607-L610

---

# 🖱️ การลาก UI

### PC

ลากจาก Header ด้วย:

```text
คลิกขวา + ลาก
```

### Mobile

```text
แตะค้าง + ลาก
```

ระบบ Drag มี threshold เพื่อแยกการลากออกจากการกด และมีการป้องกันการจับ Input ซ้อนกัน fileciteturn6file0L724-L832

ปุ่ม Logo ใช้สำหรับเปิด / ซ่อนหน้าต่าง

---

# 🧹 Cleanup

เรียก:

```lua
Library:Destroy()
```

เพื่อปิด UI และตัด Connections ที่ Library จัดการไว้

---

# 🔄 อัปเดต Library บน GitHub

แก้ไฟล์:

```text
UI Library/UILibrary.lua
```

จากนั้น Commit + Push ขึ้น branch `main`

Loader เดิมใช้ต่อได้ เพราะ URL ชี้ไปยังไฟล์เดิม:

```text
https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua
```

ดังนั้นโดยปกติผู้ใช้ไม่จำเป็นต้องเปลี่ยน Loader เมื่อคุณอัปเดตเฉพาะเนื้อหาของ `UILibrary.lua`

---

# 🛠️ ตัวอย่างพร้อมใช้งาน

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
))()

local Main = Library:CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local General = Library:CreateSection(Main.Page, {
    Name = "General",
    Title = "ระบบทั่วไป",
})

Library:CreateLabel(Main.Page, {
    Text = "RUNLUA HUB",
    Size = 15,
    Bold = true,
})

Library:CreateParagraph(Main.Page, {
    Text = "ตัวอย่างการใช้งาน UI Library",
})

Library:CreateButton(General, {
    Name = "ทดสอบ",
    Description = "กดเพื่อแสดง Notification",
    Callback = function()
        Library:Notify({
            Title = "RUNLUA HUB",
            Message = "ทดสอบสำเร็จ",
            Duration = 3,
            Color = Library.Theme.Success,
            Icon = Library.Icons.Home,
        })
    end,
})

Library:CreateToggle(General, {
    Name = "ระบบตัวอย่าง",
    Description = "Toggle สำหรับระบบของคุณ",
    Default = false,
    Callback = function(enabled)
        print("Enabled:", enabled)
    end,
})

Library:CreateSlider(General, {
    Name = "ค่า",
    Min = 1,
    Max = 100,
    Step = 1,
    Default = 50,
    Callback = function(value)
        print("Value:", value)
    end,
})

Library:CreateDropdown(General, {
    Name = "โหมด",
    Options = {"ปกติ", "เร็ว", "สูงสุด"},
    Default = "ปกติ",
    Callback = function(value)
        print("Mode:", value)
    end,
})
```

---

# 📚 API Reference

| API | หน้าที่ |
|---|---|
| `CreateTab` | สร้างแท็บ |
| `CreateSection` | สร้าง Section |
| `CreateDivider` | สร้างเส้นแบ่ง |
| `CreateToggle` | สร้าง Toggle |
| `CreateButton` | สร้าง Button |
| `CreateSlider` | สร้าง Slider |
| `CreateInput` | สร้างช่องข้อความ |
| `CreateKeybind` | สร้าง Keybind |
| `CreateDropdown` | สร้าง Dropdown |
| `CreateLabel` | สร้างข้อความ |
| `CreateParagraph` | สร้างข้อความหลายบรรทัด |
| `CreatePlayerList` | สร้างรายการผู้เล่น |
| `Notify` | แจ้งเตือน |
| `SelectTab` | เลือกแท็บ |
| `Show` | แสดง UI |
| `Hide` | ซ่อน UI |
| `Destroy` | Cleanup และปิด UI |
| `Settings.Get` | อ่าน Settings |
| `Settings.Save` | บันทึก Settings |
| `Settings.Load` | โหลด Settings |
| `Settings.Reset` | รีเซ็ต Settings |
| `Settings.Apply` | ใช้ Settings |
| `Settings.GetStorageAvailable` | ตรวจสอบ File Storage |

---

## 📌 GitHub Raw URL

```text
https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua
```

## ❤️ RUNLUA HUB

UI Library สำหรับโปรเจกต์ RUNLUA HUB — ออกแบบให้ใช้งานซ้ำได้ง่าย ดูเป็นระบบ และดูแลต่อบน GitHub ได้สะดวก

UI Library สำหรับ Roblox ที่ออกแบบมาให้สร้าง UI ได้ง่าย รองรับทั้ง PC และ Mobile พร้อม Component และ Animation ที่พร้อมใช้งาน

---

## ✨ ความสามารถ

- 🖥️ รองรับ PC และ Mobile
- 📱 Responsive UI
- 🎨 ระบบ Theme
- 🔔 ระบบ Notification
- 🗂️ ระบบ Tab
- 📦 ระบบ Section
- 🔘 Toggle
- 🔲 Button
- 🎚️ Slider
- ⌨️ Keybind
- 📝 Input
- 📋 Dropdown
- 👤 Player List
- 🏷️ Label
- 📄 Paragraph
- ➖ Divider
- 🖱️ รองรับการลาก UI
- 🧹 ระบบ Cleanup
- ⚡ Animation ภายใน Library

---

# 📥 การติดตั้ง

เรียก Library จาก Raw GitHub URL:

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
))()
```

> เปลี่ยน URL ให้ตรงกับตำแหน่งไฟล์ `UI-Library.lua` ของคุณ

---

# 🚀 Quick Start

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
))()

local Main = Library:CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local Section = Library:CreateSection(Main.Page, {
    Title = "ระบบหลัก"
})

Library:CreateToggle(Section, {
    Name = "เปิดใช้งาน",
    Description = "เปิดหรือปิดระบบ",
    Default = false,

    Callback = function(Value)
        print("สถานะ:", Value)
    end,
})

Library:CreateButton(Section, {
    Name = "ทดสอบ",

    Callback = function()
        Library:Notify({
            Title = "RUNLUA HUB",
            Message = "ทำงานเรียบร้อยแล้ว",
            Duration = 3,
        })
    end,
})
```

---

# 🗂️ Tab

สร้าง Tab ใหม่:

```lua
local Main = Library:CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})
```

ตัวอย่างหลาย Tab:

```lua
local Main = Library:CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local Settings = Library:CreateTab({
    Name = "ตั้งค่า",
    Icon = Library.Icons.Settings,
})
```

---

# 📦 Section

สร้าง Section ภายใน Tab:

```lua
local Section = Library:CreateSection(Main.Page, {
    Title = "การตั้งค่าหลัก"
})
```

จากนั้นสามารถใส่ Component ลงใน Section:

```lua
Library:CreateButton(Section, {
    Name = "ทดสอบ",

    Callback = function()
        print("ทำงานแล้ว")
    end,
})
```

---

# 🔘 Toggle

```lua
Library:CreateToggle(Section, {
    Name = "เปิดใช้งาน",
    Description = "เปิดหรือปิดระบบ",
    Default = false,

    Callback = function(Value)
        if Value then
            print("เปิด")
        else
            print("ปิด")
        end
    end,
})
```

### ตัวเลือก

| ตัวเลือก | ประเภท | รายละเอียด |
|---|---|---|
| `Name` | string | ชื่อ Toggle |
| `Description` | string | คำอธิบาย |
| `Default` | boolean | ค่าเริ่มต้น |
| `Callback` | function | ทำงานเมื่อเปลี่ยนค่า |
| `Icon` | icon | ไอคอน |
| `Order` | number | ลำดับการแสดงผล |

---

# 🔲 Button

```lua
Library:CreateButton(Section, {
    Name = "ทดสอบ",

    Callback = function()
        print("กดปุ่มแล้ว")
    end,
})
```

สามารถใช้ร่วมกับ Notification:

```lua
Library:CreateButton(Section, {
    Name = "แสดงข้อความ",

    Callback = function()
        Library:Notify({
            Title = "RUNLUA HUB",
            Message = "กดปุ่มเรียบร้อยแล้ว",
            Duration = 3,
        })
    end,
})
```

---

# 🎚️ Slider

```lua
Library:CreateSlider(Section, {
    Name = "ความเร็ว",

    Min = 1,
    Max = 100,
    Step = 1,
    Default = 50,

    Suffix = "%",

    Callback = function(Value)
        print("ค่า:", Value)
    end,
})
```

### ตัวเลือก

| ตัวเลือก | ประเภท | รายละเอียด |
|---|---|---|
| `Name` | string | ชื่อ Slider |
| `Min` | number | ค่าต่ำสุด |
| `Max` | number | ค่าสูงสุด |
| `Step` | number | จำนวนการเพิ่ม/ลด |
| `Default` | number | ค่าเริ่มต้น |
| `Suffix` | string | ข้อความต่อท้ายค่า |
| `Format` | function | กำหนดรูปแบบการแสดงค่า |
| `Callback` | function | ทำงานเมื่อค่าเปลี่ยน |
| `Icon` | icon | ไอคอน |
| `Order` | number | ลำดับ |

### Custom Format

```lua
Library:CreateSlider(Section, {
    Name = "ระยะ",

    Min = 0,
    Max = 500,
    Step = 10,
    Default = 100,

    Format = function(Value)
        return tostring(Value) .. " studs"
    end,

    Callback = function(Value)
        print(Value)
    end,
})
```

---

# 📝 Input

```lua
Library:CreateInput(Section, {
    Name = "ชื่อผู้เล่น",

    Placeholder = "พิมพ์ชื่อ...",
    Default = "",

    Callback = function(Text)
        print("ข้อความ:", Text)
    end,
})
```

ล้างข้อความเมื่อกดช่อง:

```lua
Library:CreateInput(Section, {
    Name = "ข้อความ",
    Placeholder = "พิมพ์ข้อความ...",
    ClearOnFocus = true,

    Callback = function(Text)
        print(Text)
    end,
})
```

### ตัวเลือก

| ตัวเลือก | ประเภท | รายละเอียด |
|---|---|---|
| `Name` | string | ชื่อช่อง |
| `Placeholder` | string | ข้อความตัวอย่าง |
| `Default` | string | ข้อความเริ่มต้น |
| `ClearOnFocus` | boolean | ล้างข้อความเมื่อ Focus |
| `Callback` | function | ทำงานเมื่อ FocusLost |
| `Icon` | icon | ไอคอน |
| `Order` | number | ลำดับ |

---

# ⌨️ Keybind

```lua
Library:CreateKeybind(Section, {
    Name = "ปุ่มเปิดระบบ",

    Default = Enum.KeyCode.E,

    Callback = function(Key)
        print("ตั้งปุ่มเป็น:", Key.Name)
    end,
})
```

ผู้ใช้สามารถกดที่ Keybind แล้วกดปุ่มใหม่เพื่อเปลี่ยน Key ได้

---

# 📋 Dropdown

```lua
Library:CreateDropdown(Section, {
    Name = "เลือกโหมด",

    Options = {
        "โหมดที่ 1",
        "โหมดที่ 2",
        "โหมดที่ 3",
    },

    Default = "โหมดที่ 1",

    Callback = function(Value)
        print("เลือก:", Value)
    end,
})
```

### ตัวเลือก

| ตัวเลือก | ประเภท | รายละเอียด |
|---|---|---|
| `Name` | string | ชื่อ Dropdown |
| `Options` | table | รายการตัวเลือก |
| `Default` | any | ค่าเริ่มต้น |
| `Callback` | function | ทำงานเมื่อเลือก |
| `Icon` | icon | ไอคอน |
| `Order` | number | ลำดับ |

---

# 🏷️ Label

```lua
Library:CreateLabel(Section, {
    Text = "RUNLUA HUB",
})
```

แบบตัวหนา:

```lua
Library:CreateLabel(Section, {
    Text = "RUNLUA HUB UI LIBRARY",
    Bold = true,
    Size = 14,
})
```

### ตัวเลือก

| ตัวเลือก | ประเภท | รายละเอียด |
|---|---|---|
| `Text` | string | ข้อความ |
| `Color` | Color3 | สีข้อความ |
| `Bold` | boolean | ตัวหนา |
| `Size` | number | ขนาดตัวอักษร |
| `Align` | Enum.TextXAlignment | การจัดข้อความ |
| `Height` | number | ความสูง |
| `Order` | number | ลำดับ |

---

# 📄 Paragraph

```lua
Library:CreateParagraph(Section, {
    Text = "RUNLUA HUB เป็น UI Library สำหรับสร้างหน้าต่างที่ใช้งานง่าย",
})
```

กำหนดขนาด:

```lua
Library:CreateParagraph(Section, {
    Text = "ข้อความรายละเอียด",
    Size = 12,
})
```

---

# 👤 Player List

```lua
Library:CreatePlayerList(Section, {
    OnSelect = function(Player)
        if Player then
            print("เลือกผู้เล่น:", Player.Name)
        end
    end,
})
```

กำหนดสี:

```lua
Library:CreatePlayerList(Section, {
    AccentColor = Library.Theme.Accent,

    OnSelect = function(Player)
        if Player then
            print(Player.Name)
        end
    end,
})
```

---

# 🔔 Notification

```lua
Library:Notify({
    Title = "RUNLUA HUB",
    Message = "เปิดระบบเรียบร้อยแล้ว",
    Duration = 3,
})
```

กำหนดสี:

```lua
Library:Notify({
    Title = "สำเร็จ",
    Message = "ดำเนินการเรียบร้อย",
    Duration = 3,
    Color = Library.Theme.Success,
})
```

กำหนด Icon:

```lua
Library:Notify({
    Title = "แจ้งเตือน",
    Message = "มีการเปลี่ยนแปลง",
    Duration = 3,
    Icon = Library.Icons.Home,
})
```

### ตัวเลือก

| ตัวเลือก | ประเภท | รายละเอียด |
|---|---|---|
| `Title` | string | หัวข้อ |
| `Message` | string | ข้อความ |
| `Duration` | number | ระยะเวลาแสดง |
| `Color` | Color3 | สี Accent |
| `Icon` | icon | ไอคอน |

---

# ➖ Divider

ใช้แบ่งส่วนของ UI:

```lua
Library:CreateDivider(Section)
```

---

# 🎨 Icons

สามารถเรียก Icon ที่มีอยู่ใน Library ผ่าน:

```lua
Library.Icons
```

ตัวอย่าง:

```lua
Library.Icons.Home
Library.Icons.Settings
Library.Icons.Target
Library.Icons.Search
Library.Icons.Shop
Library.Icons.Person
Library.Icons.Star
Library.Icons.Egg
Library.Icons.Run
Library.Icons.Discord
Library.Icons.YouTube
Library.Icons.Gun
Library.Icons.Map
Library.Icons.Rocket
Library.Icons.Gift
Library.Icons.Fish
Library.Icons.WiFi
Library.Icons.Thunder
Library.Icons.Diamond
Library.Icons.Punch
Library.Icons.Fishingrod
```

นำไปใช้กับ Component ได้ เช่น:

```lua
Library:CreateButton(Section, {
    Name = "เปิดระบบ",
    Icon = Library.Icons.Run,

    Callback = function()
        print("ทำงานแล้ว")
    end,
})
```

---

# 🖥️ ตรวจสอบ Platform

ตรวจสอบว่าเป็น Mobile หรือไม่:

```lua
if Library.IsMobile then
    print("กำลังใช้งานบนมือถือ")
else
    print("กำลังใช้งานบน PC")
end
```

ดูชื่อ Platform:

```lua
print(Library.Platform)
```

---

# 👁️ แสดง / ซ่อน UI

แสดง UI:

```lua
Library:Show()
```

ซ่อน UI:

```lua
Library:Hide()
```

---

# 🗑️ ลบ UI

เมื่อต้องการปิดและ Cleanup Library ทั้งหมด:

```lua
Library:Destroy()
```

---

# 🧩 ตัวอย่างเต็ม

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
))()

local Main = Library:CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local Settings = Library:CreateTab({
    Name = "ตั้งค่า",
    Icon = Library.Icons.Settings,
})

local MainSection = Library:CreateSection(Main.Page, {
    Title = "ระบบหลัก"
})

Library:CreateToggle(MainSection, {
    Name = "เปิดใช้งาน",
    Description = "เปิดหรือปิดระบบ",
    Default = false,

    Callback = function(Value)
        print("สถานะ:", Value)
    end,
})

Library:CreateButton(MainSection, {
    Name = "ทดสอบ",
    Icon = Library.Icons.Run,

    Callback = function()
        Library:Notify({
            Title = "RUNLUA HUB",
            Message = "ระบบทำงานเรียบร้อยแล้ว",
            Duration = 3,
            Icon = Library.Icons.Home,
        })
    end,
})

Library:CreateSlider(MainSection, {
    Name = "ความเร็ว",

    Min = 1,
    Max = 100,
    Step = 1,
    Default = 50,
    Suffix = "%",

    Callback = function(Value)
        print("ความเร็ว:", Value)
    end,
})

local SettingsSection = Library:CreateSection(Settings.Page, {
    Title = "การตั้งค่า"
})

Library:CreateDropdown(SettingsSection, {
    Name = "เลือกโหมด",

    Options = {
        "โหมดที่ 1",
        "โหมดที่ 2",
        "โหมดที่ 3",
    },

    Default = "โหมดที่ 1",

    Callback = function(Value)
        print("โหมด:", Value)
    end,
})

Library:CreateInput(SettingsSection, {
    Name = "ชื่อ",

    Placeholder = "พิมพ์ชื่อ...",
    Default = "",

    Callback = function(Text)
        print("ชื่อ:", Text)
    end,
})

Library:CreateKeybind(SettingsSection, {
    Name = "ปุ่มลัด",

    Default = Enum.KeyCode.E,

    Callback = function(Key)
        print("ปุ่ม:", Key.Name)
    end,
})
```

---

# 📚 API

Library มี API หลักดังนี้:

```text
Library.Theme
Library.Config
Library.Icons
Library.Tabs

Library.Notify()

Library:CreateTab()
Library:CreateSection()
Library:CreateDivider()

Library:CreateToggle()
Library:CreateButton()
Library:CreateSlider()
Library:CreateInput()
Library:CreateKeybind()
Library:CreateDropdown()

Library:CreateLabel()
Library:CreateParagraph()
Library:CreatePlayerList()

Library:SelectTab()

Library:Show()
Library:Hide()
Library:Destroy()

Library.IsMobile
Library.Platform

Library.ScreenGui
Library.MainFrame
```

---

# 📁 โครงสร้าง Repository ที่แนะนำ

```text
RUNLUA-HUBS/
│
├── UI-Library.lua
│
├── Examples/
│   ├── Basic.lua
│   ├── Components.lua
│   └── Full.lua
│
└── README.md
```

---

# ⚠️ หมายเหตุ

- URL ในตัวอย่างต้องเปลี่ยนให้ตรงกับไฟล์จริงบน GitHub
- `Callback` ควรตรวจสอบข้อมูลก่อนนำไปใช้งาน
- หากสร้าง UI หลายชุด ควรเรียก `Destroy()` เมื่อไม่ต้องการใช้งานแล้ว
- Library รองรับการใช้งานบน PC และ Mobile

---

# 📜 License

โปรเจกต์นี้เป็นส่วนหนึ่งของ **RUNLUA HUB**

หากมีการนำ Library ไปใช้งานหรือดัดแปลง กรุณาเก็บเครดิตของ RUNLUA HUB ไว้ในโปรเจกต์

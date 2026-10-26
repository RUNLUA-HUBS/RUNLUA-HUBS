# คู่มือการใช้งาน RUNLUA HUB UI Library

คู่มือนี้อ้างอิงจากไฟล์ `UINEW_B.lua` ที่แนบมา โดยครอบคลุม API ที่ไลบรารีส่งออกผ่านตัวแปร `Library` และ `_G.RUNLUA_HUB`

> **หมายเหตุด้านความปลอดภัย**: Loader จะดาวน์โหลดและรันโค้ดจาก URL ภายนอกโดยตรง ควรตรวจสอบเนื้อหาในไฟล์/Repository ก่อนใช้งาน และหลีกเลี่ยงการฝังโทเคน รหัสผ่าน หรือข้อมูลส่วนตัวไว้ในสคริปต์

---

## 1. การโหลดไลบรารี

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
))()
```

เมื่อโหลดสำเร็จ ไลบรารีจะคืนตาราง `Library` และกำหนดค่าเดียวกันไว้ที่:

```lua
_G.RUNLUA_HUB = Library
```

ดังนั้นจึงเรียกใช้งานได้ทั้งสองแบบ:

```lua
Library:Notify({ Title = "พร้อมใช้งาน", Message = "โหลด UI แล้ว" })
-- หรือ
_G.RUNLUA_HUB.Notify({ Title = "พร้อมใช้งาน", Message = "โหลด UI แล้ว" })
```

แนะนำให้ใช้ตัวแปร `Library` ในสคริปต์ของตนเอง เพราะอ่านง่ายและไม่ชนกับโค้ดอื่น

---

## 2. โครงสร้างพื้นฐานของ UI

ทุกคอมโพเนนต์ต้องมี `parent` เป็นตำแหน่งที่จะวางคอมโพเนนต์ โดยปกติใช้ `tab.Page` หรือ `section` ที่สร้างจาก `Library:CreateSection`:

```lua
local mainTab = Library:CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
    Order = 1,
})

local section = Library:CreateSection(mainTab.Page, {
    Title = "ตัวเลือกทั่วไป",
    Order = 1,
})

Library:CreateToggle(section, {
    Name = "เปิดใช้งาน",
    Default = false,
    Callback = function(enabled)
        print("สถานะ:", enabled)
    end,
})
```

### ลำดับการสร้างที่แนะนำ

1. โหลด `Library`
2. สร้าง Tab ด้วย `CreateTab`
3. สร้าง Section ด้วย `CreateSection(tab.Page, ...)`
4. เพิ่มคอมโพเนนต์ลงใน Section
5. ใช้ Callback เชื่อมกับ logic ของโปรเจกต์

---

## 3. ไอคอน

ไลบรารีมีไอคอนพร้อมใช้ใน `Library.Icons` เช่น:

```lua
Library.Icons.Home
Library.Icons.Settings
Library.Icons.Search
Library.Icons.Target
Library.Icons.Shop
Library.Icons.Person
Library.Icons.Save
Library.Icons.Reset
Library.Icons.Cloud
Library.Icons.Pencil
Library.Icons.Book
Library.Icons.Diamond
Library.Icons.Discord
Library.Icons.YouTube
Library.Icons.WiFi
Library.Icons.Map
Library.Icons.Rocket
Library.Icons.Gift
Library.Icons.Bag
Library.Icons.Fish
Library.Icons.Cross
Library.Icons.Resize
```

ค่าไอคอนเหล่านี้เป็นฟังก์ชันวาดไอคอนภายใน ไม่ใช่ URL หรือเลข Asset ที่ต้องนำไปกำหนดเอง

ตัวอย่าง:

```lua
Library:CreateButton(section, {
    Name = "เปิดร้านค้า",
    Icon = Library.Icons.Shop,
    Callback = function()
        print("เปิดร้านค้า")
    end,
})
```

---

## 4. การสร้าง Tab

### รูปแบบ

```lua
local tab = Library:CreateTab({
    Name = "ชื่อแท็บ",
    Icon = Library.Icons.Home,
    Order = 1,
    IsSettings = false,
})
```

| ตัวเลือก | ชนิด | ค่าเริ่มต้น | รายละเอียด |
|---|---|---:|---|
| `Name` | string | `"แท็บ"` | ชื่อที่แสดงบน Sidebar |
| `Icon` | icon function | `Library.Icons.Home` | ไอคอนของแท็บ |
| `Order` | number | ลำดับที่สร้าง | ลำดับแท็บบน Sidebar |
| `IsSettings` | boolean | `false` | ทำให้แท็บเป็นแท็บตั้งค่าและอยู่ล่างสุด |

### ค่าที่คืนกลับ

ตาราง Tab ที่คืนกลับมามีฟิลด์สำคัญ:

```lua
tab.Name       -- ชื่อแท็บ
tab.Index      -- ลำดับแท็บ
tab.Page       -- ScrollingFrame สำหรับใส่ Section/คอมโพเนนต์
tab.Button     -- ปุ่มแท็บบน Sidebar
tab.Indicator  -- แถบแสดงแท็บที่เลือก
tab.Label      -- TextLabel ชื่อแท็บ
tab.IconHolder -- พื้นที่ไอคอน
tab.IsSettings -- เป็นแท็บตั้งค่าหรือไม่
```

เลือกแท็บด้วยโค้ด:

```lua
Library:SelectTab(tab)
```

---

## 5. Section และ Divider

### CreateSection

```lua
local section = Library:CreateSection(tab.Page, {
    Name = "CombatSection", -- ไม่ใส่ก็ได้
    Title = "ระบบต่อสู้",
    Order = 1,
})
```

ตัวเลือก:

- `Name`: ชื่อภายในของ Frame
- `Title`: หัวข้อที่แสดงด้านบน Section
- `Order`: ลำดับ Section

Section จะจัดเรียงคอมโพเนนต์ด้วย `UIListLayout` และปรับความสูงอัตโนมัติ

### CreateDivider

```lua
Library:CreateDivider(tab.Page, 2)
```

ใช้สร้างเส้นแบ่งแนวนอน โดยพารามิเตอร์ตัวที่สองคือ `Order`

---

## 6. Toggle / สวิตช์เปิด-ปิด

```lua
local toggleRow, getEnabled, setEnabled = Library:CreateToggle(section, {
    Name = "เปิด ESP",
    Description = "แสดงตำแหน่งผู้เล่นบนหน้าจอ",
    Default = false,
    Icon = Library.Icons.ESP,
    Order = 1,
    Callback = function(enabled)
        if enabled then
            print("ESP เปิด")
        else
            print("ESP ปิด")
        end
    end,
})
```

ตัวเลือก:

| ตัวเลือก | ชนิด | ค่าเริ่มต้น |
|---|---|---:|
| `Name` | string | `"สวิตช์"` |
| `Description` | string/nil | ไม่มีคำอธิบาย |
| `Default` | boolean | `false` |
| `Icon` | icon function | `Settings` |
| `Order` | number | อัตโนมัติ |
| `Floating` หรือ `FloatButton` | boolean | `false` |
| `Callback` | function(boolean) | ฟังก์ชันว่าง |

ค่าที่คืนกลับ:

```lua
row       -- Frame ของรายการ
getState  -- function() คืนค่า true/false
setState  -- function(value) ตั้งค่า true/false
```

ตัวอย่างควบคุมภายหลัง:

```lua
setEnabled(true)
print(getEnabled()) -- true
```

### โหมด Floating

ถ้าต้องการให้ Toggle มีปุ่ม `ลอย` สำหรับเปิดแผงควบคุมย่อยที่ลากและปรับขนาดได้:

```lua
Library:CreateToggle(section, {
    Name = "โหมดลอย",
    Floating = true,
    Callback = function(value)
        print(value)
    end,
})
```

---

## 7. Button / ปุ่มกด

```lua
local buttonRow = Library:CreateButton(section, {
    Name = "รีเฟรชข้อมูล",
    Description = "โหลดข้อมูลล่าสุดอีกครั้ง",
    Icon = Library.Icons.Reset,
    Color = Library.Theme.Accent,
    Order = 2,
    Callback = function()
        print("รีเฟรชแล้ว")
    end,
})
```

ตัวเลือก:

- `Name`: ชื่อปุ่ม ค่าเริ่มต้น `"ปุ่ม"`
- `Description`: คำอธิบายเสริม ถ้าใส่ ปุ่มจะสูงขึ้น
- `Icon`: ไอคอน ค่าเริ่มต้นเป็นไอคอน Action
- `Color`: สีแถบด้านซ้าย/ไอคอน
- `Order`: ลำดับ
- `Callback`: ฟังก์ชันที่ทำงานเมื่อกดปุ่ม

`Callback` ของ Button ไม่รับอาร์กิวเมนต์

---

## 8. Slider / แถบเลื่อน

```lua
local sliderRow, getVolume, setVolume = Library:CreateSlider(section, {
    Name = "ระดับเสียง",
    Min = 0,
    Max = 100,
    Step = 5,
    Default = 50,
    Suffix = "%",
    Icon = Library.Icons.Sound,
    Order = 3,
    Callback = function(value)
        print("เสียง:", value)
    end,
})
```

ตัวเลือก:

| ตัวเลือก | ชนิด | ค่าเริ่มต้น | รายละเอียด |
|---|---|---:|---|
| `Name` | string | `"ตัวเลื่อน"` | ชื่อ |
| `Min` | number | `0` | ค่าต่ำสุด |
| `Max` | number | `100` | ค่าสูงสุด |
| `Step` | number | `1` | ระยะการเพิ่ม/ลด |
| `Default` | number | `Min` | ค่าเริ่มต้น |
| `Suffix` | string | `""` | ข้อความต่อท้ายที่แสดง |
| `Format` | function(number) | แสดงตัวเลข+Suffix | ฟังก์ชันจัดรูปแบบข้อความ |
| `Icon` | icon function | `Slider` | ไอคอน |
| `Order` | number | อัตโนมัติ | ลำดับ |
| `Callback` | function(number) | ว่าง | เรียกเมื่อเลื่อน/กรอกค่า |

ค่าที่คืนกลับ:

```lua
getVolume()   -- อ่านค่าปัจจุบัน
setVolume(75) -- ตั้งค่าใหม่และอัปเดตแถบ
```

### Format แบบกำหนดเอง

```lua
Library:CreateSlider(section, {
    Name = "ความเร็ว",
    Min = 0.1,
    Max = 3,
    Step = 0.1,
    Default = 1,
    Format = function(value)
        return string.format("%.1fx", value)
    end,
})
```

ผู้ใช้สามารถลากแถบหรือคลิกช่องตัวเลขแล้วพิมพ์ค่าได้ ค่าจะถูก Clamp ให้อยู่ระหว่าง `Min` และ `Max`

---

## 9. NumberInput / ช่องกรอกตัวเลข

```lua
local row, getDistance, setDistance = Library:CreateNumberInput(section, {
    Name = "ระยะตรวจจับ",
    Min = 1,
    Max = 500,
    Step = 1,
    Default = 100,
    Suffix = " studs",
    Icon = Library.Icons.Target,
    Callback = function(value)
        print("ระยะ:", value)
    end,
})
```

ตัวเลือกเหมือน Slider เกือบทั้งหมด แต่ไม่มี `Format` และใช้กรอกตัวเลขโดยตรง:

- `Name`
- `Min`
- `Max`
- `Step` ค่าเริ่มต้น `0.05`
- `Default`
- `Suffix`
- `Icon`
- `Order`
- `Callback(number)`

ค่าที่คืนกลับคือ `row`, ฟังก์ชันอ่านค่า และฟังก์ชันตั้งค่า

```lua
print(getDistance())
setDistance(250)
```

ถ้ากรอกข้อความที่ไม่ใช่ตัวเลข ระบบจะไม่เปลี่ยนค่าปัจจุบัน

---

## 10. Input / ช่องกรอกข้อความ

```lua
local row, getText, setText = Library:CreateInput(section, {
    Name = "ชื่อผู้เล่น",
    Placeholder = "พิมพ์ชื่อ...",
    Default = "",
    ClearOnFocus = false,
    Icon = Library.Icons.Person,
    Order = 4,
    Callback = function(text)
        print("ข้อความ:", text)
    end,
})
```

ตัวเลือก:

- `Name`: ชื่อช่อง
- `Placeholder`: ข้อความตัวอย่างในช่อง ค่าเริ่มต้น `"พิมพ์..."`
- `Default`: ข้อความเริ่มต้น
- `ClearOnFocus`: ล้างข้อความเมื่อแตะ/คลิกช่องหรือไม่
- `Icon`: ไอคอน ค่าเริ่มต้น Pencil
- `Order`: ลำดับ
- `Callback(text)`: เรียกเมื่อช่องเสียโฟกัส

ค่าที่คืนกลับ:

```lua
local text = getText()
setText("ข้อความใหม่")
```

Callback จะทำงานตอน `FocusLost` ไม่ใช่ทุกครั้งที่พิมพ์ตัวอักษร

---

## 11. Keybind / ปุ่มลัด

```lua
local row, getKey, setKey = Library:CreateKeybind(section, {
    Name = "ปุ่มเปิด/ปิดเมนู",
    Default = Enum.KeyCode.F,
    Icon = Library.Icons.Keybind,
    Order = 5,
    Callback = function(keyCode)
        print("กดปุ่ม:", keyCode.Name)
    end,
})
```

ตัวเลือก:

- `Name`
- `Default`: ต้องเป็น `Enum.KeyCode` เช่น `Enum.KeyCode.F`
- `Icon`
- `Order`
- `Callback(keyCode)`: ทำงานเมื่อผู้ใช้กดปุ่มที่ตั้งไว้

ค่าที่คืนกลับ:

```lua
local currentKey = getKey()
setKey(Enum.KeyCode.G)
```

การเปลี่ยนปุ่ม: กดปุ่ม Keybind ใน UI แล้วกดคีย์ใหม่ ระบบจะแสดง `...` ระหว่างรอรับคีย์

> Callback จะไม่ทำงานถ้าเกมกำลังใช้คีย์นั้นกับ TextBox/ระบบที่ถือว่าเป็น GameProcessed

---

## 12. Dropdown / รายการตัวเลือก

```lua
local wrapper, getMode, setMode = Library:CreateDropdown(section, {
    Name = "โหมดการทำงาน",
    Options = {"ปกติ", "เร็ว", "ปลอดภัย"},
    Default = "ปกติ",
    Icon = Library.Icons.Settings,
    Order = 6,
    Callback = function(value)
        print("เลือก:", value)
    end,
})
```

ตัวเลือก:

- `Name`: ชื่อ Dropdown
- `Options`: ตาราง Array ของตัวเลือก
- `Default`: ค่าที่เลือกตอนเริ่มต้น ถ้าไม่ระบุจะใช้ `Options[1]`
- `Icon`
- `Order`
- `Callback(value)`: เรียกเมื่อเลือกตัวเลือก

ค่าที่คืนกลับ:

```lua
print(getMode())
setMode("เร็ว")
```

ตัวเลือกควรเป็น string หรือค่าที่แปลงเป็นข้อความได้ เพราะข้อความบนปุ่มใช้ `tostring`

---

## 13. Label และ Paragraph

### Label

เหมาะกับข้อความสั้นหนึ่งบรรทัด:

```lua
local label = Library:CreateLabel(section, {
    Text = "สถานะ: พร้อมใช้งาน",
    Color = Library.Theme.Success,
    Size = 13,
    Height = 26,
    Bold = true,
    Align = Enum.TextXAlignment.Left,
    Order = 7,
})
```

ตัวเลือก:

- `Text`: ข้อความ
- `Color`: สีข้อความ ค่าเริ่มต้น `Theme.Text`
- `Size`: ขนาดตัวอักษร ค่าเริ่มต้น `12`
- `Height`: ความสูง ค่าเริ่มต้น `22`
- `Bold`: ใช้ตัวหนาหรือไม่
- `Align`: การจัดแนวข้อความ
- `Order`: ลำดับ

คืนค่าเป็น `TextLabel` ของ Roblox จึงแก้ได้โดยตรง:

```lua
label.Text = "สถานะ: เสร็จแล้ว"
label.TextColor3 = Library.Theme.Success
```

### Paragraph

เหมาะกับคำอธิบายหลายบรรทัดและจะปรับความสูงตามข้อความอัตโนมัติ:

```lua
local paragraph = Library:CreateParagraph(section, {
    Text = "คำอธิบายระบบ... สามารถมีข้อความยาวและขึ้นบรรทัดใหม่ได้",
    Color = Library.Theme.TextMuted,
    Size = 12,
    Order = 8,
})
```

ตัวเลือกคือ `Text`, `Color`, `Size`, `Order` และคืนค่าเป็น `TextLabel`

---

## 14. PlayerList / รายชื่อผู้เล่น

```lua
local playerList, rebuildPlayers, getSelectedPlayer = Library:CreatePlayerList(section, {
    AccentColor = Library.Theme.Accent,
    Order = 9,
    OnSelect = function(player)
        print("เลือกผู้เล่น:", player.Name, player.UserId)
    end,
})
```

ความสามารถของรายการ:

- แสดงผู้เล่นอื่นทั้งหมด ยกเว้น LocalPlayer
- เรียงตาม DisplayName/Name
- แสดง Avatar, DisplayName, Username และเลือด
- อัปเดตเลือดเมื่อ Humanoid.HealthChanged
- สร้างรายการใหม่เมื่อผู้เล่นเกิดใหม่

ค่าที่คืนกลับ:

```lua
rebuildPlayers()             -- สร้างรายการใหม่ตาม Players:GetPlayers()
local player = getSelectedPlayer() -- คืน Player ที่เลือก หรือ nil
```

ตัวเลือก:

- `AccentColor`: สีของการ์ดที่ถูกเลือก
- `Order`: ลำดับ
- `OnSelect(player)`: Callback เมื่อกดผู้เล่น

---

## 15. Notification / การแจ้งเตือน

```lua
Library:Notify({
    Title = "สำเร็จ",
    Message = "บันทึกข้อมูลเรียบร้อยแล้ว",
    Duration = 3,
    Color = Library.Theme.Success,
    Icon = Library.Icons.Correct,
})
```

ตัวเลือก:

| ตัวเลือก | ชนิด | ค่าเริ่มต้น |
|---|---|---:|
| `Title` | string | `"แจ้งเตือน"` |
| `Message` | string | `""` |
| `Duration` | number | `3` วินาที |
| `Color` | Color3 | `Theme.Accent` |
| `Icon` | icon function | `Icons.Home` |

ตัวอย่างแจ้งเตือนแต่ละประเภท:

```lua
Library:Notify({
    Title = "สำเร็จ",
    Message = "เปิดใช้งานแล้ว",
    Color = Library.Theme.Success,
    Icon = Library.Icons.Correct,
})

Library:Notify({
    Title = "คำเตือน",
    Message = "ไม่พบข้อมูล",
    Color = Library.Theme.Warning,
    Icon = Library.Icons.Thunder,
})

Library:Notify({
    Title = "ผิดพลาด",
    Message = "ไม่สามารถดำเนินการได้",
    Color = Library.Theme.Danger,
    Icon = Library.Icons.Cross,
})
```

ระบบรองรับการเข้าคิว และแสดงพร้อมกันได้สูงสุดตาม `Library.Config.MaxNotifications` ซึ่งค่าเริ่มต้นคือ 4 รายการ

---

## 16. เปิด/ซ่อน/ทำลาย UI

```lua
Library:Show()     -- แสดงหน้าต่างหลัก
Library:Hide()     -- ซ่อนหน้าต่าง เหลือปุ่มโลโก้ลอย
Library:Destroy()  -- ปิดและล้าง Connections/GUI ทั้งหมด
```

ปุ่มโลโก้ลอยสามารถกดเพื่อเปิด/ปิดหน้าต่าง และลากไปยังตำแหน่งอื่นได้

บน Desktop ค่าเริ่มต้นใช้ `RightShift` เปิด/ปิด UI ส่วน Mobile ใช้การแตะโลโก้

> หลังเรียก `Destroy()` ไม่ควรใช้ Callback หรืออ้างอิงคอมโพเนนต์เดิมต่อ

---

## 17. ปุ่มลัดหลักของหน้าต่าง

```lua
local ok = Library:SetToggleKey(Enum.KeyCode.RightControl)
local key = Library:GetToggleKey()
print(key.Name)
```

`SetToggleKey` จะคืน `true` เมื่อรับค่าเป็น `Enum.KeyCode` ที่ถูกต้อง และคืน `false` หากส่งชนิดอื่น:

```lua
print(Library:SetToggleKey(Enum.KeyCode.F4)) -- true
print(Library:SetToggleKey("F4"))            -- false
```

---

## 18. Theme และ Config

ไลบรารีเปิดตารางให้ปรับแต่งได้โดยตรง:

```lua
Library.Theme.Accent = Color3.fromRGB(255, 80, 160)
Library.Theme.Background = Color3.fromRGB(15, 15, 20)
```

สีสำคัญใน `Library.Theme`:

```lua
Background, Surface, SurfaceAlt, SurfaceHover
Accent, AccentSoft, AccentLight
Text, TextMuted, Border
Success, Danger, Warning
SwitchOff, Shadow, White, IconDim
```

ค่าที่สำคัญใน `Library.Config`:

```lua
Library.Config.WindowSize       = Vector2.new(600, 420)
Library.Config.WindowMinSize    = Vector2.new(420, 300)
Library.Config.SidebarWidth    = 156
Library.Config.HeaderHeight    = 52
Library.Config.RowHeight       = 50
Library.Config.MaxNotifications = 4
```

การแก้ `Config` บางรายการมีผลกับการสร้าง/ปรับขนาดในภายหลัง ส่วนสีที่ UI ผูกกับ Theme จะอัปเดตได้ผ่านระบบตั้งค่าของ UI

---

## 19. Settings / การบันทึกการตั้งค่า GUI

```lua
local settings = Library.Settings
```

เมธอดทั้งหมด:

```lua
settings.Get()                 -- อ่านข้อมูลการตั้งค่าปัจจุบัน
settings.Save()                -- บันทึกลงไฟล์
settings.Load()                -- โหลดจากไฟล์
settings.Reset()               -- คืนค่าเริ่มต้น
settings.Apply(data)           -- นำตารางข้อมูลมาใช้
settings.GetStorageAvailable() -- มี isfile/readfile/writefile หรือไม่
```

ข้อมูลหลักที่จัดเก็บ:

- `UserScale`
- `TextScale`
- `FontWeight`
- สีของ Theme ที่รองรับ

ชื่อไฟล์เริ่มต้น:

```lua
Library.Settings.FileName -- "RUNLUA_HUB_SETTINGS.json"
Library.Settings.Version  -- 4
```

ตัวอย่าง:

```lua
local data = Library.Settings.Get()
print(data.TextScale, data.FontWeight)

local ok, message = Library.Settings.Save()
print(ok, message)
```

การบันทึกถาวรต้องอาศัยฟังก์ชันสภาพแวดล้อม เช่น `isfile`, `readfile`, `writefile` หากไม่มี ไลบรารีจะแจ้งว่าไม่สามารถบันทึกเป็นไฟล์ถาวรได้

แท็บ `ตั้งค่า GUI` ที่ไลบรารีสร้างมาให้โดยอัตโนมัติ รองรับ:

- ขนาดตัวอักษร ปกติ ×1 / กลาง ×2 / ใหญ่ ×3
- ความหนาอักษร Regular, Medium, SemiBold, Bold, ExtraBold, Heavy
- ชุดสี น้ำเงินฟ้า, ม่วงไฟฟ้า, เขียวมรกต, แดงคริมสัน, ทอง, ขาวดำ
- สีหลักและสีพื้นหลัง
- บันทึก/โหลด/รีเซ็ต

---

## 20. UILock และการโหลดซ้ำ

ไลบรารีมีระบบ Lock เพื่อป้องกัน UI หลายอินสแตนซ์แย่งกันควบคุม หากโหลดสคริปต์ใหม่ ระบบจะพยายาม Cleanup อินสแตนซ์เดิมก่อน

ตรวจสอบสถานะ:

```lua
print(Library.UILock.IsOwner())
print(Library.UILock.GetOwner())
print(Library.UILock.SessionId)
```

เมธอด:

```lua
Library.UILock.Acquire() -- ขอสิทธิ์ควบคุม UI
Library.UILock.Release() -- ปล่อยสิทธิ์
```

ถ้าไม่ใช่เจ้าของ การกด/ลาก/ปรับขนาดบางส่วนจะถูกปิดไว้จนกว่าเจ้าของเดิมจะปล่อย Lock หรือหมดเวลา

---

## 21. ตรวจสอบแพลตฟอร์มและอ้างอิง GUI

```lua
print(Library.IsMobile) -- true/false
print(Library.Platform) -- เช่น Android, IOS, Windows
```

อ้างอิง Roblox Instances หลัก:

```lua
local screenGui = Library.ScreenGui
local mainFrame = Library.MainFrame
local settingsTab = Library.SettingsTab
local allTabs = Library.Tabs
```

ใช้สำหรับงานขั้นสูง เช่น ปรับตำแหน่ง ตรวจสอบสถานะ Visible หรือเพิ่มองค์ประกอบ Roblox ของตนเอง

---

## 22. ตัวอย่างโปรเจกต์แบบครบชุด

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
))()

local enabled = false
local speed = 16

local home = Library:CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
    Order = 1,
})

local general = Library:CreateSection(home.Page, {
    Title = "ทั่วไป",
    Order = 1,
})

Library:CreateParagraph(general, {
    Text = "ตัวอย่างการสร้าง UI ด้วย RUNLUA HUB Library",
    Size = 12,
})

local _, getToggle, setToggle = Library:CreateToggle(general, {
    Name = "เปิดระบบ",
    Description = "เปิดหรือปิดระบบตัวอย่าง",
    Default = false,
    Icon = Library.Icons.Settings,
    Callback = function(value)
        enabled = value
        Library:Notify({
            Title = value and "เปิดใช้งาน" or "ปิดใช้งาน",
            Message = "สถานะระบบถูกเปลี่ยนแล้ว",
            Color = value and Library.Theme.Success or Library.Theme.Warning,
            Icon = value and Library.Icons.Correct or Library.Icons.Cross,
        })
    end,
})

Library:CreateSlider(general, {
    Name = "ความเร็ว",
    Min = 1,
    Max = 100,
    Step = 1,
    Default = speed,
    Suffix = "%",
    Icon = Library.Icons.Run,
    Callback = function(value)
        speed = value
    end,
})

Library:CreateDropdown(general, {
    Name = "โหมด",
    Options = {"ปกติ", "เร็ว", "ประหยัด"},
    Default = "ปกติ",
    Icon = Library.Icons.Settings,
    Callback = function(value)
        print("โหมด:", value)
    end,
})

Library:CreateInput(general, {
    Name = "ข้อความ",
    Placeholder = "พิมพ์ข้อความ...",
    Icon = Library.Icons.Pencil,
    Callback = function(text)
        print("ข้อความ:", text)
    end,
})

Library:CreateButton(general, {
    Name = "ทดสอบแจ้งเตือน",
    Description = "กดเพื่อทดสอบระบบ Notification",
    Icon = Library.Icons.Home,
    Color = Library.Theme.Accent,
    Callback = function()
        Library:Notify({
            Title = "ทดสอบ",
            Message = "Notification ทำงานแล้ว",
            Duration = 3,
            Color = Library.Theme.Accent,
            Icon = Library.Icons.Home,
        })
    end,
})

local tools = Library:CreateTab({
    Name = "เครื่องมือ",
    Icon = Library.Icons.Settings,
    Order = 2,
})

local toolSection = Library:CreateSection(tools.Page, {
    Title = "คำสั่ง",
    Order = 1,
})

Library:CreateKeybind(toolSection, {
    Name = "ปุ่มลัดตัวอย่าง",
    Default = Enum.KeyCode.F,
    Callback = function(keyCode)
        if getToggle() then
            print("ทำงานด้วย", keyCode.Name)
        end
    end,
})

Library:CreateDivider(tools.Page, 2)

Library:CreateButton(toolSection, {
    Name = "ซ่อน UI",
    Icon = Library.Icons.Minimize,
    Callback = function()
        Library:Hide()
    end,
})
```

> หากไอคอนชื่อใดไม่มีในเวอร์ชันที่ใช้งาน ให้เปลี่ยนเป็นไอคอนที่มีแน่นอน เช่น `Library.Icons.Home`, `Settings`, `Pencil` หรือ `Action`

---

## 23. ตาราง API สรุป

| API | ใช้สำหรับ | Callback |
|---|---|---|
| `CreateTab` | สร้างแท็บ | ไม่มี |
| `CreateSection` | จัดกลุ่มคอมโพเนนต์ | ไม่มี |
| `CreateDivider` | เส้นแบ่ง | ไม่มี |
| `CreateToggle` | เปิด/ปิด | `boolean` |
| `CreateButton` | ปุ่มกด | ไม่มีอาร์กิวเมนต์ |
| `CreateSlider` | เลื่อนค่าตัวเลข | `number` |
| `CreateNumberInput` | กรอกค่าตัวเลข | `number` |
| `CreateInput` | กรอกข้อความ | `string` |
| `CreateKeybind` | ตั้งปุ่มลัด | `Enum.KeyCode` |
| `CreateDropdown` | เลือกจากรายการ | ค่าที่เลือก |
| `CreateLabel` | ข้อความสั้น | ไม่มี |
| `CreateParagraph` | ข้อความหลายบรรทัด | ไม่มี |
| `CreatePlayerList` | เลือกผู้เล่น | `Player` |
| `Notify` | แจ้งเตือน | ไม่มี |
| `Show` / `Hide` | แสดง/ซ่อน UI | ไม่มี |
| `Destroy` | ล้าง UI และ Connections | ไม่มี |
| `SelectTab` | เลือกแท็บ | ไม่มี |
| `SetToggleKey` | ตั้งปุ่มเปิด/ปิด UI | ไม่มี |

---

## 24. ข้อควรระวังและแนวทางแก้ปัญหา

### UI ไม่แสดง

ตรวจสอบว่า Loader คืนค่าไม่เป็น `nil` และสคริปต์ทำงานหลังเกมสร้าง `LocalPlayer` แล้ว:

```lua
assert(Library, "โหลด UI Library ไม่สำเร็จ")
```

### ปุ่มกดไม่ได้

ตรวจสอบว่าเป็นเจ้าของ UILock หรือไม่:

```lua
print(Library.UILock.IsOwner())
```

ถ้าเป็น `false` ให้รออินสแตนซ์เดิมปล่อย Lock หรือเรียก `Library.UILock.Acquire()` เมื่อเหมาะสม

### บันทึกการตั้งค่าไม่ได้

ตรวจสอบความสามารถของสภาพแวดล้อม:

```lua
print(Library.Settings.GetStorageAvailable())
```

ถ้าเป็น `false` ระบบยังใช้งานได้ แต่การตั้งค่าจะไม่คงอยู่หลังเริ่มใหม่

### Callback ทำให้สคริปต์หยุด

ไลบรารีป้องกัน Callback หลายจุดด้วย `pcall` แต่ควรเขียน Callback ให้ปลอดภัยและตรวจสอบตัวแปรก่อนใช้งาน:

```lua
Callback = function(value)
    local ok, err = pcall(function()
        -- โค้ดของคุณ
    end)
    if not ok then
        warn(err)
    end
end
```

### ควรเรียก Destroy เมื่อใด

เรียกเมื่อจะปิดระบบถาวรหรือกำลังโหลด UI เวอร์ชันใหม่ เพื่อหยุด Connections และล้างองค์ประกอบเดิม:

```lua
Library:Destroy()
```

---

**สรุป:** API หลักของไลบรารีอยู่ใน `Library` ตารางเดียว โดยใช้ `CreateTab` → `CreateSection` → คอมโพเนนต์ และใช้ Callback เชื่อมเข้ากับระบบของโปรเจกต์ ส่วน `Settings`, `UILock`, `Theme`, `Config` และเมธอดควบคุมหน้าต่างใช้สำหรับงานขั้นสูงและการดูแลสถานะ UI

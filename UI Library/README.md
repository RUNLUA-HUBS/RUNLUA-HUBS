# RUNLUA HUB UI Library — README

คู่มือการใช้งานไลบรารี UI สำหรับ Roblox Luau  
เอกสารนี้อ้างอิงจาก โหลดAPI ไลบราลี่ จาก https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua เวอร์ชันที่ให้มา

## สารบัญ

1. [ภาพรวม](#ภาพรวม)
2. [เริ่มต้นใช้งาน](#เริ่มต้นใช้งาน)
3. [ระบบแท็บและ Section](#ระบบแท็บและ-section)
4. [คอมโพเนนต์ทั้งหมด](#คอมโพเนนต์ทั้งหมด)
5. [ระบบคีย์ลัด](#ระบบคีย์ลัด)
6. [เปิด/ซ่อน GUI และการลากหน้าต่าง](#เปิดซ่อน-gui-และการลากหน้าต่าง)
7. [การแจ้งเตือน](#การแจ้งเตือน)
8. [Theme และ Config](#theme-และ-config)
9. [การตั้งค่าและบันทึกข้อมูล](#การตั้งค่าและบันทึกข้อมูล)
10. [Player List](#player-list)
11. [จัดการไลบรารีและ Cleanup](#จัดการไลบรารีและ-cleanup)
12. [ตัวอย่างโปรเจกต์](#ตัวอย่างโปรเจกต์)
13. [ข้อควรทราบและการแก้ปัญหา](#ข้อควรทราบและการแก้ปัญหา)

---

## ภาพรวม

ไลบรารีนี้สร้างหน้าต่าง UI ธีมสีน้ำเงินเข้ม มี Sidebar สำหรับเปลี่ยนแท็บ, หน้าคอนเทนต์แบบเลื่อน, ปุ่ม Toggle, Button, Slider, Input, Keybind, Dropdown, Label, Paragraph และ Player List

ความสามารถที่มีในซอร์ส:
- สร้างแท็บและ Section เพื่อจัดกลุ่ม UI
- ปุ่ม Toggle พร้อม callback เมื่อเปิด/ปิด
- ปุ่ม Button สำหรับเรียก callback
- Slider ที่กำหนด Min, Max, Step และ Suffix ได้
- Input สำหรับรับข้อความ
- Keybind ที่ตั้งคีย์ใหม่ได้จาก UI
- Dropdown สำหรับเลือกค่าจากรายการ
- Label และ Paragraph สำหรับแสดงข้อความ
- Player List แสดงผู้เล่นอื่นพร้อม Avatar และข้อมูลเลือด
- Notification แบบเข้าคิว
- ปุ่มลอยโลโก้ (Toggle Pill) สำหรับเปิด/ซ่อนหน้าต่าง และลากตำแหน่งได้
- คีย์ลัดเปิด/ซ่อน GUI บน PC และตั้งคีย์ใหม่ได้
- หน้า Settings สำหรับปรับหน้าตา/การตั้งค่าที่ไลบรารีรองรับ
- API สำหรับ Get/Save/Load/Reset/Apply ค่าตั้งค่า
- Cleanup connections และลบ UI เมื่อสั่ง Destroy

> หมายเหตุ: README นี้อธิบาย API ที่พบในไฟล์เท่านั้น ไม่ได้ยืนยันว่าทุกฟังก์ชันได้ผ่านการทดสอบใน Roblox Studio หรือทุก executor

## เริ่มต้นใช้งาน

นำไฟล์ไลบรารีไปไว้ในตำแหน่งที่สคริปต์ของคุณเข้าถึงได้ แล้วโหลดให้ได้ค่า `Library` ก่อนเรียก API ตัวอย่างนี้ใช้ `loadstring`/`game:HttpGet` ซึ่งใช้ได้เฉพาะสภาพแวดล้อมที่อนุญาตให้เรียกใช้งานรูปแบบดังกล่าว และ URL ต้องชี้ไปยังไฟล์ Lua จริง

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"))()
```

หากคุณจัดเก็บไฟล์ไว้ใน ModuleScript ของโปรเจกต์ Roblox ให้ใช้ `require(ModuleScript)` แทนตามโครงสร้างโปรเจกต์ของคุณ

### สร้างแท็บและเพิ่มปุ่มแรก

```lua
local Library = loadstring(game:HttpGet("RAW_URL_ของไฟล์ไลบรารี"))()

local MainTab = Library.CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local Section = Library.CreateSection(MainTab.Page, {
    Name = "MainSection",
    Title = "เมนูหลัก",
})

Library.CreateButton(Section, {
    Name = "ทดสอบ",
    Description = "กดเพื่อแสดงข้อความแจ้งเตือน",
    Callback = function()
        Library.Notify({
            Title = "RUNLUA HUB",
            Message = "ปุ่มทำงานแล้ว!",
            Duration = 3,
        })
    end,
})
```

`CreateTab()` คืนค่าเป็นตารางแท็บ ซึ่งมี `Page` สำหรับวางคอมโพเนนต์ลงในหน้าของแท็บนั้น ส่วน `CreateSection()` คืนค่า Frame ที่ใช้เป็น parent ของคอมโพเนนต์

---

## ระบบแท็บและ Section

### `Library.CreateTab(opts)`

สร้างแท็บใหม่และคืนค่าตารางแท็บ

| ตัวเลือก | ชนิด | ความหมาย |
|---|---|---|
| `Name` | string | ชื่อแท็บ |
| `Icon` | function | ฟังก์ชันวาดไอคอน เช่น `Library.Icons.Home` |
| `Order` | number | ลำดับแท็บใน Sidebar |
| `IsSettings` | boolean | ใช้ทำแท็บประเภท Settings; ปกติไม่จำเป็นต้องตั้งเอง |

ตัวอย่าง:

```lua
local FarmTab = Library.CreateTab({
    Name = "ฟาร์ม",
    Icon = Library.Icons.Run,
    Order = 1,
})
```

ค่าที่คืนมามี `Name`, `Index`, `Page`, `Button`, `Indicator`, `Label`, `IconHolder` และ `IsSettings`

เปลี่ยนแท็บด้วย:

```lua
Library.SelectTab(FarmTab)
```

### `Library.CreateSection(parent, opts)`

สร้างกลุ่มคอมโพเนนต์ในหน้าแท็บหรือใน parent ที่เป็น GUI object

| ตัวเลือก | ชนิด | ความหมาย |
|---|---|---|
| `Name` | string | ชื่อ Section |
| `Title` | string | หัวข้อที่แสดงด้านบน |
| `Order` | number | ลำดับการแสดง |

```lua
local Section = Library.CreateSection(FarmTab.Page, {
    Name = "FarmOptions",
    Title = "ตั้งค่าการฟาร์ม",
    Order = 1,
})
```

### `Library.CreateDivider(parent, order)`

สร้างเส้นคั่นแนวนอน:

```lua
Library.CreateDivider(Section, 10)
```

---

## คอมโพเนนต์ทั้งหมด

คอมโพเนนต์ด้านล่างส่วนใหญ่รับ `parent` เป็นอาร์กิวเมนต์แรก และตาราง `opts` เป็นอาร์กิวเมนต์ที่สอง

### 1. Toggle — `Library.CreateToggle(parent, opts)`

สวิตช์เปิด/ปิด คืนค่า 3 ค่า: `row`, `getValue`, `setValue`

ตัวเลือก:
- `Name`: ชื่อสวิตช์
- `Description`: คำอธิบาย (ไม่ใส่ก็ได้)
- `Default`: ค่าเริ่มต้นแบบ boolean
- `Callback`: ฟังก์ชันที่ถูกเรียกพร้อมสถานะ `true`/`false`
- `Icon`: ฟังก์ชันวาดไอคอน
- `Order`: ลำดับ

```lua
local ToggleRow, GetEnabled, SetEnabled = Library.CreateToggle(Section, {
    Name = "เปิดระบบตัวอย่าง",
    Description = "เปิดหรือปิดระบบนี้",
    Default = false,
    Callback = function(enabled)
        print("สถานะ:", enabled)
    end,
})

-- อ่านค่า
print(GetEnabled())

-- เปลี่ยนค่าโดยโค้ด
SetEnabled(true)
```

ข้อสำคัญ: `SetEnabled(value)` อัปเดตสถานะและภาพของ Toggle แต่ในซอร์สปัจจุบันไม่ได้เรียก `Callback` เมื่อเปลี่ยนค่าผ่าน setter

### 2. Button — `Library.CreateButton(parent, opts)`

ปุ่มเรียกใช้งาน callback คืนค่า `row`

ตัวเลือก:
- `Name`: ชื่อปุ่ม
- `Description`: คำอธิบาย (ไม่ใส่ก็ได้)
- `Callback`: ฟังก์ชันที่เรียกเมื่อกด
- `Color`: สีเน้นของปุ่ม
- `Icon`: ฟังก์ชันวาดไอคอน
- `Order`: ลำดับ

```lua
Library.CreateButton(Section, {
    Name = "ทำงาน",
    Description = "เรียกการทำงานหนึ่งครั้ง",
    Callback = function()
        print("Button clicked")
    end,
})
```

### 3. Slider — `Library.CreateSlider(parent, opts)`

แถบเลื่อนตัวเลข คืนค่า `row`, `getValue`, `setValue`

ตัวเลือก:
- `Name`: ชื่อ
- `Min`: ค่าต่ำสุด (ค่าเริ่มต้น 0)
- `Max`: ค่าสูงสุด (ค่าเริ่มต้น 100)
- `Step`: ระยะการเพิ่ม/ลด (ค่าเริ่มต้น 1)
- `Default`: ค่าเริ่มต้น
- `Suffix`: ข้อความต่อท้ายค่า เช่น `%` หรือ ` studs`
- `Format`: ฟังก์ชันกำหนดข้อความแสดงผล รับค่าแล้วคืน string
- `Callback`: เรียกเมื่อค่าถูกเปลี่ยน
- `Icon`: ฟังก์ชันวาดไอคอน
- `Order`: ลำดับ

```lua
local SliderRow, GetSpeed, SetSpeed = Library.CreateSlider(Section, {
    Name = "ความเร็ว",
    Min = 1,
    Max = 100,
    Step = 1,
    Default = 16,
    Suffix = "",
    Callback = function(value)
        print("ค่าปัจจุบัน:", value)
    end,
})

print(GetSpeed())
SetSpeed(25)
```

`SetSpeed(value)` จำกัดค่าให้อยู่ระหว่าง Min และ Max และอัปเดตภาพ/ค่า แต่ไม่เรียก callback ตามโค้ดปัจจุบัน

### 4. Input — `Library.CreateInput(parent, opts)`

ช่องรับข้อความ คืนค่า `row`, `getText`, `setText`

ตัวเลือก:
- `Name`: ชื่อช่อง
- `Placeholder`: ข้อความตัวอย่างในช่อง
- `Default`: ข้อความเริ่มต้น
- `ClearOnFocus`: ล้างข้อความเมื่อเลือกช่อง
- `Callback`: เรียกเมื่อช่องเสีย Focus (เช่น กด Enter หรือคลิกออก ตามพฤติกรรม TextBox)
- `Icon`: ฟังก์ชันวาดไอคอน
- `Order`: ลำดับ

```lua
local InputRow, GetText, SetText = Library.CreateInput(Section, {
    Name = "ชื่อผู้เล่น",
    Placeholder = "พิมพ์ชื่อ...",
    Default = "",
    ClearOnFocus = false,
    Callback = function(text)
        print("ข้อความ:", text)
    end,
})

SetText("Example")
print(GetText())
```

### 5. Keybind — `Library.CreateKeybind(parent, opts)`

สร้างช่องตั้งคีย์ลัดสำหรับฟังก์ชันที่คุณกำหนดเอง คืนค่า `row`, `getKey`, `setKey`

ตัวเลือก:
- `Name`: ชื่อคีย์ลัด
- `Default`: คีย์เริ่มต้น เช่น `Enum.KeyCode.E`
- `Callback`: ฟังก์ชันที่เรียกเมื่อกดคีย์ที่ตั้งไว้
- `Icon`: ฟังก์ชันวาดไอคอน
- `Order`: ลำดับ

```lua
local KeyRow, GetKey, SetKey = Library.CreateKeybind(Section, {
    Name = "เปิดระบบตัวอย่าง",
    Default = Enum.KeyCode.E,
    Callback = function(keyCode)
        print("กดคีย์:", keyCode.Name)
        -- เรียกเฉพาะฟังก์ชันที่ต้องการให้คีย์นี้ควบคุม
    end,
})

-- อ่านคีย์ที่เลือก
print(GetKey().Name)

-- ตั้งคีย์ผ่านโค้ด
SetKey(Enum.KeyCode.F)
```

วิธีเปลี่ยนคีย์จาก UI: คลิกปุ่มที่แสดงชื่อคีย์ จากนั้นกดคีย์บอร์ดที่ต้องการเพื่อบันทึกคีย์ใหม่

**ระบบนี้ไม่ผูกคีย์ลัดให้ทุกฟังก์ชันโดยอัตโนมัติ** แต่ละ `CreateKeybind` จะเรียกเฉพาะ `Callback` ที่กำหนดให้กับ Keybind ตัวนั้นเท่านั้น จึงควรสร้าง Keybind เฉพาะฟังก์ชันที่ต้องการให้มีคีย์ลัด

หมายเหตุจากโค้ด: handler คีย์ลัดตรวจ `gameProcessed` (`gp`) และจะไม่เรียก callback เมื่อ Roblox หรือ UI อื่นประมวลผล input นั้นไปแล้ว

### 6. Dropdown — `Library.CreateDropdown(parent, opts)`

รายการตัวเลือกแบบกดเพื่อเปิด/ปิดรายการ คืนค่า `wrapper`, `getValue`, `setValue`

ตัวเลือก:
- `Name`: ชื่อรายการ
- `Options`: array ของค่าที่เลือกได้
- `Default`: ค่าเริ่มต้น (หากไม่ระบุจะใช้ตัวเลือกแรก)
- `Callback`: เรียกพร้อมค่าที่เลือก
- `Icon`: ฟังก์ชันวาดไอคอน
- `Order`: ลำดับ

```lua
local DropdownRow, GetChoice, SetChoice = Library.CreateDropdown(Section, {
    Name = "โหมด",
    Options = {"ปกติ", "เร็ว", "ประหยัด"},
    Default = "ปกติ",
    Callback = function(choice)
        print("เลือก:", choice)
    end,
})

print(GetChoice())
SetChoice("เร็ว")
```

`SetChoice(value)` เปลี่ยนค่าที่แสดง แต่ไม่ได้เรียก callback ตามโค้ดปัจจุบัน ควรใช้ค่าที่มีอยู่ใน `Options`

### 7. Label — `Library.CreateLabel(parent, opts)`

ข้อความสั้น ๆ แบบบรรทัดเดียว คืนค่า TextLabel

ตัวเลือก:
- `Text`: ข้อความ
- `Color`: สีข้อความ
- `Size`: ขนาดข้อความ
- `Height`: ความสูง
- `Bold`: `true` เพื่อใช้ตัวหนา
- `Align`: เช่น `Enum.TextXAlignment.Left`, `.Center`, `.Right`
- `Order`: ลำดับ

```lua
local StatusLabel = Library.CreateLabel(Section, {
    Text = "สถานะ: พร้อม",
    Size = 12,
    Height = 18,
    Bold = true,
    Color = Library.Theme.Success,
})
```

เปลี่ยนข้อความภายหลังได้ด้วย `StatusLabel.Text = "ข้อความใหม่"`

### 8. Paragraph — `Library.CreateParagraph(parent, opts)`

ข้อความหลายบรรทัดที่ตัดบรรทัดอัตโนมัติ คืนค่า TextLabel

ตัวเลือก:
- `Text`: ข้อความ
- `Color`: สีข้อความ
- `Size`: ขนาดข้อความ
- `Order`: ลำดับ

```lua
local Info = Library.CreateParagraph(Section, {
    Text = "ข้อความอธิบายระบบนี้ สามารถยาวได้และตัดบรรทัดอัตโนมัติ",
    Size = 11,
    Color = Library.Theme.TextMuted,
})
```

เปลี่ยนข้อความภายหลังได้ด้วย `Info.Text = "ข้อความใหม่"`

### 9. Player List — `Library.CreatePlayerList(parent, opts)`

สร้างรายชื่อผู้เล่นอื่นในเซิร์ฟเวอร์พร้อมรูป Avatar, Display Name, Username และแถบเลือดตามข้อมูลตัวละคร คืนค่า wrapper ของรายการ

ตัวเลือกที่พบในซอร์ส:
- `OnSelect`: callback เมื่อเลือกผู้เล่น โดยรับผู้เล่น (`Player`) ที่เลือก
- `AccentColor`: สีเน้นสำหรับผู้เล่นที่ถูกเลือก
- `Order`: ลำดับ

```lua
local PlayerList = Library.CreatePlayerList(Section, {
    AccentColor = Library.Theme.Accent,
    OnSelect = function(player)
        if player then
            print("เลือกผู้เล่น:", player.Name, player.UserId)
        end
    end,
})
```

รายการสร้างจาก `Players:GetPlayers()` และไม่นำ LocalPlayer มาแสดง รายการอัปเดตตามการเข้าร่วม/ออกจากเซิร์ฟเวอร์ตาม connections ภายในคอมโพเนนต์ โปรดใช้ `OnSelect` เพื่อเก็บผู้เล่นที่ผู้ใช้เลือก ไม่ควรสมมติว่า `CreatePlayerList` คืนค่า `getSelectedPlayer` เพราะซอร์สคืนค่าเป็น wrapper เท่านั้น

---

## ระบบคีย์ลัด

มีคีย์ลัดอยู่ 2 ประเภท แยกจากกันชัดเจน:

1. **คีย์ลัดเปิด/ซ่อนหน้าต่างหลัก** — ตั้งผ่าน `Library.SetToggleKey(...)`
2. **คีย์ลัดเฉพาะฟังก์ชัน** — สร้างด้วย `Library.CreateKeybind(...)` และกำหนด `Callback` ของฟังก์ชันนั้น

### เปลี่ยนคีย์ลัด GUI

คีย์เริ่มต้นของ GUI ในไฟล์นี้คือ `RightShift`

```lua
-- เปลี่ยนเป็น RightControl
local ok = Library.SetToggleKey(Enum.KeyCode.RightControl)

-- อ่านคีย์ปัจจุบัน
local currentKey = Library.GetToggleKey()
print(currentKey.Name)
```

`SetToggleKey` รับ `Enum.KeyCode` เท่านั้น หากส่งค่าไม่ถูกต้องจะคืน `false`; หากตั้งได้จะคืน `true`

### สร้างคีย์ลัดให้เฉพาะฟังก์ชันที่ต้องการ

```lua
Library.CreateKeybind(Section, {
    Name = "สลับโหมด",
    Default = Enum.KeyCode.G,
    Callback = function()
        -- ใส่เฉพาะการทำงานของฟังก์ชันนี้
        print("สลับโหมดแล้ว")
    end,
})
```

อย่าสร้าง `InputBegan` แยกซ้ำ ๆ ให้ทุกฟังก์ชันโดยไม่จำเป็น ใช้ `CreateKeybind` เพื่อให้ UI แสดงคีย์และผู้ใช้เปลี่ยนคีย์ได้จากปุ่มเดียวกัน

ข้อจำกัด: Keybind ปัจจุบันตรวจจับคีย์บอร์ดบน PC ไม่ใช่ระบบปุ่มสัมผัสบนมือถือ และ input ที่ `gameProcessed` เป็น `true` จะถูกข้าม

---

## เปิด/ซ่อน GUI และการลากหน้าต่าง

### API ที่ใช้ได้

```lua
Library.Show() -- แสดงหน้าต่างหลัก
Library.Hide() -- ซ่อนหน้าต่างหลัก แต่ปุ่มโลโก้ลอยยังอยู่
```

- PC: ค่าเริ่มต้นกด `RightShift` เพื่อเปิด/ซ่อน GUI
- เปลี่ยนปุ่มได้ด้วย `Library.SetToggleKey(Enum.KeyCode.RightControl)` เป็นต้น
- ปุ่มโลโก้ลอย (`TogglePill`) ใช้เปิด/ซ่อนหน้าต่างและลากย้ายตำแหน่งได้
- บน PC สามารถคลิกซ้ายค้างบริเวณโลโก้หรือพื้นที่ว่างของแถบด้านบนแล้วลากได้
- บนมือถือใช้การสัมผัสลากบริเวณที่กำหนด
- มุมขวาล่างของหน้าต่างมีจุดจับสำหรับปรับขนาด UI

อย่าลืมว่าปุ่มย่อหน้าต่างเป็นการซ่อนหน้าต่าง ไม่ใช่การทำลาย UI ส่วนปุ่มปิด (X) จะเรียก cleanup และทำลาย UI

---

## การแจ้งเตือน

### `Library.Notify(opts)`

แสดง Notification โดยจัดคิวและจำกัดจำนวนที่แสดงพร้อมกันตาม Config

ตัวเลือก:
- `Title`: หัวข้อ
- `Message`: เนื้อหา
- `Duration`: เวลาที่แสดง
- `Color`: สีเน้น
- `Icon`: ฟังก์ชันวาดไอคอน

```lua
Library.Notify({
    Title = "RUNLUA HUB",
    Message = "ทำงานสำเร็จ",
    Duration = 3.5,
    Color = Library.Theme.Success,
    Icon = Library.Icons.Correct,
})
```

หากไม่ระบุ จะใช้ค่าปริยายจากไลบรารี เช่น Title `RUNLUA HUB`, Duration 3 วินาที และสี Accent

---

## Theme และ Config

### `Library.Theme`

ตารางสีที่ UI ใช้ สามารถเปลี่ยนสีแล้วเรียกใช้กับคอมโพเนนต์ใหม่ได้ ตัวอย่าง:

```lua
Library.Theme.Accent = Color3.fromRGB(0, 170, 255)
Library.Theme.Background = Color3.fromRGB(8, 10, 18)
```

สีหลักที่มีในไฟล์:
`Background`, `Surface`, `SurfaceAlt`, `SurfaceHover`, `Accent`, `AccentSoft`, `AccentLight`, `Text`, `TextMuted`, `Border`, `Success`, `Danger`, `Warning`, `SwitchOff`, `Shadow`, `White`, `IconGradStart`, `IconGradEnd`, `IconGradAngle`, `IconDim`

ไลบรารีมีระบบผูกสีให้กับองค์ประกอบ UI และหน้า Settings มีตัวควบคุมธีมอยู่ด้วย อย่างไรก็ตาม การเปลี่ยนค่าในตาราง Theme ด้วยตัวเองหลังสร้าง UI แล้วไม่ได้รับประกันว่า UI ทุกชิ้นที่สร้างไปแล้วจะเปลี่ยนทันทีในทุกกรณี

### `Library.Config`

ค่าปรับแต่ง UI ภายใน เช่น:
- `WindowSize`, `WindowMinSize`
- `SidebarWidth`, `SidebarWidthCompact`, `CompactBreakpoint`
- `HeaderHeight`, `RowHeight`, `RowHeightDesc`, `RowSpacing`, `Padding`
- `CornerRadius`
- `AnimFast`, `AnimNormal`, `AnimSlow`
- `MaxNotifications`, `DragThreshold`, `ToggleDebounce`

```lua
print(Library.Config.WindowSize)
print(Library.Config.MaxNotifications)
```

ค่าเหล่านี้เป็นค่าระดับไลบรารี อย่าแก้โดยไม่เข้าใจผลกระทบต่อ Layout

### `Library.Icons`

ตารางฟังก์ชันวาดไอคอนที่ไลบรารีใช้ ตัวอย่างเช่น:

```lua
Icon = Library.Icons.Home
Icon = Library.Icons.Settings
Icon = Library.Icons.Run
Icon = Library.Icons.Pencil
Icon = Library.Icons.Correct
```

ใช้เฉพาะชื่อไอคอนที่มีจริงใน `Library.Icons` ของไฟล์ที่ใช้อยู่ หากส่งค่า `Icon` ให้คอมโพเนนต์ ต้องเป็นฟังก์ชันวาดไอคอนตามรูปแบบของไลบรารี ไม่ใช่ string หรือ Asset ID ตรง ๆ

---

## การตั้งค่าและบันทึกข้อมูล

ไลบรารีเปิด API ไว้ที่ `Library.Settings`

```lua
local Settings = Library.Settings

local data = Settings.Get()
print(data.Version)

local saved = Settings.Save()
local loaded = Settings.Load()
Settings.Reset()
Settings.Apply(data)
print(Settings.GetStorageAvailable())
```

เมธอดที่มี:
- `Get()` — รวบรวมค่าตั้งค่าปัจจุบันเป็น table
- `Save()` — บันทึกค่าตั้งค่าผ่านระบบ storage ที่ไลบรารีตรวจพบ
- `Load()` — โหลดข้อมูลตั้งค่าจาก storage ที่รองรับ
- `Reset()` — รีเซ็ตค่าตั้งค่าตามระบบของไลบรารี
- `Apply(data)` — นำ table ที่ส่งเข้ามาไปใช้เป็นค่าตั้งค่า คืนผลสำเร็จ/ไม่สำเร็จตามการตรวจสอบภายใน
- `GetStorageAvailable()` — ตรวจว่าพบ file storage ที่ไลบรารีใช้ได้หรือไม่
- `FileName` — ชื่อไฟล์ที่ใช้เก็บการตั้งค่า
- `Version` — เวอร์ชันโครงสร้างข้อมูลตั้งค่า

ข้อมูลที่รวบรวมมีค่าขนาดตัวอักษร, น้ำหนักฟอนต์, สี Theme และตำแหน่งหน้าต่าง/ปุ่มโลโก้ตามโครงสร้างที่เขียนไว้ในซอร์ส

**ข้อควรทราบ:** การบันทึกลงไฟล์ขึ้นกับความสามารถของสภาพแวดล้อมที่รันอยู่ หากไม่มี API file storage ที่ไลบรารีตรวจพบ การ Save/Load อาจไม่สามารถใช้ได้ ตรวจด้วย `Settings.GetStorageAvailable()` ก่อน อย่าถือว่าการตั้งค่าถูกบันทึกถาวรแล้วหากยังไม่ได้ตรวจผลลัพธ์

ตัวอย่างเช็กก่อนบันทึก:

```lua
if Library.Settings.GetStorageAvailable() then
    local ok = Library.Settings.Save()
    print("Save result:", ok)
else
    warn("สภาพแวดล้อมนี้ไม่มี file storage ที่ไลบรารีรองรับ")
end
```

---

## Player List

`CreatePlayerList` สร้างรายการผู้เล่นอื่นจากเซิร์ฟเวอร์ปัจจุบัน และแสดงข้อมูลพื้นฐานที่ UI อ่านได้ เช่น Avatar, Display Name, Username และเลือดของตัวละครเมื่อมี Humanoid

ตัวอย่างเลือกผู้เล่น:

```lua
local selectedPlayer

Library.CreatePlayerList(Section, {
    OnSelect = function(player)
        selectedPlayer = player
        if selectedPlayer then
            print(selectedPlayer.Name)
        end
    end,
})
```

ก่อนใช้ข้อมูลตัวละคร ควรตรวจสอบว่า `player.Character` และ `Humanoid` ยังมีอยู่ เพราะตัวละครอาจกำลังเกิดใหม่หรือไม่มี Humanoid ชั่วคราว

---

## จัดการไลบรารีและ Cleanup

API หลักที่คืนมาจากไฟล์:

| API | การทำงาน |
|---|---|
| `Library.Show()` | แสดงหน้าต่างหลัก |
| `Library.Hide()` | ซ่อนหน้าต่างหลัก |
| `Library.Destroy()` | ตัด connections ที่ไลบรารีติดตามและทำลาย ScreenGui |
| `Library.SelectTab(tab)` | เปลี่ยนไปยังแท็บที่สร้างไว้ |
| `Library.SetToggleKey(keyCode)` | ตั้งคีย์เปิด/ซ่อน GUI |
| `Library.GetToggleKey()` | อ่านคีย์เปิด/ซ่อน GUI |
| `Library.IsMobile` | บอกว่าไลบรารีตรวจพบว่าเป็นอุปกรณ์มือถือหรือไม่ |
| `Library.Platform` | ชื่อแพลตฟอร์มที่ตรวจพบ |
| `Library.ScreenGui` | อ้างอิง ScreenGui ของไลบรารี |
| `Library.MainFrame` | อ้างอิงหน้าต่างหลัก |
| `Library.SettingsTab` | อ้างอิงแท็บตั้งค่าที่สร้างไว้ |
| `_G.RUNLUA_HUB` | ตัวแปร global ที่ไลบรารีกำหนดให้ชี้ไปยัง Library |

ตัวอย่างปิดและล้าง UI:

```lua
Library.Destroy()
```

ซอร์สจะพยายาม cleanup ไลบรารีเก่าก่อนเริ่มสร้าง instance ใหม่ หากมี `_G.RUNLUA_HUB_ACTIVE` และ `_G.RUNLUA_HUB_CLEANUP` อยู่แล้ว

ไม่ควรเรียก `Destroy()` หากยังต้องการใช้งาน UI เดิมต่อ เพราะ ScreenGui จะถูกทำลาย

---

## ตัวอย่างโปรเจกต์

ตัวอย่างนี้รวมแท็บ, Section, Toggle, Button, Slider, Input, Dropdown, Keybind, Label, Paragraph, Notification และคีย์เปิด/ซ่อน GUI:

```lua
local Library = loadstring(game:HttpGet("RAW_URL_ของไฟล์ไลบรารี"))()

-- คีย์เปิด/ซ่อน GUI
Library.SetToggleKey(Enum.KeyCode.RightShift)

local MainTab = Library.CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local Section = Library.CreateSection(MainTab.Page, {
    Name = "MainSection",
    Title = "ตัวอย่างคอมโพเนนต์",
})

local Status = Library.CreateLabel(Section, {
    Text = "สถานะ: พร้อม",
    Bold = true,
    Color = Library.Theme.Success,
})

Library.CreateParagraph(Section, {
    Text = "ตัวอย่างการใช้งาน UI Library ของ RUNLUA HUB",
})

local ToggleRow, GetToggle, SetToggle = Library.CreateToggle(Section, {
    Name = "เปิดระบบ",
    Default = false,
    Callback = function(enabled)
        Status.Text = enabled and "สถานะ: เปิด" or "สถานะ: ปิด"
    end,
})

Library.CreateButton(Section, {
    Name = "แจ้งเตือน",
    Callback = function()
        Library.Notify({
            Title = "RUNLUA HUB",
            Message = "นี่คือตัวอย่าง Notification",
            Duration = 3,
        })
    end,
})

local SliderRow, GetNumber, SetNumber = Library.CreateSlider(Section, {
    Name = "ค่าตัวอย่าง",
    Min = 0,
    Max = 100,
    Default = 50,
    Step = 5,
    Suffix = "%",
    Callback = function(value)
        print("Slider:", value)
    end,
})

local InputRow, GetInput, SetInput = Library.CreateInput(Section, {
    Name = "ข้อความ",
    Placeholder = "พิมพ์ข้อความ...",
    Callback = function(value)
        print("Input:", value)
    end,
})

local DropdownRow, GetMode, SetMode = Library.CreateDropdown(Section, {
    Name = "โหมด",
    Options = {"ปกติ", "เร็ว", "ประหยัด"},
    Default = "ปกติ",
    Callback = function(value)
        print("Mode:", value)
    end,
})

Library.CreateKeybind(Section, {
    Name = "เรียกฟังก์ชันตัวอย่าง",
    Default = Enum.KeyCode.G,
    Callback = function(keyCode)
        print("ทำงานจากคีย์:", keyCode.Name)
        Library.Notify({
            Title = "Keybind",
            Message = "กด " .. keyCode.Name .. " แล้ว",
            Duration = 2,
        })
    end,
})

-- เรียกเมื่อจำเป็นต้องแสดง UI อีกครั้ง
-- Library.Show()

-- เรียกเมื่ออยากล้าง UI ทั้งหมด
-- Library.Destroy()
```

เปลี่ยน `RAW_URL_ของไฟล์ไลบรารี` เป็น Raw URL ของไฟล์ที่คุณโฮสต์ไว้จริง ห้ามใช้ข้อความตัวอย่างนี้ตรง ๆ

---

## ข้อควรทราบและการแก้ปัญหา

**กดคีย์ลัดแล้วไม่ทำงาน**
- ตรวจว่ากำลังใช้คีย์ที่ตั้งไว้จริง
- Keybind ของฟังก์ชันทำงานเฉพาะ callback ที่ผูกกับ Keybind นั้น
- Input ที่ Roblox/UI ประมวลผลแล้ว (`gameProcessed == true`) อาจถูกข้าม
- ระบบ Keybind ในไฟล์นี้เป็นการกดคีย์บอร์ด จึงเหมาะกับ PC

**เปลี่ยนคีย์ GUI แล้วไม่ได้**
- ส่ง `Enum.KeyCode` เช่น `Enum.KeyCode.RightControl` ไม่ใช่ string `"RightControl"`
- ตรวจผลลัพธ์จาก `Library.SetToggleKey(...)` ว่าเป็น `true`

**UI หายไป**
- `Library.Hide()` แค่ซ่อนหน้าต่างหลัก; `Library.Destroy()` ทำลาย ScreenGui
- ถ้าทำลายแล้ว ต้องโหลด/สร้างไลบรารีใหม่

**Save/Load ไม่ทำงาน**
- ตรวจ `Library.Settings.GetStorageAvailable()`
- การเข้าถึงไฟล์ขึ้นอยู่กับสภาพแวดล้อมที่ใช้รัน ไม่ใช่ทุกที่ที่รองรับ `isfile`, `readfile` หรือ `writefile`

**ไอคอนไม่แสดง**
- ตรวจว่าชื่อใน `Library.Icons` มีอยู่จริง
- ไอคอนอาจต้องรอโหลด Asset; ผลลัพธ์ขึ้นกับการเข้าถึง asset และสภาพแวดล้อมที่รัน

**Callback ของ Setter ไม่ทำงาน**
- `SetToggle`, `SetSpeed`, `SetText` และ `SetChoice` ถูกออกแบบให้เปลี่ยนค่าของ UI โดยตรง; ในโค้ดปัจจุบัน setter เหล่านี้ไม่ได้เรียก callback ของคอมโพเนนต์ทุกตัวโดยอัตโนมัติ

---

## API Reference แบบย่อ

```lua
Library.CreateTab(opts)
Library.CreateSection(parent, opts)
Library.CreateDivider(parent, order)

Library.CreateToggle(parent, opts)
Library.CreateButton(parent, opts)
Library.CreateSlider(parent, opts)
Library.CreateInput(parent, opts)
Library.CreateKeybind(parent, opts)
Library.CreateDropdown(parent, opts)
Library.CreateLabel(parent, opts)
Library.CreateParagraph(parent, opts)
Library.CreatePlayerList(parent, opts)

Library.Notify(opts)
Library.SelectTab(tab)
Library.Show()
Library.Hide()
Library.Destroy()

Library.SetToggleKey(Enum.KeyCode.RightShift)
Library.GetToggleKey()

Library.Settings.Get()
Library.Settings.Save()
Library.Settings.Load()
Library.Settings.Reset()
Library.Settings.Apply(data)
Library.Settings.GetStorageAvailable()

Library.Theme
Library.Config
Library.Icons
Library.IsMobile
Library.Platform
Library.ScreenGui
Library.MainFrame
Library.SettingsTab
```

---

**RUNLUA HUB UI Library**  
README นี้อธิบายตาม API ที่เปิดเผยในไฟล์ `UILibrary_Fixed_PC_Keybind_Drag.lua` หากมีการแก้ซอร์สหรือเปลี่ยนชื่อฟังก์ชัน ควรอัปเดตเอกสารให้ตรงกับไฟล์เวอร์ชันนั้นด้วย


> UI Library แบบ Sidebar + Scrolling ที่เน้นใช้งานจริง พร้อมหมวด **ตั้งค่า GUI** แบบพิเศษ, ปรับขนาด, ปรับตัวอักษร, เปลี่ยนสี, บันทึก/โหลด และรีเซ็ตกลับค่าเดิม

## ✨ จุดเด่น

- **Sidebar + Scrolling UI** — รองรับแท็บจำนวนมากและจอแคบ
- **Responsive** — จอเล็กจะเข้าสู่โหมด compact อัตโนมัติ
- **ลากหน้าต่าง** — PC: คลิกขวาค้างที่ Header / Mobile: ลาก Header
- **ปุ่มโลโก้** — คลิกเพื่อเปิด/ปิด UI และลากตำแหน่งได้
- **หมวดตั้งค่า GUI พิเศษ** — แยกจากแท็บปกติและวางไว้ท้าย Sidebar
- **ปรับขนาด UI** — 0.55x ถึง 1.80x
- **ปรับขนาดตัวอักษร** — 0.75x ถึง 1.75x
- **ปรับความหนาอักษร** — Regular → Heavy
- **เปลี่ยนสี** — มีชุดสีสำเร็จรูป + HEX แบบกำหนดเอง
- **บันทึกการตั้งค่า** — เขียนเป็น `RUNLUA_HUB_SETTINGS.json` เมื่อ environment รองรับ `writefile/readfile/isfile`
- **โหลดอัตโนมัติ** — ตอนเริ่ม UI จะพยายามโหลดค่าที่เคยบันทึกไว้
- **รีเซ็ตค่าเดิม** — คืนขนาด/สี/ตัวอักษรกลับค่าเริ่มต้นโดยไม่ต้องรันใหม่
- **กัน error** — งานที่แตะ file API / JSON / UI บางส่วนครอบด้วย `pcall` เพื่อไม่ให้ระบบหลักดับง่าย

## 📦 ไฟล์

```text
UILibrary_REDESIGN_SCROLL.lua   ← ไฟล์ Library ที่แก้แล้ว
README.md                       ← คู่มือฉบับนี้
RUNLUA_HUB_SETTINGS.json        ← สร้างอัตโนมัติหลังบันทึก (เฉพาะ environment ที่รองรับ file API)
```

## 🚀 วิธีเริ่มใช้งาน

### แบบ Library / `require`

นำ `UILibrary_REDESIGN_SCROLL.lua` ไปใส่เป็น ModuleScript แล้ว `require()` จาก LocalScript ฝั่ง client

```lua
local Library = require(script.Parent.UILibrary_REDESIGN_SCROLL)

local Home = Library:CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local Section = Library.CreateSection(Home.Page, {
    Title = "ทั่วไป",
})

Library.CreateToggle(Section, {
    Name = "เปิดใช้งาน",
    Description = "ตัวอย่าง Toggle",
    Icon = Library.Icons.Action,
    Default = false,
    Callback = function(enabled)
        print("สถานะ:", enabled)
    end,
})

Library.CreateButton(Section, {
    Name = "ทดสอบปุ่ม",
    Description = "ตัวอย่าง Button",
    Icon = Library.Icons.Action,
    Callback = function()
        Library.Notify({
            Title = "สำเร็จ",
            Message = "ปุ่มทำงานแล้ว",
        })
    end,
})
```

### แบบ API จาก GitHub Raw ⭐

แนะนำให้ใช้วิธีนี้สำหรับการโหลด Library จากไฟล์กลางของ RUNLUA HUB โดยตรง:

```lua
local API_URL = "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
local Library = loadstring(game:HttpGet(API_URL))()
```

หรือแบบสั้น:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"))()
```

> วิธีนี้ต้องใช้ environment ที่รองรับ `loadstring` และ `game:HttpGet()`
> และ URL จะโหลดไฟล์ `UILibrary.lua` จาก GitHub branch `main` โดยตรง

### ตัวอย่างเริ่มต้นแบบ API

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"))()

local Home = Library:CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local Section = Library.CreateSection(Home.Page, {
    Title = "ทั่วไป",
})

Library.CreateButton(Section, {
    Name = "ทดสอบระบบ",
    Description = "ทดสอบว่า GUI โหลดสำเร็จและ API ใช้งานได้",
    Icon = Library.Icons.Action,
    Callback = function()
        Library.Notify({
            Title = "RUNLUA HUB",
            Message = "API โหลดสำเร็จแล้ว!",
        })
    end,
})
```

> `readfile/writefile/isfile` ไม่ใช่ API มาตรฐานที่มีในทุก environment ดังนั้นระบบบันทึกแบบไฟล์จะแจ้งเตือนและ fallback เป็นหน่วยความจำเมื่อไม่มี file API

## ⚙️ หมวด “ตั้งค่า GUI”

หลัง Library เริ่มทำงาน จะมีแท็บ **ตั้งค่า GUI** ถูกสร้างให้อัตโนมัติ ไม่ต้องสร้างเอง

### 1) ขนาด UI

เลื่อนค่า `ขนาด UI` เพื่อขยาย/ย่อหน้าต่างรวมถึงปุ่มโลโก้

- `0.55x` = เล็กมาก
- `1.00x` = ค่าเริ่มต้น
- `1.80x` = ใหญ่สุด

### 2) ขนาดตัวอักษร

เลื่อน `ขนาดตัวอักษร` เพื่อเพิ่ม/ลดขนาดข้อความทั้ง Library โดยระบบจำ **ขนาดต้นฉบับ** แยกไว้ เพื่อไม่ให้การปรับหลายรอบทำให้ตัวหนังสือโตทับซ้อน

### 3) ความหนาอักษร

เลือกได้:

```text
Regular
Medium
SemiBold
Bold
ExtraBold
Heavy
```

น้ำหนักฟอนต์ชุดนี้เป็นชื่อที่ Roblox รองรับในระบบ font weight ปัจจุบัน

### 4) เปลี่ยนสี

#### ชุดสีหลัก

มี preset ให้เลือก:

```text
น้ำเงินฟ้า
ม่วงไฟฟ้า
เขียวมรกต
แดงคริมสัน
ทอง
ขาวดำ
```

#### สีหลัก HEX

ใส่สีเองได้ เช่น

```text
#00A2FF
#8B5CF6
#22C55E
```

ระบบจะสร้าง `AccentSoft` และ `AccentLight` ให้จากสีหลักอัตโนมัติ

#### สีพื้นหลัง HEX

ใส่สีพื้นหลังเองได้ เช่น

```text
#0A1020
#111111
#080808
```

### 5) บันทึกการตั้งค่า

กด **บันทึกการตั้งค่า** เพื่อบันทึกค่าเหล่านี้:

- ขนาด UI
- ขนาดตัวอักษร
- ความหนาอักษร
- สีธีมที่เป็น Color3
- ตำแหน่งหน้าต่างหลัก
- ตำแหน่งปุ่มโลโก้

ไฟล์ชื่อ:

```text
RUNLUA_HUB_SETTINGS.json
```

ระบบใช้ `HttpService:JSONEncode()` / `JSONDecode()` เฉพาะสำหรับแปลงข้อมูลการตั้งค่าเป็น JSON; การใช้ JSON ไม่ได้เปิด HTTP request ให้อัตโนมัติ

### 6) โหลดการตั้งค่า

กด **โหลดการตั้งค่า** ได้ตลอดเวลาเพื่อดึงค่าจากไฟล์ล่าสุดกลับมาใช้ และระบบจะพยายามโหลดค่าเดิมอัตโนมัติในตอนเริ่มต้น

### 7) รีเซ็ตกลับค่าเดิม

กด **รีเซ็ตกลับค่าเดิม** เพื่อคืนค่า:

```text
UI Scale        = 1.00x
Text Scale      = 1.00x
Font Weight     = Bold
Theme           = ค่าเริ่มต้นของ Library
```

ตำแหน่งหน้าต่าง/โลโก้จะไม่ถูกลากกลับอัตโนมัติจากปุ่มรีเซ็ต เพื่อป้องกันผู้ใช้เสียตำแหน่งที่จัดไว้; ถ้าต้องการเก็บตำแหน่งใหม่ให้กดบันทึกอีกครั้ง

## 🧩 API ที่เพิ่ม

```lua
Library.Settings.FileName
Library.Settings.Get()
Library.Settings.Save()
Library.Settings.Load()
Library.Settings.Reset()
Library.Settings.Apply(data)
Library.Settings.GetStorageAvailable()
```

ตัวอย่างเช็กว่า environment บันทึกไฟล์ได้หรือไม่:

```lua
if Library.Settings.GetStorageAvailable() then
    print("File save: READY")
else
    print("File save: UNAVAILABLE")
end
```

ตัวอย่างอ่านค่าปัจจุบัน:

```lua
local cfg = Library.Settings.Get()
print(cfg.UserScale)
print(cfg.TextScale)
print(cfg.FontWeight)
```

## 🛠️ Component API เดิม

ยังคงมี:

```lua
Library.CreateTab
Library.CreateSection
Library.CreateDivider
Library.CreateToggle
Library.CreateButton
Library.CreateSlider
Library.CreateInput
Library.CreateKeybind
Library.CreateDropdown
Library.CreateLabel
Library.CreateParagraph
Library.CreatePlayerList
Library.SelectTab
Library.Notify
Library.Show
Library.Hide
Library.Destroy
```

## 🧪 ตัวอย่าง Slider

```lua
Library.CreateSlider(Section, {
    Name = "ความเร็ว",
    Min = 0,
    Max = 100,
    Step = 1,
    Default = 50,
    Suffix = "%",
    Callback = function(value)
        print("ค่า:", value)
    end,
})
```

## 🧪 ตัวอย่าง Dropdown

```lua
Library.CreateDropdown(Section, {
    Name = "โหมด",
    Options = {"ปลอดภัย", "ปกติ", "แรง"},
    Default = "ปกติ",
    Callback = function(value)
        print("เลือก:", value)
    end,
})
```

## 🧪 ตัวอย่าง Keybind

```lua
Library.CreateKeybind(Section, {
    Name = "ปุ่มเปิดเมนู",
    Default = Enum.KeyCode.RightShift,
    Callback = function(key)
        print("ตั้งปุ่มเป็น:", key.Name)
    end,
})
```

## 🧯 สิ่งที่แก้ในเวอร์ชันนี้

- ปรับ scope ของตัวแปรที่ถูกเรียกใช้ก่อน declaration ให้ชัดเจนขึ้น
- ป้องกันการชนกันของการปรับ scale กับ responsive scale
- ทำให้ text scaling ใช้ “base size” จึงไม่คูณซ้ำเมื่อปรับหลายรอบ
- เพิ่มการ refresh สีทั้ง Background / Text / UIStroke / UIGradient ตาม palette เดิม
- ทำให้ Tab ปกติและ Settings Tab มีสถานะแยกกัน
- Settings Tab ถูกวางไว้ท้าย Sidebar พร้อม separator และ visual style พิเศษ
- ปรับ `CreateTab` ให้รองรับ `Order`
- เพิ่ม `Cloud` icon ที่ใช้จริงในปุ่มโหลด
- เพิ่มระบบโหลดค่าอัตโนมัติเมื่อเริ่มต้น
- เพิ่ม fallback เมื่อไม่มี file API
- เพิ่มการตรวจ JSON และค่าตัวเลข/สีที่โหลดเข้ามา ไม่ปล่อยค่าขยะเข้าระบบ
- ขนาดโลโก้ sync กับ UI scale
- รองรับฟอนต์ weight แบบ Roblox สมัยใหม่
- เพิ่ม API `Library.Settings.*` สำหรับควบคุมจากสคริปต์ภายนอก

## 📌 หมายเหตุสำคัญ

ไฟล์นี้เป็น GUI Library ฝั่ง client และมีโค้ดตรวจจับ platform/input รวมถึงการ fallback ระหว่าง `CoreGui` กับ `PlayerGui` ตาม environment

การบันทึกแบบถาวรขึ้นกับความสามารถของ environment ที่รันอยู่ หากไม่มี `isfile/readfile/writefile` ปุ่มบันทึกจะไม่ทำให้ script crash แต่จะเก็บ snapshot ไว้ในหน่วยความจำของ session เท่านั้น

`HttpService:JSONEncode()` และ `JSONDecode()` ใช้สำหรับ serialization ของข้อมูลการตั้งค่า ไม่ได้หมายความว่าระบบกำลังส่ง HTTP request ออกไป

## 🌐 RUNLUA HUB API URL

URL หลักสำหรับโหลด UI Library รุ่นใน GitHub:

```text
https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua
```

ตัวโหลดมาตรฐาน:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"))()
```

เมื่ออัปเดตไฟล์ `UILibrary.lua` บน GitHub แล้ว สคริปต์ที่เรียก URL นี้จะดึงไฟล์จาก `main` โดยตรงในครั้งถัดไปที่รัน

## 🔗 เอกสารอ้างอิงทางการ

- Roblox HttpService: https://create.roblox.com/docs/reference/engine/classes/HttpService
- Roblox UserInputService: https://create.roblox.com/docs/reference/engine/classes/UserInputService
- Roblox Rich Text / Font Weight: https://create.roblox.com/docs/ui/rich-text

## 🏁 สรุปการใช้งานแบบเร็ว

```text
1. โหลด Library จาก GitHub Raw API
2. สร้างแท็บปกติด้วย Library:CreateTab()
3. ใช้ Settings Tab ที่ชื่อ “ตั้งค่า GUI” ท้าย Sidebar
4. ปรับ ขนาด UI / ขนาดตัวอักษร / ความหนา / สี
5. กด “บันทึกการตั้งค่า”
6. ครั้งต่อไป Library จะพยายามโหลดค่าที่เซฟไว้ให้อัตโนมัติ
7. ต้องการคืนค่า → “รีเซ็ตกลับค่าเดิม”
```

---

**RUNLUA HUB • GUI Library**  
Built for a clean, configurable, responsive UI workflow.

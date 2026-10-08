# RUNLUA HUB — Unified UI Library v2.1

> รุ่นนี้รวมฟังก์ชันจาก `V1.0.lua` เข้าไปอยู่ใน Sidebar + Scrolling UI รุ่นใหม่โดยตรง พร้อมหมวด **ตั้งค่า GUI** แบบแยกเฉพาะ, ปรับขนาด UI, ปรับฟอนต์, เปลี่ยนสี, บันทึก/โหลด/รีเซ็ต และระบบ cleanup ตอนปิด UI

---

## 🚀 โหลด Library จาก GitHub Raw

URL หลัก:

```text
https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua
```

ตัวโหลดมาตรฐาน:

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
))()
```

แบบบรรทัดเดียว:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"))()
```

> ต้องใช้ environment ที่รองรับ `loadstring` และ `game:HttpGet()` สำหรับรูปแบบนี้

---

# ✨ มีอะไรในรุ่นนี้

## UI ใหม่

- Sidebar + Scrolling
- Responsive สำหรับหน้าจอแคบ
- หน้าต่างลากได้
- ปุ่มโลโก้สำหรับเปิด/ปิด UI
- ระบบเปิด/ปิดพร้อม animation
- Notification
- ระบบ cleanup ก่อนสร้าง UI รอบใหม่
- รองรับ PC / Mobile

## หมวดที่ย้ายมาจาก V1.0

ฟังก์ชันของ V1 ถูกย้ายมาให้ใช้งานผ่าน UI ใหม่ โดยยังคงแบ่งหมวดตามหน้าที่:

```text
หลัก
โจมตี
เครื่องมือ
แกล้ง
ESP
ตั้งค่า GUI
```

### หลัก

```text
บิน
กระโดดไม่จำกัด
วิ่งเร็ว
วาร์ปตามจุดที่กด
เดินทะลุกำแพง
หายตัว
โหมดอมตะ บางแมพ
```

ค่าที่ปรับได้ในหมวดนี้:

```text
ความเร็วบิน
ความเร็วเดิน
```

### โจมตี

```text
ล็อคหัวผู้เล่น
ขยาย Hitbox ผู้เล่น
ล็อคหัว NPC / บอท
ขยาย Hitbox NPC / บอท
ฆ่าบอทใกล้ตัว
```

ค่าที่ปรับได้:

```text
FOV
ขนาด Hitbox ผู้เล่น
ขนาด Hitbox NPC / บอท
ระยะฆ่าบอท
```

### ESP

```text
มองทะลุ ผู้เล่น
เส้น ESP ผู้เล่น
มองทะลุ NPC / บอท
เส้น ESP NPC / บอท
```

พร้อมระบบ cache สำหรับ NPC และการล้าง ESP เมื่อปิดฟังก์ชัน

### เครื่องมือ

```text
ลดกราฟิก เพิ่ม FPS
ทำแมพสว่าง
เพิ่มความเร็วรถ
หยิบของเร็ว | E
สแกนของในแมพ
เสก Tool
แป้นพิมพ์บนหน้าจอ
เข้าเซิร์ฟเวอร์คนน้อย
Infinite Yield
Quirky CMD
```

ค่าที่ปรับได้:

```text
ความสว่าง
ความเร็วรถ
```

### แกล้ง

```text
ดึงผู้เล่นมาใกล้ตัว
หลุมดำดูดของ
ชนผู้เล่นกระเด็น
ถอดเสื้อผ้า
ชักว่าว
เครื่องมือ F3X
```

ฟังก์ชันที่เดิมเรียกไฟล์ภายนอกจะยังเรียกจากแหล่งเดิมเมื่อผู้ใช้กดปุ่ม แทนการฝังไฟล์ภายนอกเข้า Library

---

# ⚙️ หมวด "ตั้งค่า GUI"

แท็บนี้สร้างอัตโนมัติและแยกออกจากหมวดฟังก์ชันทั้งหมด

## 1. ขนาด UI

ปรับได้:

```text
0.55x → 1.80x
```

ตัวอย่าง:

```text
0.55x = เล็ก
1.00x = ค่าเริ่มต้น
1.80x = ใหญ่
```

ค่านี้ใช้กับหน้าต่างหลักและปุ่มโลโก้

## 2. ขนาดตัวอักษร

ปรับได้:

```text
0.75x → 1.45x
```

ระบบจะจำ `BaseTextSize` ของแต่ละข้อความก่อนปรับ เพื่อป้องกันการคูณขนาดซ้ำเมื่อเลื่อนหลายครั้ง

## 3. ความหนาตัวอักษร

รองรับ:

```text
Regular
Medium
SemiBold
Bold
ExtraBold
Heavy
```

ฟอนต์หลักของ UI ใช้ Kanit ที่กำหนดไว้ใน Library

## 4. เปลี่ยนสี

มี Preset:

```text
Neon Blue
Purple
Crimson
Emerald
Monochrome
```

และปรับสีเองด้วย HEX:

```text
#00A2FF
#8B5CF6
#22C55E
#FF4161
```

ช่องสีที่ปรับได้:

```text
สีหลัก
สีพื้นหลัง
สีแผง
สีแผงรอง
สีข้อความ
สีข้อความรอง
สีเส้นขอบ
```

เมื่อเปลี่ยนสี ระบบจะ refresh สีขององค์ประกอบเดิม เช่น:

```text
Background
Text
UIStroke
Scrollbar
UIGradient
```

---

# 💾 ระบบบันทึก / โหลด / รีเซ็ต

ชื่อไฟล์:

```text
RUNLUA_HUB_GUI_SETTINGS.json
```

ข้อมูลหลักที่บันทึก:

```text
UI Scale
Font Scale
Font Weight
Theme
ตำแหน่งหน้าต่าง
ตำแหน่งปุ่มโลโก้
```

กด:

```text
บันทึกการตั้งค่า
```

เพื่อเขียนไฟล์

และ:

```text
โหลดการตั้งค่า
```

เพื่อโหลดค่ากลับมา

ตอนเริ่ม Library จะพยายามโหลดค่าที่เคยบันทึกไว้อัตโนมัติ

## รีเซ็ต

ปุ่ม:

```text
รีเซ็ตกลับค่าเดิม
```

จะคืน:

```text
UI Scale      = 1.00x
Font Scale    = 1.00x
Font Weight   = Medium
Theme         = ค่าเริ่มต้นของ Library
ตำแหน่งหน้าต่าง = ตรงกลาง
ตำแหน่งโลโก้    = ค่าเริ่มต้น
```

จากนั้นระบบจะบันทึกค่าที่รีเซ็ตไว้ด้วย เพื่อไม่ให้รันครั้งใหม่แล้วโหลดค่าก่อนหน้าเดิมกลับมา

---

# 🔄 บันทึกอัตโนมัติ

เปิด:

```text
บันทึกอัตโนมัติเมื่อเปลี่ยนค่า
```

แล้ว Library จะบันทึกเมื่อเปลี่ยนค่าตั้งค่า โดยใช้ debounce เพื่อลดการเขียนไฟล์ถี่เกินไป เช่นตอนลาก Slider

---

# 🧩 API ใหม่ของ Library

## Core

```lua
Library:CreateTab()
Library.CreateSection()
Library.CreateDivider()
Library.CreateToggle()
Library.CreateButton()
Library.CreateSlider()
Library.CreateInput()
Library.CreateKeybind()
Library.CreateDropdown()
Library.CreateLabel()
Library.CreateParagraph()
Library.CreatePlayerList()

Library.SelectTab()
Library.Notify()
Library.Show()
Library.Hide()
Library.Destroy()
```

## Settings

```lua
Library.Settings.File
Library.Settings.Save()
Library.Settings.Load()
Library.Settings.Reset()
Library.Settings.Snapshot()
Library.Settings.Apply(data)

Library.Settings.GetUIScale()
Library.Settings.SetUIScale(value)

Library.Settings.GetFontScale()
Library.Settings.SetFontScale(value)

Library.Settings.GetFontWeight()
Library.Settings.SetFontWeight(name)
```

ตัวอย่าง:

```lua
Library.Settings.SetUIScale(1.25)
Library.Settings.SetFontScale(1.10)
Library.Settings.SetFontWeight("Bold")
```

บันทึกทันที:

```lua
Library.Settings.Save()
```

รีเซ็ต:

```lua
Library.Settings.Reset()
```

---

# 🔌 API Compatibility จาก V1

เพื่อให้ย้ายโค้ด V1 ได้ง่าย แต่ละแท็บของ Library ใหม่รองรับ API แบบเดิม:

```lua
local Tab = Library:CreateTab({
    Name = "ตัวอย่าง",
    Icon = Library.Icons.Home,
})

Tab:NewLabel("หัวข้อ")

Tab:NewButton("ทดสอบ", function()
    print("ทำงาน")
end, "คำอธิบาย")

Tab:NewToggle("เปิดระบบ", false, function(enabled)
    print(enabled)
end, "คำอธิบาย", {
    text = "ค่า",
    min = 0,
    max = 100,
    default = 50,
    callback = function(value)
        print(value)
    end,
})
```

ดังนั้นโค้ดฟังก์ชันจาก `V1.0.lua` จึงย้ายเข้ามาใน UI ใหม่ได้โดยไม่ต้องสร้างหน้าต่าง V1 เดิมขึ้นมาอีก

---

# 🧹 ระบบ Cleanup

เมื่อกดปิด/Destroy Library ระบบจะพยายามคืนสถานะของฟังก์ชัน V1 ที่กำลังทำงาน เช่น:

```text
Fly
Noclip
Invisible
Hitbox
ESP
FPS Boost
Fullbright
Click TP
Car Speed
Blackhole
Proximity Prompt Fast
Animation
```

พร้อม:

```text
Disconnect connections
ลบ object ชั่วคราว
ล้าง ESP line
คืนค่าฟิสิกส์/Lighting ที่เก็บไว้
หยุด animation ที่สร้างโดยระบบ
```

ช่วยลดปัญหา object ค้างและ connection ค้างหลังปิด UI

---

# 📦 โครงสร้างไฟล์ ZIP

```text
RUNLUA_HUB_GUI_v2.1/
│
├─ UILibrary.lua
├─ README.md
└─ V1.0_ORIGINAL.lua
```

`UILibrary.lua` คือไฟล์หลักที่รวม UI ใหม่ + ฟังก์ชันจาก V1

`V1.0_ORIGINAL.lua` เป็นสำเนา V1 ต้นฉบับสำหรับอ้างอิงเท่านั้น

---

# 🛠️ วิธีใช้แบบเร็ว

```text
1. โหลด UILibrary.lua
2. รอ UI เปิด
3. เลือกหมวด หลัก / โจมตี / เครื่องมือ / แกล้ง / ESP
4. ไปที่ "ตั้งค่า GUI"
5. ปรับขนาด UI
6. ปรับขนาดตัวอักษร
7. เลือกความหนาอักษร
8. เลือกสีหรือใส่ HEX
9. กด "บันทึกการตั้งค่า"
10. ครั้งถัดไป Library จะพยายามโหลดค่าที่บันทึกไว้
```

---

# ⚠️ หมายเหตุ

การบันทึกแบบไฟล์ถาวรขึ้นอยู่กับ environment ที่ใช้รัน หาก environment ไม่มี:

```lua
isfile
readfile
writefile
```

ระบบบันทึกไฟล์จะไม่สามารถเขียน JSON ลงดิสก์ได้

ส่วนการเรียก GitHub Raw ต้องใช้ environment ที่รองรับ:

```lua
game:HttpGet()
loadstring()
```

ฟังก์ชันบางรายการจาก V1 เป็น client-side และผลลัพธ์จะแตกต่างกันตามเกม/ระบบ server ของเกมที่กำลังเล่น

---

# 🌐 GitHub

ใช้ไฟล์หลักบน GitHub ที่ path:

```text
UI Library/UILibrary.lua
```

Raw API:

```text
https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua
```

ตัวโหลด:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"))()
```

---

# 🏁 RUNLUA HUB

**Unified UI • V1 Function Migration • Settings System • Save/Load • Responsive Sidebar**

รุ่นนี้ตั้งใจให้ `UILibrary.lua` เป็นไฟล์กลางของ UI Library และให้ฟังก์ชันจาก V1 อยู่ภายใน UI รุ่นใหม่ทั้งหมด

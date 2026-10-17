# 🎨 RUNLUA HUB — UI Library

UI Library สำหรับ Roblox ที่รองรับ **มือถือ** และ **PC** อย่างสมบูรณ์
ฟอนต์ไทยขึ้นครบ ธีมเปลี่ยนได้ บันทึกการตั้งค่าได้ พร้อมใช้เลย

> 💬 **Discord:** https://discord.gg/WjQZPX8PKD

---

## ✨ มีอะไรบ้าง

- 📱 รองรับ Android / iOS / PC
- 🇹🇭 ภาษาไทยขึ้นครบ (ไม่เป็นบล็อกสี่เหลี่ยม)
- 🎨 เปลี่ยนสี UI ได้ตามใจ
- 💾 บันทึกการตั้งค่าได้
- 🔒 กัน 2 สคริปต์แย่ง UI
- 🔔 มี Notification สวยๆ
- 👥 แสดงรายชื่อผู้เล่น + เลือด
- 🧩 Components ครบ (Toggle, Slider, Button, ฯลฯ)

---

## 📦 วิธีใช้

### โหลด Library

    local Library = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
    ))()

### สร้าง Tab และ Section

    -- สร้าง Tab
    local MainTab = Library:CreateTab({
        Name = "หน้าหลัก",
        Icon = Library.Icons.Home,
    })

    -- สร้าง Section ใน Tab
    local Section = Library:CreateSection(MainTab.Page, {
        Title = "ตัวเลือกหลัก",
    })

---

## 🧩 ตัวอย่าง Components

### 🔘 Toggle (สวิตช์)

    Library:CreateToggle(Section, {
        Name = "เปิดใช้งาน",
        Description = "คำอธิบายเพิ่มเติม",
        Default = false,
        Icon = Library.Icons.Action,
        Callback = function(state)
            print("สถานะ:", state)
        end,
    })

### 🔵 Button (ปุ่ม)

    Library:CreateButton(Section, {
        Name = "กดตรงนี้",
        Description = "ปุ่มตัวอย่าง",
        Icon = Library.Icons.Action,
        Color = Library.Theme.Success,
        Callback = function()
            print("กดแล้ว!")
        end,
    })

### 📊 Slider (ตัวเลื่อน)

    Library:CreateSlider(Section, {
        Name = "ความเร็ว",
        Min = 0,
        Max = 100,
        Default = 50,
        Suffix = " km/h",
        Icon = Library.Icons.Slider,
        Callback = function(value)
            print("ค่า:", value)
        end,
    })

### 🔢 NumberInput (ช่องตัวเลข)

    Library:CreateNumberInput(Section, {
        Name = "จำนวน",
        Min = 0,
        Max = 1000,
        Default = 100,
        Suffix = " ชิ้น",
        Icon = Library.Icons.Pencil,
        Callback = function(value)
            print("จำนวน:", value)
        end,
    })

### ⌨️ Input (ช่องข้อความ)

    Library:CreateInput(Section, {
        Name = "ชื่อผู้ใช้",
        Placeholder = "พิมพ์ชื่อ...",
        Icon = Library.Icons.Pencil,
        Callback = function(text)
            print("ข้อความ:", text)
        end,
    })

### 🎹 Keybind (ปุ่มลัด)

    Library:CreateKeybind(Section, {
        Name = "ปุ่มลัด",
        Default = Enum.KeyCode.E,
        Icon = Library.Icons.Keybind,
        Callback = function(key)
            print("กดปุ่ม:", key.Name)
        end,
    })

### 📋 Dropdown (ตัวเลือก)

    Library:CreateDropdown(Section, {
        Name = "เลือกโหมด",
        Options = {"โหมด 1", "โหมด 2", "โหมด 3"},
        Default = "โหมด 1",
        Icon = Library.Icons.Dropdown,
        Callback = function(selected)
            print("เลือก:", selected)
        end,
    })

### 📝 Label / Paragraph

    Library:CreateLabel(Section, {
        Text = "ข้อความหัวข้อ",
        Size = 14,
        Bold = true,
    })

    Library:CreateParagraph(Section, {
        Text = "ข้อความยาวๆ ที่ตัดบรรทัดอัตโนมัติ",
        Size = 12,
    })

### 👥 Player List

    local playerList, rebuild, getSelected = Library:CreatePlayerList(Section, {
        OnSelect = function(player)
            print("เลือกผู้เล่น:", player.Name)
        end,
    })

---

## 📖 API ทั้งหมด

### 🗂️ การสร้าง UI

| ฟังก์ชัน | คำอธิบาย | Returns |
|----------|-----------|---------|
| Library:CreateTab(opts) | สร้าง Tab ใหม่ | tab |
| Library:CreateSection(parent, opts) | สร้าง Section | section |
| Library:CreateDivider(parent, order) | สร้างเส้นคั่น | frame |
| Library:CreateToggle(parent, opts) | สร้างสวิตช์ | row, getter, setter |
| Library:CreateButton(parent, opts) | สร้างปุ่ม | row |
| Library:CreateSlider(parent, opts) | สร้างสไลเดอร์ | row, getter, setter |
| Library:CreateNumberInput(parent, opts) | สร้างช่องตัวเลข | row, getter, setter |
| Library:CreateInput(parent, opts) | สร้างช่องข้อความ | row, getter, setter |
| Library:CreateKeybind(parent, opts) | สร้างปุ่มลัด | row, getter, setter |
| Library:CreateDropdown(parent, opts) | สร้าง dropdown | wrapper, getter, setter |
| Library:CreateLabel(parent, opts) | สร้าง Label | label |
| Library:CreateParagraph(parent, opts) | สร้าง Paragraph | label |
| Library:CreatePlayerList(parent, opts) | สร้าง Player List | wrapper, rebuild, getSelected |

### 🎛️ การควบคุม UI

| ฟังก์ชัน | คำอธิบาย |
|----------|-----------|
| Library:Show() | เปิด UI |
| Library:Hide() | ปิด UI |
| Library:Destroy() | ลบ UI ทั้งหมด |
| Library:SelectTab(tab) | เลือก Tab |
| Library:SetToggleKey(keyCode) | ตั้งปุ่มเปิด/ปิด UI |
| Library:GetToggleKey() | ดูปุ่มเปิด/ปิดปัจจุบัน |

### 🔔 Notification

| ฟังก์ชัน | คำอธิบาย |
|----------|-----------|
| Library.Notify(opts) | แสดงการแจ้งเตือน |

Options ของ Notify:
- Title (string) — หัวข้อ
- Message (string) — ข้อความ
- Duration (number) — ระยะเวลา (วินาที)
- Color (Color3) — สี
- Icon (function) — ฟังก์ชันสร้างไอคอน

### 💾 การตั้งค่า

| ฟังก์ชัน | คำอธิบาย |
|----------|-----------|
| Library.Settings.Save() | บันทึกการตั้งค่า |
| Library.Settings.Load() | โหลดการตั้งค่า |
| Library.Settings.Reset() | รีเซ็ตกลับค่าเดิม |
| Library.Settings.Get() | ดูข้อมูลการตั้งค่าปัจจุบัน |
| Library.Settings.Apply(data) | ใส่ข้อมูลการตั้งค่าโดยตรง |
| Library.Settings.GetStorageAvailable() | เช็คว่ารองรับ writefile ไหม |

### 🔒 UI Lock

| ฟังก์ชัน | คำอธิบาย |
|----------|-----------|
| Library.UILock.IsOwner() | เช็คว่าตัวเองเป็นเจ้าของ UI ไหม |
| Library.UILock.GetOwner() | ดู Owner ID ปัจจุบัน |
| Library.UILock.Release() | ปล่อย UI |
| Library.UILock.Acquire() | ยึด UI |
| Library.UILock.SessionId | Session ID ของตัวเอง |

### 📊 ค่าคงที่

| ตัวแปร | คำอธิบาย |
|---------|-----------|
| Library.Theme | ตารางสีทั้งหมด |
| Library.Config | ตาราง config |
| Library.Icons | ตารางไอคอน |
| Library.Tabs | ตาราง Tabs ทั้งหมด |
| Library.IsMobile | true ถ้าเป็นมือถือ |
| Library.Platform | ชื่อแพลตฟอร์ม |
| Library.ScreenGui | ScreenGui หลัก |
| Library.MainFrame | Frame หลัก |
| Library.SettingsTab | Tab ตั้งค่า |

---

## 🎨 สีทั้งหมดในธีม

    Library.Theme.Background       -- สีพื้นหลังหลัก
    Library.Theme.Surface          -- สีพื้นผิว
    Library.Theme.SurfaceAlt       -- สีพื้นผิวสำรอง
    Library.Theme.SurfaceHover     -- สีตอน hover
    Library.Theme.Accent           -- สีหลัก (Accent)
    Library.Theme.AccentSoft       -- สี Accent แบบนุ่ม
    Library.Theme.AccentLight      -- สี Accent แบบสว่าง
    Library.Theme.Text             -- สีข้อความหลัก
    Library.Theme.TextMuted        -- สีข้อความรอง
    Library.Theme.Border           -- สีเส้นขอบ
    Library.Theme.Success          -- สีเขียว (สำเร็จ)
    Library.Theme.Danger           -- สีแดง (อันตราย)
    Library.Theme.Warning          -- สีเหลือง (เตือน)
    Library.Theme.White            -- สีขาว

---

## 🖼️ ไอคอนทั้งหมด

    Library.Icons.Home
    Library.Icons.Player
    Library.Icons.Settings
    Library.Icons.Action
    Library.Icons.Close
    Library.Icons.Minimize
    Library.Icons.Slider
    Library.Icons.Pencil
    Library.Icons.Keybind
    Library.Icons.Dropdown
    Library.Icons.Book
    Library.Icons.Save
    Library.Icons.Cloud
    Library.Icons.Diamond
    Library.Icons.Shop
    Library.Icons.Bag
    Library.Icons.Thunder
    Library.Icons.Run
    Library.Icons.Gun
    Library.Icons.Map
    Library.Icons.Rocket
    Library.Icons.Box
    Library.Icons.Crystal
    Library.Icons.Egg
    Library.Icons.Star
    Library.Icons.Search
    Library.Icons.Target
    Library.Icons.Discord
    Library.Icons.YouTube
    Library.Icons.Reset
    Library.Icons.Swords
    Library.Icons.File
    Library.Icons.Gift
    Library.Icons.Fruit
    Library.Icons.Fish
    Library.Icons.Dinosaur
    Library.Icons.Word
    Library.Icons.Sound
    Library.Icons.Airplane
    Library.Icons.Smile
    Library.Icons.Pin1
    Library.Icons.Pin2
    Library.Icons.Hook
    Library.Icons.Fishing
    Library.Icons.Spoon
    Library.Icons.Resize

---

## 🔔 Notification

    Library.Notify({
        Title = "สำเร็จ",
        Message = "บันทึกการตั้งค่าแล้ว",
        Duration = 3,
        Color = Library.Theme.Success,
        Icon = Library.Icons.Action,
    })

---

## 🎨 เปลี่ยนธีม

    -- เปลี่ยนสีหลัก
    Library.Theme.Accent = Color3.fromRGB(255, 100, 100)

    -- เปลี่ยนสีพื้นหลัง
    Library.Theme.Background = Color3.fromRGB(20, 20, 30)

หรือเปลี่ยนผ่าน GUI: **Settings → สีและธีม**

---

## 💾 บันทึก/โหลดการตั้งค่า

    -- บันทึก
    Library.Settings.Save()

    -- โหลด
    Library.Settings.Load()

    -- รีเซ็ต
    Library.Settings.Reset()

หรือผ่าน GUI: **Settings → บันทึก / คืนค่า**

---

## 🔒 UI Lock System

    -- เช็คว่าตัวเองเป็นเจ้าของ UI ไหม
    if Library.UILock.IsOwner() then
        print("คุณถือสิทธิ์ UI")
    end

    -- ปล่อย UI
    Library.UILock.Release()

    -- ยึด UI
    Library.UILock.Acquire()

---

## ⌨️ ปุ่มควบคุม

| ปุ่ม | ฟังก์ชัน |
|------|----------|
| RightShift | เปิด/ปิด UI (PC) |
| แตะที่โลโก้ | เปิด/ปิด UI |
| ลากที่ Header | ลาก UI |
| ลากมุมขวาล่าง | ปรับขนาด UI |

เปลี่ยนปุ่มได้ผ่าน:

    Library:SetToggleKey(Enum.KeyCode.F)

---

## 📖 ตัวอย่างโค้ดเต็ม

    -- โหลด Library
    local Library = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
    ))()

    -- สร้าง Tab
    local MainTab = Library:CreateTab({
        Name = "หน้าหลัก",
        Icon = Library.Icons.Home,
    })

    -- สร้าง Section
    local Section = Library:CreateSection(MainTab.Page, {
        Title = "การตั้งค่า",
    })

    -- เพิ่ม Toggle
    Library:CreateToggle(Section, {
        Name = "เปิดใช้งานฟีเจอร์",
        Description = "คำอธิบายฟีเจอร์",
        Default = false,
        Callback = function(state)
            if state then
                Library.Notify({
                    Title = "เปิดใช้งาน",
                    Message = "ฟีเจอร์ทำงานแล้ว",
                    Color = Library.Theme.Success,
                    Icon = Library.Icons.Action,
                })
            end
        end,
    })

    -- เพิ่ม Slider
    Library:CreateSlider(Section, {
        Name = "ความเร็ว",
        Min = 0,
        Max = 200,
        Default = 50,
        Callback = function(value)
            print("ความเร็ว:", value)
        end,
    })

    -- เพิ่ม Button
    Library:CreateButton(Section, {
        Name = "รีเซ็ตทั้งหมด",
        Description = "ล้างค่ากลับเป็นค่าเริ่มต้น",
        Icon = Library.Icons.Reset,
        Color = Library.Theme.Warning,
        Callback = function()
            Library.Settings.Reset()
            Library.Notify({
                Title = "รีเซ็ตแล้ว",
                Message = "ทุกอย่างกลับเป็นค่าเริ่มต้น",
                Color = Library.Theme.Warning,
                Icon = Library.Icons.Reset,
            })
        end,
    })

---

## ⚠️ ข้อกำหนด

Executor ที่รองรับ:
- loadstring / HttpGet
- writefile / readfile (สำหรับบันทึกการตั้งค่า)

แนะนำ:
- Android: Delta, Codex, Arceus X, Fluxus
- PC: Synapse X, Script-Ware, Krnl

---

## 📌 หมายเหตุ

- ใช้ฟอนต์ SourceSans (ฝังมากับ Roblox) → ภาษาไทยขึ้นครบ
- Resize UI ได้ทั้งมือถือและ PC
- ไม่กระทบ performance ของเกม

---

## 📄 License

MIT License — ใช้ได้ฟรี

---

## 💬 Discord Community

เข้าร่วมดิสคอร์ดของเรา:
👉 https://discord.gg/WjQZPX8PKD

- 📢 อัพเดตสคริปต์ใหม่
- 🐛 รายงานบั๊ก
- 💡 ขอฟีเจอร์ใหม่
- 🤝 คุยกับทีมงาน

---

## 🙏 เครดิต

พัฒนาโดย RUNLUA HUB
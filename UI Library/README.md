# RUNLUA HUB • UI Library — คู่มือการใช้งาน

> คู่มือสำหรับผู้พัฒนาและผู้ใช้งานไลบรารี RUNLUA HUB • UI Library  
> เอกสารนี้จัดทำจากซอร์สโค้ด `UIตัวใหม่ล่าสุด.txt` ที่ใช้เป็นต้นฉบับ ณ วันที่ 18 ตุลาคม 2026  
> **หมายเหตุ:** คู่มือนี้อธิบาย API และพฤติกรรมที่พบในซอร์ส ไม่ใช่การรับประกันว่า Asset ID ทุกหมายเลขยังเปิดใช้งานได้ หรือภาพที่ Roblox แสดงจะตรงกับคำอธิบายเชิงความหมายทุกกรณี

## สารบัญ

- [ภาพรวม](#ภาพรวม)
- [ข้อกำหนดและการเริ่มต้น](#ข้อกำหนดและการเริ่มต้น)
- [การควบคุมหน้าต่าง UI](#การควบคุมหน้าต่าง-ui)
- [โครงสร้าง Tab และ Section](#โครงสร้าง-tab-และ-section)
- [Components ทั้งหมด](#components-ทั้งหมด)
- [ระบบตั้งค่า GUI](#ระบบตั้งค่า-gui)
- [ระบบบันทึกการตั้งค่า](#ระบบบันทึกการตั้งค่า)
- [Notifications](#notifications)
- [Icons และ Asset ID ทั้งหมด](#icons-และ-asset-id-ทั้งหมด)
- [Theme และ Config](#theme-และ-config)
- [API ที่ Library ส่งออก](#api-ที่-library-ส่งออก)
- [ตัวอย่างการใช้งาน](#ตัวอย่างการใช้งาน)
- [ข้อจำกัดและการแก้ปัญหา](#ข้อจำกัดและการแก้ปัญหา)

---

## ภาพรวม

RUNLUA HUB • UI Library เป็นไลบรารี UI สำหรับ Roblox ที่มี Sidebar, หน้ารายการแบบเลื่อน, Components สำหรับสร้างตัวควบคุม, การแจ้งเตือน, รองรับ PC/มือถือ และหน้า `ตั้งค่า GUI` แยกจาก Tab ทั่วไป

คุณสมบัติที่ตรวจพบในซอร์ส:

- สร้าง Tab และเลือก Tab เพื่อแสดงหน้า Page
- สร้าง Section และ Divider เพื่อจัดกลุ่มเนื้อหา
- Toggle, Button, Slider, Number Input, Text Input, Keybind และ Dropdown
- Label, Paragraph และ Player List
- ไอคอนจาก Roblox Asset ID ผ่าน `Library.Icons`
- ปรับขนาดตัวอักษรและความหนาตัวอักษร
- เปลี่ยนชุดสีหลักและสีพื้นหลังจากชุดสีสำเร็จรูป
- บันทึก/โหลดการตั้งค่า GUI ผ่านไฟล์ JSON หากสภาพแวดล้อมมี API จัดการไฟล์
- ปุ่มโลโก้ลอยสำหรับเปิด/ปิดหน้าต่าง และการลากหน้าต่าง
- ระบบล็อก UI เพื่อป้องกันสคริปต์หลายชุดแย่งควบคุมหน้าต่างเดียวกัน
- ระบบ Cleanup สำหรับยกเลิก Connections และทำลาย UI

## ข้อกำหนดและการเริ่มต้น

ตัวอย่าง Loader ที่ใช้ในโปรเจกต์:

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"
))()
```

เมื่อโหลดสำเร็จ ไลบรารีจะคืนค่า `Library` และกำหนดไว้ที่ `_G.RUNLUA_HUB` ด้วย

> ควรโหลดเฉพาะซอร์สจากแหล่งที่เชื่อถือได้ และตรวจสอบโค้ดก่อนรันเสมอ การใช้ `loadstring` และ `game:HttpGet` ขึ้นอยู่กับสภาพแวดล้อมที่ใช้รัน และไม่ใช่รูปแบบที่เปิดให้ใช้ได้ในทุกบริบทของ Roblox Studio/เกม

### ตัวอย่างเริ่มต้น

```lua
local Library = loadstring(game:HttpGet("[URL_ของไฟล์ไลบรารี](https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua)"))()

local mainTab = Library.CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local section = Library.CreateSection(mainTab.Page, {
    Title = "ตัวอย่าง",
    Order = 1,
})

Library.CreateLabel(section, {
    Text = "ยินดีต้อนรับ",
    Size = 14,
})

Library.CreateButton(section, {
    Name = "ทดสอบ",
    Description = "กดเพื่อแสดงการแจ้งเตือน",
    Icon = Library.Icons.Action,
    Callback = function()
        Library.Notify({
            Title = "สำเร็จ",
            Message = "ปุ่มทำงานแล้ว",
            Duration = 3,
        })
    end,
})
```

---

## การควบคุมหน้าต่าง UI

### PC

- กด `RightShift` เพื่อสลับเปิด/ปิดหน้าต่างหลัก
- คลิกซ้ายค้างบนโลโก้ลอยหรือบริเวณแถบด้านบน แล้วลากเพื่อย้ายตำแหน่ง UI
- ปุ่มย่อหน้าต่างซ่อนหน้าต่างหลัก แต่ยังคงโลโก้ลอยไว้
- ปุ่มปิดจะเรียก Cleanup เพื่อทำลาย UI และยกเลิก Connections

สามารถเปลี่ยนปุ่มเปิด/ปิดด้วย API:

```lua
Library.SetToggleKey(Enum.KeyCode.RightControl)
print(Library.GetToggleKey().Name)
```

`SetToggleKey` รับค่า `Enum.KeyCode` เท่านั้น หากส่งชนิดอื่นจะคืนค่า `false`

### มือถือ / อุปกรณ์สัมผัส

- แตะโลโก้ลอยเพื่อเปิดหรือปิดหน้าต่าง
- ลากแถบด้านบนเพื่อย้ายหน้าต่าง
- UI ตรวจจับแพลตฟอร์มและปรับเลย์เอาต์ตามขนาดหน้าจอ
- Sidebar มีโหมดกะทัดรัดเมื่อพื้นที่หน้าจอแคบ

### ขนาดและ Responsive

ค่าเริ่มต้นใน Config ที่พบในซอร์ส:

| คีย์ | ค่า | ความหมาย |
|---|---:|---|
| `WindowSize` | `600 × 420` | ขนาดหน้าต่างเริ่มต้น |
| `WindowMinSize` | `420 × 300` | ขนาดหน้าต่างขั้นต่ำที่กำหนดใน Config |
| `SidebarWidth` | `156` | ความกว้าง Sidebar ปกติ |
| `SidebarWidthCompact` | `60` | ความกว้าง Sidebar แบบกะทัดรัด |
| `CompactBreakpoint` | `680` | จุดแบ่งสำหรับเลย์เอาต์กะทัดรัด |
| `HeaderHeight` | `52` | ความสูงแถบหัว |
| `RowHeight` | `50` | ความสูงแถวทั่วไป |
| `RowHeightDesc` | `76` | ความสูงแถวที่มีคำอธิบาย |
| `RowSpacing` | `10` | ระยะห่างแถว |
| `Padding` | `14` | ระยะขอบภายใน |
| `CornerRadius` | `10` | ค่ามุมโค้งมาตรฐาน |
| `AnimFast` | `0.15` | ระยะเวลาแอนิเมชันเร็ว |
| `AnimNormal` | `0.22` | ระยะเวลาแอนิเมชันปกติ |
| `AnimSlow` | `0.35` | ระยะเวลาแอนิเมชันช้า |
| `MaxNotifications` | `4` | จำนวน Notification ที่แสดงพร้อมกันสูงสุด |
| `DragThreshold` | `5` | ค่าระยะลากที่กำหนดใน Config |
| `ToggleDebounce` | `0.25` | ค่าหน่วง Toggle ที่กำหนดใน Config |

หมายเหตุ: ค่าบางตัวเป็นค่าภายในระบบ และไม่จำเป็นว่าจะมีผลหากแก้ `Library.Config` หลังสร้าง UI แล้ว

---

## โครงสร้าง Tab และ Section

### `CreateTab(opts)`

สร้าง Tab ใหม่และคืนค่าออบเจ็กต์ Tab โดยมี `Page` ให้ใช้เป็น Parent ของ Components

| ตัวเลือก | ชนิด | ความหมาย |
|---|---|---|
| `Name` | string | ชื่อ Tab |
| `Icon` | function | ฟังก์ชันวาดไอคอน เช่น `Library.Icons.Home` |
| `IsSettings` | boolean | ระบุว่าเป็น Tab ตั้งค่าแบบพิเศษ |
| `Order` | number | ลำดับที่ต้องการ หากรองรับโดยส่วนสร้าง Tab |

ตัวอย่าง:

```lua
local tab = Library.CreateTab({
    Name = "ฟาร์ม",
    Icon = Library.Icons.Egg,
})

print(tab.Name)
-- เพิ่ม Components ลง tab.Page
```

Tab ที่สร้างจะมีข้อมูลสำคัญ เช่น `Name`, `Index`, `Page`, `Button`, `Indicator`, `Label`, `IconHolder` และ `IsSettings`

### `CreateSection(parent, opts)`

สร้างกลุ่ม Components ที่จัดเรียงแนวตั้ง

| ตัวเลือก | ชนิด | ความหมาย |
|---|---|---|
| `Title` | string | ชื่อหัวข้อ Section (ไม่บังคับ) |
| `Order` | number | ลำดับ Section |
| `Name` | string | ชื่อภายในของ Section |

```lua
local section = Library.CreateSection(tab.Page, {
    Title = "การตั้งค่าฟาร์ม",
    Order = 1,
})
```

### `CreateDivider(parent, order)`

สร้างเส้นคั่นแนวนอนเพื่อแยกกลุ่ม UI

```lua
Library.CreateDivider(tab.Page, 2)
```

---

## Components ทั้งหมด

ตัวเลือกที่ไม่ระบุส่วนใหญ่จะใช้ค่าเริ่มต้นของไลบรารี หากไม่ส่ง `Callback` จะใช้ฟังก์ชันว่างแทน

### 1. Toggle — `CreateToggle(parent, opts)`

สวิตช์เปิด/ปิด และเรียก Callback ทุกครั้งที่สถานะเปลี่ยนจากการกด

| ตัวเลือก | ความหมาย |
|---|---|
| `Name` | ชื่อสวิตช์ |
| `Description` | คำอธิบายใต้ชื่อ |
| `Default` | ค่าเริ่มต้น `true` หรือ `false` |
| `Icon` | ไอคอนจาก `Library.Icons.*` |
| `Order` | ลำดับการแสดง |
| `Callback` | ฟังก์ชันรับค่า Boolean |
| `Floating` หรือ `FloatButton` | ถ้าเป็น `true` จะเพิ่มปุ่มโหมดลอยให้ Toggle |

```lua
Library.CreateToggle(section, {
    Name = "เปิดระบบตัวอย่าง",
    Description = "เปิดหรือปิดระบบ",
    Default = false,
    Icon = Library.Icons.Settings,
    Callback = function(enabled)
        print("สถานะ:", enabled)
    end,
})
```

เมื่อเปิด `Floating = true` จะมีปุ่ม `ลอย` เพื่อแสดง/ซ่อนแผงควบคุม Toggle แยกต่างหาก แผงลอยสามารถลากได้ และมีมุมจับปรับขนาดของแผงลอย

### 2. Button — `CreateButton(parent, opts)`

ปุ่มสั่งทำงานแบบครั้งเดียว

| ตัวเลือก | ความหมาย |
|---|---|
| `Name` | ข้อความปุ่ม |
| `Description` | คำอธิบาย |
| `Icon` | ไอคอน |
| `Color` | สีเน้นของปุ่ม |
| `Order` | ลำดับ |
| `Callback` | ฟังก์ชันที่จะทำงานเมื่อกด |

```lua
Library.CreateButton(section, {
    Name = "เรียกใช้งาน",
    Description = "ตัวอย่างปุ่ม",
    Icon = Library.Icons.Action,
    Color = Library.Theme.Accent,
    Callback = function()
        print("Button clicked")
    end,
})
```

### 3. Slider — `CreateSlider(parent, opts)`

ตัวเลื่อนค่าตัวเลข รองรับการลากและแก้ค่าจากช่องตัวเลขที่อยู่ในแถวเดียวกัน

| ตัวเลือก | ความหมาย |
|---|---|
| `Name` | ชื่อ Slider |
| `Min` / `Max` | ค่าต่ำสุด / สูงสุด |
| `Step` | ระยะเพิ่ม/ลดต่อขั้น |
| `Default` | ค่าเริ่มต้น |
| `Suffix` | ข้อความต่อท้ายค่า เช่น `%` |
| `Format` | ฟังก์ชันจัดรูปแบบข้อความแสดงค่า (ถ้ามี) |
| `Icon` | ไอคอน |
| `Order` | ลำดับ |
| `Callback` | รับค่าตัวเลขปัจจุบัน |

```lua
Library.CreateSlider(section, {
    Name = "ความเร็ว",
    Min = 1,
    Max = 10,
    Step = 1,
    Default = 3,
    Suffix = "x",
    Icon = Library.Icons.Run,
    Callback = function(value)
        print("ความเร็ว:", value)
    end,
})
```

ค่าที่ได้จะถูกจำกัดให้อยู่ในช่วง Min–Max และปัดตาม Step เมื่อมีการแก้ค่าจากช่องตัวเลข

### 4. Number Input — `CreateNumberInput(parent, opts)`

ช่องปรับตัวเลขพร้อมปุ่ม/การปรับค่าใน UI

| ตัวเลือก | ความหมาย |
|---|---|
| `Name` | ชื่อรายการ |
| `Min` / `Max` | ขอบเขตตัวเลข |
| `Step` | ระยะเปลี่ยนค่าต่อขั้น |
| `Default` | ค่าเริ่มต้น |
| `Suffix` | หน่วยหรือข้อความต่อท้าย |
| `Icon` | ไอคอน |
| `Order` | ลำดับ |
| `Callback` | รับค่าตัวเลข |

```lua
Library.CreateNumberInput(section, {
    Name = "จำนวน",
    Min = 0,
    Max = 100,
    Step = 5,
    Default = 20,
    Suffix = " ชิ้น",
    Callback = function(value)
        print(value)
    end,
})
```

### 5. Text Input — `CreateInput(parent, opts)`

ช่องรับข้อความจากผู้ใช้ ใช้สำหรับค่าข้อความ เช่น ชื่อหรือคำค้นหา

ตัวเลือกหลักที่ควรใช้ ได้แก่ `Name`, `Placeholder`, `Default`, `Icon`, `Order` และ `Callback` ทั้งนี้ควรตรวจชื่อ/พฤติกรรมของตัวเลือกจากเวอร์ชันซอร์สที่ใช้งานจริงก่อนเผยแพร่ตัวอย่างเฉพาะทาง

```lua
Library.CreateInput(section, {
    Name = "ชื่อผู้ใช้",
    Placeholder = "พิมพ์ข้อความ...",
    Default = "",
    Icon = Library.Icons.Pencil,
    Callback = function(value)
        print("ข้อความ:", value)
    end,
})
```

### 6. Keybind — `CreateKeybind(parent, opts)`

รายการตั้งค่าปุ่มคีย์บอร์ด เมื่อผู้ใช้เริ่มจับปุ่ม ระบบจะรับปุ่มที่กดและแสดงชื่อปุ่มปัจจุบัน

| ตัวเลือก | ความหมาย |
|---|---|
| `Name` | ชื่อรายการ |
| `Default` | ค่าเริ่มต้นประเภท `Enum.KeyCode` |
| `Icon` | ไอคอน |
| `Order` | ลำดับ |
| `Callback` | ตรวจซอร์สเวอร์ชันที่ใช้งานจริงเพื่อยืนยันว่ามี Callback เมื่อเปลี่ยนปุ่มหรือไม่ |

```lua
Library.CreateKeybind(section, {
    Name = "ปุ่มลัด",
    Default = Enum.KeyCode.G,
    Icon = Library.Icons.Keybind,
})
```

ตัว Component คืนค่า 3 ค่า: แถว UI, ฟังก์ชันอ่านปุ่มปัจจุบัน และฟังก์ชันตั้งปุ่มใหม่

```lua
local row, getKey, setKey = Library.CreateKeybind(section, {
    Name = "ปุ่มลัด",
    Default = Enum.KeyCode.G,
})
print(getKey().Name)
setKey(Enum.KeyCode.H)
```

### 7. Dropdown — `CreateDropdown(parent, opts)`

รายการเลือกหนึ่งตัวเลือกจากรายการที่กำหนด

| ตัวเลือก | ความหมาย |
|---|---|
| `Name` | ชื่อ Dropdown |
| `Options` | Array ของตัวเลือก |
| `Default` | ค่าที่เลือกเริ่มต้น (ถ้าไม่ระบุจะใช้ตัวเลือกแรก) |
| `Icon` | ไอคอน |
| `Order` | ลำดับ |
| `Callback` | รับค่าที่ผู้ใช้เลือก |

```lua
Library.CreateDropdown(section, {
    Name = "โหมด",
    Options = {"ปกติ", "เร็ว", "ประหยัด"},
    Default = "ปกติ",
    Icon = Library.Icons.Dropdown,
    Callback = function(value)
        print("เลือก:", value)
    end,
})
```

คืนค่า 3 ค่า: ตัว UI, ฟังก์ชันอ่านค่าปัจจุบัน และฟังก์ชันตั้งค่า

```lua
local control, getValue, setValue = Library.CreateDropdown(section, {
    Name = "โหมด",
    Options = {"A", "B", "C"},
    Default = "A",
})
print(getValue())
setValue("B")
```

### 8. Label — `CreateLabel(parent, opts)`

ข้อความบรรทัดเดียว เหมาะกับชื่อหรือสถานะสั้น ๆ

| ตัวเลือก | ความหมาย |
|---|---|
| `Text` | ข้อความ |
| `Color` | สีข้อความ |
| `Size` | ขนาดตัวอักษรตั้งต้น |
| `Height` | ความสูง Label |
| `Bold` | ใช้ตัวหนาเมื่อเป็น `true` |
| `Align` | ค่า `Enum.TextXAlignment` |
| `Order` | ลำดับ |

```lua
Library.CreateLabel(section, {
    Text = "สถานะ: พร้อม",
    Size = 14,
    Bold = true,
})
```

### 9. Paragraph — `CreateParagraph(parent, opts)`

ข้อความหลายบรรทัดที่ตัดบรรทัดอัตโนมัติ

| ตัวเลือก | ความหมาย |
|---|---|
| `Text` | เนื้อหา |
| `Color` | สีข้อความ |
| `Size` | ขนาดตัวอักษร |
| `Order` | ลำดับ |

```lua
Library.CreateParagraph(section, {
    Text = "คำอธิบายแบบยาว สามารถแสดงหลายบรรทัดและปรับความสูงตามข้อความ",
    Size = 12,
})
```

### 10. Player List — `CreatePlayerList(parent, opts)`

สร้างรายการผู้เล่นในเซิร์ฟเวอร์ โดยซอร์สเรียงตามชื่อที่แสดง/ชื่อผู้เล่น และไม่แสดง LocalPlayer

| ตัวเลือก | ความหมาย |
|---|---|
| `OnSelect` | Callback เมื่อเลือกผู้เล่น |
| `AccentColor` | สีเน้นของรายการ |
| `Order` | ลำดับ |

```lua
Library.CreatePlayerList(section, {
    AccentColor = Library.Theme.Accent,
    Order = 10,
    OnSelect = function(player)
        print("เลือกผู้เล่น:", player.Name)
    end,
})
```

Callback ของ Player List รับออบเจ็กต์ Player ที่ถูกเลือก

---

## ระบบตั้งค่า GUI

Tab `ตั้งค่า GUI` ถูกสร้างโดยไลบรารีให้อัตโนมัติ ไม่จำเป็นต้องสร้างซ้ำ

### รูปลักษณ์หลัก

- **ขนาดตัวอักษร:** ปรับสเกลข้อความ มีช่วงที่กำหนดไว้ `0.50` ถึง `3.00` และ Step `0.05`
- **ความหนาอักษร:** `Regular`, `Medium`, `SemiBold`, `Bold`, `ExtraBold`, `Heavy`

ค่าเริ่มต้นจากซอร์ส: `TextScale = 1.30`, `FontWeight = "Bold"`

### สีและธีม

ชุดสีหลักที่มีใน Dropdown:

| ชุดสี | Accent | AccentSoft | AccentLight |
|---|---|---|---|
| น้ำเงินฟ้า | `RGB(0,132,255)` | `RGB(0,90,190)` | `RGB(90,180,255)` |
| ม่วงไฟฟ้า | `RGB(145,70,255)` | `RGB(100,45,190)` | `RGB(190,145,255)` |
| เขียวมรกต | `RGB(0,205,140)` | `RGB(0,145,100)` | `RGB(110,240,190)` |
| แดงคริมสัน | `RGB(235,55,85)` | `RGB(175,30,55)` | `RGB(255,125,145)` |
| ทอง | `RGB(235,175,45)` | `RGB(165,115,20)` | `RGB(255,215,100)` |
| ขาวดำ | `RGB(230,230,230)` | `RGB(150,150,150)` | `RGB(255,255,255)` |

มีแถบเลือกสีพื้นหลังเป็นช่องสี (swatches) ด้วย สีพื้นหลังที่กำหนดในซอร์สประกอบด้วย:

- ดำ — `RGB(12,12,16)`
- เทาเข้ม — `RGB(30,32,38)`
- ม่วงเข้ม — `RGB(24,15,38)`
- น้ำเงินเข้ม — `RGB(8,24,48)`
- เขียวเข้ม — `RGB(10,32,28)`
- แดงเข้ม — `RGB(38,14,22)`
- เทาน้ำเงิน — `RGB(28,38,54)`

พื้นหลังเริ่มต้นของ Theme คือ `RGB(10,16,32)` ส่วนสีพื้นหลังในรายการเลือกเป็นชุดสีเพิ่มเติม

### บันทึก / คืนค่า

- **บันทึกการตั้งค่า:** บันทึกธีม ขนาดตัวอักษร ความหนาอักษร และตำแหน่งหน้าต่าง/โลโก้ลงไฟล์ JSON หากมีระบบไฟล์
- **โหลดการตั้งค่า:** โหลดข้อมูลจากไฟล์เดิม
- **รีเซ็ตกลับค่าเดิม:** คืนสี ขนาดข้อความ และความหนาอักษรเป็นค่าเริ่มต้น

---

## ระบบบันทึกการตั้งค่า

ชื่อไฟล์ที่กำหนดในซอร์ส:

```text
RUNLUA_HUB_SETTINGS.json
```

โครงสร้างข้อมูลมีเวอร์ชัน, `UserScale`, `TextScale`, `FontWeight`, `Theme`, `MainPosition` และ `PillPosition`

API:

```lua
local settings = Library.Settings

local data = settings.Get()       -- อ่านค่าปัจจุบันเป็นตาราง
local ok, message = settings.Save()
local ok2, message2 = settings.Load()
settings.Reset()
settings.Apply(data)
local canSaveToFile = settings.GetStorageAvailable()
print(settings.FileName, settings.Version)
```

ข้อควรทราบ:

- การบันทึกถาวรต้องอาศัย `isfile`, `readfile` และ `writefile`
- หากไม่มี API เหล่านี้ การตั้งค่าอาจเก็บได้เพียงในหน่วยความจำของเซสชันปัจจุบัน
- การ Reset ในซอร์สคืนค่ารูปลักษณ์ แต่ไม่ใช่การลบไฟล์ JSON ที่เคยบันทึกโดยอัตโนมัติ
- การตั้งค่าบางอย่าง เช่น ขนาดหน้าต่าง อาจถูกคำนวณใหม่ตาม Responsive Layout

---

## Notifications

เรียกแจ้งเตือนผ่าน `Library.Notify(opts)`

| ตัวเลือก | ความหมาย |
|---|---|
| `Title` | หัวข้อ (ค่าเริ่มต้น `แจ้งเตือน`) |
| `Message` | รายละเอียด |
| `Duration` | เวลาแสดงเป็นวินาที (ค่าเริ่มต้น 3) |
| `Color` | สีเน้น |
| `Icon` | ฟังก์ชันวาดไอคอน (ค่าเริ่มต้น `Library.Icons.Home`) |

```lua
Library.Notify({
    Title = "บันทึกสำเร็จ",
    Message = "บันทึกการตั้งค่าแล้ว",
    Duration = 3,
    Color = Library.Theme.Success,
    Icon = Library.Icons.Save,
})
```

ระบบมีคิว Notification และกำหนดให้แสดงพร้อมกันสูงสุด 4 รายการตาม `Config.MaxNotifications`

---

## Icons และ Asset ID ทั้งหมด

ไอคอนเรียกใช้ผ่าน `Library.Icons.<ชื่อ>` ซึ่งเป็นฟังก์ชันวาดภาพ ไม่ใช่ตัวเลข Asset ID โดยตรง ตัวอย่าง `Library.Icons.Home`

> คำอธิบายด้านล่างเป็นการตีความจากชื่อที่ตั้งไว้ในซอร์ส ไม่ใช่การยืนยันรูปร่างภาพจริงทุก Asset ID ควรเปิดตรวจภาพใน Roblox ก่อนใช้งานจริง

### ไอคอนที่มีชื่อเรียกใน `Library.Icons`

| ชื่อที่เรียก | Asset ID | ความหมาย/การใช้งานตามชื่อ |
|---|---:|---|
| `Home` | `81381827579989` | หน้าแรก |
| `Player` | `18854794429` | ผู้เล่น |
| `Person` | `18854794429` | บุคคล (Alias ของ Player) |
| `ESP` | `1137376344` | ESP / การมองเห็นข้อมูลวัตถุ |
| `Float` | `114167292947807` | โหมดลอย / ไอคอนดาวแบบที่ 2 |
| `Teleport` | `76761366176541` | พิกัด / เทเลพอร์ต |
| `Fling` | `13050670483` | หมัด / ผลัก |
| `Settings` | `135274678904780` | ตั้งค่า |
| `Action` | `118550787033099` | ยืนยัน / การกระทำ |
| `Correct` | `118550787033099` | ถูกต้อง (Alias ของ Action) |
| `Minimize` | `118924374112009` | ย่อหน้าต่าง |
| `Close` | `16844961944` | ปิด |
| `Slider` | `8587689327` | สไลเดอร์ / สัญญาณ |
| `Pencil` | `16417283031` | แก้ไข |
| `Keybind` | `82866471491531` | ปุ่มลัด / Wi-Fi (ชื่อ Asset ใน Registry คือ WiFi) |
| `Dropdown` | `96140958199506` | เมนู / Dropdown |
| `Book` | `90777101549927` | หนังสือ |
| `Save` | `113712416335562` | บันทึก |
| `Cloud` | `7013266261` | คลาวด์ / โหลดจากที่เก็บ |
| `Diamond` | `6788518059` | เพชร |
| `Shop` | `11807308307` | ร้านค้า |
| `Bag` | `13933329303` | กระเป๋า |
| `Thunder` | `123699649588161` | สายฟ้า |
| `Run` | `10507122439` | วิ่ง |
| `Gun` | `15286668313` | ปืน |
| `Map` | `14240466966` | แผนที่ |
| `Rocket` | `16149155554` | จรวด |
| `Box` | `89528045721909` | กล่อง |
| `Crystal` | `12814035490` | คริสตัล |
| `Egg` | `86058422496634` | ไข่ |
| `Star` | `95134188293701` | ดาว |
| `Star2` | `114167292947807` | ดาวแบบที่ 2 |
| `Search` | `132302594577680` | ค้นหา |
| `Target` | `100986564809027` | เป้าหมาย |
| `Target2` | `13577839026` | เป้าหมายแบบที่ 2 |
| `Discord` | `110769239384778` | Discord |
| `YouTube` | `85469926655680` | YouTube |
| `Reset` | `4343875685` | รีเซ็ต |
| `Swords` | `7485051733` | ดาบ |
| `File` | `92272038372516` | ไฟล์ |
| `Gift` | `90596283238411` | ของขวัญ |
| `Fruit` | `130882648` | ผลไม้ |
| `Fish` | `114366026221277` | ปลา |
| `Dinosaur` | `15232707578` | ไดโนเสาร์ |
| `Word` | `121176334529781` | ข้อความ / Word |
| `Sound` | `117386765962827` | เสียง |
| `Airplane` | `2189714464` | เครื่องบิน |
| `Smile` | `11955884989` | หน้ายิ้ม |
| `Pin1` | `94180059461552` | หมุดตำแหน่งแบบที่ 1 |
| `Pin2` | `78174345206454` | หมุดตำแหน่งแบบที่ 2 |
| `Hook` | `14376301503` | ตะขอ |
| `Fishing` | `74554825003519` | คันเบ็ด |
| `Spoon` | `73443323737499` | ช้อน |
| `Resize` | `9052792546` | ปรับขนาด |

### Asset ID ที่อยู่ใน Registry แต่ไม่มีฟังก์ชัน `Library.Icons` แยกตามชื่อนั้นโดยตรง

| ชื่อใน Registry | Asset ID | ความหมายตามชื่อ |
|---|---:|---|
| `ThreeLines` | `15567843411` | เส้นสามเส้น / เมนู |
| `SwordsAndKnives` | `7485051733` | ดาบและมีด |
| `target2` | `13577839026` | เป้าหมายแบบที่ 2 |
| `Correct` | `118550787033099` | เครื่องหมายถูก |
| `Crystal` | `12814035490` | คริสตัล |
| `star2` | `114167292947807` | ดาวแบบที่ 2 |
| `word` | `121176334529781` | Word / ข้อความ |
| `sound` | `117386765962827` | เสียง |
| `fruit` | `130882648` | ผลไม้ |
| `file` | `92272038372516` | ไฟล์ |
| `book` | `90777101549927` | หนังสือ |
| `pencil` | `16417283031` | ดินสอ |
| `gun` | `15286668313` | ปืน |
| `map` | `14240466966` | แผนที่ |
| `coordinates` | `76761366176541` | พิกัด |
| `airplane` | `2189714464` | เครื่องบิน |
| `rocket` | `16149155554` | จรวด |
| `smile` | `11955884989` | หน้ายิ้ม |
| `gift` | `90596283238411` | ของขวัญ |
| `bag` | `13933329303` | กระเป๋า |
| `fish` | `114366026221277` | ปลา |
| `WiFi` | `82866471491531` | Wi-Fi |
| `signal` | `8587689327` | สัญญาณ |
| `dinosaur` | `15232707578` | ไดโนเสาร์ |
| `box` | `89528045721909` | กล่อง |
| `thunder` | `123699649588161` | สายฟ้า |
| `reset` | `4343875685` | รีเซ็ต |
| `diamond` | `6788518059` | เพชร |
| `punch` | `13050670483` | หมัด |
| `spoon` | `73443323737499` | ช้อน |
| `menu` | `96140958199506` | เมนู |
| `meun2` | `77038338415780` | เมนูแบบที่ 2 (สะกดตามซอร์ส) |
| `cloud` | `7013266261` | คลาวด์ |
| `short` | `118924374112009` | ไอคอนย่อ |
| `cross` | `16844961944` | กากบาท / ปิด |
| `Resize` | `9052792546` | ปรับขนาด |

### โลโก้หลัก

| รายการ | Asset ID |
|---|---:|
| โลโก้ `RUNLUA HUB` บนปุ่มลอย | `74536582053430` |

### วิธีใช้ไอคอน

```lua
Library.CreateButton(section, {
    Name = "เปิดร้านค้า",
    Icon = Library.Icons.Shop,
    Callback = function()
        print("เปิดร้านค้า")
    end,
})
```

ถ้าต้องการตรวจสอบ ID ให้เปิดหน้า Asset ของ Roblox โดยแทน `<ID>` ด้วยตัวเลข Asset ID:

```text
https://www.roblox.com/library/<ID>
```

Roblox อาจเปลี่ยนรูปแบบหน้า Asset หรือจำกัดการมองเห็นตามสิทธิ์/สถานะ Asset ได้ และการเปิดหน้าเว็บไม่รับประกันว่า Asset จะใช้แสดงในเกมได้

---

## Theme และ Config

### Theme

`Library.Theme` เปิดให้เข้าถึงตารางสีของธีม ตัวอย่างคีย์หลัก:

| คีย์ | ค่าเริ่มต้น RGB | ใช้กับ |
|---|---|---|
| `Background` | `(10,16,32)` | พื้นหลังหลัก |
| `Surface` | `(18,28,50)` | พื้นหลังแถว/การ์ด |
| `SurfaceAlt` | `(24,36,60)` | พื้นหลังรอง |
| `SurfaceHover` | `(30,44,74)` | สี Hover |
| `Accent` | `(0,132,255)` | สีเน้นหลัก |
| `AccentSoft` | `(0,90,190)` | สีเน้นรอง |
| `AccentLight` | `(90,180,255)` | สีเน้นสว่าง |
| `Text` | `(232,240,255)` | ข้อความหลัก |
| `TextMuted` | `(140,160,200)` | ข้อความรอง |
| `Border` | `(38,60,105)` | เส้นขอบ |
| `Success` | `(0,180,120)` | สถานะสำเร็จ |
| `Danger` | `(220,60,80)` | สถานะผิดพลาด/อันตราย |
| `Warning` | `(240,180,60)` | คำเตือน |
| `SwitchOff` | `(40,52,76)` | Toggle ปิด |
| `White` | `(255,255,255)` | สีขาว |
| `IconGradStart` | `(255,255,255)` | สีเริ่ม Gradient ไอคอน |
| `IconGradEnd` | `(0,195,255)` | สีปลาย Gradient ไอคอน |
| `IconGradAngle` | `-45` | มุม Gradient |
| `IconDim` | `(120,135,165)` | สีไอคอนที่ไม่ Active |

ตัวอย่างอ่านค่า:

```lua
print(Library.Theme.Accent)
```

แม้ตาราง Theme จะถูกส่งออกมา แต่การแก้ค่าโดยตรงหลังสร้าง UI อาจไม่ทำให้ทุกออบเจ็กต์เปลี่ยนทันที เพราะการอัปเดตสีใช้ระบบ Theme binding ภายในและขึ้นกับ Component นั้น ๆ

### Config

`Library.Config` เปิดเผยค่าการจัดวาง/แอนิเมชันที่ระบุไว้ในหัวข้อ Responsive ควรปรับอย่างระมัดระวัง และทดสอบทั้ง PC กับมือถือหลังแก้ค่า

---

## API ที่ Library ส่งออก

รายการต่อไปนี้เป็น API ที่พบในตาราง `Library` ตอนท้ายซอร์ส:

| API | คำอธิบาย |
|---|---|
| `Theme` | ตารางสีของ UI |
| `Config` | ค่าการจัดวางและแอนิเมชัน |
| `Icons` | ฟังก์ชันวาดไอคอน |
| `Tabs` | รายการ Tab ที่สร้าง |
| `Notify(opts)` | แสดง Notification |
| `CreateTab(opts)` | สร้าง Tab |
| `CreateSection(parent, opts)` | สร้าง Section |
| `CreateDivider(parent, order)` | สร้างเส้นคั่น |
| `CreateToggle(parent, opts)` | สร้าง Toggle |
| `CreateButton(parent, opts)` | สร้าง Button |
| `CreateSlider(parent, opts)` | สร้าง Slider |
| `CreateNumberInput(parent, opts)` | สร้างช่องตัวเลข |
| `CreateInput(parent, opts)` | สร้างช่องข้อความ |
| `CreateKeybind(parent, opts)` | สร้าง Keybind |
| `CreateDropdown(parent, opts)` | สร้าง Dropdown |
| `CreateLabel(parent, opts)` | สร้าง Label |
| `CreateParagraph(parent, opts)` | สร้าง Paragraph |
| `CreatePlayerList(parent, opts)` | สร้างรายชื่อผู้เล่น |
| `SetToggleKey(keyCode)` | ตั้งปุ่มเปิด/ปิด UI |
| `GetToggleKey()` | อ่านปุ่มเปิด/ปิด UI |
| `SelectTab(tab)` | เลือก Tab |
| `Show()` | แสดงหน้าต่างหลัก |
| `Hide()` | ซ่อนหน้าต่างหลัก |
| `Destroy()` | ปิดและล้าง UI |
| `IsMobile` | บอกว่าอุปกรณ์ถูกตรวจเป็นมือถือหรือไม่ |
| `Platform` | ชื่อแพลตฟอร์มที่ตรวจพบ |
| `ScreenGui` | ออบเจ็กต์ ScreenGui |
| `MainFrame` | ออบเจ็กต์หน้าต่างหลัก |
| `SettingsTab` | Tab ตั้งค่า GUI |
| `UILock` | API ตรวจ/ยึด/ปล่อยสิทธิ์ควบคุม UI |
| `Settings` | API อ่าน บันทึก โหลด รีเซ็ต และใช้ค่าตั้งค่า |

### UILock

```lua
print(Library.UILock.IsOwner())
print(Library.UILock.GetOwner())

-- ใช้เฉพาะเมื่อเข้าใจผลกระทบของการเปลี่ยนสิทธิ์
Library.UILock.Release()
Library.UILock.Acquire()
```

`SessionId` เป็นรหัสเซสชันปัจจุบัน ไม่ควรนำไปใช้เป็นรหัสลับหรือข้อมูลยืนยันตัวตน

### Show / Hide / Destroy

```lua
Library.Show()    -- แสดงหน้าต่างหลัก
Library.Hide()    -- ซ่อนหน้าต่างหลัก แต่คงปุ่มโลโก้ไว้
Library.Destroy() -- ทำลาย UI และยกเลิก Connections
```

---

## ตัวอย่างการใช้งาน

ตัวอย่างรวม Components หลายชนิดไว้ใน Tab เดียว:

```lua
local Library = loadstring(game:HttpGet("URL_ของไฟล์ไลบรารี"))()

local tab = Library.CreateTab({
    Name = "ตัวอย่าง",
    Icon = Library.Icons.Home,
})

local section = Library.CreateSection(tab.Page, {
    Title = "ตัวควบคุม",
    Order = 1,
})

Library.CreateLabel(section, {
    Text = "ตัวอย่าง UI Library",
    Size = 14,
    Bold = true,
})

Library.CreateParagraph(section, {
    Text = "ส่วนนี้สาธิตการสร้างตัวควบคุมพื้นฐาน",
    Size = 12,
})

Library.CreateToggle(section, {
    Name = "เปิดใช้งาน",
    Default = false,
    Callback = function(state)
        print("Toggle:", state)
    end,
})

Library.CreateButton(section, {
    Name = "แจ้งเตือน",
    Icon = Library.Icons.Discord,
    Callback = function()
        Library.Notify({
            Title = "ตัวอย่าง",
            Message = "เรียก Notification สำเร็จ",
            Duration = 3,
        })
    end,
})

Library.CreateSlider(section, {
    Name = "ระดับ",
    Min = 0,
    Max = 100,
    Step = 5,
    Default = 25,
    Suffix = "%",
    Callback = function(value)
        print("Slider:", value)
    end,
})

Library.CreateDropdown(section, {
    Name = "คุณภาพ",
    Options = {"ต่ำ", "กลาง", "สูง"},
    Default = "กลาง",
    Callback = function(value)
        print("Dropdown:", value)
    end,
})

Library.CreateInput(section, {
    Name = "ข้อความ",
    Placeholder = "พิมพ์ที่นี่",
    Default = "",
    Callback = function(value)
        print("Input:", value)
    end,
})
```

> เนื่องจากรายละเอียดตัวเลือกของ `CreateInput` และพฤติกรรม Callback บางส่วนอาจเปลี่ยนระหว่างเวอร์ชัน ควรทดสอบตัวอย่างกับไฟล์ที่นำไปเผยแพร่จริงก่อนประกาศว่าเป็น API ที่รับประกันความเข้ากันได้

---

## ข้อจำกัดและการแก้ปัญหา

### UI ไม่แสดง

1. ตรวจสอบว่า Loader URL ถูกต้องและเข้าถึงได้
2. ตรวจสอบ Output/Console ว่ามี error ระหว่างโหลดหรือไม่
3. ตรวจสอบว่าอุปกรณ์/สภาพแวดล้อมอนุญาตให้รันโค้ดและสร้าง UI ในตำแหน่งที่ใช้หรือไม่
4. หากมี UI instance เก่าค้างอยู่ ให้ปิด/ทำ Cleanup ของสคริปต์ก่อนหน้า แล้วลองใหม่

### แจ้งว่า UI ถูกล็อก

ไลบรารีมีระบบ Lock ผ่าน `_G.RUNLUA_HUB_LOCK` หากมีเซสชันอื่นถือสิทธิ์อยู่ UI ปัจจุบันอาจไม่รับคำสั่ง ให้รอเซสชันเก่าปล่อยล็อกหรือ Cleanup เซสชันเก่าก่อน ไม่ควรบังคับแก้ Global lock โดยไม่เข้าใจผลกระทบ

### การตั้งค่าไม่บันทึกถาวร

ตรวจว่า Runtime มี `isfile`, `readfile`, `writefile` หรือไม่ ถ้าไม่มี ไลบรารีจะแจ้งว่าบันทึกได้เฉพาะหน่วยความจำของเซสชัน

### ไอคอนว่างหรือไม่ตรง

- ตรวจ Asset ID และสิทธิ์การใช้งานของ Asset
- ตรวจว่าภาพนั้นยังมีอยู่และ Roblox อนุญาตให้แสดงในบริบทที่ใช้งาน
- Asset ID ในคู่มือถอดตาม Registry ในซอร์ส ไม่ได้ยืนยันรูปร่างภาพจากการเปิดดู Asset จริง

### Callback ไม่ทำงานตามที่คาด

- ตรวจสะกด `Callback` และรูปแบบ `function(value) ... end`
- Toggle ส่ง Boolean; Slider/Number Input ส่งตัวเลข; Dropdown ส่งค่าที่เลือก; Player List ส่ง Player
- หลีกเลี่ยงการทำงานหนักใน Callback และใช้ `pcall` เมื่อจำเป็นต้องกันข้อผิดพลาด

### ปิด UI อย่างถูกต้อง

ใช้ `Library.Destroy()` เพื่อเรียก Cleanup ซึ่งจะยกเลิก Connections ล้างคิว Notification และทำลาย ScreenGui

---

## ข้อมูลเวอร์ชันเอกสาร

- ชื่อไลบรารี: RUNLUA HUB • UI Library
- ไฟล์ต้นฉบับที่ใช้จัดทำ: `UIตัวใหม่ล่าสุด.txt`
- วันที่จัดทำ: 2026-10-18
- รูปแบบ: Markdown สำหรับ GitHub (`README.md`)
- เอกสารนี้อ้างอิงซอร์สที่ตรวจสอบ ไม่ได้ถอดหรือเผยแพร่โค้ดที่ถูก Obfuscate เพิ่มเติม

หากมีการเปลี่ยน API หรือเพิ่มไอคอนในอนาคต ควรอัปเดตตาราง API และ Asset ID ให้ตรงกับซอร์สเวอร์ชันที่เผยแพร่จริง

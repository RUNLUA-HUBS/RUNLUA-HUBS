# RUNLUA HUB UI Library --- คู่มือการใช้งาน

เอกสารนี้อ้างอิงจากไฟล์ `UInew.lua` และรวบรวม API ที่ไลบรารีเปิดให้ใช้งาน ตัวอย่างเป็น
Luau สำหรับ Roblox

> **หมายเหตุ:** ไลบรารีนี้เป็น UI ฝั่ง Client ไม่ได้สร้างระบบเกมหรือ RemoteEvent
> ให้เอง ฟังก์ชัน `Callback` ใช้เชื่อมต่อกับโค้ดของผู้ใช้
> และควรใช้เฉพาะในเกม/ประสบการณ์ที่คุณมีสิทธิ์ทดสอบหรือพัฒนา

## สารบัญ

-   [1. ติดตั้งและเรียกใช้](#1-ติดตั้งและเรียกใช้)
-   [2. รูปแบบการสร้าง UI](#2-รูปแบบการสร้าง-ui)
-   [3. API ของไลบรารี](#3-api-ของไลบรารี)
-   [4. รายละเอียดคอมโพเนนต์](#4-รายละเอียดคอมโพเนนต์)
-   [5. การแจ้งเตือน](#5-การแจ้งเตือน)
-   [6. แท็บและการควบคุมหน้าต่าง](#6-แท็บและการควบคุมหน้าต่าง)
-   [7. การตั้งค่าและบันทึกค่า](#7-การตั้งค่าและบันทึกค่า)
-   [8. ธีม ไอคอน และข้อมูลแพลตฟอร์ม](#8-ธีม-ไอคอน-และข้อมูลแพลตฟอร์ม)
-   [9. ตัวอย่างเต็ม](#9-ตัวอย่างเต็ม)
-   [10. ข้อควรทราบและแก้ปัญหา](#10-ข้อควรทราบและแก้ปัญหา)

## 1. ติดตั้งและเรียกใช้

วาง `UInew.lua` ในตำแหน่งที่โปรเจกต์ของคุณเข้าถึงได้
แล้วเรียกใช้ตามวิธีโหลดไฟล์ของสภาพแวดล้อมที่ใช้งาน ตัวอย่างต่อไปนี้สมมติว่าไฟล์ถูกจัดเก็บเป็น
`ModuleScript`:

``` lua
local Library = require(path.to.UInew)
```

ไฟล์จะคืนค่า `Library` และกำหนดตารางเดียวกันไว้ที่ `_G.RUNLUA_HUB`

หากใช้ไฟล์ผ่าน URL ให้ใช้ URL ที่ชี้ไปยังไฟล์ Lua ที่คุณเผยแพร่เอง และตรวจสอบว่า URL
นั้นคืนเนื้อหา Lua โดยตรง ทั้งนี้ `require()` ของ Roblox ปกติไม่สามารถ require URL
ทั่วไปได้โดยตรง

## 2. รูปแบบการสร้าง UI

คอมโพเนนต์ส่วนใหญ่ต้องรับ `parent` และตาราง `opts`:

``` lua
local tab = Library.CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local section = Library.CreateSection(tab, {
    Title = "ข้อมูลทั่วไป",
})

Library.CreateLabel(section, {
    Text = "ยินดีต้อนรับสู่ RUNLUA HUB",
    Bold = true,
})
```

-   `parent` คือ GUI Instance ที่จะใส่คอมโพเนนต์เข้าไป โดยทั่วไปใช้ค่าที่
    `CreateTab()` คืนมา
-   `opts` คือตารางตั้งค่าคอมโพเนนต์ แต่ละชนิดรองรับตัวเลือกต่างกัน
-   `Order` ใช้กำหนดลำดับการแสดงผลในรายการที่รองรับ หากไม่ระบุ
    ไลบรารีจะกำหนดลำดับให้อัตโนมัติ
-   callback จะถูกเรียกเมื่อผู้ใช้โต้ตอบกับคอมโพเนนต์นั้น

## 3. API ของไลบรารี

API หลักที่ไฟล์ส่งออก:

  API                                 รายละเอียด
  ----------------------------------- -------------------------------------------------
  `CreateTab(opts)`                   สร้างแท็บและคืนหน้า ScrollingFrame สำหรับใส่คอมโพเนนต์
  `CreateSection(parent, opts)`       สร้างหัวข้อ/ส่วนแบ่งกลุ่ม
  `CreateDivider(parent, order)`      สร้างเส้นแบ่ง
  `CreateToggle(parent, opts)`        สร้างสวิตช์เปิด/ปิด
  `CreateButton(parent, opts)`        สร้างปุ่มกด
  `CreateSlider(parent, opts)`        สร้างแถบเลื่อนตัวเลข
  `CreateNumberInput(parent, opts)`   สร้างช่องกรอกตัวเลข
  `CreateInput(parent, opts)`         สร้างช่องกรอกข้อความ
  `CreateKeybind(parent, opts)`       สร้างตัวเลือกปุ่มลัด
  `CreateDropdown(parent, opts)`      สร้างรายการตัวเลือกแบบดรอปดาวน์
  `CreateLabel(parent, opts)`         สร้างข้อความบรรทัดเดียว
  `CreateParagraph(parent, opts)`     สร้างข้อความหลายบรรทัด
  `CreatePlayerList(parent, opts)`    สร้างรายชื่อผู้เล่นพร้อมข้อมูลเลือด
  `Notify(opts)`                      แสดงการแจ้งเตือน
  `SelectTab(tab)`                    เลือก/เปิดแท็บที่สร้างไว้
  `Show()` / `Hide()`                 แสดงหรือซ่อนหน้าต่างหลัก
  `Destroy()`                         ปิดและล้าง UI/การเชื่อมต่อของไลบรารี
  `SetToggleKey(keyCode)`             ตั้งปุ่มเปิด/ซ่อนหน้าต่าง
  `GetToggleKey()`                    อ่านปุ่มเปิด/ซ่อนปัจจุบัน
  `IsMobile`                          Boolean บอกว่าไลบรารีตรวจพบอุปกรณ์มือถือหรือไม่
  `Platform`                          ชื่อแพลตฟอร์มที่ตรวจพบ
  `Theme`                             ตารางสีธีมปัจจุบัน
  `Config`                            ตารางค่าการจัดวางและแอนิเมชัน
  `Icons`                             ตารางฟังก์ชันวาดไอคอน
  `Tabs`                              ตารางแท็บภายในไลบรารี
  `ScreenGui`                         GUI หลัก
  `MainFrame`                         เฟรมหน้าต่างหลัก
  `SettingsTab`                       แท็บตั้งค่าที่ไลบรารีสร้างไว้
  `UILock`                            API ตรวจสอบ/จัดการล็อก UI
  `Settings`                          API อ่าน บันทึก โหลด และรีเซ็ตการตั้งค่า

## 4. รายละเอียดคอมโพเนนต์

### 4.1 `CreateTab(opts)`

สร้างแท็บใหม่และคืน `ScrollingFrame` ของหน้าแท็บ เพื่อนำไปใช้เป็น `parent`
ของคอมโพเนนต์อื่น

  ตัวเลือก         ชนิด        ค่าเริ่มต้น/คำอธิบาย
  -------------- ---------- -----------------------------
  `Name`         string     `"แท็บ"`
  `Icon`         function   `Library.Icons.Home`
  `Order`        number     ลำดับแท็บ; ถ้าไม่ระบุใช้ลำดับที่สร้าง
  `IsSettings`   boolean    ระบุว่าเป็นแท็บตั้งค่า

``` lua
local home = Library.CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
    Order = 1,
})
```

### 4.2 `CreateSection(parent, opts)`

สร้างหัวข้อเพื่อจัดกลุ่มคอมโพเนนต์

  ตัวเลือก    ชนิด      คำอธิบาย
  --------- -------- ------------------
  `Title`   string   ข้อความหัวข้อ
  `Name`    string   ชื่อสำรองที่โค้ดรองรับ
  `Order`   number   ลำดับการแสดงผล

``` lua
local section = Library.CreateSection(home, {
    Title = "การตั้งค่าทั่วไป",
})
```

### 4.3 `CreateDivider(parent, order)`

สร้างเส้นแบ่งแนวนอนระหว่างกลุ่มคอมโพเนนต์ รับ `parent` และ `order` (ตัวเลขลำดับ
ซึ่งละได้)

``` lua
Library.CreateDivider(home)
```

### 4.4 `CreateToggle(parent, opts)`

สร้างสวิตช์เปิด/ปิด คืนค่า 3 ค่า: `row`, ฟังก์ชันอ่านสถานะปัจจุบัน และฟังก์ชันตั้งสถานะ

  ตัวเลือก                       ชนิด        ค่าเริ่มต้น/คำอธิบาย
  ---------------------------- ---------- -----------------------------------
  `Name`                       string     ชื่อสวิตช์
  `Description`                string     คำอธิบายใต้ชื่อ
  `Default`                    boolean    ค่าเริ่มต้น ปกติเป็น `false`
  `Callback`                   function   ถูกเรียกเมื่อสถานะเปลี่ยน โดยรับ boolean
  `Icon`                       function   ฟังก์ชันวาดไอคอนจาก `Library.Icons`
  `Order`                      number     ลำดับ
  `Floating` / `FloatButton`   boolean    ตัวเลือกโหมดปุ่มลอยที่โค้ดรองรับ

``` lua
local row, getEnabled, setEnabled = Library.CreateToggle(home, {
    Name = "เปิดระบบตัวอย่าง",
    Description = "ตัวอย่างสวิตช์เปิด/ปิด",
    Default = false,
    Callback = function(enabled)
        print("สถานะ:", enabled)
    end,
})

-- อ่านสถานะและเปลี่ยนสถานะจากโค้ด
print(getEnabled())
setEnabled(true)
```

### 4.5 `CreateButton(parent, opts)`

สร้างปุ่มกด คืน Instance ของแถวปุ่ม

  ตัวเลือก          ชนิด        คำอธิบาย
  --------------- ---------- ---------------
  `Name`          string     ข้อความบนปุ่ม
  `Description`   string     คำอธิบายเพิ่มเติม
  `Callback`      function   ทำงานเมื่อกดปุ่ม
  `Color`         Color3     สีปุ่มที่กำหนดเอง
  `Icon`          function   ฟังก์ชันวาดไอคอน
  `Order`         number     ลำดับ

``` lua
Library.CreateButton(home, {
    Name = "ทดสอบ",
    Description = "แสดงข้อความใน Output",
    Callback = function()
        print("กดปุ่มแล้ว")
    end,
})
```

### 4.6 `CreateSlider(parent, opts)`

สร้างแถบเลื่อนตัวเลข คืนคอมโพเนนต์และฟังก์ชันอ่าน/ตั้งค่าตาม implementation ของไฟล์

  ตัวเลือก       ชนิด        ค่าเริ่มต้น/คำอธิบาย
  ------------ ---------- ------------------------------
  `Name`       string     ชื่อแถบเลื่อน
  `Min`        number     ค่าต่ำสุด
  `Max`        number     ค่าสูงสุด
  `Default`    number     ค่าเริ่มต้น
  `Step`       number     ระยะเพิ่ม/ลดต่อขั้น
  `Suffix`     string     ข้อความต่อท้ายค่าที่แสดง เช่น `"%"`
  `Format`     function   ฟังก์ชันจัดรูปแบบค่าที่แสดง
  `Callback`   function   รับค่าตัวเลขเมื่อค่าเปลี่ยน
  `Icon`       function   ไอคอน
  `Order`      number     ลำดับ

``` lua
Library.CreateSlider(home, {
    Name = "ระดับตัวอย่าง",
    Min = 0,
    Max = 100,
    Default = 50,
    Step = 5,
    Suffix = "%",
    Callback = function(value)
        print("ค่าที่เลือก:", value)
    end,
})
```

### 4.7 `CreateNumberInput(parent, opts)`

ช่องกรอกตัวเลข รองรับการจำกัดค่าต่ำสุด/สูงสุดและระยะขั้น

  ตัวเลือก          ชนิด        คำอธิบาย
  --------------- ---------- ----------------
  `Name`          string     ชื่อช่อง
  `Default`       number     ค่าเริ่มต้น
  `Min` / `Max`   number     ขอบเขตค่าที่อนุญาต
  `Step`          number     ระยะขั้น
  `Suffix`        string     ข้อความต่อท้าย
  `Callback`      function   รับค่าตัวเลขที่ยืนยัน
  `Icon`          function   ไอคอน
  `Order`         number     ลำดับ

``` lua
Library.CreateNumberInput(home, {
    Name = "จำนวน",
    Default = 10,
    Min = 1,
    Max = 100,
    Step = 1,
    Callback = function(value)
        print("จำนวน:", value)
    end,
})
```

### 4.8 `CreateInput(parent, opts)`

ช่องกรอกข้อความ คืนคอมโพเนนต์และฟังก์ชันที่ใช้เข้าถึง/เปลี่ยนค่าตาม implementation

  ตัวเลือก           ชนิด        คำอธิบาย
  ---------------- ---------- ---------------------------------------
  `Name`           string     ชื่อช่อง
  `Default`        string     ข้อความเริ่มต้น
  `Placeholder`    string     ข้อความตัวอย่างในช่อง
  `ClearOnFocus`   boolean    ล้างข้อความเมื่อโฟกัส หากรองรับในช่องนั้น
  `Callback`       function   รับข้อความตามจังหวะยืนยัน/เปลี่ยนค่าที่โค้ดกำหนด
  `Icon`           function   ไอคอน
  `Order`          number     ลำดับ

``` lua
Library.CreateInput(home, {
    Name = "ชื่อผู้ใช้",
    Placeholder = "พิมพ์ข้อความ...",
    Default = "",
    Callback = function(text)
        print("ข้อความ:", text)
    end,
})
```

### 4.9 `CreateKeybind(parent, opts)`

สร้างตัวเลือกปุ่มลัด

  ตัวเลือก       ชนิด        คำอธิบาย
  ------------ ---------- -------------------------------
  `Name`       string     ชื่อปุ่มลัด
  `Default`    EnumItem   ปุ่มเริ่มต้นจาก `Enum.KeyCode`
  `Callback`   function   ทำงานเมื่อกดปุ่มลัดตาม logic ในไฟล์
  `Icon`       function   ไอคอน
  `Order`      number     ลำดับ

``` lua
Library.CreateKeybind(home, {
    Name = "ปุ่มลัดตัวอย่าง",
    Default = Enum.KeyCode.G,
    Callback = function(key)
        print("ปุ่มลัดทำงาน:", key)
    end,
})
```

### 4.10 `CreateDropdown(parent, opts)`

สร้างรายการแบบดรอปดาวน์ คืน `wrapper`, ฟังก์ชันอ่านค่าที่เลือก และฟังก์ชันตั้งค่าที่แสดง

  ตัวเลือก       ชนิด        คำอธิบาย
  ------------ ---------- -----------------------
  `Name`       string     ชื่อรายการ
  `Options`    table      รายการตัวเลือกแบบ array
  `Default`    any        ค่าที่เลือกเริ่มต้น
  `Callback`   function   รับตัวเลือกที่ผู้ใช้เลือก
  `Icon`       function   ไอคอน
  `Order`      number     ลำดับ

``` lua
local dropdown, getChoice, setChoice = Library.CreateDropdown(home, {
    Name = "เลือกโหมด",
    Options = {"โหมด A", "โหมด B", "โหมด C"},
    Default = "โหมด A",
    Callback = function(choice)
        print("เลือก:", choice)
    end,
})

print("ค่าปัจจุบัน:", getChoice())
setChoice("โหมด B")
```

### 4.11 `CreateLabel(parent, opts)`

ข้อความบรรทัดเดียว คืน `TextLabel`

  ตัวเลือก     ชนิด                   ค่าเริ่มต้น/คำอธิบาย
  ---------- --------------------- -------------------
  `Text`     string                ข้อความ
  `Size`     number                ขนาดตัวอักษร ปกติ 12
  `Color`    Color3                สีข้อความ
  `Bold`     boolean               ใช้ตัวหนา
  `Align`    Enum.TextXAlignment   แนวจัดข้อความ
  `Height`   number                ความสูง ปกติ 22
  `Order`    number                ลำดับ

``` lua
Library.CreateLabel(home, {
    Text = "RUNLUA HUB พร้อมใช้งาน",
    Bold = true,
    Size = 14,
})
```

### 4.12 `CreateParagraph(parent, opts)`

ข้อความหลายบรรทัดที่ตัดบรรทัดอัตโนมัติ คืน `TextLabel`

  ตัวเลือก    ชนิด      คำอธิบาย
  --------- -------- ------------
  `Text`    string   เนื้อหา
  `Size`    number   ขนาดตัวอักษร
  `Color`   Color3   สีข้อความ
  `Order`   number   ลำดับ

``` lua
Library.CreateParagraph(home, {
    Text = "ส่วนนี้ใช้แสดงคำอธิบายยาว ๆ โดยข้อความจะตัดบรรทัดอัตโนมัติ",
    Size = 12,
})
```

### 4.13 `CreatePlayerList(parent, opts)`

แสดงรายชื่อผู้เล่นอื่นในเซิร์ฟเวอร์ พร้อมรูปโปรไฟล์และแถบเลือด โดยตัวผู้เล่น LocalPlayer
จะไม่อยู่ในรายการ คืน `wrapper`, ฟังก์ชัน `rebuild()` สำหรับสร้างรายการใหม่
และฟังก์ชันอ่านผู้เล่นที่เลือก

  ตัวเลือก          ชนิด        คำอธิบาย
  --------------- ---------- ----------------------------------
  `OnSelect`      function   ถูกเรียกเมื่อเลือกผู้เล่น โดยรับ `Player`
  `AccentColor`   Color3     สีเน้นของการ์ดผู้เล่นที่เลือก
  `Order`         number     ลำดับ

``` lua
local list, refreshPlayers, getSelectedPlayer =
    Library.CreatePlayerList(home, {
        AccentColor = Library.Theme.Accent,
        OnSelect = function(player)
            print("เลือกผู้เล่น:", player.Name)
        end,
    })

-- สร้างรายการใหม่ และอ่านผู้เล่นที่เลือก
refreshPlayers()
local selected = getSelectedPlayer()
```

## 5. การแจ้งเตือน

`Library.Notify(opts)` แสดงกล่องแจ้งเตือนชั่วคราว

  ตัวเลือก       ชนิด        คำอธิบาย
  ------------ ---------- ----------------------------------
  `Title`      string     หัวข้อ
  `Message`    string     ข้อความแจ้งเตือน
  `Duration`   number     ระยะเวลาแสดง หน่วยวินาที
  `Color`      Color3     สีเน้น
  `Icon`       function   ฟังก์ชันวาดไอคอนจาก `Library.Icons`

``` lua
Library.Notify({
    Title = "RUNLUA HUB",
    Message = "ตั้งค่าเรียบร้อย",
    Duration = 3,
    Color = Library.Theme.Success,
    Icon = Library.Icons.Correct,
})
```

## 6. แท็บและการควบคุมหน้าต่าง

### เลือกแท็บ

``` lua
local home = Library.CreateTab({Name = "หน้าหลัก", Icon = Library.Icons.Home})
local settings = Library.CreateTab({Name = "ตัวอย่างตั้งค่า", Icon = Library.Icons.Settings})

Library.SelectTab(home)
```

ส่ง Instance ที่คืนมาจาก `CreateTab()` ให้ `SelectTab()` ใช้เลือกหน้า

### แสดง/ซ่อน/ทำลาย UI

``` lua
Library.Show()    -- แสดงหน้าต่างหลัก
Library.Hide()    -- ซ่อนหน้าต่างหลัก
Library.Destroy() -- ล้าง UI และการเชื่อมต่อของไลบรารี
```

`Destroy()` เป็นการล้างทรัพยากร ไม่ใช่การซ่อนชั่วคราว
ควรสร้างไลบรารีใหม่หากต้องการเริ่มใช้งานอีกครั้ง

### ตั้งปุ่มเปิด/ซ่อนหน้าต่าง

``` lua
local ok = Library.SetToggleKey(Enum.KeyCode.RightShift)
print("ตั้งปุ่มสำเร็จ:", ok)

local currentKey = Library.GetToggleKey()
print(currentKey)
```

`SetToggleKey` รับเฉพาะค่า `Enum.KeyCode` และคืน `false` หากชนิดข้อมูลไม่ถูกต้อง

## 7. การตั้งค่าและบันทึกค่า

`Library.Settings` มี API ดังนี้:

  API                       รายละเอียด
  ------------------------- -----------------------------------------
  `Get()`                   รวบรวมการตั้งค่าปัจจุบันเป็นตาราง
  `Save()`                  บันทึกการตั้งค่า หากสภาพแวดล้อมรองรับ file API
  `Load()`                  โหลดการตั้งค่าที่บันทึกไว้
  `Reset()`                 คืนค่าการตั้งค่าเป็นค่าเริ่มต้น
  `Apply(data)`             ใช้ข้อมูลการตั้งค่าจากตาราง
  `GetStorageAvailable()`   ตรวจสอบว่ามีระบบจัดเก็บไฟล์ให้ใช้งานหรือไม่
  `FileName`                ชื่อไฟล์ตั้งค่าที่กำหนดไว้ในไลบรารี
  `Version`                 เวอร์ชันโครงสร้างการตั้งค่า

``` lua
local settings = Library.Settings.Get()
print(settings)

local storageAvailable = Library.Settings.GetStorageAvailable()
if storageAvailable then
    Library.Settings.Save()
end

-- โหลดค่าที่บันทึกไว้
Library.Settings.Load()

-- คืนค่าเริ่มต้น (ระวัง: การตั้งค่าปัจจุบันจะถูกรีเซ็ต)
-- Library.Settings.Reset()

-- ใช้ตารางค่าที่เตรียมไว้
-- Library.Settings.Apply(settings)
```

การบันทึกลงไฟล์อาศัยฟังก์ชันไฟล์ของสภาพแวดล้อมที่รันอยู่ เช่น `readfile`/`writefile`
ซึ่งไม่มีให้ใช้ใน Roblox LocalScript มาตรฐานทุกกรณี หากไม่มีระบบดังกล่าว
การบันทึก/โหลดไฟล์อาจไม่ทำงาน

## 8. ธีม ไอคอน และข้อมูลแพลตฟอร์ม

### ธีม

`Library.Theme` เป็นตารางสีที่ใช้กับ UI เช่น:

-   `Background` --- สีพื้นหลังหลัก
-   `Surface`, `SurfaceAlt`, `SurfaceHover` --- สีพื้นผิวและสถานะ hover
-   `Accent`, `AccentSoft`, `AccentLight` --- สีเน้น
-   `Text`, `TextMuted` --- สีข้อความ
-   `Border` --- สีเส้นขอบ
-   `Success`, `Warning`, `Danger` --- สีสถานะ
-   `SwitchOff`, `Shadow`, `White` --- สีประกอบ

สีเป็นค่า `Color3` เช่น `Color3.fromRGB(0, 132, 255)`. การแก้ตาราง `Theme`
โดยตรงอาจไม่ได้เปลี่ยนทุก Instance ที่สร้างไปแล้วในทุกกรณี
ใช้แท็บตั้งค่าที่มากับไลบรารีเป็นวิธีหลักในการปรับค่าที่ไลบรารีรองรับ

### ไอคอน

`Library.Icons` มีฟังก์ชันวาดไอคอน เช่น `Home`, `Settings`, `Player`,
`Search`, `Save`, `Reset`, `Dropdown`, `Slider`, `Keybind` และรายการอื่น ๆ
ที่ประกาศไว้ในไฟล์

ส่งฟังก์ชันไอคอนให้ตัวเลือก `Icon` ไม่ใช่ส่งชื่อเป็น string:

``` lua
Library.CreateButton(home, {
    Name = "ปุ่มตัวอย่าง",
    Icon = Library.Icons.Home,
    Callback = function() end,
})
```

### ข้อมูลอุปกรณ์

``` lua
print(Library.IsMobile) -- true/false
print(Library.Platform) -- ชื่อแพลตฟอร์มที่ตรวจพบ
```

ค่าดังกล่าวถูกตรวจจับขณะเริ่มโหลดไลบรารี

## 9. ตัวอย่างเต็ม

``` lua
local Library = require(path.to.UInew)

local home = Library.CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
    Order = 1,
})

local section = Library.CreateSection(home, {
    Title = "ตัวอย่างคอมโพเนนต์",
})

Library.CreateParagraph(section, {
    Text = "ตัวอย่างการใช้งาน RUNLUA HUB UI Library",
})

Library.CreateToggle(section, {
    Name = "เปิดใช้งานตัวอย่าง",
    Default = false,
    Callback = function(enabled)
        print("Toggle:", enabled)
    end,
})

Library.CreateButton(section, {
    Name = "ทดสอบแจ้งเตือน",
    Callback = function()
        Library.Notify({
            Title = "ทดสอบ",
            Message = "ปุ่มทำงานแล้ว",
            Duration = 3,
            Color = Library.Theme.Accent,
            Icon = Library.Icons.Correct,
        })
    end,
})

Library.CreateSlider(section, {
    Name = "ระดับ",
    Min = 0,
    Max = 100,
    Default = 25,
    Step = 5,
    Callback = function(value)
        print("Slider:", value)
    end,
})

Library.CreateDropdown(section, {
    Name = "เลือกตัวเลือก",
    Options = {"หนึ่ง", "สอง", "สาม"},
    Default = "หนึ่ง",
    Callback = function(value)
        print("Dropdown:", value)
    end,
})

Library.CreateInput(section, {
    Name = "ข้อความ",
    Placeholder = "กรอกข้อความ",
    Callback = function(value)
        print("Input:", value)
    end,
})

Library.Notify({
    Title = "RUNLUA HUB",
    Message = "โหลด UI สำเร็จ",
    Duration = 3,
    Color = Library.Theme.Success,
    Icon = Library.Icons.Home,
})
```

## 10. ข้อควรทราบและแก้ปัญหา

-   **ไม่เห็น UI:** ตรวจสอบว่าโค้ดรันฝั่ง Client และสภาพแวดล้อมรองรับ API ที่ไฟล์ใช้
-   **ปุ่ม callback ไม่ทำงาน:** ตรวจสอบว่ากำหนด
    `Callback = function(...) ... end` และดู Output เพื่อหา error
-   **ไอคอนไม่ขึ้น:** Asset อาจโหลดไม่ได้หรือสิทธิ์การใช้งานไม่ตรงกับประสบการณ์
    ตรวจสอบ Asset ID และการเข้าถึง
-   **บันทึก/โหลดไม่ได้:** ตรวจสอบ `Library.Settings.GetStorageAvailable()`
    และข้อจำกัดของสภาพแวดล้อม
-   **มี UI ซ้อนกัน:** ไฟล์มีระบบ UI lock และ cleanup สำหรับการทำงานซ้ำ
    แต่การรันหลายสำเนาในสภาพแวดล้อมต่างกันอาจยังต้องตรวจสอบเอง
-   **ปุ่มลัดไม่ทำงาน:** ตรวจสอบว่าไม่ได้มีระบบอื่นดัก input และใช้ `Enum.KeyCode`
    ที่ถูกต้อง
-   **หลัง `Destroy()` ใช้ต่อไม่ได้:** `Destroy()` ใช้ล้าง UI และ connections
    ให้โหลด/สร้างไลบรารีใหม่ตามวิธีติดตั้ง

หากมีการเพิ่มหรือเปลี่ยน API ใน `UInew.lua` ให้ปรับ README
นี้ให้ตรงกับโค้ดเวอร์ชันล่าสุดก่อนเผยแพร่


## 11. รายการ ICON ID และโลโก้ที่ใช้ในไฟล์

ใน `UInew.lua` มีตาราง `ICON_IDS` สำหรับกำหนด Roblox Asset ID ของภาพไอคอน และมี `LOGO_ASSET_ID` แยกต่างหากสำหรับโลโก้หลักของ UI

### โลโก้หลัก

| รายการ | Asset ID | รูปแบบ URL |
|---|---:|---|
| โลโก้ UI (`LOGO_ASSET_ID`) | `110783494016876` | `rbxassetid://110783494016876` |

### ไอคอนทั้งหมดใน `ICON_IDS`

| ชื่อในตาราง `ICON_IDS` | Asset ID |
|---|---:|
| `Home` | `81381827579989` |
| `Settings` | `135274678904780` |
| `ThreeLines` | `15567843411` |
| `ESP` | `1137376344` |
| `SwordsAndKnives` | `7485051733` |
| `Target` | `100986564809027` |
| `target2` | `13577839026` |
| `Search` | `132302594577680` |
| `Correct` | `118550787033099` |
| `Shop` | `11807308307` |
| `Person` | `18854794429` |
| `Crystal` | `12814035490` |
| `Star` | `95134188293701` |
| `star2` | `114167292947807` |
| `Egg` | `86058422496634` |
| `Run` | `10507122439` |
| `Discord` | `110769239384778` |
| `YouTube` | `85469926655680` |
| `word` | `121176334529781` |
| `sound` | `117386765962827` |
| `fruit` | `130882648` |
| `file` | `92272038372516` |
| `book` | `90777101549927` |
| `pencil` | `16417283031` |
| `gun` | `15286668313` |
| `map` | `14240466966` |
| `coordinates` | `76761366176541` |
| `airplane` | `2189714464` |
| `rocket` | `16149155554` |
| `smile` | `11955884989` |
| `gift` | `90596283238411` |
| `bag` | `13933329303` |
| `fish` | `114366026221277` |
| `WiFi` | `82866471491531` |
| `signal` | `8587689327` |
| `dinosaur` | `15232707578` |
| `box` | `89528045721909` |
| `thunder` | `123699649588161` |
| `reset` | `4343875685` |
| `diamond` | `6788518059` |
| `punch` | `13050670483` |
| `spoon` | `73443323737499` |
| `menu` | `96140958199506` |
| `meun2` | `77038338415780` |
| `cloud` | `7013266261` |
| `Pin1` | `94180059461552` |
| `Pin2` | `78174345206454` |
| `Save` | `113712416335562` |
| `hook` | `14376301503` |
| `Fishingrod` | `74554825003519` |
| `cross` | `16844961944` |
| `short` | `118924374112009` |

### ชื่อไอคอนที่เรียกใช้ผ่าน `Library.Icons`

ชื่อเหล่านี้เป็นชื่อฟังก์ชันที่ไลบรารีเปิดให้ใช้ ไม่ใช่ชื่อในตาราง `ICON_IDS` ทั้งหมดโดยตรง

| ชื่อที่เรียกใช้ | ใช้ ID จาก |
|---|---|
| `Library.Icons.Home` | `Home` |
| `Library.Icons.Player` / `Person` | `Person` |
| `Library.Icons.ESP` | `ESP` |
| `Library.Icons.Float` | `star2` |
| `Library.Icons.Teleport` | `coordinates` |
| `Library.Icons.Fling` | `punch` |
| `Library.Icons.Settings` | `Settings` |
| `Library.Icons.Action` / `Correct` | `Correct` |
| `Library.Icons.Minimize` | `short` |
| `Library.Icons.Close` | `cross` |
| `Library.Icons.Slider` | `signal` |
| `Library.Icons.Pencil` | `pencil` |
| `Library.Icons.Keybind` | `WiFi` |
| `Library.Icons.Dropdown` | `menu` |
| `Library.Icons.Book` | `book` |
| `Library.Icons.Save` | `Save` |
| `Library.Icons.Cloud` | `cloud` |
| `Library.Icons.Diamond` | `diamond` |
| `Library.Icons.Shop` | `Shop` |
| `Library.Icons.Bag` | `bag` |
| `Library.Icons.Thunder` | `thunder` |
| `Library.Icons.Run` | `Run` |
| `Library.Icons.Gun` | `gun` |
| `Library.Icons.Map` | `map` |
| `Library.Icons.Rocket` | `rocket` |
| `Library.Icons.Box` | `box` |
| `Library.Icons.Crystal` | `Crystal` |
| `Library.Icons.Egg` | `Egg` |
| `Library.Icons.Star` | `Star` |
| `Library.Icons.Star2` | `star2` |
| `Library.Icons.Search` | `Search` |
| `Library.Icons.Target` | `Target` |
| `Library.Icons.Target2` | `target2` |
| `Library.Icons.Discord` | `Discord` |
| `Library.Icons.YouTube` | `YouTube` |
| `Library.Icons.Reset` | `reset` |
| `Library.Icons.Swords` | `SwordsAndKnives` |
| `Library.Icons.File` | `file` |
| `Library.Icons.Gift` | `gift` |
| `Library.Icons.Fruit` | `fruit` |
| `Library.Icons.Fish` | `fish` |
| `Library.Icons.Dinosaur` | `dinosaur` |
| `Library.Icons.Word` | `word` |
| `Library.Icons.Sound` | `sound` |
| `Library.Icons.Airplane` | `airplane` |
| `Library.Icons.Smile` | `smile` |
| `Library.Icons.Pin1` | `Pin1` |
| `Library.Icons.Pin2` | `Pin2` |
| `Library.Icons.Hook` | `hook` |
| `Library.Icons.Fishing` | `Fishingrod` |
| `Library.Icons.Spoon` | `spoon` |

### วิธีนำ Asset ID ไปใช้

```lua
local image = Instance.new("ImageLabel")
image.Size = UDim2.fromOffset(24, 24)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://81381827579989" -- Home
image.Parent = script.Parent
```

หรือใช้ฟังก์ชันไอคอนของไลบรารีโดยตรง:

```lua
Library.CreateButton(tab, {
    Name = "ปุ่มตัวอย่าง",
    Icon = Library.Icons.Home,
    Callback = function()
        print("กดปุ่มแล้ว")
    end,
})
```

**หมายเหตุ:** ID ในตารางคือหมายเลข Asset ที่ระบุไว้ในซอร์สโค้ด ไม่ได้ยืนยันว่า Asset ทุกชิ้นยังเปิดใช้งานได้หรือทุกเกมมีสิทธิ์โหลดภาพนั้น

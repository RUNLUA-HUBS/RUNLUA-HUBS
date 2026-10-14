คู่มือการใช้งาน UI Library — RUNLUA_HUB_V2.lua

คู่มือนี้อ้างอิงจากไฟล์ RUNLUA_HUB_V2.lua (RUNLUA UI LIBRARY v3.0 — Text Spacing Fix + Icon Manual) ครอบคลุมการสร้างแท็บ หมวดหมู่ คอมโพเนนต์ การตั้งค่า การแจ้งเตือน ปุ่มลอย และไอคอนทั้งหมดที่มีในซอร์ส พร้อมตาราง ICON MANUAL สำหรับ AI และนักพัฒนา

หมายเหตุ: ไลบรารีนี้เป็น Luau สำหรับ Roblox และอาจพึ่งพา API ที่มีเฉพาะบางสภาพแวดล้อม (executor) ควรทดสอบในสภาพแวดล้อมที่ใช้งานจริงก่อนนำไปเผยแพร่

---

1. โหลดไลบรารี

ตัวอย่างรูปแบบการโหลดจาก URL ที่โฮสต์ไฟล์ไว้แล้ว:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"))()
```

เปลี่ยน URL เป็นที่อยู่จริงของไฟล์ที่คุณโฮสต์ ไลบรารีจะคืนค่าเป็นตาราง Library และกำหนด _G.RUNLUA_HUB ไว้ด้วย หากโหลดซ้ำ ระบบจะเรียก _G.RUNLUA_HUB_CLEANUP เพื่อล้าง UI เก่าก่อนโดยอัตโนมัติ

---

2. เริ่มต้นสร้าง UI

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"))()

local tab = Library.CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local section = Library.CreateSection(tab.Page, {
    Name = "Main",
    Title = "หมวดหมู่หลัก",
})

Library.CreateToggle(section, {
    Name = "ตัวอย่างสวิตช์",
    Description = "เปิดหรือปิดฟังก์ชันตัวอย่าง",
    Default = false,
    Callback = function(enabled)
        print("สถานะ:", enabled)
    end,
})
```

แนวคิดหลัก: CreateTab สร้างแท็บ, tab.Page คือพื้นที่ใส่คอมโพเนนต์, CreateSection สร้างกลุ่ม/หัวข้อ แล้วเพิ่ม Toggle, Button, Slider และอื่น ๆ เข้าไป

---

3. API หลักของ Library

API หน้าที่
Library.CreateTab(options) สร้างแท็บ
Library.SelectTab(tab) เลือกแท็บที่ระบุ
Library.CreateSection(parent, options) สร้างหมวดหมู่/กลุ่ม
Library.CreateDivider(parent, order) สร้างเส้นคั่น
Library.CreateToggle(parent, options) สวิตช์เปิด/ปิด
Library.CreateButton(parent, options) ปุ่มกดเรียกการทำงาน
Library.CreateSlider(parent, options) แถบเลื่อนตัวเลข
Library.CreateInput(parent, options) ช่องกรอกข้อความ
Library.CreateKeybind(parent, options) ตั้งปุ่มลัดคีย์บอร์ด
Library.CreateDropdown(parent, options) รายการตัวเลือก
Library.CreateLabel(parent, options) ข้อความบรรทัดเดียว
Library.CreateParagraph(parent, options) ข้อความหลายบรรทัด (ตัดบรรทัดอัตโนมัติ)
Library.CreatePlayerList(parent, options) รายชื่อผู้เล่น + แสดงเลือด
Library.Notify(options) แสดงการแจ้งเตือน
Library.Show() แสดงหน้าต่างหลัก
Library.Hide() ซ่อนหน้าต่างหลัก
Library.Destroy() ล้าง UI และการเชื่อมต่อทั้งหมด
Library.SetToggleKey(Enum.KeyCode.RightShift) ตั้งปุ่มลัดเปิด/ปิด UI (คืนค่า true/false)
Library.GetToggleKey() อ่านปุ่มลัดปัจจุบัน
Library.Settings.Get() อ่านค่าการตั้งค่าปัจจุบัน
Library.Settings.Save() บันทึกค่าลงไฟล์
Library.Settings.Load() โหลดค่าที่บันทึกไว้
Library.Settings.Reset() รีเซ็ตค่ากลับค่าเริ่มต้น
Library.Settings.Apply(data) นำตารางข้อมูลการตั้งค่ามาใช้
Library.Settings.GetStorageAvailable() ตรวจว่ามีระบบจัดเก็บไฟล์หรือไม่
Library.Settings.FileName ชื่อไฟล์ (RUNLUA_HUB_SETTINGS.json)
Library.Settings.Version เวอร์ชันสคีมา (3)

พร็อพเพอร์ตีที่เปิดให้เข้าถึงได้: Library.Theme, Library.Config, Library.Icons, Library.Tabs, Library.SettingsTab, Library.ScreenGui, Library.MainFrame, Library.IsMobile, Library.Platform

---

4. สร้างแท็บและหมวดหมู่

CreateTab(options)

```lua
local tab = Library.CreateTab({
    Name = "ผู้เล่น",
    Icon = Library.Icons.Player,
    Order = 2,
})
```

ตัวเลือก ชนิด รายละเอียด
Name string ชื่อแท็บ
Icon function ฟังก์ชันวาดไอคอน เช่น Library.Icons.Player
Order number ลำดับแท็บ
IsSettings boolean ทำเครื่องหมายว่าเป็นแท็บตั้งค่า (จัดวางแยก + ใช้สี AccentSoft)

แท็บที่สร้างจะมี tab.Page สำหรับใส่คอมโพเนนต์

CreateSection(parent, options)

```lua
local section = Library.CreateSection(tab.Page, {
    Name = "Movement",
    Title = "การเคลื่อนที่",
    Order = 1,
})
```

ตัวเลือก ชนิด รายละเอียด
Name string ชื่อภายในของกลุ่ม
Title string หัวข้อที่แสดง (สูง 26px)
Order number ลำดับกลุ่ม

สำคัญ: CreateSection ไม่มี ตัวเลือก Icon ในเวอร์ชันนี้ ไอคอนหมวดหมู่ใช้ผ่าน CreateTab({Icon = ...}) เท่านั้น

CreateDivider(parent, order)

```lua
Library.CreateDivider(section, 10)
```

สร้างเส้นคั่นสูง 16px รับ parent และ order

---

5. คอมโพเนนต์ทั้งหมด

5.1 Toggle — สวิตช์เปิด/ปิด

```lua
local row, getEnabled, setEnabled = Library.CreateToggle(section, {
    Name = "แสดง ESP",
    Description = "เปิดหรือปิดการแสดงผล",
    Default = false,
    Order = 1,
    Icon = Library.Icons.ESP,
    Callback = function(enabled)
        print("เปิดอยู่หรือไม่:", enabled)
    end,
})

print(getEnabled())  -- อ่านค่าปัจจุบัน
setEnabled(true)     -- ตั้งค่าใหม่
```

ตัวเลือก: Name, Description, Default (boolean), Order, Icon, Callback (รับ boolean), Floating, FloatButton

ค่าที่คืน: row, getEnabled(), setEnabled(v)

แผงสวิตช์ลอย: ใส่ Floating = true หรือ FloatButton = true เพื่อสร้างแผงลอยเฉพาะ Toggle นั้น แผงจะ:

· แสดงชื่อฟังก์ชัน + สถานะ เปิด/ปิด
· ลากได้จากแถบด้านบน
· ปรับขนาดได้จากปุ่ม ◢ มุมซ้ายล่าง (200–440 กว้าง, 66–150 สูง)
· มีสวิตช์บนแผงสำหรับ toggle โดยตรง

```lua
Library.CreateToggle(section, {
    Name = "เปิดระบบตัวอย่าง",
    Description = "ควบคุมจากแผงลอยได้",
    Default = false,
    Floating = true,
    Icon = Library.Icons.Float,
    Callback = function(enabled)
        print("สถานะ:", enabled)
    end,
})
```

คำแนะนำ: ใช้แผงลอยเฉพาะฟังก์ชันที่จำเป็น ไม่ควรเปิดให้ทุก Toggle อัตโนมัติ

---

5.2 Button — ปุ่มกด

```lua
Library.CreateButton(section, {
    Name = "ทดสอบ",
    Description = "กดเพื่อเรียกการทำงาน",
    Order = 2,
    Icon = Library.Icons.Action,
    Color = Library.Theme.Accent,
    Callback = function()
        print("กดปุ่มแล้ว")
    end,
})
```

ตัวเลือก: Name, Description, Order, Icon, Color (Color3 — แสดงเป็นแถบ accent ด้านซ้าย), Callback (ไม่มีอาร์กิวเมนต์)

---

5.3 Slider — แถบเลื่อน

```lua
local row, getValue, setValue = Library.CreateSlider(section, {
    Name = "ความเร็ว",
    Min = 0,
    Max = 100,
    Step = 5,
    Default = 25,
    Suffix = "%",
    Order = 3,
    Icon = Library.Icons.Slider,
    Format = function(v) return v .. "%" end,  -- ไม่บังคับ
    Callback = function(value)
        print("ค่า:", value)
    end,
})
```

ตัวเลือก: Name, Min, Max, Step, Default, Suffix, Format (ฟังก์ชันรับตัวเลข คืน string), Order, Icon, Callback

ค่าที่คืน: row, getValue(), setValue(v)

หมายเหตุ: ความสูงของแถวคือ 58px, Step ต้องเป็นค่าบวก หากตั้ง Step = 0 จะไม่ปัดเศษ

---

5.4 Input — ช่องข้อความ

```lua
local row, getText, setText = Library.CreateInput(section, {
    Name = "ชื่อผู้เล่น",
    Placeholder = "พิมพ์ชื่อ...",
    Default = "",
    ClearOnFocus = false,
    Order = 4,
    Icon = Library.Icons.Pencil,
    Callback = function(text)
        print("ข้อความ:", text)
    end,
})
```

ตัวเลือก: Name, Placeholder, Default, ClearOnFocus (ล้างข้อความเมื่อโฟกัส), Order, Icon, Callback (เรียกเมื่อช่องเสียโฟกัส)

ค่าที่คืน: row, getText(), setText(v)

เมื่อโฟกัส ขอบจะเปลี่ยนเป็นสี Accent

---

5.5 Keybind — ปุ่มลัด

```lua
local row, getKey, setKey = Library.CreateKeybind(section, {
    Name = "ปุ่มลัดฟังก์ชัน",
    Default = Enum.KeyCode.E,
    Order = 5,
    Icon = Library.Icons.Keybind,
    Callback = function(keyCode)
        print("ปุ่ม:", keyCode.Name)
    end,
})
```

ตัวเลือก: Name, Default (Enum.KeyCode), Order, Icon, Callback (รับ KeyCode)

ค่าที่คืน: row, getKey(), setKey(k)

วิธีใช้: คลิกปุ่มลัดบน UI → ปุ่มจะแสดง ... → กดปุ่มใหม่บนคีย์บอร์ดเพื่อกำหนด

ฟังก์ชันนี้เน้นคีย์บอร์ด ไม่ใช่ปุ่มลัดสัมผัสบนมือถือ

---

5.6 Dropdown — รายการตัวเลือก

```lua
local row, getMode, setMode = Library.CreateDropdown(section, {
    Name = "โหมด",
    Options = {"ปกติ", "เร็ว", "ปลอดภัย"},
    Default = "ปกติ",
    Order = 6,
    Icon = Library.Icons.Dropdown,
    Callback = function(value)
        print("เลือก:", value)
    end,
})
```

ตัวเลือก: Name, Options (table), Default, Order, Icon, Callback

ค่าที่คืน: row, getMode(), setMode(v)

คอมโพเนนต์นี้ใช้ wrapper ภายนอก มี AutomaticSize.Y — ความสูงขยาย/หดอัตโนมัติเมื่อเปิด/ปิด ความสูงตัวเลือกคือ 30px, padding 6px

---

5.7 Label — ข้อความบรรทัดเดียว

```lua
Library.CreateLabel(section, {
    Text = "ข้อมูลสถานะ",
    Size = 12,
    Height = 22,
    Bold = true,
    Align = Enum.TextXAlignment.Left,
    Color = Library.Theme.Text,
    Order = 7,
})
```

ตัวเลือก: Text, Size, Height, Bold, Align, Color, Order

---

5.8 Paragraph — ข้อความหลายบรรทัด

```lua
Library.CreateParagraph(section, {
    Text = "คำอธิบายที่ยาวขึ้นและสามารถตัดบรรทัดได้",
    Size = 11,
    Color = Library.Theme.TextMuted,
    Order = 8,
})
```

ตัวเลือก: Text, Size, Color, Order

ใช้ AutomaticSize.Y + TextWrapped + LineHeight = 1.2 — ความสูงปรับตามเนื้อหา

---

5.9 PlayerList — รายชื่อผู้เล่น

```lua
local playerList, refreshPlayers, getSelectedPlayer =
    Library.CreatePlayerList(section, {
        AccentColor = Library.Theme.Accent,
        Order = 9,
        OnSelect = function(player)
            if player then
                print("เลือกผู้เล่น:", player.Name)
            end
        end,
    })
```

ตัวเลือก: AccentColor, Order, OnSelect

ค่าที่คืน: wrapper, refreshPlayers(), getSelectedPlayer()

คุณสมบัติ:

· แสดงผู้เล่นอื่นในเซิร์ฟเวอร์ (ไม่รวม LocalPlayer)
· แต่ละการ์ดแสดงอวตาร, DisplayName, @Username, เลือดปัจจุบัน/สูงสุด + แถบเลือด (เขียว > 50%, เหลือง > 20%, แดง ≤ 20%)
· อัปเดตเลือดอัตโนมัติผ่าน HealthChanged และ CharacterAdded
· การ์ดที่เลือกจะเปลี่ยนเป็นสี AccentColor
· เรียงตาม DisplayName

หมายเหตุ: ความสูง wrapper คงที่ 220px ใช้ scrollbar ภายใน

---

6. การแจ้งเตือน (Notify)

```lua
Library.Notify({
    Title = "สำเร็จ",
    Message = "ตั้งค่าเรียบร้อยแล้ว",
    Duration = 3,
    Color = Library.Theme.Accent,
    Icon = Library.Icons.Home,
})
```

ตัวเลือก: Title, Message, Duration (วินาที, ค่าเริ่มต้น 3), Color, Icon

คุณสมบัติ:

· แสดงมุมขวาบน แบบคิว
· จำกัด Library.Config.MaxNotifications = 4 พร้อมกัน
· มีแถบสีด้านซ้าย + ขอบสี + fade in/out
· การแจ้งเตือนเก่าจะถูกทำลายอัตโนมัติเมื่อเกินโควตา

---

7. ไอคอนที่ไลบรารีส่งออกให้ใช้

การใช้งาน: Icon ต้องเป็นฟังก์ชันที่ไลบรารีส่งออก เช่น Library.Icons.Home ไม่ใช่ Asset ID โดยตรง

```lua
Icon = Library.Icons.Home  -- ✅ ถูก
Icon = 81381827579989      -- ❌ ผิด
```

7.1 ไอคอนหลัก

ชื่อ API Asset ID ความหมาย/การใช้งานที่เหมาะสม
Library.Icons.Home 81381827579989 หน้าหลัก / Dashboard
Library.Icons.Player / Person 18854794429 ผู้เล่น
Library.Icons.ESP 1137376344 ESP / การมองเห็น
Library.Icons.Float 114167292947807 ไอคอนลอย / ฟังก์ชันพิเศษ
Library.Icons.Teleport 76761366176541 วาร์ป / พิกัด
Library.Icons.Fling 13050670483 ผลัก / Fling
Library.Icons.Settings 135274678904780 ตั้งค่า
Library.Icons.Action / Correct 118550787033099 ยืนยัน / คำสั่ง
Library.Icons.Minimize 118924374112009 ย่อหน้าต่าง
Library.Icons.Close 16844961944 ปิดหน้าต่าง
Library.Icons.Slider 8587689327 ปรับระดับ / Slider
Library.Icons.Pencil 16417283031 แก้ไข / ช่องข้อความ
Library.Icons.Keybind 82866471491531 ปุ่มลัด
Library.Icons.Dropdown 96140958199506 รายการตัวเลือก
Library.Icons.Book 90777101549927 คู่มือ / ข้อมูล
Library.Icons.Save 113712416335562 บันทึก
Library.Icons.Cloud 7013266261 คลาวด์ / ออนไลน์
Library.Icons.Diamond 6788518059 พรีเมียม / เพชร

7.2 ไอคอนเพิ่มเติม

ชื่อ API Asset ID ความหมาย
Library.Icons.Shop 11807308307 ร้านค้า
Library.Icons.Bag 13933329303 กระเป๋า / สัมภาระ
Library.Icons.Thunder 123699649588161 สายฟ้า / ความเร็ว
Library.Icons.Run 10507122439 วิ่ง
Library.Icons.Gun 15286668313 ปืน
Library.Icons.Map 14240466966 แผนที่
Library.Icons.Rocket 16149155554 จรวด / บูสต์
Library.Icons.Box 89528045721909 กล่อง / ไอเท็ม
Library.Icons.Crystal 12814035490 คริสตัล
Library.Icons.Egg 86058422496634 ไข่
Library.Icons.Star 95134188293701 ดาว / คะแนน
Library.Icons.Star2 114167292947807 ดาวแบบที่ 2
Library.Icons.Search 132302594577680 ค้นหา
Library.Icons.Target 100986564809027 เป้า / ล็อกเป้า
Library.Icons.Target2 13577839026 เป้าแบบเลือกได้
Library.Icons.Swords 7485051733 ดาบ / ต่อสู้
Library.Icons.Discord 110769239384778 Discord
Library.Icons.YouTube 85469926655680 YouTube
Library.Icons.Reset 4343875685 รีเซ็ต
Library.Icons.File 92272038372516 ไฟล์
Library.Icons.Gift 90596283238411 ของขวัญ
Library.Icons.Fruit 130882648 ผลไม้
Library.Icons.Fish 114366026221277 ปลา
Library.Icons.Dinosaur 15232707578 ไดโนเสาร์
Library.Icons.Word 121176334529781 ข้อความ
Library.Icons.Sound 117386765962827 เสียง
Library.Icons.Airplane 2189714464 เครื่องบิน
Library.Icons.Smile 11955884989 ยิ้ม
Library.Icons.Pin1 94180059461552 หมุด
Library.Icons.Pin2 78174345206454 หมุดสำรอง
Library.Icons.Hook 14376301503 ตะขอ
Library.Icons.Fishing 74554825003519 คันเบ็ด
Library.Icons.Spoon 73443323737499 ช้อน

---

8. ICON MANUAL — ตารางจากซอร์ส (สำหรับ AI และนักพัฒนา)

ตารางนี้มาจากคอมเมนต์บนสุดของไฟล์ ใช้เป็นแนวทางเลือกไอคอนให้ตรงกับฟังก์ชันใหม่

Icon Key ความหมาย ใช้กับฟังก์ชันแบบไหน
Home บ้าน / กลับหน้าหลัก ปุ่มกลับเมนูหลัก, Go Home
Player ผู้เล่น / ตัวเรา โปรไฟล์, ข้อมูลผู้เล่น
ESP เรดาร์ / สแกน ตรวจจับ, Anti-kick, ตรวจจับข้าศึก
Float ดาว / ลอย ฟีเจอร์พิเศษ, บายพาส, บัฟ
Teleport พิกัด / วาร์ป วาร์ป, ไปยังจุด, TP
Fling หมัด / ผลัก โจมตี, ผลัก, ตบ
Settings เกียร์ / ตั้งค่า ตั้งค่า, ออโต้, ระบบ
Action ถูก / ทำงาน ปุ่มยืนยัน, เปิด-ปิด
Minimize ย่อ ปุ่มย่อหน้าต่าง
Close ปิด / กากบาท ปุ่มปิด, ยกเลิก, error
Slider คลื่น / ปรับค่า สไลเดอร์, ระดับความแรง
Pencil ดินสอ / แก้ไข ฟอร์ม, พิมพ์, แก้ไข
Keybind WiFi / ปุ่มลัด ตั้งปุ่มลัด, Anti-AFK
Dropdown เมนู / รายการ เลือกตัวเลือก, ดรอปดาวน์
Book หนังสือ / ข้อมูล เอกสาร, ขนาดตัวอักษร, help
Save บันทึก เซฟ, เก็บข้อมูล
Cloud คลาวด์ / โหลด โหลด, รีเฟรช, ดึงข้อมูล
Diamond เพชร / ของมีค่า คราฟ, อัปเกรด, พรีเมี่ยม
Shop ร้านค้า ขายของ, ตลาด
Bag กระเป๋า / สัมภาระ เก็บของ, กระเป๋า, ฟาร์มผ้า
Thunder สายฟ้า / เร็ว สปีด, เร่งความเร็ว, บัฟ
Run วิ่ง เดิน, เร็ว, เคลื่อนไหว
Gun ปืน โจมตีระยะไกล
Map แผนที่ นำทาง, ตำแหน่ง
Rocket จรวด / บูสต์ บูสต์, เพิ่มพลัง, พุ่ง
Box กล่อง ไอเท็ม, ลัง, คราฟ
Crystal คริสตัล ของหายาก, สคริปต์ VIP
Star / Star2 ดาว / คะแนน ระดับ, แรงค์, คะแนน
Egg ไข่ ฟาร์มไข่, วางไข่
Person คน ผู้เล่น, เพื่อน, ทีม
Search ค้นหา ค้นหา, ค้นหาไอเท็ม
Correct ติ๊ก / ยืนยัน ยืนยัน, ทำสำเร็จ
Target เป้า เล็งเป้า, ล็อกเป้า
Target2 เป้าแบบที่ 2 ล็อกเป้าแบบเลือกได้
Swords ดาบ ต่อสู้, โจมตี
Discord โลโก้ Discord ลิงก์ Discord
YouTube โลโก้ YouTube ลิงก์วิดีโอ
Reset รีเซ็ต คืนค่าเดิม, ล้างค่า

---

9. ไอคอนใหม่ที่แนะนำสำหรับหมวดหมู่และฟังก์ชัน

รายการนี้เป็น ชื่อไอคอนจากชุด Lucide เพื่อใช้เป็นแนวทางเลือกดีไซน์ ไม่ใช่ Roblox Asset ID และนำไปใส่ใน Library.Icons โดยตรงไม่ได้ ต้องหา/สร้าง Roblox image asset ที่เหมาะสม แล้วเพิ่ม ID ในตาราง ICON_IDS ก่อน

หมวดหมู่/ฟังก์ชัน ชื่อไอคอน Lucide ความหมาย
หน้าหลัก house หน้าหลัก
ผู้เล่น users รายชื่อผู้เล่น
ตัวละคร user-round ตัวละคร / โปรไฟล์
ESP / มองเห็น eye การมองเห็น
เป้าหมาย crosshair เล็งเป้าหมาย
เคลื่อนที่ footprints การเคลื่อนที่
วิ่ง / ความเร็ว zap ความเร็ว / พลัง
วาร์ป / พิกัด map-pin จุดหมาย
นำทาง navigation ทิศทาง
บิน plane การบิน
แรงผลัก / Fling move การเคลื่อนย้าย
ต่อสู้ swords ต่อสู้
ป้องกัน shield ป้องกัน
เครื่องมือ wrench เครื่องมือ
ตั้งค่า settings ตั้งค่า
ปุ่มลัด keyboard คีย์บอร์ด
สวิตช์ toggle-right เปิด/ปิด
ปรับระดับ sliders-horizontal ปรับค่า
รายการเลือก list รายการ
ค้นหา search ค้นหา
ร้านค้า shopping-cart ร้านค้า
พรีเมียม gem พรีเมียม
บันทึก save บันทึก
รีเซ็ต rotate-ccw รีเซ็ต
ข้อมูล info ข้อมูล
แจ้งเตือน bell แจ้งเตือน
คู่มือ book-open คู่มือ
สคริปต์ / โค้ด code โค้ด
ไฟล์โค้ด file-code ไฟล์โค้ด
เซิร์ฟเวอร์ server เซิร์ฟเวอร์
ความปลอดภัย shield-check ความปลอดภัย
ปิดหน้าต่าง x ปิด
ย่อหน้าต่าง minus ย่อ

ดูตัวอย่างไอคอนที่ https://lucide.dev/icons/

---

10. ปุ่มเปิด/ปิดหน้าต่าง และการลาก UI

ปุ่มลัดคีย์บอร์ด

```lua
Library.SetToggleKey(Enum.KeyCode.RightControl)
print(Library.GetToggleKey().Name)
```

ค่าเริ่มต้นคือ Enum.KeyCode.RightShift ใช้ได้เฉพาะเดสก์ท็อป (บนมือถือถูกปิดไว้)

โลโก้ลอย (TogglePill)

· ปรากฏที่มุมซ้ายบน (Position = UDim2.new(0.1, 20, 0.25, 25)) ขนาด 54px
· แตะ/คลิก → เปิด/ปิดหน้าต่าง (มี debounce 0.25s)
· ลาก → ย้ายตำแหน่งได้ (มี DragThreshold = 5 แยกการคลิกจากการลาก)
· โหลดโลโก้ → ลองใช้ getcustomasset ก่อน แล้ว fallback เป็น URL

การลากหน้าต่างหลัก

· ลากที่ Header (แถบด้านบน) — ใช้ได้ทั้งเมาส์และทัช
· ปุ่มภายในจะไม่ถูกลากทับ (ตรวจสอบ isPointOverButton)
· บนเดสก์ท็อปมี ContextActionService บล็อกการหมุนกล้องเมื่อคลิกขวาที่ header

ปรับขนาดหน้าต่าง

· ปุ่ม ◢ (ResizeHandle) มุมซ้ายล่างของ mainFrame
· ขนาดต่ำสุด: 420×300, สูงสุดตาม viewport
· UIScale จะถูกคำนวณใหม่หลัง resize

---

11. Settings และการบันทึกค่า

```lua
local data = Library.Settings.Get()
local available = Library.Settings.GetStorageAvailable()

Library.Settings.Save()      -- บันทึกลงไฟล์ (หรือ memory ถ้าไม่รองรับ)
Library.Settings.Load()      -- โหลดค่าล่าสุด
Library.Settings.Reset()     -- คืนค่าเริ่มต้น
-- Library.Settings.Apply(data)  -- ถ้ามีตารางข้อมูล
```

ไฟล์ที่บันทึก: RUNLUA_HUB_SETTINGS.json

ข้อมูลที่บันทึก:

· UserScale, TextScale, FontWeight
· สีทั้งหมดใน Theme (แปลงเป็น RGB array)
· ตำแหน่ง MainPosition และ PillPosition

พฤติกรรม:

· ถ้าไม่มี writefile/readfile/isfile → เก็บในหน่วยความจำของเซสชัน
· โหลดอัตโนมัติตอนเริ่มต้น (ใน pcall)
· เมื่อโหลด/รีเซ็ต ระบบจะอัปเดต dropdown ในแท็บ Settings อัตโนมัติ

แท็บ "ตั้งค่า GUI" (SettingsTab)

สร้างไว้ล่วงหน้าพร้อม:

1. รูปลักษณ์หลัก — ขนาดตัวอักษร (พอดี/กลาง/ใหญ่), ความหนาอักษร (Regular/Medium/SemiBold/Bold/ExtraBold/Heavy)
2. สีและธีม — ชุดสีหลัก 6 แบบ + สวอตช์สีหลัก 12 สี + สีพื้นหลัง 8 สี
3. บันทึก / คืนค่า — ปุ่มบันทึก/โหลด/รีเซ็ต + Label สถานะ

```lua
Library.SettingsTab  -- เข้าถึงแท็บตั้งค่าได้โดยตรง
```

---

12. Theme และ Config

Theme (สีทั้งหมด)

```lua
Library.Theme.Background   -- พื้นหลังหลัก
Library.Theme.Surface      -- พื้นผิวการ์ด
Library.Theme.SurfaceAlt   -- พื้นผิวรอง
Library.Theme.SurfaceHover -- พื้นผิวเมื่อ hover
Library.Theme.Accent       -- สีเน้น
Library.Theme.AccentSoft   -- สีเน้นแบบเข้ม
Library.Theme.AccentLight  -- สีเน้นแบบอ่อน
Library.Theme.Text         -- ข้อความหลัก
Library.Theme.TextMuted    -- ข้อความรอง
Library.Theme.Border       -- เส้นขอบ
Library.Theme.Success      -- สำเร็จ (เขียว)
Library.Theme.Danger       -- อันตราย (แดง)
Library.Theme.Warning      -- เตือน (เหลือง)
Library.Theme.SwitchOff    -- สวิตช์ปิด
Library.Theme.White        -- ขาว
Library.Theme.IconDim      -- ไอคอนมืด
```

เมื่อแก้ไข Theme แล้ว ควรเรียก Library.Settings.Apply(Library.Settings.Get()) เพื่อให้การเปลี่ยนแปลงถูกนำไปใช้กับ UI

Config (ค่าคงที่)

```lua
Library.Config.WindowSize          -- Vector2.new(600, 420)
Library.Config.WindowMinSize       -- Vector2.new(420, 320)
Library.Config.SidebarWidth        -- 156
Library.Config.SidebarWidthCompact -- 60
Library.Config.CompactBreakpoint   -- 720 (px)
Library.Config.RowHeight           -- 50
Library.Config.RowHeightDesc       -- 76
Library.Config.RowSpacing          -- 10
Library.Config.MaxNotifications    -- 4
Library.Config.ToggleDebounce      -- 0.25
```

การแก้ไข v3.0: ค่าเหล่านี้ถูกปรับให้สูงขึ้นเพื่อให้ข้อความไม่ทับกัน พร้อมเพิ่ม UITextSizeConstraint ทุกป้ายข้อความ

---

13. Responsive — รองรับจอเล็ก

· เมื่อ viewport กว้าง < 720px → โหมด compact
· Sidebar จะแคบลงเหลือ 60px, ซ่อน label ของแท็บ, ไอคอนอยู่กลาง
· ProfileCard ย่อเหลือ 52px, ซ่อนชื่อ/username/เลือด
· UIScale คำนวณอัตโนมัติ (computeScale) ให้พอดี viewport

---

14. ตัวอย่างรวม

```lua
local Library = loadstring(game:HttpGet("URL_ไฟล์ไลบรารี"))()

-- แท็บการเคลื่อนที่
local tab = Library.CreateTab({
    Name = "การเคลื่อนที่",
    Icon = Library.Icons.Teleport,
})

local section = Library.CreateSection(tab.Page, {
    Name = "Movement",
    Title = "การเคลื่อนที่",
})

Library.CreateToggle(section, {
    Name = "เปิดระบบตัวอย่าง",
    Description = "เปิด/ปิดระบบจากสวิตช์หรือแผงลอย",
    Default = false,
    Floating = true,
    Icon = Library.Icons.Float,
    Callback = function(enabled)
        print("สถานะ:", enabled)
    end,
})

Library.CreateButton(section, {
    Name = "แจ้งเตือนทดสอบ",
    Description = "ทดสอบระบบ Notify",
    Icon = Library.Icons.Action,
    Callback = function()
        Library.Notify({
            Title = "ทดสอบ",
            Message = "ปุ่มทำงานแล้ว",
            Duration = 3,
            Icon = Library.Icons.Home,
        })
    end,
})

local _, getValue, setValue = Library.CreateSlider(section, {
    Name = "ค่าทดสอบ",
    Min = 0,
    Max = 100,
    Step = 1,
    Default = 25,
    Suffix = "%",
    Icon = Library.Icons.Slider,
    Callback = function(value)
        print("ค่า:", value)
    end,
})

print("ค่าปัจจุบัน:", getValue())
setValue(50)

-- แท็บผู้เล่น + PlayerList
local playerTab = Library.CreateTab({
    Name = "ผู้เล่น",
    Icon = Library.Icons.Player,
    Order = 2,
})

local playerSection = Library.CreateSection(playerTab.Page, {
    Title = "รายชื่อผู้เล่น",
})

Library.CreatePlayerList(playerSection, {
    AccentColor = Library.Theme.Accent,
    OnSelect = function(player)
        print("เลือก:", player.Name)
    end,
})
```

---

15. แก้ปัญหาที่พบบ่อย

อาการ สาเหตุที่เป็นไปได้ วิธีแก้
ไอคอนไม่ขึ้น ส่งเลข Asset ID แทนฟังก์ชัน ใช้ Library.Icons.Home ไม่ใช่ 81381827579989
ไอคอนยังไม่โหลด PreloadAllIcons ยังทำงานอยู่ รอสักครู่ ระบบจะ fallback เป็น rbxthumb:// อัตโนมัติ
Callback ผิดชนิด ส่งค่าผิดประเภท Toggle→boolean, Slider→number, Input→string, Dropdown→ค่าที่เลือก, Keybind→Enum.KeyCode, Button→ไม่มีอาร์กิวเมนต์
ปุ่มลอยไม่ขึ้น คอมโพเนนต์ไม่ใช่ Toggle หรือไม่ได้ตั้ง Floating ใช้กับ CreateToggle และตั้ง Floating = true หรือ FloatButton = true
Keybind บนมือถือไม่ได้ ระบบออกแบบสำหรับคีย์บอร์ด ใช้ปุ่มสัมผัสหรือ Toggle แทน
บันทึกค่าไม่ได้ ไม่มี writefile/readfile เรียก Library.Settings.GetStorageAvailable() ตรวจสอบก่อน — ถ้า false จะเก็บในหน่วยความจำ
สร้าง Section ไม่มีไอคอน CreateSection ไม่รับ Icon ใช้ CreateTab({Icon = ...}) แทน
โหลดซ้ำแล้ว UI ซ้อน มี UI เก่าค้าง ไลบรารีเรียก _G.RUNLUA_HUB_CLEANUP อัตโนมัติ — หรือเรียก Library.Destroy() เองก่อนโหลดใหม่
หน้าต่างไม่เปิดจากปุ่มลัด gp (gameProcessed) เป็น true ปุ่มลัดจะไม่ทำงานเมื่อผู้ใช้กำลังพิมพ์ใน TextBox
ข้อความทับกัน ใช้ TextScale สูงเกิน ลดในแท็บ Settings → ขนาดตัวอักษร เป็น "พอดี" (1.00)

---

16. การล้าง UI

```lua
Library.Destroy()  -- ล้างทุกอย่าง: connections, notifications, ScreenGui
```

หรือปล่อยให้ระบบจัดการอัตโนมัติเมื่อ:

· กดปุ่มปิด (closeBtn)
· screenGui ถูก Destroy
· โหลดไลบรารีใหม่ (ตรวจ _G.RUNLUA_HUB_CLEANUP)

หลังล้าง _G.RUNLUA_HUB_ACTIVE = false และ _G.RUNLUA_HUB_CLEANUP = nil

---

17. การเข้าถึงจากภายนอก

```lua
-- Global access
_G.RUNLUA_HUB          -- ตาราง Library
_G.RUNLUA_HUB_ACTIVE   -- boolean สถานะ
_G.RUNLUA_HUB_CLEANUP  -- ฟังก์ชันล้าง UI
```

---

จบคู่มือ — ไฟล์นี้จัดทำจาก RUNLUA_HUB_V2.lua (RUNLUA UI LIBRARY v3.0) โดยแยก Roblox Asset ID ที่อยู่ในซอร์สออกจากชื่อไอคอน Lucide ที่แนะนำไว้อย่างชัดเจน

เวอร์ชัน: 3.0 — Text Spacing Fix + Icon Manual
อัปเดตล่าสุด: ปรับ RowHeight: 50, RowHeightDesc: 76, RowSpacing: 10, เพิ่ม UITextSizeConstraint ทุกป้ายข้อความ

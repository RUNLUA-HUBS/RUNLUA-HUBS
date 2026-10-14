# คู่มือการใช้งาน UI Library — UINEW_FIXED.lua

คู่มือนี้อ้างอิงจากไฟล์ `UINEW_FIXED.lua` ที่แนบมา ครอบคลุมการสร้างแท็บ หมวดหมู่ คอมโพเนนต์ การตั้งค่า การแจ้งเตือน ปุ่มลอย และไอคอนที่มีในซอร์ส รวมถึงชื่อไอคอนใหม่ที่แนะนำสำหรับ **หมวดหมู่และฟังก์ชันเท่านั้น**

> หมายเหตุ: ไลบรารีนี้เป็น Luau สำหรับ Roblox และอาจพึ่งพา API ที่มีเฉพาะบางสภาพแวดล้อม ควรทดสอบในสภาพแวดล้อมที่ใช้งานจริงก่อนนำไปเผยแพร่

## 1. โหลดไลบรารี

ตัวอย่างรูปแบบการโหลดจาก URL ที่โฮสต์ไฟล์ไว้แล้ว:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"))()
```

เปลี่ยน `https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua` เป็น URL จริงของไฟล์ที่คุณโฮสต์ อย่าใช้ข้อความตัวอย่างนี้ตรง ๆ ไลบรารีจะคืนค่าเป็นตาราง `Library` และกำหนด `_G.RUNLUA_HUB` ไว้ด้วย

## 2. เริ่มต้นสร้าง UI

```lua
local Library = loadstring(game:HttpGet("URL_ไฟล์ไลบรารี"))()

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

แนวคิดหลักคือ `CreateTab` สร้างแท็บ และ `tab.Page` คือพื้นที่สำหรับใส่คอมโพเนนต์ ส่วน `CreateSection` สร้างกลุ่ม/หัวข้อ แล้วจึงเพิ่ม Toggle, Button, Slider และอื่น ๆ เข้าไป

## 3. API หลักของ Library

| API | หน้าที่ |
|---|---|
| `Library.CreateTab(options)` | สร้างแท็บ |
| `Library.SelectTab(tab)` | เลือกแท็บ |
| `Library.CreateSection(parent, options)` | สร้างหมวดหมู่/กลุ่ม |
| `Library.CreateDivider(parent, order)` | สร้างเส้นคั่น |
| `Library.CreateToggle(parent, options)` | สวิตช์เปิด/ปิด |
| `Library.CreateButton(parent, options)` | ปุ่มกดเรียกการทำงาน |
| `Library.CreateSlider(parent, options)` | แถบเลื่อนตัวเลข |
| `Library.CreateInput(parent, options)` | ช่องกรอกข้อความ |
| `Library.CreateKeybind(parent, options)` | ตั้งปุ่มลัดคีย์บอร์ด |
| `Library.CreateDropdown(parent, options)` | รายการตัวเลือก |
| `Library.CreateLabel(parent, options)` | ข้อความบรรทัดเดียว |
| `Library.CreateParagraph(parent, options)` | ข้อความหลายบรรทัด |
| `Library.CreatePlayerList(parent, options)` | รายชื่อผู้เล่นในเซิร์ฟเวอร์ |
| `Library.Notify(options)` | แสดงการแจ้งเตือน |
| `Library.Show()` | แสดงหน้าต่างหลัก |
| `Library.Hide()` | ซ่อนหน้าต่างหลัก |
| `Library.Destroy()` | ล้าง UI และการเชื่อมต่อที่ไลบรารีจัดการ |
| `Library.SetToggleKey(Enum.KeyCode.RightShift)` | ตั้งปุ่มลัดเปิด/ปิด UI |
| `Library.GetToggleKey()` | อ่านปุ่มลัดปัจจุบัน |
| `Library.Settings.Get()` | อ่านค่าการตั้งค่า |
| `Library.Settings.Save()` | บันทึกค่าการตั้งค่า |
| `Library.Settings.Load()` | โหลดค่าที่บันทึกไว้ |
| `Library.Settings.Reset()` | รีเซ็ตค่าการตั้งค่า |
| `Library.Settings.Apply(data)` | นำข้อมูลการตั้งค่ามาใช้ |
| `Library.Settings.GetStorageAvailable()` | ตรวจว่าพบระบบจัดเก็บไฟล์ที่รองรับหรือไม่ |

พร็อพเพอร์ตีที่เปิดให้เข้าถึงได้ ได้แก่ `Library.Theme`, `Library.Config`, `Library.Icons`, `Library.Tabs`, `Library.SettingsTab`, `Library.ScreenGui`, `Library.MainFrame`, `Library.IsMobile` และ `Library.Platform`

## 4. สร้างแท็บและหมวดหมู่

### CreateTab(options)

```lua
local tab = Library.CreateTab({
    Name = "ผู้เล่น",
    Icon = Library.Icons.Player,
    Order = 2,
})
```

| ตัวเลือก | ชนิด | รายละเอียด |
|---|---|---|
| `Name` | string | ชื่อแท็บ |
| `Icon` | function | ฟังก์ชันวาดไอคอน เช่น `Library.Icons.Player` |
| `Order` | number | ลำดับแท็บ |
| `IsSettings` | boolean | ทำเครื่องหมายแท็บตั้งค่า |

แท็บที่สร้างจะมี `tab.Page` สำหรับใส่คอมโพเนนต์

### CreateSection(parent, options)

```lua
local section = Library.CreateSection(tab.Page, {
    Name = "Movement",
    Title = "การเคลื่อนที่",
    Order = 1,
})
```

| ตัวเลือก | ชนิด | รายละเอียด |
|---|---|---|
| `Name` | string | ชื่อภายในของกลุ่ม |
| `Title` | string | หัวข้อที่แสดง |
| `Order` | number | ลำดับกลุ่ม |

**สำคัญ:** ซอร์สปัจจุบันไม่ได้มีตัวเลือก `Icon` ให้ `CreateSection` โดยตรง ไอคอนที่ใช้กับหมวดหมู่ในแถบด้านข้างตั้งผ่าน `CreateTab({Icon = ...})` ส่วนหัวข้อหมวดหมู่ภายในหน้าจะเป็นข้อความ `Title`

## 5. คอมโพเนนต์ทั้งหมด

### 5.1 Toggle — สวิตช์เปิด/ปิด

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

print(getEnabled())
setEnabled(true)
```

ตัวเลือก: `Name`, `Description`, `Default` (boolean), `Order`, `Icon`, `Callback` (รับ boolean), `Floating` และ `FloatButton`

**แผงสวิตช์ลอย:** ใส่ `Floating = true` หรือ `FloatButton = true` เพื่อสร้างแผงลอยเฉพาะ Toggle นั้น แผงจะแสดงชื่อฟังก์ชันกับสถานะเปิด/ปิด ลากได้จากแถบด้านบน และปรับขนาดได้จากมุมซ้ายล่าง

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

ใช้แผงลอยเฉพาะฟังก์ชันที่จำเป็น ไม่ต้องเปิดให้ทุก Toggle โดยอัตโนมัติ

### 5.2 Button — ปุ่มกด

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

ตัวเลือก: `Name`, `Description`, `Order`, `Icon`, `Color` (Color3), `Callback` (ไม่มีอาร์กิวเมนต์)

### 5.3 Slider — แถบเลื่อน

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
    Callback = function(value)
        print("ค่า:", value)
    end,
})
```

ตัวเลือก: `Name`, `Min`, `Max`, `Step`, `Default`, `Suffix`, `Format`, `Order`, `Icon`, `Callback` (รับตัวเลข) ใช้ `Min` ที่ไม่มากกว่า `Max` และ `Step` เป็นค่าบวก

### 5.4 Input — ช่องข้อความ

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

ตัวเลือก: `Name`, `Placeholder`, `Default`, `ClearOnFocus`, `Order`, `Icon`, `Callback` (รับข้อความเมื่อช่องเสียโฟกัส)

### 5.5 Keybind — ปุ่มลัด

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

ตัวเลือก: `Name`, `Default` (Enum.KeyCode), `Order`, `Icon`, `Callback` (รับ KeyCode) ผู้ใช้คลิก/แตะตัวควบคุมบน UI แล้วกดปุ่มใหม่เพื่อกำหนดปุ่มลัด ฟังก์ชันนี้เน้นคีย์บอร์ด ไม่ใช่ปุ่มลัดสัมผัสบนมือถือ

### 5.6 Dropdown — รายการตัวเลือก

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

ตัวเลือก: `Name`, `Options` (table), `Default`, `Order`, `Icon`, `Callback` (รับค่าที่เลือก) ถ้าไม่กำหนด `Default` จะใช้ตัวเลือกแรกเมื่อมีตัวเลือก

### 5.7 Label — ข้อความบรรทัดเดียว

```lua
Library.CreateLabel(section, {
    Text = "ข้อมูลสถานะ",
    Size = 12,
    Height = 18,
    Bold = true,
    Align = Enum.TextXAlignment.Left,
    Color = Library.Theme.Text,
    Order = 7,
})
```

ตัวเลือก: `Text`, `Size`, `Height`, `Bold`, `Align`, `Color`, `Order`

### 5.8 Paragraph — ข้อความหลายบรรทัด

```lua
Library.CreateParagraph(section, {
    Text = "คำอธิบายที่ยาวขึ้นและสามารถตัดบรรทัดได้",
    Size = 11,
    Color = Library.Theme.TextMuted,
    Order = 8,
})
```

ตัวเลือก: `Text`, `Size`, `Color`, `Order`

### 5.9 PlayerList — รายชื่อผู้เล่น

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

ตัวเลือก: `AccentColor`, `Order`, `OnSelect` รายการนี้แสดงผู้เล่นอื่นในเซิร์ฟเวอร์ ไม่รวม LocalPlayer; `refreshPlayers()` ใช้สร้างรายการใหม่ และ `getSelectedPlayer()` คืนผู้เล่นที่เลือกหรือ `nil`

### 5.10 Divider — เส้นคั่น

```lua
Library.CreateDivider(section, 10)
```

รับ `parent` และ `order`

## 6. การแจ้งเตือน

```lua
Library.Notify({
    Title = "สำเร็จ",
    Message = "ตั้งค่าเรียบร้อยแล้ว",
    Duration = 3,
    Color = Library.Theme.Accent,
    Icon = Library.Icons.Home,
})
```

ตัวเลือก: `Title`, `Message`, `Duration` (วินาที), `Color`, `Icon` ระบบมีคิวแจ้งเตือนตามการตั้งค่าภายใน `Library.Config`

## 7. ไอคอนที่ไลบรารีส่งออกให้ใช้

**การใช้งาน:** `Icon` ต้องเป็นฟังก์ชันที่ไลบรารีส่งออก ไม่ใช่ตัวเลข ID โดยตรง ตัวอย่าง `Icon = Library.Icons.Home`

| ชื่อ API | Asset ID | ความหมาย/การใช้งานที่เหมาะสม |
|---|---:|---|
| `Library.Icons.Home` | `81381827579989` | หน้าหลัก / Dashboard |
| `Library.Icons.Player` | `18854794429` | ผู้เล่น |
| `Library.Icons.ESP` | `1137376344` | ESP / การมองเห็น |
| `Library.Icons.Float` | `114167292947807` | ไอคอนลอย / ฟังก์ชันพิเศษ |
| `Library.Icons.Teleport` | `76761366176541` | วาร์ป / พิกัด |
| `Library.Icons.Fling` | `13050670483` | ผลัก / Fling |
| `Library.Icons.Settings` | `135274678904780` | ตั้งค่า |
| `Library.Icons.Action` | `118550787033099` | ยืนยัน / คำสั่ง |
| `Library.Icons.Minimize` | `118924374112009` | ย่อหน้าต่าง |
| `Library.Icons.Close` | `16844961944` | ปิดหน้าต่าง |
| `Library.Icons.Slider` | `8587689327` | ปรับระดับ / Slider |
| `Library.Icons.Pencil` | `16417283031` | แก้ไข / ช่องข้อความ |
| `Library.Icons.Keybind` | `82866471491531` | ปุ่มลัด |
| `Library.Icons.Dropdown` | `96140958199506` | รายการตัวเลือก |
| `Library.Icons.Book` | `90777101549927` | คู่มือ / ข้อมูล |
| `Library.Icons.Save` | `113712416335562` | บันทึก |
| `Library.Icons.Cloud` | `7013266261` | คลาวด์ / ออนไลน์ |
| `Library.Icons.Diamond` | `6788518059` | พรีเมียม / เพชร |

## 8. Asset ID ทั้งหมดที่มีในตารางภายใน

ตารางนี้มาจาก `ICON_IDS` ในไฟล์ต้นฉบับ ชื่อคีย์เป็นชื่อภายในของไลบรารี ไม่ใช่ทุกชื่อที่จะเรียกผ่าน `Library.Icons.<ชื่อ>` ได้โดยตรง

| คีย์ภายใน | Asset ID | ความหมายโดยประมาณ |
|---|---:|---|
| `Home` | `81381827579989` | หน้าหลัก |
| `Settings` | `135274678904780` | ตั้งค่า |
| `ThreeLines` | `15567843411` | เมนู |
| `ESP` | `1137376344` | ESP / การมองเห็น |
| `SwordsAndKnives` | `7485051733` | ต่อสู้ / อาวุธ |
| `Target` | `100986564809027` | เป้าหมาย |
| `target2` | `13577839026` | เป้าหมายสำรอง |
| `Search` | `132302594577680` | ค้นหา |
| `Correct` | `118550787033099` | ยืนยัน / ถูกต้อง |
| `Shop` | `11807308307` | ร้านค้า |
| `Person` | `18854794429` | ผู้เล่น |
| `Crystal` | `12814035490` | คริสตัล |
| `Star` | `95134188293701` | ดาว |
| `star2` | `114167292947807` | ดาว / ฟังก์ชันพิเศษ |
| `Egg` | `86058422496634` | ไข่ |
| `Run` | `10507122439` | วิ่ง |
| `Discord` | `110769239384778` | Discord |
| `YouTube` | `85469926655680` | YouTube |
| `word` | `121176334529781` | ข้อความ |
| `sound` | `117386765962827` | เสียง |
| `fruit` | `130882648` | ผลไม้ |
| `file` | `92272038372516` | ไฟล์ |
| `book` | `90777101549927` | หนังสือ / คู่มือ |
| `pencil` | `16417283031` | แก้ไข |
| `gun` | `15286668313` | อาวุธ |
| `map` | `14240466966` | แผนที่ |
| `coordinates` | `76761366176541` | พิกัด / วาร์ป |
| `airplane` | `2189714464` | เครื่องบิน / บิน |
| `rocket` | `16149155554` | จรวด / เพิ่มความเร็ว |
| `smile` | `11955884989` | ยิ้ม / อารมณ์ |
| `gift` | `90596283238411` | ของขวัญ |
| `bag` | `13933329303` | กระเป๋า |
| `fish` | `114366026221277` | ปลา |
| `WiFi` | `82866471491531` | Wi-Fi / ใช้แทนไอคอนปุ่มลัดใน UI |
| `signal` | `8587689327` | สัญญาณ / ตัวเลื่อน |
| `dinosaur` | `15232707578` | ไดโนเสาร์ |
| `box` | `89528045721909` | กล่อง |
| `thunder` | `123699649588161` | สายฟ้า |
| `reset` | `4343875685` | รีเซ็ต |
| `diamond` | `6788518059` | เพชร |
| `punch` | `13050670483` | หมัด / Fling |
| `spoon` | `73443323737499` | ช้อน |
| `menu` | `96140958199506` | เมนู / Dropdown |
| `meun2` | `77038338415780` | เมนูสำรอง (สะกดตามคีย์ในซอร์ส) |
| `cloud` | `7013266261` | คลาวด์ |
| `Pin1` | `94180059461552` | หมุด |
| `Pin2` | `78174345206454` | หมุดสำรอง |
| `Save` | `113712416335562` | บันทึก |
| `hook` | `14376301503` | ตะขอ |
| `Fishingrod` | `74554825003519` | คันเบ็ด |
| `cross` | `16844961944` | ปิด / กากบาท |
| `short` | `118924374112009` | ย่อหน้าต่าง |

> ID ถูกถอดจากซอร์ส ไม่ได้รับประกันว่า Asset ทุกชิ้นยังเปิดให้ใช้งานหรือแสดงผลได้เสมอ เพราะสิทธิ์และสถานะของ Roblox Asset อาจเปลี่ยนได้ ควรทดสอบก่อนใช้งานจริง

## 9. ไอคอนใหม่ที่แนะนำสำหรับหมวดหมู่และฟังก์ชัน

รายการต่อไปนี้เป็น **ชื่อไอคอนจากชุด Lucide** เพื่อใช้เป็นแนวทางเลือกดีไซน์ ไม่ใช่ Roblox Asset ID และนำไปใส่ใน `Library.Icons` โดยตรงไม่ได้ ต้องหา/สร้าง Roblox image asset ที่เหมาะสม แล้วเพิ่ม ID และฟังก์ชันวาดในไลบรารีก่อน

| หมวดหมู่/ฟังก์ชัน | ชื่อไอคอน Lucide | ความหมาย |
|---|---|---|
| หน้าหลัก | `house` | หน้าหลัก |
| ผู้เล่น | `users` | รายชื่อผู้เล่น |
| ตัวละคร | `user-round` | ตัวละคร / โปรไฟล์ |
| ESP / มองเห็น | `eye` | การมองเห็น |
| เป้าหมาย | `crosshair` | เล็งเป้าหมาย |
| เคลื่อนที่ | `footprints` | การเคลื่อนที่ |
| วิ่ง / ความเร็ว | `zap` | ความเร็ว / พลัง |
| วาร์ป / พิกัด | `map-pin` | จุดหมาย |
| นำทาง | `navigation` | ทิศทาง / นำทาง |
| บิน | `plane` | การบิน |
| แรงผลัก / Fling | `move` | การเคลื่อนย้าย |
| ต่อสู้ | `swords` | ต่อสู้ |
| ป้องกัน | `shield` | ป้องกัน |
| เครื่องมือ | `wrench` | เครื่องมือ |
| ตั้งค่า | `settings` | ตั้งค่า |
| ปุ่มลัด | `keyboard` | คีย์บอร์ด |
| สวิตช์ | `toggle-right` | เปิด/ปิด |
| ปรับระดับ | `sliders-horizontal` | ปรับค่า |
| รายการเลือก | `list` | รายการ |
| ค้นหา | `search` | ค้นหา |
| ร้านค้า | `shopping-cart` | ร้านค้า |
| พรีเมียม | `gem` | พรีเมียม |
| บันทึก | `save` | บันทึก |
| รีเซ็ต | `rotate-ccw` | รีเซ็ต |
| ข้อมูล | `info` | ข้อมูล |
| แจ้งเตือน | `bell` | แจ้งเตือน |
| คู่มือ | `book-open` | คู่มือ |
| สคริปต์ / โค้ด | `code` | โค้ด |
| ไฟล์โค้ด | `file-code` | ไฟล์โค้ด |
| เซิร์ฟเวอร์ | `server` | เซิร์ฟเวอร์ |
| ความปลอดภัย | `shield-check` | ความปลอดภัย |
| ปิดหน้าต่าง | `x` | ปิด |
| ย่อหน้าต่าง | `minus` | ย่อ |

ดูตัวอย่างไอคอนที่ https://lucide.dev/icons/ ชื่อใช้ตัวพิมพ์เล็กและขีดกลางตามที่แสดงในตาราง

## 10. ตั้งค่าปุ่มเปิด/ปิดหน้าต่าง

```lua
Library.SetToggleKey(Enum.KeyCode.RightControl)
print(Library.GetToggleKey().Name)
```

ค่าเริ่มต้นในซอร์สคือปุ่มลัดคีย์บอร์ดตามตัวแปรภายใน ไลบรารีมีปุ่ม/โลโก้สำหรับเปิดหน้าต่างด้วย และมีการแสดงข้อความแนะนำการควบคุมตามอุปกรณ์ที่ตรวจพบ การตั้งปุ่มลัดนี้เหมาะกับคอมพิวเตอร์ ไม่ใช่ปุ่มสัมผัสบนมือถือ

## 11. Settings และการบันทึกค่า

```lua
local data = Library.Settings.Get()
local available = Library.Settings.GetStorageAvailable()

Library.Settings.Save()
Library.Settings.Load()
-- หากต้องการคืนค่าเริ่มต้น:
Library.Settings.Reset()
-- หากมีตารางข้อมูลการตั้งค่า:
-- Library.Settings.Apply(data)
```

มี `Library.Settings.Version` และ `Library.Settings.FileName` สำหรับดูเวอร์ชันและชื่อไฟล์ การบันทึก/โหลดขึ้นกับความสามารถด้านไฟล์ของสภาพแวดล้อมที่ใช้ หากไม่รองรับ ระบบจัดเก็บไฟล์อาจไม่พร้อมใช้งาน

## 12. ตัวอย่างรวม

```lua
local Library = loadstring(game:HttpGet("URL_ไฟล์ไลบรารี"))()

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
```

## 13. แก้ปัญหาที่พบบ่อย

**ไอคอนไม่ขึ้น:** ส่งฟังก์ชัน เช่น `Library.Icons.Home` ไม่ใช่เลข Asset ID ตรวจสอบว่า ID ยังแสดงผลได้ใน Roblox และลองใช้ไอคอนที่ไลบรารีมีอยู่ก่อน

**Callback ทำงานไม่ตรงชนิด:** Toggle ส่ง boolean, Slider ส่ง number, Input ส่ง string, Dropdown ส่งค่าที่เลือก, Keybind ส่ง `Enum.KeyCode` และ Button ไม่ส่งอาร์กิวเมนต์

**ปุ่มลอยไม่ขึ้น:** ตรวจว่าคอมโพเนนต์นั้นเป็น Toggle และตั้ง `Floating = true` หรือ `FloatButton = true` แล้ว ระบบนี้ไม่ได้สร้างแผงลอยให้ Button, Slider หรือ Dropdown อัตโนมัติ

**Keybind ใช้บนมือถือไม่ได้:** ระบบปุ่มลัดออกแบบมาสำหรับคีย์บอร์ด ควรใช้ปุ่มสัมผัสหรือ Toggle แทนบนมือถือ

**บันทึกค่าไม่ได้:** เรียก `Library.Settings.GetStorageAvailable()` ตรวจสอบก่อน และตรวจว่า executor/สภาพแวดล้อมมี API จัดเก็บไฟล์ที่ไลบรารีต้องการหรือไม่

**หมวดหมู่ไม่มีไอคอน:** ในเวอร์ชันนี้ `CreateSection` รับ `Name`, `Title`, `Order` แต่ไม่ได้รับ `Icon` โดยตรง หากต้องการไอคอนให้หมวดหมู่ที่แถบแท็บ ให้กำหนด `Icon` ใน `CreateTab`

---

จบคู่มือ — ไฟล์นี้จัดทำจาก `UINEW_FIXED.lua` ที่แนบมา โดยแยก Roblox Asset ID ที่อยู่ในซอร์สออกจากชื่อไอคอน Lucide ที่แนะนำไว้อย่างชัดเจน

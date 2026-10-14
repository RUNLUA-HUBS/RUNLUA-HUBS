# คู่มือการใช้งาน RUNLUA UI Library

เอกสารนี้อธิบายการใช้งานไฟล์ `UINEW_FIXED.lua` ฉบับแก้ไข รวม API ที่เปิดให้เรียกใช้ ตัวเลือกของคอมโพเนนต์ ระบบปุ่มลอย ระบบปรับขนาด การตั้งค่า และการแก้ไขที่ทำในฉบับนี้

## 1. การติดตั้งและเรียกใช้

ไฟล์นี้เป็น Roblox Lua/Luau Module-style library ที่คืนค่า `Library` เมื่อรันสำเร็จ โดยทั่วไปให้โหลด/รันไฟล์ตาม executor หรือระบบ loader ที่ใช้อยู่:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"))()
```

ถ้าไฟล์อยู่ในสคริปต์เดียวกัน ให้ใช้ค่าที่คืนกลับมาเป็นตัวแปร `Library` แล้วสร้างแท็บและคอมโพเนนต์ต่าง ๆ ต่อได้ทันที

> ไลบรารีจะพยายามปิดอินสแตนซ์เดิมผ่าน `_G.RUNLUA_HUB_CLEANUP` ก่อนสร้างอินสแตนซ์ใหม่ เพื่อป้องกัน UI ซ้อนกัน

## 2. โครงสร้างการสร้าง UI ขั้นพื้นฐาน

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RUNLUA-HUBS/RUNLUA-HUBS/refs/heads/main/UI%20Library/UILibrary.lua"))()

local mainTab = Library.CreateTab({
    Name = "หน้าหลัก",
    Icon = Library.Icons.Home,
})

local section = Library.CreateSection(mainTab.Page, {
    Title = "ฟังก์ชันทั่วไป",
})

Library.CreateToggle(section, {
    Name = "เปิดใช้งาน",
    Description = "ตัวอย่างสวิตช์",
    Default = false,
    Callback = function(enabled)
        print("สถานะ:", enabled)
    end,
})
```

`CreateTab` คืนค่าแท็บที่มี `Page` สำหรับใช้เป็น parent ของคอมโพเนนต์ ส่วนคอมโพเนนต์ทุกชนิดควรส่ง parent เป็น `tab.Page` หรือ section ที่สร้างไว้

## 3. API หลักของ Library

| API | รายละเอียด |
|---|---|
| `Library.Theme` | ตารางสีธีมที่ใช้งานอยู่ เช่น `Background`, `Surface`, `Accent`, `Text`, `Danger`, `Success` |
| `Library.Config` | ค่าคอนฟิก เช่น `WindowSize`, `WindowMinSize`, `RowHeight`, `AnimNormal` |
| `Library.Icons` | ฟังก์ชันวาดไอคอน เช่น `Home`, `Player`, `ESP`, `Settings`, `Action`, `Slider`, `Dropdown`, `Save` |
| `Library.Tabs` | ตารางแท็บทั้งหมดที่สร้างขึ้น |
| `Library.Notify(opts)` | แสดงการแจ้งเตือน |
| `Library.CreateTab(opts)` | สร้างแท็บ |
| `Library.CreateSection(parent, opts)` | สร้างหัวข้อ/กลุ่มคอมโพเนนต์ |
| `Library.CreateDivider(parent, order)` | สร้างเส้นแบ่ง |
| `Library.CreateToggle(parent, opts)` | สร้างสวิตช์เปิด/ปิด |
| `Library.CreateButton(parent, opts)` | สร้างปุ่มกดครั้งเดียว |
| `Library.CreateSlider(parent, opts)` | สร้างตัวเลื่อนค่า |
| `Library.CreateInput(parent, opts)` | สร้างช่องข้อความ |
| `Library.CreateKeybind(parent, opts)` | สร้างปุ่มลัด |
| `Library.CreateDropdown(parent, opts)` | สร้างรายการตัวเลือก |
| `Library.CreateLabel(parent, opts)` | สร้างข้อความบรรทัดเดียว |
| `Library.CreateParagraph(parent, opts)` | สร้างข้อความหลายบรรทัด |
| `Library.CreatePlayerList(parent, opts)` | สร้างรายชื่อผู้เล่นและเลือกผู้เล่น |
| `Library.SelectTab(tab)` | เลือกแท็บที่สร้างไว้ |
| `Library.Show()` / `Library.Hide()` | แสดง/ซ่อนหน้าต่างหลัก |
| `Library.Destroy()` | ลบ UI และยกเลิก connection ทั้งหมด |
| `Library.IsMobile` | `true` เมื่อระบบตรวจพบอุปกรณ์มือถือ |
| `Library.Platform` | ชื่อแพลตฟอร์มที่ตรวจพบ |
| `Library.ScreenGui` | ScreenGui หลัก |
| `Library.MainFrame` | Frame หน้าต่างหลัก |

### การแจ้งเตือน

```lua
Library.Notify({
    Title = "สำเร็จ",
    Message = "เปิดใช้งานแล้ว",
    Duration = 3,
    Color = Library.Theme.Success,
    Icon = Library.Icons.Action,
})
```

ฟิลด์ `Title`, `Message`, `Duration`, `Color`, `Icon` เป็นตัวเลือกทั้งหมด หากไม่ระบุจะใช้ค่าเริ่มต้นของไลบรารี่

## 4. รายละเอียดคอมโพเนนต์ทุกชนิด

### 4.1 `CreateTab(opts)`

ตัวเลือกที่ใช้บ่อย:

- `Name`: ชื่อแท็บ
- `Icon`: ฟังก์ชันวาดไอคอนจาก `Library.Icons`
- `Order`: ลำดับแท็บ
- `IsSettings = true`: ใช้สร้างแท็บตั้งค่า

คืนค่า object ที่มีอย่างน้อย `Page`, `Button`, `Name`, `Index` และข้อมูลแท็บที่ใช้กับ `Library.SelectTab(tab)`

### 4.2 `CreateSection(parent, opts)`

- `Name`: ชื่อภายในของ section
- `Title`: หัวข้อที่แสดงบน UI
- `Order`: ลำดับการจัดวาง

### 4.3 `CreateDivider(parent, order)`

สร้างเส้นแบ่งแนวนอน ใช้ `order` เพื่อกำหนดลำดับ

### 4.4 `CreateToggle(parent, opts)`

ตัวเลือก:

- `Name`: ชื่อสวิตช์
- `Description`: คำอธิบายใต้ชื่อ
- `Default`: ค่าเริ่มต้นแบบ boolean
- `Callback(value)`: ทำงานเมื่อค่าเปลี่ยน
- `Icon`: ไอคอน
- `Order`: ลำดับ
- `Floating = true` หรือ `FloatButton = true`: เปิดความสามารถปุ่มลอยให้สวิตช์นั้น

ตัวอย่าง:

```lua
local row, getValue, setValue = Library.CreateToggle(section, {
    Name = "เปิด ESP",
    Description = "แสดงข้อมูลผู้เล่น",
    Default = false,
    Floating = true,
    Icon = Library.Icons.ESP,
    Callback = function(enabled)
        -- เปิด/ปิดฟังก์ชันจริงของผู้ใช้
    end,
})
```

ค่าที่คืน:

1. `row`: Frame ของแถว
2. `getValue()`: อ่านค่า boolean ปัจจุบัน
3. `setValue(boolean)`: ตั้งค่า toggle จากโค้ด

#### วิธีใช้ปุ่มลอยที่แก้ไขแล้ว

1. ใส่ `Floating = true` หรือ `FloatButton = true` ให้เฉพาะฟังก์ชันที่ต้องการ
2. ตอนเริ่มต้น **แผงปุ่มลอยจะยังไม่แสดง**
3. กดปุ่ม `ลอย` ที่อยู่ด้านขวาของแถวฟังก์ชันนั้น เพื่อเปิด/ปิดแผงปุ่มลอยเฉพาะฟังก์ชัน
4. เมื่อแผงแสดงแล้ว ให้กดสวิตช์ในแผงเพื่อเปลี่ยนค่าฟังก์ชัน
5. ลากชื่อด้านบนของแผงเพื่อย้ายตำแหน่ง
6. ลากมุมซ้ายล่างเพื่อปรับขนาด แผงจะมีขนาดกว้าง 190–420 และสูง 58–140 พิกเซล
7. กดปุ่ม `ลอย✓` เพื่อซ่อนแผง โดยไม่เปลี่ยนค่าการทำงานของฟังก์ชัน

ฟังก์ชันที่ไม่ได้ระบุ `Floating` หรือ `FloatButton` จะไม่สร้างปุ่มลอยและจะไม่แสดงปุ่ม `ลอย` ในแถวนั้น

### 4.5 `CreateButton(parent, opts)`

ตัวเลือก:

- `Name`, `Description`, `Icon`, `Color`, `Order`
- `Callback()`: ทำงานเมื่อกดปุ่ม

```lua
Library.CreateButton(section, {
    Name = "รีเฟรช",
    Description = "โหลดข้อมูลใหม่",
    Icon = Library.Icons.Action,
    Callback = function()
        Library.Notify({Title = "รีเฟรชแล้ว", Message = "ดำเนินการสำเร็จ"})
    end,
})
```

### 4.6 `CreateSlider(parent, opts)`

ตัวเลือก:

- `Name`, `Description`, `Icon`, `Order`
- `Min`, `Max`, `Step`, `Default`
- `Suffix`: ข้อความต่อท้ายค่า
- `Format(value)`: ฟังก์ชันจัดรูปแบบค่าที่แสดง
- `Callback(value)`: ทำงานเมื่อค่าเปลี่ยน

```lua
Library.CreateSlider(section, {
    Name = "ความเร็ว",
    Min = 0,
    Max = 100,
    Step = 5,
    Default = 50,
    Suffix = "%",
    Callback = function(value) print(value) end,
})
```

### 4.7 `CreateInput(parent, opts)`

- `Name`, `Placeholder`, `Default`, `Icon`, `Order`
- `ClearOnFocus`: ล้างค่าเมื่อเริ่มโฟกัส
- `Callback(text)`: ทำงานเมื่อข้อความถูกยืนยัน/เปลี่ยนตามพฤติกรรมของช่อง

### 4.8 `CreateKeybind(parent, opts)`

- `Name`, `Default` เป็น `Enum.KeyCode`, `Icon`, `Order`
- `Callback(keyCode)`: เรียกเมื่อเปลี่ยน/ใช้ปุ่มลัดตามการทำงานของคอมโพเนนต์

ปุ่มลัดหลักของหน้าต่าง:

```lua
Library.SetToggleKey(Enum.KeyCode.RightShift)
local key = Library.GetToggleKey()
```

`SetToggleKey` คืน `true` เมื่อรับค่า `Enum.KeyCode` ถูกต้อง และคืน `false` เมื่อชนิดข้อมูลไม่ถูกต้อง

### 4.9 `CreateDropdown(parent, opts)`

- `Name`, `Options` เป็น array, `Default`, `Icon`, `Order`
- `Callback(value)`

```lua
Library.CreateDropdown(section, {
    Name = "โหมด",
    Options = {"ปลอดภัย", "เร็ว", "กำหนดเอง"},
    Default = "ปลอดภัย",
    Callback = function(value) print(value) end,
})
```

### 4.10 `CreateLabel(parent, opts)`

- `Text`, `Color`, `Size`, `Bold`, `Align`, `Height`, `Order`

### 4.11 `CreateParagraph(parent, opts)`

- `Text`, `Color`, `Size`, `Order`

เหมาะสำหรับคำอธิบายยาวหรือข้อความช่วยเหลือ

### 4.12 `CreatePlayerList(parent, opts)`

- `OnSelect(player)`: callback เมื่อเลือกผู้เล่น
- `AccentColor`: สีเน้น
- `Order`: ลำดับ

## 5. การตั้งค่าและการบันทึก

เข้าหน้า Settings ของ UI เพื่อปรับ:

- ขนาดตัวอักษร
- น้ำหนักฟอนต์
- สีธีม
- บันทึกการตั้งค่า
- โหลดการตั้งค่า
- รีเซ็ตกลับค่าเริ่มต้น

หรือเรียกผ่าน `Library.Settings`:

```lua
local settings = Library.Settings
local ok, message = settings.Save()
local loaded, loadMessage = settings.Load()
settings.Reset()
local data = settings.Get()
settings.Apply(data)
local canSave = settings.GetStorageAvailable()
```

ไฟล์ตั้งค่าชื่อ `RUNLUA_HUB_SETTINGS.json` หากสภาพแวดล้อมไม่มี `isfile/readfile/writefile` ระบบจะเก็บค่าไว้ในหน่วยความจำของเซสชันแทน

## 6. การควบคุมหน้าต่าง

- คอมพิวเตอร์: กด `RightShift` เพื่อเปิด/ปิด โดยเปลี่ยนได้ด้วย `Library.SetToggleKey`
- มือถือ: แตะโลโก้ลอยเพื่อเปิด/ปิด
- ลากแถบด้านบนเพื่อย้ายหน้าต่าง
- ลากมุมปรับขนาดของหน้าต่างหลักเพื่อเปลี่ยนขนาด
- โลโก้ลอยสามารถลากย้ายได้
- ปิดหน้าต่างด้วยปุ่มปิดจะเรียก `Library.Destroy()` และยกเลิก connection ทั้งหมด

## 7. สิ่งที่แก้ไขในฉบับนี้

1. ปุ่มลอยรายฟังก์ชันไม่แสดงขึ้นมาเองเมื่อรัน UI อีกต่อไป
2. เพิ่มปุ่ม `ลอย` ในแถวของ toggle ที่ประกาศ `Floating = true` หรือ `FloatButton = true`
3. ปุ่ม `ลอย` มีสถานะปิด/เปิดชัดเจน (`ลอย` / `ลอย✓`)
4. แผงปุ่มลอยยังคงมีสวิตช์เปิด/ปิดฟังก์ชันแยกจากปุ่มเปิดแผง
5. แก้บัคปรับขนาดแผงลอยที่ตำแหน่งถูกบวกซ้ำทุก InputChanged จนแผงกระโดดหรือเพี้ยน
6. การปรับขนาดแผงคำนวณจากตำแหน่งและขนาดตอนเริ่มลากทุกครั้ง จึงลากต่อเนื่องได้เสถียร
7. รักษาการ cleanup connection และการลบ UI เมื่อปิดไลบรารี่
8. ตรวจสอบ API สาธารณะหลักและโครงสร้างตัวเลือกของทุกคอมโพเนนต์แล้ว

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

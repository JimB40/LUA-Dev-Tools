----------------------------------------------------------
-- LUA DEV TOOLS
-- release date: 2021-06-22
----------------------------------------------------------
-- Written Robert Janiszewski (JimB40)
-- fm2m.jimb40.com
-- robert <at> jimb40 <dot> com
----------------------------------------------------------
local Parent = ...
local this = {}
this.__index = Parent
setmetatable(this, this)


local srcS = 0
local srcN = this.TX.HORUS and 14 or 7

local tBH = this.TX.HORUS and 20 or 9

local c1 = this.TX.HORUS and 40 or 20
local c2 = this.TX.HORUS and 50 or 24
local c3 = this.TX.HORUS and 150 or 80
local c4 = this.TX.HORUS and 160 or 84


local function run(e)
  local source
  local lineHeight = this.TX.HORUS and 16 or 8
  lcd.clear(this.GUI.C2)
  lcd.drawFilledRectangle(0,0,LCD_W,tBH, this.GUI.C1)
  lcd.drawText( c1 - (this.TX.HORUS and 30 or 20), 1, 'Switches', this.GUI.C2)
  lcd.drawText( c3 - (this.TX.HORUS and 30 or 20), 1, 'Sources', this.GUI.C2)

  for source = srcS, srcS+srcN do
    local line = source - srcS
    lcd.drawText(c1, tBH + line * lineHeight, source, this.GUI.C1+RIGHT)
    lcd.drawSwitch(c2, tBH + line * lineHeight, source, this.GUI.C1)
    lcd.drawText(c3, tBH + line * lineHeight, source, this.GUI.C1+RIGHT)
    lcd.drawSource(c4, tBH + line * lineHeight, source, this.GUI.C1)
  end

  if e == EVT_VIRTUAL_NEXT or e == EVT_VIRTUAL_NEXT_REPT then
    srcS = math.min(500, srcS+1)
  elseif e == EVT_VIRTUAL_PREV or e == EVT_VIRTUAL_PREV_REPT then
    srcS = math.max(-500, srcS-1)
  elseif e == EVT_VIRTUAL_NEXT_PAGE then
    srcS = math.min(500, srcS+srcN)
  elseif e == EVT_VIRTUAL_PREV_PAGE then
    srcS = math.min(500, srcS-srcN)
  end

  return 0

end

return { run=run }

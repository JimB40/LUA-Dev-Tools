----------------------------------------------------------
-- JimB40 Lua Dev ToolBox
-- version 0.2
-- release date: 2021-11-08
----------------------------------------------------------
-- Coded by Robert Janiszewski (JimB40)
-- fm2m.jimb40.com
-- robert <at> jimb40 <dot> com
----------------------------------------------------------
local Parent = ...
local this = {}
this.__index = Parent
setmetatable(this, this)


local srcS = 0
local lines = this.TX.COLOR and (this.TX.NV14 and 24 or 14) or 7

local col1 = this.TX.COLOR and 40 or 20
local col2 = this.TX.COLOR and 50 or 24
local col3 = this.TX.COLOR and 150 or 80
local col4 = this.TX.COLOR and 160 or 84


local function run(e)
  local source
  lcd.clear(this.GUI.C2)
  this.GUI.drawTopBar()
  lcd.drawText( col1 - (this.TX.COLOR and 30 or 20), 1, 'Switches', this.GUI.C2)
  lcd.drawText( col3 - (this.TX.COLOR and 30 or 20), 1, 'Sources', this.GUI.C2)

  for source = srcS, srcS+lines do
    local line = source - srcS
    lcd.drawText(col1, this.GUI.topBarHeight + line * this.GUI.lineHeight, source, this.GUI.C1+RIGHT)
    lcd.drawSwitch(col2, this.GUI.topBarHeight + line * this.GUI.lineHeight, source, this.GUI.C1)
    lcd.drawText(col3, this.GUI.topBarHeight + line * this.GUI.lineHeight, source, this.GUI.C1+RIGHT)
    lcd.drawSource(col4, this.GUI.topBarHeight + line * this.GUI.lineHeight, source, this.GUI.C1)
  end

  if e == EVT_VIRTUAL_NEXT or e == EVT_VIRTUAL_NEXT_REPT then
    srcS = math.min(500, srcS+1)
  elseif e == EVT_VIRTUAL_PREV or e == EVT_VIRTUAL_PREV_REPT then
    srcS = math.max(-500, srcS-1)
  elseif e == EVT_VIRTUAL_NEXT_PAGE then
    srcS = math.min(500, srcS+lines)
  elseif e == EVT_VIRTUAL_PREV_PAGE then
    srcS = math.min(500, srcS-lines)
  end

  return 0

end

return { run=run }

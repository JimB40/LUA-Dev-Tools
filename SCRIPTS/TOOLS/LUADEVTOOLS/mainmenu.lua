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

local maxDispLines = this.TX.COLOR and 14 or 6
local lineSpace = this.TX.COLOR and 22 or 9

this.selLine = this.pageLast
local firstDispLine = 1
local selectMode = true
local editMode = false

local function drawMenu()
  local w = 0
  local y = this.TX.COLOR and 30 or 9
  local xt = this.TX.COLOR and 10 or 1
  local xv = 10
  local lineDisp = 1

  local function drawMenuItem(x, y, w, h, value, selected, editMode, la, ra)
    local flags = selected and this.GUI.C2 or this.GUI.C1
    x = LCD_W - w
    if selected then
      lcd.drawFilledRectangle(x+1,y,w-x,h, this.GUI.C1)
    end
    lcd.drawText(x+9, y+2, value, flags)
  end

  for iop = firstDispLine, math.min(#this.PAGES,firstDispLine+maxDispLines-1), 1 do

    local item = this.PAGES[iop]
    local sFlag = 0  -- flags
    local editFlag = editMode and INVERS or 0
    local yi = y + ((iop - firstDispLine) * lineSpace) -- line y position
    local vx = xt+w
    drawMenuItem(vx, yi, LCD_W-vx, lineSpace+1, item.t, (iop == this.selLine), editMode, la, ra) -- dipslay item
  end
end

local function selectNextMenuItem(dir)
  this.selLine = this.selLine+dir > #this.PAGES and #this.PAGES or this.selLine+dir < 1 and 1 or this.selLine+dir
  --this.PG.this.selLine = this.selLine
  if dir>0 then
    firstDispLine = math.max(this.selLine - maxDispLines + 1, firstDispLine)
  elseif dir<0 then
    firstDispLine = math.min(this.selLine, firstDispLine)
  end
end

local function processKeys(e)
  if (e == EVT_VIRTUAL_MENU) then -- XLITE -> SHIFT button, QX7 -> MENU pressed
    killEvents(EVT_VIRTUAL_MENU)
  end
  if (e == EVT_VIRTUAL_EXIT) then -- XLITE, QX7 -> EXIT pressed
    killEvents(EVT_VIRTUAL_EXIT)
  end
  if (e == EVT_VIRTUAL_ENTER) then -- XLITE -> joystick pressed, QX7 -> NAV pressed
    this.pageSelected = this.selLine
    killEvents(EVT_VIRTUAL_ENTER)
  end
  if (e == 100) then -- XLITE -> joystick Up
    if this.TX.type == 'xlite' then
      selectNextMenuItem(-1)
    end
    killEvents(100)
  end
  if (e == EVT_VIRTUAL_NEXT or e == EVT_VIRTUAL_NEXT_PAGE) then -- XLITE -> joystick Right, QX7 -> NavRT
    selectNextMenuItem(1)
    -- killEvents(e)
  end
  if (e == EVT_VIRTUAL_PREV or e == EVT_VIRTUAL_PREV_PAGE) then -- XLITE -> joystick Left, QX7 NavLT
    selectNextMenuItem(-1)
    -- killEvents(e)
  end
end

--  MAIN LOOP functions
---------------------------------------
-- INIT function
this.init = function()
  print('*** mainmenu.lua init')
end

-- RUN function
this.run = function(e)

  lcd.clear(this.GUI.C2)
  processKeys(e)

  this.GUI.drawTopBar()
  this.GUI.drawTitle('JimB40 LUA Dev ToolBox')
  drawMenu()

  return 0

end

return this

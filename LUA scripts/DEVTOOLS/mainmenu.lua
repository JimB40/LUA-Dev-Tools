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

local maxDispLines = this.TX.HORUS and 14 or 6
local lineSpace = this.TX.HORUS and 20 or 9

this.selLine = this.pageLast
local firstDispLine = 1
local selectMode = true
local editMode = false

local function drawMenu()
  local w = 0
  local y = this.TX.HORUS and 30 or 9
  local xt = this.TX.HORUS and 10 or 1
  local xv = 10
  local lineDisp = 1

  local function drawMenuItem(x, y, w, h, value, selected, editMode, la, ra)
    local flags = selected and this.GUI.C2 or this.GUI.C1
    x = LCD_W - w
    if selected then
      lcd.drawFilledRectangle(x+1,y,w,h, this.GUI.C1)
    end
    lcd.drawText(x+9, y+2, value, flags)
  end

  for iop = firstDispLine, math.min(#this.PAGES,firstDispLine+maxDispLines-1), 1 do

    local item = this.PAGES[iop]
    local sFlag = 0  -- flags
    local editFlag = editMode and INVERS or 0
    local yi = y + ((iop - firstDispLine) * lineSpace) -- line y position
    local vx = xt+w
    drawMenuItem(vx, yi, LCD_W-vx, lineSpace+ (this.TX.HORUS and 4 or 1), item.t, (iop == this.selLine), editMode, la, ra) -- dipslay item
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
  if (e == EVT_VIRTUAL_NEXT_PAGE) then -- XLITE -> joystick Down, QX7 -> PAGE pressed
    if this.TX.type == 'xlite' then
      selectNextMenuItem(1)
    end
    killEvents(EVT_VIRTUAL_NEXT_PAGE)
  end
  if (e == 100) then -- XLITE -> joystick Up
    if this.TX.type == 'xlite' then
      selectNextMenuItem(-1)
    end
    killEvents(100)
  end
  if (e == EVT_VIRTUAL_NEXT) then -- XLITE -> joystick Right, QX7 -> NavRT
    selectNextMenuItem(1)
    killEvents(EVT_VIRTUAL_NEXT)
  end
  if (e == EVT_VIRTUAL_PREV) then -- XLITE -> joystick Left, QX7 NavLT
    selectNextMenuItem(-1)
    killEvents(EVT_VIRTUAL_PREV)
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

  lcd.clear()
  processKeys(e)

  this.GUI.drawTopBar()
  this.GUI.drawTitle('JimB40 LUA DevTools')
  this.GUI.drawTime()
  drawMenu()

  return 0

end

return this

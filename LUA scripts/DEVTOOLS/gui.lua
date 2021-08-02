----------------------------------------------------------
-- JimB40 Lua Dev ToolBox
-- release date: 2021-09-01
----------------------------------------------------------
-- Coded by Robert Janiszewski (JimB40)
-- fm2m.jimb40.com
-- robert <at> jimb40 <dot> com
----------------------------------------------------------
local Parent = ...
local this = {}
this.__index = Parent
setmetatable(this, this)

this.topBarH = this.TX.COLOR and 23 or 8
this.bottBarH = this.TX.COLOR and 23 or 8
this.C1 = this.TX.COLOR and TEXT_COLOR or 0
this.C2 = this.TX.COLOR and TEXT_BGCOLOR or INVERS

-- Draw TopBar
this.drawTopBar = function(h)
  if h == nil then h = this.topBarH end
  lcd.drawFilledRectangle(0,0,LCD_W, h, this.C1)
end

-- Draw TopBar
this.drawBottBar = function(h)
  if h == nil then h = this.bottBarH end
  lcd.drawFilledRectangle(0,this.LCD_H-this.bottBarH,LCD_W, h, this.C1)
end

-- Draw Time
this.drawTitle = function(t)
  lcd.drawText(1,this.TX.COLOR and 1 or 0,t, this.C2)
end

return this

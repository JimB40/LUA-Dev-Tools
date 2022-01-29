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

this.__call = function(table,key)
  -- print(table,key)
  if key == 'C1' or key == 'C2' then
    if this.TX.COLOR then
      lcd.setColor(CUSTOM_COLOR, this[key])
      return CUSTOM_COLOR
    else
      return this[key]
    end
  end
end

setmetatable(this, this)


this.topBarHeight = this.TX.COLOR and 20 or 9
this.lineHeight = this.TX.COLOR and 18 or 8
this.C1 = this.TX.COLOR and BLACK or 0
this.C2 = this.TX.COLOR and WHITE or INVERS

-- Draw TopBar
this.drawTopBar = function(h)
  if h == nil then h = this.topBarHeight end
  lcd.drawFilledRectangle(0,0,LCD_W, h, this('C1'))
end

-- Draw Time
this.drawTitle = function(t)
  lcd.drawText(1,this.TX.COLOR and 1 or 0,t, this('C2'))
end

return this

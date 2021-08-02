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

this.topBarH = this.TX.HORUS and 23 or 8
this.bottBarH = this.TX.HORUS and 23 or 8
this.C1 = this.TX.HORUS and TEXT_COLOR or 0
this.C2 = this.TX.HORUS and TEXT_BGCOLOR or INVERS

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
  lcd.drawText(1,this.TX.HORUS and 1 or 0,t, this.C2)
end

-- Draw Time
this.drawTime = function()
  local hour = string.format('%.2d',getDateTime().hour)
  local min = string.format('%.2d',getDateTime().min)
  if math.ceil(math.fmod(getTime() / 100, 2)) == 1 then
    hour = hour .. ":"
  end
  lcd.drawText(LCD_W-(this.TX.HORUS and 48 or 22),this.TX.HORUS and 1 or 0,hour, this.C2)
  lcd.drawText(LCD_W-(this.TX.HORUS and 22 or 10),this.TX.HORUS and 1 or 0,min, this.C2)
end

return this

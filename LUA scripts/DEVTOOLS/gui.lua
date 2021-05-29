print('*** gui.lua loaded')

local Parent = ...
local this = {}
this.__index = Parent
setmetatable(this, this)

this.topBarH = this.TX.HORUS and 23 or 8
this.bottBarH = this.TX.HORUS and 23 or 8

-- Draw TopBar
this.drawTopBar = function(h)
  if h == nil then h = this.topBarH end
  lcd.drawFilledRectangle(0,0,LCD_W, h)
end

-- Draw TopBar
this.drawBottBar = function(h)
  if h == nil then h = this.bottBarH end
  lcd.drawFilledRectangle(0,this.LCD_H-this.bottBarH,LCD_W, h)
end

-- Draw Time
this.drawTitle = function(t)
  lcd.drawText(1,this.TX.HORUS and 1 or 0,t, this.TX.HORUS and TEXT_INVERTED_COLOR or INVERS)
end

-- Draw Time
this.drawTime = function()
  local hour = string.format('%.2d',getDateTime().hour)
  local min = string.format('%.2d',getDateTime().min)
  if math.ceil(math.fmod(getTime() / 100, 2)) == 1 then
    hour = hour .. ":"
  end
  lcd.drawText(LCD_W-(this.TX.HORUS and 48 or 22),this.TX.HORUS and 1 or 0,hour, this.TX.HORUS and TEXT_INVERTED_COLOR or INVERS)
  lcd.drawText(LCD_W-(this.TX.HORUS and 22 or 10),this.TX.HORUS and 1 or 0,min, this.TX.HORUS and TEXT_INVERTED_COLOR or INVERS)
end

return this

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

local o  = this.TX.COLOR and 0 or 1
local lH = this.TX.COLOR and 18 or 9
local c1 = 1
local c2 = this.TX.COLOR and 150 or 5

print('osName:',this.TX.osName)
print('osVersion:',this.TX.osVersion)
print('radioName:',this.TX.radioName)
print('txName: ', this.TX.radioModel)

local function run(event)
  lcd.clear(this.GUI.C2)
  lcd.drawText(c1, o+lH*0,   'OS:', this.GUI.C1)
  lcd.drawText(c2, this.TX.COLOR and (o+lH*0) or (o+lH*1),   this.TX.osName..' '..this.TX.osVersion, this.GUI.C1 + (this.TX.COLOR and 0 or BOLD))
  lcd.drawText(c1, this.TX.COLOR and (o+lH*1+1) or (o+lH*2),   'OS Radio Name:', this.GUI.C1)
  lcd.drawText(c2, this.TX.COLOR and (o+lH*1+1) or (o+lH*3),   this.TX.radioName, this.GUI.C1 + (this.TX.COLOR and 0 or BOLD))
  lcd.drawText(c1, this.TX.COLOR and (o+lH*2+2) or (o+lH*4), 'OS Radio Model:', this.GUI.C1)
  lcd.drawText(c2, this.TX.COLOR and (o+lH*2+2) or (o+lH*5), this.TX.radioModel, this.GUI.C1 + (this.TX.COLOR and 0 or BOLD))
  return 0
end

return { run=run }

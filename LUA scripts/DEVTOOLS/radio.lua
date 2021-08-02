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

local osVersion, radioName, osMajor, osMinor, osRevision = getVersion()
--check if run on Companion strip suffiix
this.osVersion = osVersion
this.radioName = radioName
this.SIM = string.find(radioName, '-')
this.radioModel = this.SIM and string.sub(this.radioName, 1, this.SIM - 1) or this.radioName
this.HORUS = LCD_W > 470 and true or false

return this

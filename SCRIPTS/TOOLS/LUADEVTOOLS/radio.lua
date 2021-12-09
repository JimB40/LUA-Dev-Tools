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

local osVersion, radioName, osMajor, osMinor, osRevision, osName = getVersion()
--check if run on Companion strip suffiix
this.osVersion = osVersion
this.osName = osName == nil and (osMajor > 1 and 'OpenTX' or 'FreedomTX') or osName
this.radioName = radioName
this.SIM = string.find(radioName, '-')
this.radioModel = this.SIM and string.sub(this.radioName, 1, this.SIM - 1) or this.radioName
this.NV14 = LCD_W == 320 and LCD_H == 480
this.GS = LCD_W == 212 and LCD_H == 64
this.COLOR = ((LCD_W == 480 and LCD_H == 272) or this.NV14)

return this

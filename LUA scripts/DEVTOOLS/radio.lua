print('radio.lua loaded')

local Parent = ...
local ts = {}
ts.__index = Parent
setmetatable(ts, ts)

local otxVersion, txModel, otxMajor, otxMinor, otxRevision = getVersion()
--check if run on Companion strip suffiix
local simuSuffix = string.find(txModel, '-')
ts.model = simuSuffix and string.sub(txModel, 1, simuSuffix - 1) or txModel
print('radioModel: '..ts.model)
ts.type = ts.model
ts.type = (ts.model == 'x10express' or ts.model == 'x12s' or ts.model == 't16' or ts.model == 'tx16s') and 'x10' or ts.type
ts.type = ts.model == 'x7express' and 'x7' or ts.type
ts.type = ts.model == 'xlites' and 'xlite' or ts.type
ts.type = ts.model == 'x9d+2019' and 'x9d' or ts.type
ts.HORUS = ts.type == 'x10' or ts.type == 'x12s' or ts.type == 't16' or ts.type == 'tx16s'
print('radioType: '..ts.type)

-- local LCD_BW       = { W = 128, H =  64, color = 1 }
-- local LCD_BW_WIDE  = { W = 212, H =  64, color = 1 }
-- local LCD_COLOR    = { W = 480, H = 272, color = 8 }
--
-- local TxLCD = {
--   xlite   = LCD_BW,
--   xlites  = LCD_BW,
--   x7      = LCD_BW,
--   x9d     = LCD_BW_WIDE,
--   x9d2019 = LCD_BW_WIDE,
--   x9lite  = LCD_BW,
--   x10     = LCD_COLOR,
--   x12     = LCD_COLOR
--   x12     = LCD_COLOR
-- }
--
-- this.LCD = TxLCD[this.txModel]

return ts

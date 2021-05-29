------------------------------------------------------------------------
-- Radio data
-- date: 2020-04-27
-- author: Robert Janiszewski robert(at)jimb40.com
------------------------------------------------------------------------
-- compatible radios: OpenTx
-- minimum OpenTx version: 2.3
------------------------------------------------------------------------
local toolName = "TNS|Radio Data|TNE"

local otxVersion, txModel, otxMajor, otxMinor, otxRevision = getVersion()
--check if run on Companion strip suffiix
local simuSuffix = string.find(txModel, '-')
local radioModel = simuSuffix and string.sub(txModel, 1, simuSuffix - 1) or txModel
local HORUS = string.match(radioModel, 'x10') or string.match(radioModel, 'x12s') or string.match(radioModel, 't16') or string.match(radioModel, 'tx16s') and true or false


local o  = HORUS and 0 or 1
local lH = HORUS and 18 or 9
local c1 = 1
local c2 = HORUS and 10 or 1

print(c2)

print('otxVersion: '..otxVersion)
print('txModel   : '..txModel)
print('txName    : '..radioModel)

local function run(event)
  lcd.clear()
  lcd.drawText(c1,   o+lH*0,  'OpenTX version')
  lcd.drawText(c2+2, o+lH*1,   otxVersion)
  lcd.drawText(c1,   o+lH*2+2,'txModel')
  lcd.drawText(c2+2, o+lH*3+2, txModel)
  lcd.drawText(c1,   o+lH*4+4,'radioName')
  lcd.drawText(c2+2, o+lH*5+4, radioModel)
  return 0
end

return { run=run }

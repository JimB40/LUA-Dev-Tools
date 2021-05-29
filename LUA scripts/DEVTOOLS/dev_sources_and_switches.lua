------------------------------------------------------------------------
-- Sources & Switches
-- date: 2020-04-27
-- author: Robert Janiszewski robert(at)jimb40.com
------------------------------------------------------------------------
-- compatible radios: OpenTx
-- minimum OpenTx version: 2.3
------------------------------------------------------------------------
local toolName = "TNS|Src & Switch|TNE"

local otxVersion, txModel, otxMajor, otxMinor, otxRevision = getVersion()
--check if run on Companion strip suffiix
local simuSuffix = string.find(txModel, '-')
local radioModel = simuSuffix and string.sub(txModel, 1, simuSuffix - 1) or txModel
local HORUS = string.match(radioModel, 'x10') or string.match(radioModel, 'x12s') or string.match(radioModel, 't16') or string.match(radioModel, 'tx16s') and true or false


local srcS = 0
local srcN = HORUS and 14 or 7

local tBH = HORUS and 20 or 9

local c1 = HORUS and 40 or 20
local c2 = HORUS and 50 or 24
local c3 = HORUS and 150 or 80
local c4 = HORUS and 160 or 84


local function run(e)
  local source
  local lineHeight = HORUS and 16 or 8
  lcd.clear()
  lcd.drawFilledRectangle(0,0,LCD_W,tBH, 0)
  lcd.drawText( c1 - (HORUS and 30 or 20), 1, 'Switches', HORUS and TEXT_INVERTED_COLOR or INVERS)
  lcd.drawText( c3 - (HORUS and 30 or 20), 1, 'Sources', HORUS and TEXT_INVERTED_COLOR or INVERS)

  for source = srcS, srcS+srcN do
    local line = source - srcS
    lcd.drawText(c1, tBH + line * lineHeight, source, RIGHT)
    lcd.drawSwitch(c2, tBH + line * lineHeight, source, 0)
    lcd.drawText(c3, tBH + line * lineHeight, source, RIGHT)
    lcd.drawSource(c4, tBH + line * lineHeight, source, 0)
  end

  if e == EVT_VIRTUAL_NEXT or e == EVT_VIRTUAL_NEXT_REPT then
    srcS = math.min(500, srcS+1)
  elseif e == EVT_VIRTUAL_PREV or e == EVT_VIRTUAL_PREV_REPT then
    srcS = math.max(-500, srcS-1)
  elseif e == EVT_VIRTUAL_NEXT_PAGE then
    srcS = math.min(500, srcS+srcN)
  elseif e == EVT_VIRTUAL_PREV_PAGE then
    srcS = math.min(500, srcS-srcN)
  end

  return 0

end

return { run=run }

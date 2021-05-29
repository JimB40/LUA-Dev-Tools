------------------------------------------------------------------------
-- Colors
-- date: 2020-10-12
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
local HORUS = LCD_W > 470 and true or false


local colors = {
  {'TEXT_COLOR',TEXT_COLOR},
  {'TEXT_BGCOLOR',TEXT_BGCOLOR},
  -- {'TEXT_INVERTED_COLOR',TEXT_INVERTED_COLOR},
  -- {'TEXT_INVERTED_BGCOLOR',TEXT_INVERTED_BGCOLOR},
  {'TEXT_DISABLE_COLOR',TEXT_DISABLE_COLOR},
  {'LINE_COLOR',LINE_COLOR},
  -- {'MENU_TITLE_BGCOLOR',MENU_TITLE_BGCOLOR},
  -- {'MENU_TITLE_COLOR',MENU_TITLE_COLOR},
  -- {'MENU_TITLE_DISABLE_COLOR',MENU_TITLE_DISABLE_COLOR},
  {'HEADER_COLOR',HEADER_COLOR},
  {'HEADER_BGCOLOR',HEADER_BGCOLOR},
  {'HEADER_ICON_BGCOLOR',HEADER_ICON_BGCOLOR},
  {'HEADER_CURRENT_BGCOLOR',HEADER_CURRENT_BGCOLOR},
  {'TITLE_BGCOLOR',TITLE_BGCOLOR},
  -- {'TRIM_BGCOLOR',TRIM_BGCOLOR},
  -- {'TRIM_SHADOW_COLOR',TRIM_SHADOW_COLOR},
  -- {'SCROLLBOX_COLOR',SCROLLBOX_COLOR},
  {'ALARM_COLOR',ALARM_COLOR},
  {'WARNING_COLOR',WARNING_COLOR},
  {'CURVE_AXIS_COLOR',CURVE_AXIS_COLOR},
  {'CURVE_CURSOR_COLOR',CURVE_CURSOR_COLOR},
  {'MAINVIEW_PANES_COLOR',MAINVIEW_PANES_COLOR},
  {'MAINVIEW_GRAPHICS_COLOR',MAINVIEW_GRAPHICS_COLOR},
  {'OVERLAY_COLOR',OVERLAY_COLOR},
  -- {'',},
}


local c1 = 0
local c2 = 240
local lines = 13
local firstLine = 1

local function run(e)
  lcd.clear()
  for i=firstLine,firstLine+lines-1 do
    local v = colors[i]
    local y = (i-firstLine)*21
    lcd.drawFilledRectangle(c1+1,y+1,18,18, v[2])
    lcd.setColor(CUSTOM_COLOR,BLACK)
    lcd.drawRectangle(c1+1,y+1,18,18, CUSTOM_COLOR)
    lcd.drawText( c1+25, y+2, v[1], CUSTOM_COLOR+SMLSIZE)
    local color = lcd.getColor(v[2])
    lcd.drawText( c2, y+2, string.format('%06X',color), CUSTOM_COLOR+SMLSIZE)
  end

  if e == EVT_VIRTUAL_NEXT then
    firstLine = firstLine == #colors-lines+1 and #colors-lines+1 or firstLine + 1
  elseif e == EVT_VIRTUAL_PREV then
    firstLine = firstLine == 1 and 1 or firstLine - 1
  end

  return 0

end

return { run=run }

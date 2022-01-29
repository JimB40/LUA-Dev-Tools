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


local colors = {
  { "EDGE TX (NEW)",              nil                       },
  { "COLOR_THEME_PRIMARY1",       COLOR_THEME_PRIMARY1         },
  { "COLOR_THEME_PRIMARY2",       COLOR_THEME_PRIMARY2         },
  { "COLOR_THEME_PRIMARY3",       COLOR_THEME_PRIMARY3         },
  { "COLOR_THEME_SECONDARY1",     COLOR_THEME_SECONDARY1       },
  { "COLOR_THEME_SECONDARY2",     COLOR_THEME_SECONDARY2       },
  { "COLOR_THEME_SECONDARY3",     COLOR_THEME_SECONDARY3       },
  { "COLOR_THEME_FOCUS",          COLOR_THEME_FOCUS            },
  { "COLOR_THEME_EDIT",           COLOR_THEME_EDIT             },
  { "COLOR_THEME_ACTIVE",         COLOR_THEME_ACTIVE           },
  { "COLOR_THEME_WARNING",        COLOR_THEME_WARNING          },
  { "COLOR_THEME_DISABLED",       COLOR_THEME_DISABLED         },

  { "OPEN TX (OLD)",              nil                       },
  { "ALARM_COLOR",                ALARM_COLOR               },
  { "BARGRAPH1_COLOR",            BARGRAPH1_COLOR           },
  { "BARGRAPH1_COLOR",            BARGRAPH1_COLOR           },
  { "BARGRAPH_BGCOLOR",           BARGRAPH_BGCOLOR          },
  { "BATTERY_CHARGE_COLOR",       BATTERY_CHARGE_COLOR      },
  { "CHECKBOX_COLOR",             CHECKBOX_COLOR            },
  { "CURVE_AXIS_COLOR",           CURVE_AXIS_COLOR          },
  { "CURVE_COLOR",                CURVE_COLOR               },
  { "CURVE_CURSOR_COLOR",         CURVE_CURSOR_COLOR        },
  { "CUSTOM_COLOR",               CUSTOM_COLOR              },
  { "DEFAULT_BGCOLOR",            DEFAULT_BGCOLOR           },
  { "DEFAULT_COLOR",              DEFAULT_COLOR             },
  { "DISABLE_COLOR",              DISABLE_COLOR             },
  { "FOCUS_BGCOLOR",              FOCUS_BGCOLOR             },
  { "FOCUS_COLOR",                FOCUS_BGCOLOR             },
  { "HEADER_BGCOLOR",             HEADER_BGCOLOR            },
  { "HEADER_COLOR",               HEADER_COLOR              },
  { "HEADER_CURRENT_BGCOLOR",     HEADER_CURRENT_BGCOLOR    },
  { "HEADER_ICON_BGCOLOR",        HEADER_ICON_BGCOLOR       },
  { "HEADER_SEPARATOR_COLOR",     HEADER_SEPARATOR_COLOR    },
  { "HIGHLIGHT_COLOR",            HIGHLIGHT_COLOR           },
  { "LINE_COLOR",                 LINE_COLOR                },
  { "MAINVIEW_GRAPHICS_COLOR",    MAINVIEW_GRAPHICS_COLOR   },
  { "MAINVIEW_PANES_COLOR",       MAINVIEW_PANES_COLOR      },
  { "MENU_BGCOLOR",               MENU_BGCOLOR              },
  { "MENU_COLOR",                 MENU_COLOR                },
  { "MENU_HIGHLIGHT_BGCOLOR",     MENU_HIGHLIGHT_BGCOLOR    },
  { "MENU_HIGHLIGHT_COLOR",       MENU_HIGHLIGHT_COLOR      },
  { "MENU_LINE_COLOR",            MENU_LINE_COLOR           },
  { "MENU_TITLE_BGCOLOR",         MENU_TITLE_BGCOLOR        },
  { "OVERLAY_COLOR",              OVERLAY_COLOR             },
  { "SCROLLBAR_COLOR",            SCROLLBAR_COLOR           },
  { "TABLE_BGCOLOR",              TABLE_BGCOLOR             },
  { "TABLE_HEADER_BGCOLOR",       TABLE_HEADER_BGCOLOR      },
  { "TEXT_DISABLE_COLOR",         TEXT_DISABLE_COLOR        },
  { "TEXT_STATUSBAR_COLOR",       TEXT_STATUSBAR_COLOR      },
  { "TITLE_BGCOLOR",              TITLE_BGCOLOR             },
  { "TEXT_COLOR",                 TEXT_COLOR                },
  { "TEXT_BGCOLOR",               TEXT_BGCOLOR              },
  { "WARNING_COLOR",              WARNING_COLOR             },

}


local c1 = 0
local c2 = 240
local lines = this.TX.NV14 and 26 or 15
local firstLine = 1

local function run(e)
  lcd.clear(this.GUI('C2'))
  for i=firstLine,firstLine+lines-1 do
    local v = colors[i]
    local y = (i-firstLine)*this.GUI.lineHeight
    if v[2] ~= nil then
      lcd.drawFilledRectangle(c1+1,y+1,16,16, v[2])
      lcd.drawRectangle(c1+1,y+1,16,16, this.GUI('C1'))
    end
    lcd.drawText( c1+25, y+2, v[1], this.GUI('C1')+SMLSIZE)
    local colorHex = v[2] and string.format('%04X',lcd.getColor(v[2])) or 'N/D'
    lcd.drawText( c2, y+2, colorHex, this.GUI('C1')+SMLSIZE)
  end

  if e == EVT_VIRTUAL_NEXT then
    firstLine = firstLine == #colors-lines+1 and #colors-lines+1 or firstLine + 1
  elseif e == EVT_VIRTUAL_PREV then
    firstLine = firstLine == 1 and 1 or firstLine - 1
  end

  return 0

end

return { run=run }

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

-- Configurable vars
local modeSwitch = 'sa'   -- switch to change display mode
local clearSwitch = 'sb'  -- switch to clear buffer

local yo  = this.TX.COLOR and 0 or 1
local c1 = this.TX.COLOR and 52 or 26
local c2 = this.TX.COLOR and 56 or 28
local c3 = this.TX.COLOR and 64 or 32


-- Non-Configurable vars
local constants = {
  vEvents = {
    {'EVT_VIRTUAL_PREV     ' , EVT_VIRTUAL_PREV      , 'PREV'           },
    {'EVT_VIRTUAL_NEXT     ' , EVT_VIRTUAL_NEXT      , 'NEXT'           },
    {'EVT_VIRTUAL_PREV_REPT' , EVT_VIRTUAL_PREV_REPT , 'PREV_REPT'      },
    {'EVT_VIRTUAL_NEXT_REPT' , EVT_VIRTUAL_NEXT_REPT , 'NEXT_REPT'      },
    {'EVT_VIRTUAL_DEC      ' , EVT_VIRTUAL_DEC       , 'DEC'            },
    {'EVT_VIRTUAL_INC      ' , EVT_VIRTUAL_INC       , 'INC'            },
    {'EVT_VIRTUAL_DEC_REPT ' , EVT_VIRTUAL_DEC_REPT  , 'DEC_REPT'       },
    {'EVT_VIRTUAL_INC_REPT ' , EVT_VIRTUAL_INC_REPT  , 'INC_REPT'       },
    {'EVT_VIRTUAL_PREV_PAGE' , EVT_VIRTUAL_PREV_PAGE , 'PREV_PAGE'      },
    {'EVT_VIRTUAL_NEXT_PAGE' , EVT_VIRTUAL_NEXT_PAGE , 'NEXT_PAGE'      },
    {'EVT_VIRTUAL_MENU'      , EVT_VIRTUAL_MENU      , 'MENU'           },
    {'EVT_VIRTUAL_MENU_LONG' , EVT_VIRTUAL_MENU_LONG , 'MENU_LONG'      },
    {'EVT_VIRTUAL_ENTER'     , EVT_VIRTUAL_ENTER     , 'ENTER'          },
    {'EVT_VIRTUAL_ENTER_LONG', EVT_VIRTUAL_ENTER_LONG, 'ENTER_LONG'     },
    {'EVT_VIRTUAL_ENTER_REPT', EVT_VIRTUAL_ENTER_REPT, 'ENTER_REPT'     },
    {'EVT_VIRTUAL_EXIT'      , EVT_VIRTUAL_EXIT      , 'EXIT'           },
    {'EVT_TOUCH_FIRST'       , EVT_TOUCH_FIRST       , 'EVT_TOUCH_FIRST'},
    {'EVT_TOUCH_BREAK'       , EVT_TOUCH_BREAK       , 'EVT_TOUCH_BREAK'},
    {'EVT_TOUCH_SLIDE'       , EVT_TOUCH_SLIDE       , 'EVT_TOUCH_SLIDE'},
    {'EVT_TOUCH_TAP'         , EVT_TOUCH_TAP         , 'EVT_TOUCH_TAP'  },
  },
  kEvents = {
    {'EVT_PAGE_FIRST'   , EVT_PAGE_FIRST   , 'PAGE_FIRST'     },
    {'EVT_PAGE_LONG'    , EVT_PAGE_LONG    , 'PAGE_LONG'      },
    {'EVT_PAGE_REPT'    , EVT_PAGE_REPT    , 'PAGE_REPT'      },
    {'EVT_PAGE_BREAK'   , EVT_PAGE_BREAK   , 'PAGE_BREAK'     },
    {'EVT_MENU_FIRST'   , EVT_MENU_FIRST   , 'MENU_FIRST'     },
    {'EVT_MENU_LONG'    , EVT_MENU_LONG    , 'MENU_LONG'      },
    {'EVT_MENU_REPT'    , EVT_MENU_REPT    , 'MENU_REPT'      },
    {'EVT_MENU_BREAK'   , EVT_MENU_BREAK   , 'MENU_BREAK'     },
    {'EVT_ENTER_FIRST'  , EVT_ENTER_FIRST  , 'ENTER_FIRST'    },
    {'EVT_ENTER_LONG'   , EVT_ENTER_LONG   , 'ENTER_LONG'     },
    {'EVT_ENTER_REPT'   , EVT_ENTER_REPT   , 'ENTER_REPT'     },
    {'EVT_ENTER_BREAK'  , EVT_ENTER_BREAK  , 'ENTER_BREAK'    },
    {'EVT_EXIT_FIRST'   , EVT_EXIT_FIRST   , 'EXIT_FIRST'     },
    {'EVT_EXIT_LONG'    , EVT_EXIT_LONG    , 'EXIT_LONG'      },
    {'EVT_EXIT_REPT'    , EVT_EXIT_REPT    , 'EXIT_REPT'      },
    {'EVT_EXIT_BREAK'   , EVT_EXIT_BREAK   , 'EXIT_BREAK'     },
    {'EVT_PLUS_FIRST'   , EVT_PLUS_FIRST   , 'PLUS_FIRST'     },
    {'EVT_PLUS_LONG'    , EVT_PLUS_LONG    , 'PLUS_LONG'      },
    {'EVT_PLUS_REPT'    , EVT_PLUS_REPT    , 'PLUS_REPT'      },
    {'EVT_PLUS_BREAK'   , EVT_PLUS_BREAK   , 'PLUS_BREAK'     },
    {'EVT_MINUS_FIRST'  , EVT_MINUS_FIRST  , 'MINUS_FIRST'    },
    {'EVT_MINUS_LONG'   , EVT_MINUS_LONG   , 'MINUS_LONG'     },
    {'EVT_MINUS_REPT'   , EVT_MINUS_REPT   , 'MINUS_REPT'     },
    {'EVT_MINUS_BREAK'  , EVT_MINUS_BREAK  , 'MINUS_BREAK'    },
    {'EVT_ROT_LEFT'     , EVT_ROT_LEFT     , 'ROT_LEFT'       },
    {'EVT_ROT_RIGHT'    , EVT_ROT_RIGHT    , 'ROT_RIGHT'      },
    {'EVT_UP_FIRST'     , EVT_UP_FIRST     , 'UP_FIRST'       },
    {'EVT_UP_LONG'      , EVT_UP_LONG      , 'UP_LONG'        },
    {'EVT_UP_REPT'      , EVT_UP_REPT      , 'UP_REPT'        },
    {'EVT_UP_BREAK'     , EVT_UP_BREAK     , 'UP_BREAK'       },
    {'EVT_DOWN_FIRST'   , EVT_DOWN_FIRST   , 'DOWN_FIRST'     },
    {'EVT_DOWN_LONG'    , EVT_DOWN_LONG    , 'DOWN_LONG'      },
    {'EVT_DOWN_REPT'    , EVT_DOWN_REPT    , 'DOWN_REPT'      },
    {'EVT_DOWN_BREAK'   , EVT_DOWN_BREAK   , 'DOWN_BREAK'     },
    {'EVT_RIGHT_FIRST'  , EVT_RIGHT_FIRST  , 'RIGHT_FIRST'    },
    {'EVT_RIGHT_LONG'   , EVT_RIGHT_LONG   , 'RIGHT_LONG'     },
    {'EVT_RIGHT_REPT'   , EVT_RIGHT_REPT   , 'RIGHT_REPT'     },
    {'EVT_RIGHT_BREAK'  , EVT_RIGHT_BREAK  , 'RIGHT_BREAK'    },
    {'EVT_LEFT_FIRST'   , EVT_LEFT_FIRST   , 'LEFT_FIRST'     },
    {'EVT_LEFT_LONG'    , EVT_LEFT_LONG    , 'LEFT_LONG'      },
    {'EVT_LEFT_REPT'    , EVT_LEFT_REPT    , 'LEFT_REPT'      },
    {'EVT_LEFT_BREAK'   , EVT_LEFT_BREAK   , 'LEFT_BREAK'     },
    {'EVT_SHIFT_FIRST'  , EVT_SHIFT_FIRST  , 'SHIFT_FIRST'    },
    {'EVT_SHIFT_LONG'   , EVT_SHIFT_LONG   , 'SHIFT_LONG'     },
    {'EVT_SHIFT_REPT'   , EVT_SHIFT_REPT   , 'SHIFT_REPT'     },
    {'EVT_SHIFT_BREAK'  , EVT_SHIFT_BREAK  , 'SHIFT_BREAK'    },
    {'EVT_TOUCH_FIRST'  , EVT_TOUCH_FIRST  , 'EVT_TOUCH_FIRST'},
    {'EVT_TOUCH_BREAK'  , EVT_TOUCH_BREAK  , 'EVT_TOUCH_BREAK'},
    {'EVT_TOUCH_SLIDE'  , EVT_TOUCH_SLIDE  , 'EVT_TOUCH_SLIDE'},
    {'EVT_TOUCH_TAP'    , EVT_TOUCH_TAP    , 'EVT_TOUCH_TAP'  },
  }
}
local labels = {
  kEvents = 'EVT_xxx',
  vEvents = 'EVT_VIRTUAL_xxx'
}
local mode = 'vEvents'    -- constats display mode
local cEvents = constants[mode]   -- currrent constatnts set
local eventSequence = {}  -- key events table
local clear = false       -- clear buffer if true

local function init()

  -- debbuger dump of constants for txt version
  print('')
  print('Defined KEY EVENTS for radio model: '..this.TX.radioModel)

  print('')
  print('EVT_VIRTUAL_XXX events')
  print('---------------')
  for i2, eD in ipairs(constants.vEvents) do
      eName = eD[1]..' '
      eVal = eD[2]

      print(eName,eVal)
  end
  print('')
  print('EVT_XXX events')
  print('----------------------')
  for i2, eD in ipairs(constants.kEvents) do
      eName = eD[1]..' '
      eVal = eD[2]
      print(eName,eVal)
  end
  print ('')

end

local function run(e)

  -- Key events mode switching check
  local m = getValue(modeSwitch)
  mode = m < 0 and 'vEvents' or m > 0 and 'kEvents' or mode
  cEvents = constants[mode]

  -- Key events clearing check
  m = getValue(clearSwitch)
  clear = m > 0 and true or false

  -- add event id if key pressed
  if e ~= 0 then
    eventSequence[#eventSequence+1] = e
  end
  -- clear sequence
  if clear then
    eventSequence = {}
    clear = false
  end

  -- draw Screen data
  lcd.clear(this.GUI.C2)
  this.GUI.drawTopBar()
  lcd.drawText( c1, yo, 'eID', RIGHT+this.GUI.C2)
  lcd.drawLine( c2, 0, c2, LCD_H, DOTTED, this.GUI.C1)
  lcd.drawText( c3, yo, labels[mode], this.GUI.C2)
  for i, e in ipairs(eventSequence) do
    local eName,eVal = 'not defined', e
    for i2, eD in ipairs(cEvents) do
      if e == eD[2] then
        eName = eD[3]
        eVal = eD[2]
        break
      end
    end
    lcd.drawText( c1, 1+i*this.GUI.lineHeight, eVal, RIGHT+this.GUI.C1)
    lcd.drawText( c3, 1+i*this.GUI.lineHeight, eName, this.GUI.C1)
  end

  return 0

end

return { init=init,  run=run }

------------------------------------------------------------------------
-- Colors
-- date: 2020-10-12
-- author: Robert Janiszewski robert(at)jimb40.com
------------------------------------------------------------------------
-- compatible radios: OpenTx
-- minimum OpenTx version: 2.3
------------------------------------------------------------------------
local toolName = "TNS|Telemetry|TNE"

local otxVersion, txModel, otxMajor, otxMinor, otxRevision = getVersion()
--check if run on Companion strip suffiix
local simuSuffix = string.find(txModel, '-')
local radioModel = simuSuffix and string.sub(txModel, 1, simuSuffix - 1) or txModel
local HORUS = LCD_W > 470 and true or false


local telem = {
  CRSF = {
    ['1RSS'] = {0,'dB'},
    ['2RSS'] = {0,'dB'},
    RQly = {0,''},
    RxBt = {0,'V'},
    RFMD = {0,''},
    TPWR = {0,'mW'},
    TQly = {0,''},
    RSNR = {0,'dB'},
    Curr = {0,'A'},
    Capa = {0,'mAh'},
    Bat_ = {0,'%'},
    FM   = {'',''},
  },
  GHOST = {
    RSSI = {0,'dB'},
    RQly = {0,'%'},
    RSNR = {0,'dB'},
    TPWR = {0,'mW'},
    RFMD = {'',''},
    FRat = {0,'Hz'},
    TLat = {0,''},
    RxBt = {0,'V'},
    Curr = {0,'A'},
    Capa = {0,'mAh'},
    VFrq = {0,'MHz'},
    VChn = {0,''},
    VBan = {0,''},
    VPwr = {0,'mW'},
  },
  D16 = {
    RSSI = {0,'dB'},
    TPWR = {0,'mW'},
    TQly = {0,''},
    TRSS = {0,'dB'},
    VFAS = {0,'V'},
    A4   = {0,'V'},
    RxBt = {0,'V'},
    Curr = {0,'A'},
    Fuel = {0,'%'},
    Tmp1 = {0,''},
  },
  D8 = {
    RSSI = {0,'dB'},
    TPWR = {0,'mW'},
    TQly = {0,''},
    TRSS = {0,'dB'},
    VFAS = {0,'V'},
    A4   = {0,'V'},
    Curr = {0,'A'},
    Fuel = {0,'%'},
    Tmp1 = {0,''},
  },
}

local units = {
   [0] = {'Raw unit', UNIT_RAW},
   [1] = {'Volts', UNIT_VOLTS},
   [2] = {'Amps', UNIT_AMPS},
   [3] = {'Milliamps', UNIT_MILLIAMPS},
   [4] = {'Knots', UNIT_KTS},
   [5] = {'Meters per Second', UNIT_METERS_PER_SECOND},
   [6] = {'Feet per Second', UNIT_FEET_PER_SECOND},
   [7] = {'Kilometers per Hour', UNIT_KMH},
   [8] = {'Miles per Hour', UNIT_MPH},
   [9] = {'Meters', UNIT_METERS},
  [10] = {'Feet', UNIT_FEET},
  [11] = {'Degrees Celsius', UNIT_CELSIUS},
  [12] = {'Degrees Fahrenheit', UNIT_FAHRENHEIT},
  [13] = {'Percent', UNIT_PERCENT},
  [14] = {'Milliamp Hour', UNIT_MAH},
  [15] = {'Watts', UNIT_WATTS},
  [16] = {'Milliwatts', UNIT_MILLIWATTS},
  [17] = {'dB', UNIT_DB},
  [18] = {'RPM', UNIT_RPMS},
  [19] = {'G', UNIT_G},
  [20] = {'Degrees', UNIT_DEGREE},
  [21] = {'Radians', UNIT_RADIANS},
  [22] = {'Milliliters', UNIT_MILLILITERS},
  [23] = {'Fluid Ounces', UNIT_FLOZ},
  [24] = {'Ml per minute', UNIT_MILLILITERS_PER_MINUTE},
  [35] = {'Hours', UNIT_HOURS},
  [36] = {'Minutes', UNIT_MINUTES},
  [37] = {'Seconds', UNIT_SECONDS},
  [38] = {'Virtual unit', UNIT_CELLS},
  [39] = {'Virtual unit', UNIT_DATETIME},
  [40] = {'Virtual unit', UNIT_GPS},
  [41] = {'Virtual unit', UNIT_BITFIELD},
  [42] = {'Virtual unit', UNIT_TEXT},
}

local fieldsNo = 0
local telem2 = {}
for prot, fields in pairs(telem) do
  for field, data in pairs(fields) do
    telem2[#telem2+1] = {prot,field}
  end
end

local c0 = HORUS and 20 or 10
local c1 = HORUS and 25 or 11
local c2 = HORUS and 85 or 40
local c3 = HORUS and 150 or 80
local c4 = HORUS and 200 or 110
local c5 = HORUS and 250 or 150
local c6 = HORUS and 300 or 180
local lines = HORUS and 16 or 7
local lineHeight = HORUS and 15 or 8
local firstLine = 1
local sensorMax = 59

local function run(e)
  lcd.clear()
  -- for i=firstLine,firstLine+lines-1 do
  --   local y = (i-firstLine)*lineHeight
  --   lcd.drawText( c0, y+2, i, SMLSIZE+RIGHT)
  --   lcd.drawText( c1, y+2, telem2[i][1], SMLSIZE)
  --   lcd.drawText( c2, y+2, telem2[i][2], SMLSIZE)
  --   lcd.drawText( c3-10, y+2, ':', SMLSIZE)
  --   local fieldData = getFieldInfo(telem2[i][2])
  --   if fieldData ~= nil then
  --     lcd.drawText( c3, y+2,    fieldData.id, SMLSIZE)
  --     lcd.drawText( c4, y+2, fieldData.name, SMLSIZE)
  --     lcd.drawText( c5, y+2, getValue(fieldData.id), SMLSIZE)
  --   else
  --     lcd.drawText( c3, y+2, 'nil', SMLSIZE)
  --   end
  -- end
  lcd.drawText( c0, 0, 'No', SMLSIZE+RIGHT)
  lcd.drawText( c1, 0, 'Name', SMLSIZE)
  lcd.drawText( c2, 0, 'ID', SMLSIZE)
  lcd.drawText( c3, 0, 'Value', SMLSIZE)
  lcd.drawText( c4, 0, 'Unit', SMLSIZE)

  for i=firstLine,firstLine+lines do
    local y = (i-firstLine+1)*lineHeight
    lcd.drawText( c0, y+2, i-1, SMLSIZE+RIGHT)
    -- lcd.drawText( c1, y+2, telem2[i][1], SMLSIZE)
    -- lcd.drawText( c2, y+2, telem2[i][2], SMLSIZE)
    -- lcd.drawText( c3-10, y+2, ':', SMLSIZE)
    local sensor = model.getSensor(i-1)
    if sensor ~= nil then
      lcd.drawText( c1, y+2,sensor.name == '' and '---' or sensor.name, SMLSIZE)
      local sensorData = getFieldInfo(sensor.name)
      if sensorData then
        lcd.drawText( c2, y+2, sensorData.id, SMLSIZE)
        local sensorValue = getValue(sensor.name)
        lcd.drawText( c3, y+2, sensorValue, SMLSIZE)
        lcd.drawText( c4, y+2, units[sensor.unit][1], SMLSIZE)
      end
    else
      lcd.drawText( c3, y+2, 'nil', SMLSIZE)
    end
  end

  if e == EVT_VIRTUAL_NEXT then
    firstLine = math.min(sensorMax-lines+1,firstLine + 1)
  elseif e == EVT_VIRTUAL_PREV then
    firstLine = math.max(1,firstLine - 1)
  end

  return 0

end

return { run=run }

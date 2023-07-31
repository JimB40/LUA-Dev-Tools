----------------------------------------------------------
-- JimB40 Lua Dev ToolBox
-- version 0.4
-- release date: 2023-07-30
----------------------------------------------------------
-- Coded by Robert Janiszewski (JimB40)
-- fm2m.jimb40.com
-- robert <at> jimb40 <dot> com
----------------------------------------------------------
local toolName = "TNS|LUA DevTools|TNE"

-- Telemetry loader
local SCRIPT_PATH = '/SCRIPTS/TOOLS/LUADEVTOOLS/'
local SCRIPT_LM = 'T'
local loadNextPage = false
local loadNextPageID = 0
local exit = 0
local G = {}

G.TX = assert(loadfile(SCRIPT_PATH..'radio.lua')) (G)
collectgarbage()

G.PAGES = {
  [0] = {t = 'Main Menu',         v = 'mainmenu.lua'                },
  {t = 'Radio data',              v = 'dev_radiodata.lua'           },
  {t = 'Key constants',           v = 'dev_keycontants.lua'         },
  {t = 'Key events',              v = 'dev_keyevents.lua'           },
  {t = 'Font characters',         v = 'dev_font_characters.lua'     },
  {t = 'Sources & Switches ID',   v = 'dev_sources_and_switches.lua'},
  {t = 'Telemetry',               v = 'dev_telemetry.lua'},
  {t = 'Colors (Color LCD only)', v = 'dev_colors.lua'},
}
G.pageDisp = 0
G.pageLast = 1

G.GUI = assert(loadfile(SCRIPT_PATH..'gui.lua')) (G)
collectgarbage()

local function processKeys(event)

  if (event == EVT_VIRTUAL_EXIT) then
    if loadNextPageID == 0 then
      exit = 1
    else
      loadNextPageID = 0
      loadNextPage = true
      killEvents(EVT_VIRTUAL_EXIT)
    end
  end
  if (event == EVT_VIRTUAL_ENTER) then
    if G.PG and G.pageDisp == 0 then
      loadNextPageID = G.PG.selLine
      loadNextPage = true
    end
    killEvents(EVT_VIRTUAL_ENTER)
  end

end

local function loadPage()
  G.PG = assert(loadfile(SCRIPT_PATH..G.PAGES[loadNextPageID].v)) (G)
  collectgarbage()
  G.pageDisp = loadNextPageID
  G.pageLast = loadNextPageID
  if G.PG.init ~= nil then G.PG.init() end
end

function init()
  loadPage()
end

function background()
end

function run(event)
  if not loadNextPage then
    G.PG.run(event)
  else
    G.PG = nil
    collectgarbage()
    loadNextPage = false
    loadPage()
  end
  processKeys(event)
  return exit
end

return {init=init, run=run, background=background}

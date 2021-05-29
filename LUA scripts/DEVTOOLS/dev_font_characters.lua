------------------------------------------------------------------------
-- Fonts
-- date: 2020-04-27
-- author: Robert Janiszewski robert(at)jimb40.com
------------------------------------------------------------------------
-- compatible radios: OpenTx
-- minimum OpenTx version: 2.3
------------------------------------------------------------------------
local toolName = 'TNS|Fonts|TNE'

local otxVersion, txModel, otxMajor, otxMinor, otxRevision = getVersion()
--check if run on Companion strip suffiix
local simuSuffix = string.find(txModel, '-')
local radioModel = simuSuffix and string.sub(txModel, 1, simuSuffix - 1) or txModel
local HORUS = string.match(radioModel, 'x10') or string.match(radioModel, 'x12s') or string.match(radioModel, 't16') or string.match(radioModel, 'tx16s') and true or false

local function run(event)
  lcd.clear()
  local o  = HORUS and 0 or 1
  local lH = HORUS and 18 or 9
  local c1 = HORUS and 1 or 1
  local c2 = HORUS and 24 or 12

  lcd.drawFilledRectangle(0,0,c2,LCD_H, 0)
  lcd.drawText(c1,   o+lH*0, '20', HORUS and TEXT_INVERTED_COLOR or INVERS)
  lcd.drawText(c1,   o+lH*1, '40', HORUS and TEXT_INVERTED_COLOR or INVERS)
  lcd.drawText(c1,   o+lH*2, '60', HORUS and TEXT_INVERTED_COLOR or INVERS)
  lcd.drawText(c1,   o+lH*3, '80', HORUS and TEXT_INVERTED_COLOR or INVERS)
  lcd.drawText(c1,   o+lH*4, 'A0', HORUS and TEXT_INVERTED_COLOR or INVERS)
  lcd.drawText(c1,   o+lH*5, 'C0', HORUS and TEXT_INVERTED_COLOR or INVERS)
  lcd.drawText(c1,   o+lH*6, 'E0', HORUS and TEXT_INVERTED_COLOR or INVERS)
  lcd.drawText(c2+2, o+lH*0, '\032\033\034\035\036\037\038\039\040\041\042\043\044\045\046\047\048\049\050\051\052\053\054\055\056\057\058\059\060\061\062\063')
  lcd.drawText(c2+2, o+lH*1, '\064\065\066\067\068\069\070\071\072\073\074\075\076\077\078\079\080\081\082\083\084\085\086\087\088\089\090\091\092\093\094\095')
  lcd.drawText(c2+2, o+lH*2, '\096\097\098\099\100\101\102\103\104\105\106\107\108\109\110\111\112\113\114\115\116\117\118\119\120\121\122\123\124\125\126\127')
  lcd.drawText(c2+2, o+lH*3, '\128\129\130\131\132\133\134\135\136\137\138\139\140\141\142\143\144\145\146\147\148\149\150\151\152\153\154\155\156\157\158\159')
  lcd.drawText(c2+2, o+lH*4, '\160\161\162\163\164\165\166\167\168\169\170\171\172\173\174\175\176\177\178\179\180\181\182\183\184\185\186\187\188\189\190\191')
  lcd.drawText(c2+2, o+lH*5, '\192\193\194\195\196\197\198\199\200\201\202\203\204\205\206\207\208\209\210\211\212\213\214\215\216\217\218\219\220\221\222\223')
  lcd.drawText(c2+2, o+lH*6, '\224\225\226\227\228\229\230\231\232\233\234\235\236\237\238\239\240\241\242\243\244\245\246\247\248\249\250\251\252\253\254\255')

  return 0
end

return { run=run }
--

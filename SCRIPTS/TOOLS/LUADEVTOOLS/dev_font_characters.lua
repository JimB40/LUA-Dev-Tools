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

local function run(event)
  lcd.clear(this.GUI.C2)
  local o  = this.TX.COLOR and 0 or 1
  local col1 = this.TX.COLOR and 1 or 1
  local col2 = this.TX.COLOR and 24 or 12

  lcd.drawFilledRectangle(0,0,col2,LCD_H, this.GUI.C1)  -- vertical bar
  if this.TX.COLOR then
    lcd.drawText(col1,   o+this.GUI.lineHeight*0,  '20', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*1,  '30', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*2,  '40', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*3,  '50', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*4,  '60', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*5,  '70', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*6,  '80', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*7,  '90', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*8,  'A0', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*9,  'B0', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*10, 'C0', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*11, 'D0', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*12, 'E0', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*13, 'F0', this.GUI.C2)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*0,  '\032\033\034\035\036\037\038\039\040\041\042\043\044\045\046\047',this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*1,  '\048\049\050\051\052\053\054\055\056\057\058\059\060\061\062\063',this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*2,  '\064\065\066\067\068\069\070\071\072\073\074\075\076\077\078\079', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*3,  '\080\081\082\083\084\085\086\087\088\089\090\091\092\093\094\095', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*4,  '\096\097\098\099\100\101\102\103\104\105\106\107\108\109\110\111', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*5,  '\112\113\114\115\116\117\118\119\120\121\122\123\124\125\126\127', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*6,  '\128\129\130\131\132\133\134\135\136\137\138\139\140\141\142\143', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*7,  '\144\145\146\147\148\149\150\151\152\153\154\155\156\157\158\159', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*8,  '\160\161\162\163\164\165\166\167\168\169\170\171\172\173\174\175', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*9,  '\176\177\178\179\180\181\182\183\184\185\186\187\188\189\190\191', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*10, '\192\193\194\195\196\197\198\199\200\201\202\203\204\205\206\207', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*11, '\208\209\210\211\212\213\214\215\216\217\218\219\220\221\222\223', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*12, '\224\225\226\227\228\229\230\231\232\233\234\235\236\237\238\239', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*13, '\240\241\242\243\244\245\246\247\248\249\250\251\252\253\254\255', this.GUI.C1)
  else
    lcd.drawText(col1,   o+this.GUI.lineHeight*0, '20', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*1, '40', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*2, '60', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*3, '80', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*4, 'A0', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*5, 'C0', this.GUI.C2)
    lcd.drawText(col1,   o+this.GUI.lineHeight*6, 'E0', this.GUI.C2)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*0, '\032\033\034\035\036\037\038\039\040\041\042\043\044\045\046\047\048\049\050\051\052\053\054\055\056\057\058\059\060\061\062\063', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*1, '\064\065\066\067\068\069\070\071\072\073\074\075\076\077\078\079\080\081\082\083\084\085\086\087\088\089\090\091\092\093\094\095', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*2, '\096\097\098\099\100\101\102\103\104\105\106\107\108\109\110\111\112\113\114\115\116\117\118\119\120\121\122\123\124\125\126\127', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*3, '\128\129\130\131\132\133\134\135\136\137\138\139\140\141\142\143\144\145\146\147\148\149\150\151\152\153\154\155\156\157\158\159', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*4, '\160\161\162\163\164\165\166\167\168\169\170\171\172\173\174\175\176\177\178\179\180\181\182\183\184\185\186\187\188\189\190\191', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*5, '\192\193\194\195\196\197\198\199\200\201\202\203\204\205\206\207\208\209\210\211\212\213\214\215\216\217\218\219\220\221\222\223', this.GUI.C1)
    lcd.drawText(col2+2, o+this.GUI.lineHeight*6, '\224\225\226\227\228\229\230\231\232\233\234\235\236\237\238\239\240\241\242\243\244\245\246\247\248\249\250\251\252\253\254\255', this.GUI.C1)
  end

  return 0
end

return { run=run }
--

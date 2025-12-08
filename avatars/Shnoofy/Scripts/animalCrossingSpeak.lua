--[[ Chat sounds ]]

function pings:chatSound(pitch)
  sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 1, pitch * 0.3 / 8 + 0.5)
end

local function playChatSound()
  local pitch = math.floor(math.random() * 9)
  pings:chatSound(pitch)
end

page:newAction(5):title("Play chat sound"):item("minecraft:note_block"):onLeftClick(playChatSound)

local chatSoundToggle = config:load("chatSound") or false
local actionChatSoundToggle = page:newAction(4)
:title("Toggle chat sounds")
:item("minecraft:birch_sign")
:setColor(0.25,0,0)
:setHoverColor(0.5,0,0)
local function setChatSoundToggle(val)
  chatSoundToggle = val
  if val == true then
    actionChatSoundToggle:setHoverColor(0,0.5,0)
  else 
    actionChatSoundToggle:setHoverColor(0.5,0,0)
  end
  config:save("chatSound", chatSoundToggle)  
end
actionChatSoundToggle:onToggle(setChatSoundToggle)
:setToggled(chatSoundToggle):setToggleColor(0, 0.25, 0)
setChatSoundToggle(chatSoundToggle)

events.CHAT_SEND_MESSAGE:register(function(msg)
  if msg:find("^%s*/") then
    -- log("command!")
    return msg
  end
  -- log("message!")
  if chatSoundToggle then
    playChatSound()
  end
  return msg
end)
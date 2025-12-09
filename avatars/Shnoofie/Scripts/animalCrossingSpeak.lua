--[[ Chat sounds ]]

-- Disabled right now - May come back later --

--[[ 
    ****
      This script won't work, do more research on animalease or korbospeak
      -- Animalease is what I want, would have to be made custom, issues with pinging/parsing
      -- KorboSpeak is already made, would not be hard at all to implement

    ****
--]] 
        

--[[
local page = action_wheel:newPage()

function pings:chatSound(pitch)
  sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 1, pitch * 0.3 / 8 + 0.5)
end

local function playChatSound()
  local pitch = math.floor(math.random() * 9)
  pings:chatSound(pitch)
end

page:newAction(5):title("Play chat sound"):item("minecraft:note_block"):onLeftClick(playChatSound)
action_wheel:setPage(page)


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


-- The only function I would have to change, keep the rest to allow for the menu to work
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
]]--
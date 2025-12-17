--manage vanilla model
vanilla_model.PLAYER:setVisible(false)

--manage vanilla armor model
vanilla_model.ARMOR:setVisible(true)
--re-enable the helmet item
vanilla_model.HELMET_ITEM:setVisible(true)

--manage vanilla cape model
vanilla_model.CAPE:setVisible(false)

--manage vanilla elytra model
vanilla_model.ELYTRA:setVisible(false)

-- Sets emmisives to the EYES render type (disables them under invisibility)
models:setSecondaryRenderType("EYES")


-- Avatar Physics
local physBone = require('Scripts/physBoneAPI')

local tailPhysics = require('Scripts/tail')
local earsPhysics = require('Scripts/ears')

local tail = tailPhysics.new(models.model.root.Body.Tail)
local ears = earsPhysics.new(models.model.root.Head.LeftEar, models.model.root.Head.RightEar)

-- pings
function pings.actionClicked()
  log("Hello")
end
--

-- Action wheel
local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)
local action = mainPage:newAction()
    :title("Test")
    :item("minecraft:acacia_door")
    :hoverColor(0, 1, 1)
    :onLeftClick(pings.actionClicked)


ears:setConfig {
  -- just changed it directly in the file
}

keybinds:newKeybind("tail - wag", "key.keyboard.v")
   :onPress(function() pings.tailWag(true) end)
   :onRelease(function() pings.tailWag(false) end)

function pings.tailWag(x)
   tail.config.enableWag.keybind = x
end

--entity init event, used for when the avatar entity is loaded for the first time
function events.entity_init()
  physBone.physBoneLeftFluff:setAirResistance(1)
  physBone.physBoneRightFluff:setAirResistance(1)
end


--render event, called every time your avatar is rendered
--it has two arguments, "delta" and "context"
--"delta" is the percentage between the last and the next tick (as a decimal value, 0.0 to 1.0)
--"context" is a string that tells from where this render event was called (the paperdoll, gui, player render, first person)
function events.render(delta, context)
 -- code here
end


local currentState 

--tick event, called 20 times per second
function events.tick()

  --[[ 
  Fixes armor offset for certain modded armors
        Currently Fixed
          - Iron's Spells and Spellbooks
  ]]--

  if player:isCrouching() and not player:isGliding() then  -- USE THE isCrouching() METHOD!! Any other method has a frame delay
    currentState = "Crouching"
    --if isPrefix(tostring(player:getItem(5)), "irons_spellbooks") then
    --log(player:getItem(6))

    --log(player:getItem(5))
    --log("irons_spellbooks")
    --log(string.find(player:getItem(5).id, "irons_spellbooks"))

      --Boots
    if isIrons(3) then
      models.model.root.LeftLeg.LeftBootPivot:setPos(0, 0, -4)
      models.model.root.RightLeg.RightBootPivot:setPos(0, 0, -4)
    end

      --Leggings
    if isIrons(4) then
      models.model.root.LeftLeg.LeftLeggingPivot:setPos(0, 0.25, -4)
      models.model.root.RightLeg.RightLeggingPivot:setPos(0, 0.25, -4)
    end

      --Chestplate
    if isIrons(5) then
      models.model.root.Body.ChestplatePivot:setPos(0, 4, 0)
    end

      --Helmet
    if isIrons(6) then
      models.model.root.Head.HelmetPivot:setPos(0, 4, 0)
    end

  else
    if currentState == "Crouching" then
      
      --Handle Boots
      models.model.root.LeftLeg.LeftBootPivot:setPos(0, 0, 0)
      models.model.root.RightLeg.RightBootPivot:setPos(0, 0, 0)

      --Handle Legs
      models.model.root.LeftLeg.LeftLeggingPivot:setPos(0, 0, 0)
      models.model.root.RightLeg.RightLeggingPivot:setPos(0, 0, 0)
      
      --Handles Chestplate
      models.model.root.Body.ChestplatePivot:setPos(0, 0, 0)

      --Handles Helmet
      models.model.root.Head.HelmetPivot:setPos(0, 0, 0)

      currentState = "Else"
    end

  end
end

function isIrons(itemID)
  return string.find(player:getItem(itemID).id, "irons_spellbooks") ~= nil
end
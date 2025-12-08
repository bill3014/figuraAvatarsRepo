--hide vanilla model
vanilla_model.PLAYER:setVisible(false)

--hide vanilla armor model
vanilla_model.ARMOR:setVisible(true)
--re-enable the helmet item
vanilla_model.HELMET_ITEM:setVisible(true)

--hide vanilla cape model
vanilla_model.CAPE:setVisible(false)

--hide vanilla elytra model
vanilla_model.ELYTRA:setVisible(false)

local physBone = require('physBoneAPI')

local tailPhysics = require('tail')
local earsPhysics = require('ears')

local tail = tailPhysics.new(models.model.root.Body.Tail)
local ears = earsPhysics.new(models.model.root.Head.LeftEar, models.model.root.Head.RightEar)

ears:setConfig {
  -- you can check ears.lua to see default config
}

keybinds:newKeybind("tail - wag", "key.keyboard.v")
   :onPress(function() pings.tailWag(true) end)
   :onRelease(function() pings.tailWag(false) end)

function pings.tailWag(x)
   tail.config.enableWag.keybind = x
end

--entity init event, used for when the avatar entity is loaded for the first time
function events.entity_init()

end


--render event, called every time your avatar is rendered
--it has two arguments, "delta" and "context"
--"delta" is the percentage between the last and the next tick (as a decimal value, 0.0 to 1.0)
--"context" is a string that tells from where this render event was called (the paperdoll, gui, player render, first person)
function events.render(delta, context)
    
  physBone.physBoneLeftFluff:setAirResistance(0.1)
  physBone.physBoneRightFluff:setAirResistance(0.1)

end


local currentState 

--tick event, called 20 times per second
function events.tick()
  if player:isCrouching() then
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
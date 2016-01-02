-- Variables --
chestPlaced = false

-- Functions --

-- Clear Window and Reset Cursor --
local function resetWindow()
  term.clear()
  term.setCursorPos(1, 1)
end
-- Places chest for mined materials --
function chest()
  turtle.select(1)
  for i=1,16 do
    if turtle.getItemDetail(i) ~= nil then
      slotDetail = turtle.getItemDetail(i)
      if slotDetail.name == "minecraft:chest" then
        turtle.placeDown()
        chestPlaced = true
        turtle.select(1)
        break
      else
        if i < 16 then
          turtle.select(i + 1)
        else
          turtle.select(1)
        end
      end
    else
      if i < 16 then
        turtle.select(i + 1)
      else
        turtle.select(1)
      end
    end
  end
end

-- If Chest was placed, goto and dump --
local function dumpInChest()
  if chestPlaced == true then
    turtle.turnRight()
    turtle.turnRight()
    print("Returning to chest...")
    for i=1,digLength do
      turtle.forward()
    end
    turtle.select(1)
    print("Dumping Inventory...")
    for i=1,16 do
      turtle.dropDown()
      if i < 16 then
        turtle.select(i + 1)
      end
    end
    turtle.turnRight()
    turtle.turnRight()
  end
end

--TODO: Fuel Check --


-- Digs and Checks for falling blocks --
local function safeDig()
  while turtle.detect() do
    turtle.dig()
  end
end

-- Main Digging --
local function dig()
  dug = 0
  while dug < digLength do
    safeDig()
    turtle.forward()
    turtle.digUp()
    turtle.digDown()
    turtle.turnRight()
    safeDig()
    turtle.turnLeft()
    turtle.turnLeft()
    safeDig()
    turtle.turnRight()
    dug = dug + 1
  end
end

-- Check where turtle is then starts Main Digging --
local function mine()
  if turtle.detectDown() then
    turtle.up()
    chest()
  else
    chest()
  end
  dig()
end

-- Begining of Program --
resetWindow()
print("How many blocks forward do you want me to go?")
write("> ")
digLength = read()
digLength = tonumber(digLength)
resetWindow()
print("Mining "..digLength.." blocks deep.")
mine()
dumpInChest()
print("All Done! :D")

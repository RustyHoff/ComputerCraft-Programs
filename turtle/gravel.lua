term.clear()
term.setCursorPos(1, 1)

turtle.select(1)
print("Starting gravel conversion.")
for i=1,16 do
  turtle.place()
  while turtle.detect() == true do
    turtle.dig()
    turtle.place()
  end
  if i < 16 then
    turtle.select(i + 1)
    print("Moving to slot "..(i + 1)..".")
  end
end
print("All done! :D")

local modal = {"cmd", "ctrl"}
local superMenu = hs.menubar.new()
function setSuperMenuDisplay(state)
    if state then
        superMenu:setTitle("!")
    else
        superMenu:setTitle(".")
    end
end
setSuperMenuDisplay(false)

local isModalActive = false
local k = hs.hotkey.modal.new(modal, 'space')
function k:entered()
  isModalActive = true
  setSuperMenuDisplay(true)
end

function k:exited()
  isModalActive = false
  setSuperMenuDisplay(false)
end

hs.hotkey.bind(modal, 'space', function()
  if isModalActive then
    k:exit()
  else
    k:enter()
  end
end)

k:bind('', ';', function()
  hs.reload()
end)
hs.alert.show("Config loaded")

function modalHotkey(key, callback)
  k:bind('', key, function()
    local window = hs.window.focusedWindow()
    if window then
      local frame = window:frame()
      local screen = window:screen()
      frame = callback(window, frame, screen)
      if frame then
        window:setFrame(frame)
      end
    end
    k:exit()
  end)
end

function modalSimpleHotkey(key, callback)
  k:bind('', key, function()
    local window = hs.window.focusedWindow()
    if window then
      local screen = window:screen()
      frame = callback(screen:frame(), screen:frame())
      if frame then
        window:setFrame(frame)
      end
    end
    k:exit()
  end)
end

modalSimpleHotkey('q', function(frame, max)
  frame.w = max.w / 2
  frame.h = max.h / 2
  return frame
end)


modalSimpleHotkey('w', function(frame, max)
  frame.h = max.h / 2
  return frame
end)

modalSimpleHotkey('e', function(frame, max)
  frame.x = max.x + (max.w / 2)
  frame.w = max.w / 2
  frame.h = max.h / 2
  return frame
end)

modalSimpleHotkey('a', function(frame, max)
  frame.w = max.w / 2
  return frame
end)

modalSimpleHotkey('d', function(frame, max)
  frame.x = max.x + (max.w / 2)
  frame.w = max.w / 2
  return frame
end)

modalSimpleHotkey('z', function(frame, max)
  frame.y = max.y + (max.h / 2)
  frame.w = max.w / 2
  frame.h = max.h / 2
  return frame
end)

modalSimpleHotkey('x', function(frame, max)
  frame.y = max.y + (max.h / 2)
  frame.h = max.h / 2
  return frame
end)

modalSimpleHotkey('c', function(frame, max)
  frame.x = max.x + (max.w / 2)
  frame.y = max.y + (max.h / 2)
  frame.w = max.w / 2
  frame.h = max.h / 2
  return frame
end)

modalSimpleHotkey('s', function(frame, max)
  frame.x = max.x
  frame.y = max.y
  frame.w = max.w
  frame.h = max.h
  return frame
end)

modalSimpleHotkey('g', function(frame, max)
  local padding = 50
  frame.x = max.x + padding
  frame.y = max.y + padding
  frame.w = max.w - padding * 2
  frame.h = max.h - padding * 2
  return frame
end)

modalSimpleHotkey('f', function(frame, max)
  frame.w = max.w / 3 * 2
  return frame
end)

modalSimpleHotkey('h', function(frame, max)
  frame.x = max.x + (max.w / 3)
  frame.w = max.w / 3 * 2
  return frame
end)

modalSimpleHotkey('j', function(frame, max)
  frame.w = max.w / 3
  return frame
end)

modalSimpleHotkey('k', function(frame, max)
  frame.x = max.x + (max.w / 3)
  frame.w = max.w / 3
  return frame
end)

modalSimpleHotkey('l', function(frame, max)
  frame.x = max.x + (max.w / 3 * 2)
  frame.w = max.w / 3
  return frame
end)

modalHotkey('[', function(window, frame, screen)
  if screen:toWest() then
    window:moveOneScreenWest()
  end
end)

modalHotkey(']', function(window, frame, screen)
  if screen:toEast() then
    window:moveOneScreenEast()
  end
end)

hs.hotkey.bind({"cmd", "shift"}, "l", function()
  hs.caffeinate.lockScreen()
end)

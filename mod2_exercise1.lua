--mod2_exercise1.lua
function setupRootElement()
  local root = {}
  root.id = 'rootElement'
  root.visible = true
  root.color = 'red'
  root['background color'] = 'yellow'
  root.text = 'Main Window'
  root.children = {
    { id = 'child1', zOrder = 1, visible = true, parent = root },
    { id = 'child2', zOrder = 2, visible = true, parent = root },
    { id = 'child3', zOrder = 3, visible = false, clickVolume = 0.02, parent = root },
  }
  root.savedIndexes = { 4, 1, 3, 2, 5, total = 5 }
  root.layoutPositions = { 'top', 'left', 'bottom', 'right' }
  root.innerLengths = { x = 1, l = { x = 2, l = { x = 3, l = { x = 4, l = { x = 5, l = { x = 6 } } } } } }

  return root
end

function table.tostring(t, maxDepth, indent, visited, currentIndent)
  local result = "{\n"
  if visited == nil then
    visited = {}
  end
  if currentIndent == nil then
    currentIndent = ""
  end
  if visited[t] then
    return tostring(t)
  else
    visited[t] = true
  end

  local first = true
  local nextIndent = currentIndent .. indent

  for k, v in pairs(t) do
    local formattedValue
    if type(v) == "string" then
      formattedValue = string.format("%q", v)
    elseif type(v) == "table" then
      if maxDepth and maxDepth > 0 then
        formattedValue = table.tostring(v, maxDepth - 1, indent, visited, nextIndent)
      else
        formattedValue = "{}"
      end
    else
      formattedValue = tostring(v)
    end
    if not first then
      result = result .. ",\n"
    else
      first = false
    end
    result = result .. nextIndent
    if type(k) == "number" then
      result = result .. formattedValue
    else
      if not (type(k) == "string" and k:match("^[_%a][_%w]*$")) then
        k = "[" .. string.format("%q", k) .. "]"
      end
      result = result .. k .. " = " .. formattedValue
    end
  end
  result = result .. "\n" .. currentIndent .. "}"
  return result
end

function main()
  local rootElement = setupRootElement()
  print(table.tostring(rootElement, 3, '  '))
end

main()
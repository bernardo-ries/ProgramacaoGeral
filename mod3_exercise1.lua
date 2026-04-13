local sampleNames = { "Maria", "Lucia", "Arthur", "Boris", "Newton" }
local testN = 10000
local users = {}
local isSorted = false

function registerUser(name)
  local lowerName = string.lower(name)
  local newUser = {id = #users +1 , name = lowerName}
  if not isSorted then
    table.insert(users, newUser)
    return
  end
  local i = #users
  while i > 0 and users[i].name > newUser.name do
    users[i+1] = users[i]
    i = i-1
  end
  users[i+1] = newUser
end

function registerUsers(names)
  for _,name in ipairs(names) do
    registerUser(name)
  end -- O(n)
  table.sort(users, function(a, b) return a.name < b.name end) -- O(n log n)
  isSorted = true
end

function main()
  local names = {}
  local n = #sampleNames
  for i=1,testN do
    names[i] = sampleNames[((i-1) % n)+1]  .. i
  end
  registerUser('Fulano')
  registerUsers(names)
  registerUser('Beltrano')
  print('Users registered: ', #users)
end

local start = os.clock()
main()
local finish = os.clock()
print("Execution time:", finish - start, "seconds")
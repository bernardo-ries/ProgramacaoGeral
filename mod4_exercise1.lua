math.randomseed(os.time())

function createOrdenedArray(size)
  local array = {}
  for i = 1, size do
    array[i] = i
  end
  return array
end

function createRandomArray(size)
  local array = {}
  for i = 1, size do
    array[i] = math.random(1, 100)
  end
  return array
end

function chosePivot(arr, low, high)
  local mid = math.floor((low + high) / 2)
  local a = arr[low]
  local b = arr[mid]
  local c = arr[high]

  if (a <= b and b <= c) or (c <= b and b <= a) then
    return mid
  elseif (b <= a and a <= c) or (c <= a and a <= b) then
    return low
  else
    return high
  end
end

function partition(arr, low, high)
  local pivotIndex = chosePivot(arr, low, high)
  arr[low], arr[pivotIndex] = arr[pivotIndex], arr[low]

  local pivot = arr[low]
  local left = low + 1
  local right = high

  while left <= right do
    while left <= right and arr[left] <= pivot do
      left = left + 1
    end

    while left <= right and arr[right] > pivot do
      right = right - 1
    end

    if left < right then
      arr[left], arr[right] = arr[right], arr[left]
    end
  end

  arr[low], arr[right] = arr[right], arr[low]
  return right
end

function quickSort(arr, low, high)
  low = low or 1
  high = high or #arr

  if low < high then
    local pivotIndex = partition(arr, low, high)
    quickSort(arr, low, pivotIndex - 1)
    quickSort(arr, pivotIndex + 1, high)
  end
end

function partitionBadCase(arr, low, high)
  local pivot = arr[low]
  local left = low + 1
  local right = high

  while left <= right do
    while left <= right and arr[left] <= pivot do
      left = left + 1
    end

    while left <= right and arr[right] > pivot do
      right = right - 1
    end

    if left < right then
      arr[left], arr[right] = arr[right], arr[left]
    end
  end

  arr[low], arr[right] = arr[right], arr[low]
  return right
end

function quickSortBadCase(arr, low, high)
  low = low or 1
  high = high or #arr

  if low < high then
    local pivotIndex = partitionBadCase(arr, low, high)
    quickSortBadCase(arr, low, pivotIndex - 1)
    quickSortBadCase(arr, pivotIndex + 1, high)
  end
end

function copyArray(array)
  local new = {}
  for i = 1, #array do
    new[i] = array[i]
  end
  return new
end

local size = 12000
local ordenedArray = createOrdenedArray(size)
local randomArray = createRandomArray(size)
local copyOfOrdenedArray = copyArray(ordenedArray)
local copyOfOrdenedArray2 = copyArray(ordenedArray)
local t1 = os.clock()
quickSortBadCase(copyOfOrdenedArray)
local t2 = os.clock()
local t3 = os.clock()
quickSort(copyOfOrdenedArray2)
local t4 = os.clock()

local randomArray = copyArray(randomArray)
local t5 = os.clock()
quickSort(randomArray)
local t6 = os.clock()

print("Time for bad algorithm:", t2 - t1 .. " seconds")
print("Time for good algorithm:", t4 - t3 .. " seconds")
print("Time for random array with good algorithm:", t6 - t5 .. " seconds")

--[[
  Nesse algoritmo, temos 2 casos principais, o caso ruim, onde o pivo escolhido é o menor elemento de um array ordenado
    nesse caso, a complexidade é O(n^2) pois o algoritmo precisa fazer n partições, e cada partição tem complexidade O(n)
  No caso bom, em contrapartida, o pivo é escolhido em um valor mediano entre 3 valores, sendo eles o inicial, o final e o do meio.
    Isso aumenta muito as chances do pivo não cair em um caso ruim, deixando a complexidade do algoritmo O(n log n) na grande maioria dos casos
  abaixo os links utilizados para fazer esse código:
    https://www.reddit.com/r/compsci/comments/20lq3o/eli5_why_is_the_worst_case_scenario_for_the/
    https://launchschool.com/books/advanced_dsa/read/quicksort_recursion
    https://en.wikipedia.org/wiki/Median_of_medians
]]
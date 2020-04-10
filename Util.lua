-- 打印
local function dump_value_(v)
    if type(v) == "string" then
        v = "\"" .. v .. "\""
    end
    return tostring(v)
end
function dump(value, desciption, nesting)
    if type(nesting) ~= "number" then nesting = 3 end

    local lookupTable = {}
    local result = {}

    local traceback = string.split(debug.traceback("", 2), "\n")
    print("dump from: " .. string.trim(traceback[3]))

    local function dump_(value, desciption, indent, nest, keylen)
        desciption = desciption or "当前数组---<var>"
        local spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ", keylen - string.len(dump_value_(desciption)))
        end
        if type(value) ~= "table" then
            result[#result +1 ] = string.format("%s%s%s = %s", indent, dump_value_(desciption), spc, dump_value_(value))
        elseif lookupTable[tostring(value)] then
            result[#result +1 ] = string.format("%s%s%s = *REF*", indent, dump_value_(desciption), spc)
        else
            lookupTable[tostring(value)] = true
            if nest > nesting then
                result[#result +1 ] = string.format("%s%s = *MAX NESTING*", indent, dump_value_(desciption))
            else
                result[#result +1 ] = string.format("%s%s = {", indent, dump_value_(desciption))
                local indent2 = indent.."    "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in pairs(value) do
                    keys[#keys + 1] = k
                    local vk = dump_value_(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then keylen = vkl end
                    values[k] = v
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for i, k in ipairs(keys) do
                    dump_(values[k], k, indent2, nest + 1, keylen)
                end
                result[#result +1] = string.format("%s}", indent)
            end
        end
    end
    dump_(value, desciption, "- ", 1)

    for i, line in ipairs(result) do
        print(line)
    end
end

function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

function string.trim(input)
    input = string.gsub(input, "^[ \t\n\r]+", "")
    return string.gsub(input, "[ \t\n\r]+$", "")
end

-- 创建一个随机数组
function createRandomArray(arrSize, maxValue)
	local arr = {}
	for i=1, arrSize do
		arr[i] = math.random(0, maxValue)
	end

	return arr;
end

-- 交换数组 元素
function swap(arr, i, j)
    local temp = arr[i]
    arr[i] = arr[j]
    arr[j] = temp
end

-- 正确的排序方法
function rightSort(arr)
    table.sort(arr, function (a, b)
        return a < b
    end)
end

-- 判断两个数组是否一样
function isEqualArr(arr1, arr2)
    if (not arr1 and arr2) or (arr1 and not arr2) then 
        return false 
    end

    if not arr1 and not arr2 then
        return false
    end

    if #arr1 ~= #arr2 then
        return false
    end

    for i = 1, #arr1 do
        if arr1[i] ~= arr2[i] then
            return false
        end
    end

    return true
end

function copyArr(arr)
    if not arr then return {} end
    local copyArr = {}
    for i = 1, #arr do
        copyArr[i] = arr[i]
    end
    return copyArr
end
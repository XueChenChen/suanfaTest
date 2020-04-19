require ".Util"

-- 冒泡排序O(n2)
--冒泡排序（Bubble Sort）也是一种简单直观的排序算法。它重复地走访过要排序的数列，一次比较两个元素，
-- 如果他们的顺序错误就把他们交换过来。走访数列的工作是重复地进行直到没有再需要交换，也就是说该数列已经排序完成。这个算法的名字由来是因为越小的元素会经由交换慢慢"浮"到数列的顶端。

-- 作为最简单的排序算法之一，冒泡排序给我的感觉就像 Abandon 在单词书里出现的感觉一样，每次都在第一页第一位，
-- 所以最熟悉。冒泡排序还有一种优化算法，就是立一个 flag，当在一趟序列遍历中元素没有发生交换，则证明该序列已经有序。但这种改进对于提升性能来
-- 说并没有什么太大作用。
-- 1. 算法步骤
-- 比较相邻的元素。如果第一个比第二个大，就交换他们两个。
-- 对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。这步做完后，最后的元素会是最大的数。
-- 针对所有的元素重复以上的步骤，除了最后一个。
-- 持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
function bubbleSort(arr)
	if not arr or #arr < 2 then return arr end

	-- for i = 1, #arr-1 do
	-- 	for j = 1, (#arr)-i do
	-- 		if arr[j] > arr[j+1] then
	-- 			swap(arr, j, j+1)
	-- 		end
	-- 	end
	-- end

	for i = #arr-1, 1, -1 do
		for j = 1, i do
			if arr[j] > arr[j+1] then
				swap(arr, j, j+1)
			end
		end
	end

	return arr
end


-- 选择排序是一种简单直观的排序算法，无论什么数据进去都是 O(n²) 的时间复杂度。
-- 所以用到它的时候，数据规模越小越好。唯一的好处可能就是不占用额外的内存空间了吧。

-- 1. 算法步骤
-- 首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置。
-- 再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。
-- 重复第二步，直到所有元素均排序完毕。
function selectionSort(arr)
	if not arr or #arr < 2 then return arr end
	
	for i = 1, #arr-1 do
		local minIdx = i
		for j = i + 1, #arr do
			if arr[minIdx] > arr[j] then
				minIdx = j
			end
		end

		swap(arr, i, minIdx)
	end

	return arr
end

-- 插入排序的代码实现虽然没有冒泡排序和选择排序那么简单粗暴，
-- 但它的原理应该是最容易理解的了，因为只要打过扑克牌的人都应该能够秒懂。
-- 插入排序是一种最简单直观的排序算法，它的工作原理是通过构建有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入。
-- 插入排序和冒泡排序一样，也有一种优化算法，叫做拆半插入。
-- 1. 算法步骤
-- 将第一待排序序列第一个元素看做一个有序序列，把第二个元素到最后一个元素当成是未排序序列。

-- 从头到尾依次扫描未排序序列，将扫描到的每个元素插入有序序列的适当位置。（如果待插入的元素与有序序列中的某个元素相等，则将待插入元素插入到相等元素的后面。）
function insertionSort(arr)
	if not arr or #arr < 2 then return arr end
	
	for i = 2, #arr do
		for j = i-1, 1, -1 do
			if arr[j+1] < arr[j] then
				swap(arr, j+1, j)
			else
				break
			end
		end
	end

	return arr
end


function heapSort(arr)
	
end

function goSort(arr)
	-- local sortArr = bubbleSort(arr) --冒泡
	-- local sortArr = selectionSort(arr) --选择
	-- local sortArr = insertionSort(arr) --插入
	return sortArr
end

-- 对数器的概念和使用
-- 有一个你想要测的方法a，
-- 实现一个绝对正确但是复杂度不好的方法b，
-- 实现一个随机样本产生器
-- 实现比对的方法
-- 把方法a和方法b比对很多次来验证方法a是否正确(大样本测试)。
-- 如果有一个样本使得比对出错，打印样本分析是哪个方法出错
-- 当样本数量很多时比对测试依然正确，可以确定方法a已经正确。
function main()
	local testTime = 500;
	local arrSize = 100;
	local maxValue = 100;

	local bEqual = true

	for i = 1, testTime do
		local arr = createRandomArray(arrSize, maxValue)
		local cArr = copyArr(arr)

		local sortArr_right = rightSort(arr) 
		local sortArr_test = goSort(cArr)

		if not isEqualArr(sortArr_right, sortArr_test) then
			bEqual = false
			print("小火鸡，你写的排序不对哦\n")
			return
		end
		print("i--", i)
	end

	print("小火鸡，very good\n")
	local arr = createRandomArray(arrSize, maxValue)
	dump(arr, "排序前数组---<var>")
	local sArr = goSort(arr)
	dump(sArr, "排序后数组---<var>")
end 

main()

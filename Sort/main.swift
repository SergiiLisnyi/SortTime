import Foundation

enum SortType {
    case selection
    case bubble
    case insert
    case quick
    case merge
}

enum ArrayType {
    case simple
    case sorted
    case reverse
}



class SortArray {
    
    func makeArraySize(_ size: Int) -> [Int] {
        var result: [Int] = []
        for _ in 0..<size{
            result.append(Int(arc4random_uniform(UInt32(size))))
        }
        return result
    }
    
    //sort "Bubble"
    func sortBubble (_ array: [Int]) -> [Int] {
        var arr = array
        for barrier in (0..<arr.endIndex).reversed() {
            for var i in 0..<barrier {
                if arr[i] > arr[i + 1] {
                    let tmp = arr[i]
                    arr[i] = arr[i + 1]
                    arr[i + 1] = tmp
                }
            }
        }
        return arr
    }
    
    // sort "Insert"
    func sortInsert (_ array: [Int]) -> [Int] {
        var arr = array
        for k in (1..<arr.endIndex) {
            let newElement = arr[k]
            var location = k - 1
            while ((location >= 0) && (arr[location]) > newElement) {
                arr[location + 1] = arr[location]
                location = location - 1
            }
            arr [location + 1] = newElement
        }
        return arr
    }
    
    //sortMerge
    func sortMerge(_ array: [Int]) -> [Int] {
        guard array.count > 1 else { return array }
        let middleIndex = array.count / 2
        let leftArray = sortMerge(Array(array[0..<middleIndex]))
        let rightArray = sortMerge(Array(array[middleIndex..<array.count]))
        return merge(leftArray, rightArray)
    }
    
    func merge(_ left: [Int], _ right: [Int]) -> [Int] {
        var leftIndex = 0
        var rightIndex = 0
        var orderedArray: [Int] = []
        
        while leftIndex < left.count && rightIndex < right.count {
            let leftElement = left[leftIndex]
            let rightElement = right[rightIndex]
            
            if leftElement < rightElement {
                orderedArray.append(leftElement)
                leftIndex += 1
            } else if leftElement > rightElement {
                orderedArray.append(rightElement)
                rightIndex += 1
            } else {
                orderedArray.append(leftElement)
                leftIndex += 1
                orderedArray.append(rightElement)
                rightIndex += 1
            }
        }
        while leftIndex < left.count {
            orderedArray.append(left[leftIndex])
            leftIndex += 1
        }
        
        while rightIndex < right.count {
            orderedArray.append(right[rightIndex])
            rightIndex += 1
        }
        return orderedArray
    }
    
    // sort "Selection"
    func sortSelection (_ array: [Int]) -> [Int] {
        var arr = array
        for barrier in (0..<arr.endIndex) {
            var index = barrier + 1
            for index in 0..<barrier {
                if arr[barrier] < arr[index] {
                    let tmp = arr[index]
                    arr[index] = arr[barrier]
                    arr[barrier] = tmp
                }
            }
        }
        return arr
    }
    
    // sort "Quick"
    func quickSort(array: [Int], left: Int = 0, right: Int? = nil) -> [Int] {
        let right = right ?? array.count - 1
        var arrayResult = array
        var m = left
        var k = right
        let center = ( arrayResult[(m + k) / 2] )
        var buf = 0
        repeat {
            while arrayResult[m] < center { m += 1 }
            while arrayResult[k] > center { k -= 1 }
            if m <= k {
                buf = arrayResult[m]
                arrayResult[m] = arrayResult[k]
                arrayResult[k] = buf
                m += 1
                k -= 1
            }
        } while m < k
        if left < k {
            arrayResult = quickSort( array: arrayResult, left: left,right: k )
        }
        if m < right {
            arrayResult = quickSort( array: arrayResult, left: m,right: right )
        }
        return arrayResult
    }
    
    //Task 4.1
    @discardableResult
    func sortArray(array: [Int], sortType: SortType) -> [Int] {
        switch sortType {
        case .bubble:
            return sortBubble(array)
        case .insert:
            return sortInsert(array)
        case .selection:
            return sortSelection(array)
        case .merge:
            return sortMerge(array)
        case .quick:
            return quickSort(array: array)
        }
    }
}


let arraySort = SortArray()
var data1k = arraySort.makeArraySize(1000)
var data2k = arraySort.makeArraySize(2000)
var data4k = arraySort.makeArraySize(4000)
var data8k = arraySort.makeArraySize(8000)
var data16k = arraySort.makeArraySize(16000)

let dictionaryArrays = [1000 : data1k, 2000: data2k, 4000 : data4k, 8000: data8k,16000 : data16k]

func timeSort (sortType: SortType, repetition: Int, typeArray: ArrayType, dictionary: Dictionary<Int, [Int]>) {
    for (key, value) in dictionaryArrays {
        let currentDateTime = Date()
            for _ in 0..<repetition  {
                arraySort.sortArray(array: value, sortType: sortType)
            }
        let time =  Date().timeIntervalSince(currentDateTime) / Double(repetition)
        print("Array(\(typeArray)) size: \(key) sorted in \(time) second by \(sortType) method")
    }
}


// Task 4.1
arraySort.sortArray(array: data1k, sortType: .bubble)

//Task 4.2
timeSort(sortType: .bubble, repetition: 5, typeArray: .simple, dictionary: dictionaryArrays)
timeSort(sortType: .selection, repetition: 5, typeArray: .simple, dictionary: dictionaryArrays)
timeSort(sortType: .insert, repetition: 5, typeArray: .simple, dictionary: dictionaryArrays)
timeSort(sortType: .merge, repetition: 5, typeArray: .simple, dictionary: dictionaryArrays)
timeSort(sortType: .quick, repetition: 5, typeArray: .simple, dictionary: dictionaryArrays)

////Task 4.3
var sortedArray1k = data1k.sorted()
var sortedArray2k = data2k.sorted()
var sortedArray4k = data4k.sorted()
var sortedArray8k = data8k.sorted()
var sortedArray16k = data16k.sorted()

let dictionarySortedArrays = [1000 : sortedArray1k, 2000: sortedArray2k,
                              4000 : sortedArray4k, 8000: sortedArray8k,16000 : sortedArray16k]

timeSort(sortType: .bubble, repetition: 5, typeArray: .sorted, dictionary: dictionarySortedArrays)
timeSort(sortType: .selection, repetition: 5, typeArray: .sorted, dictionary: dictionarySortedArrays)
timeSort(sortType: .insert, repetition: 5, typeArray: .sorted, dictionary: dictionarySortedArrays)
timeSort(sortType: .merge, repetition: 5, typeArray: .sorted, dictionary: dictionarySortedArrays)
timeSort(sortType: .quick, repetition: 5, typeArray: .sorted, dictionary: dictionarySortedArrays)

////Task 4.4
var reverceArray1k = data1k.sorted(){$0 > $1}
var reverceArray2k = data2k.sorted(){$0 > $1}
var reverceArray4k = data4k.sorted(){$0 > $1}
var reverceArray8k = data8k.sorted(){$0 > $1}
var reverceArray16k = data16k.sorted(){$0 > $1}

let dictionaryReverceArrays = [1000 : reverceArray1k, 2000: reverceArray2k,
                              4000 : reverceArray4k, 8000: reverceArray8k,16000 : reverceArray16k]

timeSort(sortType: .bubble, repetition: 5, typeArray: .reverse, dictionary: dictionaryReverceArrays)
timeSort(sortType: .selection, repetition: 5, typeArray: .reverse, dictionary: dictionaryReverceArrays)
timeSort(sortType: .insert, repetition: 5, typeArray: .reverse, dictionary: dictionaryReverceArrays)
timeSort(sortType: .merge, repetition: 5, typeArray: .reverse, dictionary: dictionaryReverceArrays)
timeSort(sortType: .quick, repetition: 5, typeArray: .reverse, dictionary: dictionaryReverceArrays)










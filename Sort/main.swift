import Foundation

enum SortName {
    case Selection
    case Bubble
    case Insert
    case Quick
    case Marge
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
    func sortArray(array: [Int], sortNane: SortName) -> [Int] {
        switch sortNane {
        case .Bubble:
            return sortBubble(array)
        case .Insert:
            return sortInsert(array)
        case .Selection:
            return sortSelection(array)
        case .Marge:
            return sortMerge(array)
        case .Quick:
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

// Task 4.1
//array.sortArray(array: data1k, sortNane: SortName.Bubble)


//Task 4.2
func timeSortBubble (arr: [Int], repetition: Int) -> Double {
    let currentDateTime = Date()
    for _ in 0..<repetition  {
        arraySort.sortArray(array: arr, sortNane: SortName.Bubble)
    }
    return Date().timeIntervalSince(currentDateTime) / Double(repetition)
}

func timeSortInsert (arr: [Int], repetition: Int) -> Double {
    let currentDateTime = Date()
    for _ in 0..<repetition  {
        arraySort.sortArray(array: arr, sortNane: SortName.Insert)
    }
    return Date().timeIntervalSince(currentDateTime) / Double(repetition)
}

func timeSortSelection (arr: [Int], repetition: Int) -> Double {
    let currentDateTime = Date()
    for _ in 0..<repetition  {
        arraySort.sortArray(array: arr, sortNane: SortName.Selection)
    }
    return Date().timeIntervalSince(currentDateTime) / Double(repetition)
}

func timeSortMarge (arr: [Int], repetition: Int) -> Double {
    let currentDateTime = Date()
    for _ in 0..<repetition  {
        arraySort.sortArray(array: arr, sortNane: SortName.Marge)
    }
    return Date().timeIntervalSince(currentDateTime) / Double(repetition)
}

func timeSortQuick (arr: [Int], repetition: Int) -> Double {
    let currentDateTime = Date()
    for _ in 0..<repetition  {
        arraySort.sortArray(array: arr, sortNane: SortName.Quick)
    }
    return Date().timeIntervalSince(currentDateTime) / Double(repetition)
}

print("Time for sort Bubble array 1000 element: \(timeSortBubble(arr: data1k, repetition: 5))")
print("Time for sort Bubble array 2000 element: \(timeSortBubble(arr: data2k, repetition: 5))")
print("Time for sort Bubble array 4000 element: \(timeSortBubble(arr: data4k, repetition: 5))")
print("Time for sort Bubble array 8000 element: \(timeSortBubble(arr: data8k, repetition: 5))")
print("Time for sort Bubble array 16000 element: \(timeSortBubble(arr: data16k, repetition: 5))")

print("Time for sort Insert array 1000 element: \(timeSortInsert(arr: data1k, repetition: 5))")
print("Time for sort Insert array 2000 element: \(timeSortInsert(arr: data2k, repetition: 5))")
print("Time for sort Insert array 4000 element: \(timeSortInsert(arr: data4k, repetition: 5))")
print("Time for sort Insert array 8000 element: \(timeSortInsert(arr: data8k, repetition: 5))")
print("Time for sort Insert array 16000 element: \(timeSortInsert(arr: data16k, repetition: 5))")

print("Time for sort Selection array 1000 element: \(timeSortSelection(arr: data1k, repetition: 5))")
print("Time for sort Selection array 2000 element: \(timeSortSelection(arr: data2k, repetition: 5))")
print("Time for sort Selection array 4000 element: \(timeSortSelection(arr: data4k, repetition: 5))")
print("Time for sort Selection array 8000 element: \(timeSortSelection(arr: data8k, repetition: 5))")
print("Time for sort Selection array 16000 element: \(timeSortSelection(arr: data16k, repetition: 5))")

print("Time for sort Marge array 1000 element: \(timeSortMarge(arr: data1k, repetition: 5))")
print("Time for sort Marge array 2000 element: \(timeSortMarge(arr: data2k, repetition: 5))")
print("Time for sort Marge array 4000 element: \(timeSortMarge(arr: data4k, repetition: 5))")
print("Time for sort Marge array 8000 element: \(timeSortMarge(arr: data8k, repetition: 5))")
print("Time for sort Marge array 16000 element: \(timeSortMarge(arr: data16k, repetition: 5))")

print("Time for sort Quick array 1000 element: \(timeSortQuick(arr: data1k, repetition: 5))")
print("Time for sort Quick array 2000 element: \(timeSortQuick(arr: data2k, repetition: 5))")
print("Time for sort Quick array 4000 element: \(timeSortQuick(arr: data4k, repetition: 5))")
print("Time for sort Quick array 8000 element: \(timeSortQuick(arr: data8k, repetition: 5))")
print("Time for sort Quick array 16000 element: \(timeSortQuick(arr: data16k, repetition: 5))")



//Task 4.3
var sortedArray1k = data1k.sorted()
var sortedArray2k = data2k.sorted()
var sortedArray4k = data4k.sorted()
var sortedArray8k = data8k.sorted()
var sortedArray16k = data16k.sorted()

print("Time for sort Bubble arraySorted 1000 element: \(timeSortBubble(arr: sortedArray1k, repetition: 5))")
print("Time for sort Bubble arraySorted  2000 element: \(timeSortBubble(arr: sortedArray2k, repetition: 5))")
print("Time for sort Bubble arraySorted  4000 element: \(timeSortBubble(arr: sortedArray4k, repetition: 5))")
print("Time for sort Bubble arraySorted  8000 element: \(timeSortBubble(arr: sortedArray8k, repetition: 5))")
print("Time for sort Bubble arraySorted  16000 element: \(timeSortBubble(arr: sortedArray16k, repetition: 5))")

print("Time for sort Insert arraySorted  1000 element: \(timeSortInsert(arr: sortedArray1k, repetition: 5))")
print("Time for sort Insert arraySorted  2000 element: \(timeSortInsert(arr: sortedArray2k, repetition: 5))")
print("Time for sort Insert arraySorted  4000 element: \(timeSortInsert(arr: sortedArray4k, repetition: 5))")
print("Time for sort Insert arraySorted  8000 element: \(timeSortInsert(arr: sortedArray8k, repetition: 5))")
print("Time for sort Insert arraySorted  16000 element: \(timeSortInsert(arr: sortedArray16k, repetition: 5))")

print("Time for sort Selection arraySorted  1000 element: \(timeSortSelection(arr: sortedArray1k, repetition: 5))")
print("Time for sort Selection arraySorted  2000 element: \(timeSortSelection(arr: sortedArray2k, repetition: 5))")
print("Time for sort Selection arraySorted  4000 element: \(timeSortSelection(arr: sortedArray4k, repetition: 5))")
print("Time for sort Selection arraySorted  8000 element: \(timeSortSelection(arr: sortedArray8k, repetition: 5))")
print("Time for sort Selection arraySorted  16000 element: \(timeSortSelection(arr: sortedArray16k, repetition: 5))")

print("Time for sort Marge arraySorted  1000 element: \(timeSortMarge(arr: sortedArray1k, repetition: 5))")
print("Time for sort Marge arraySorted  2000 element: \(timeSortMarge(arr: sortedArray2k, repetition: 5))")
print("Time for sort Marge arraySorted  4000 element: \(timeSortMarge(arr: sortedArray4k, repetition: 5))")
print("Time for sort Marge arraySorted  8000 element: \(timeSortMarge(arr: sortedArray8k, repetition: 5))")
print("Time for sort Marge arraySorted  16000 element: \(timeSortMarge(arr: sortedArray16k, repetition: 5))")

print("Time for sort Quick arraySorted  1000 element: \(timeSortQuick(arr: sortedArray1k, repetition: 5))")
print("Time for sort Quick arraySorted  2000 element: \(timeSortQuick(arr: sortedArray2k, repetition: 5))")
print("Time for sort Quick arraySorted  4000 element: \(timeSortQuick(arr: sortedArray4k, repetition: 5))")
print("Time for sort Quick arraySorted  8000 element: \(timeSortQuick(arr: sortedArray8k, repetition: 5))")
print("Time for sort Quick arraySorted  16000 element: \(timeSortQuick(arr: sortedArray16k, repetition: 5))")


//Task 4.4
var reverceArray1k = data1k.sorted(){$0 > $1}
var reverceArray2k = data2k.sorted(){$0 > $1}
var reverceArray4k = data4k.sorted(){$0 > $1}
var reverceArray8k = data8k.sorted(){$0 > $1}
var reverceArray16k = data16k.sorted(){$0 > $1}

print("Time for sort Bubble arrayReverce 1000 element: \(timeSortBubble(arr: reverceArray1k, repetition: 5))")
print("Time for sort Bubble arrayReverce 2000 element: \(timeSortBubble(arr: reverceArray2k, repetition: 5))")
print("Time for sort Bubble arrayReverce 4000 element: \(timeSortBubble(arr: reverceArray4k, repetition: 5))")
print("Time for sort Bubble arrayReverce 8000 element: \(timeSortBubble(arr: reverceArray8k, repetition: 5))")
print("Time for sort Bubble arrayReverce 16000 element: \(timeSortBubble(arr: reverceArray16k, repetition: 5))")

print("Time for sort Insert arrayReverce 1000 element: \(timeSortInsert(arr: reverceArray1k, repetition: 5))")
print("Time for sort Insert arrayReverce 2000 element: \(timeSortInsert(arr: reverceArray2k, repetition: 5))")
print("Time for sort Insert arrayReverce 4000 element: \(timeSortInsert(arr: reverceArray4k, repetition: 5))")
print("Time for sort Insert arrayReverce 8000 element: \(timeSortInsert(arr: reverceArray8k, repetition: 5))")
print("Time for sort Insert arrayReverce 16000 element: \(timeSortInsert(arr: reverceArray16k, repetition: 5))")

print("Time for sort Selection arrayReverce 1000 element: \(timeSortSelection(arr: reverceArray1k, repetition: 5))")
print("Time for sort Selection arrayReverce 2000 element: \(timeSortSelection(arr: reverceArray2k, repetition: 5))")
print("Time for sort Selection arrayReverce 4000 element: \(timeSortSelection(arr: reverceArray4k, repetition: 5))")
print("Time for sort Selection arrayReverce 8000 element: \(timeSortSelection(arr: reverceArray8k, repetition: 5))")
print("Time for sort Selection arrayReverce 16000 element: \(timeSortSelection(arr: reverceArray16k, repetition: 5))")

print("Time for sort Marge arrayReverce 1000 element: \(timeSortMarge(arr: reverceArray1k, repetition: 5))")
print("Time for sort Marge arrayReverce 2000 element: \(timeSortMarge(arr: reverceArray2k, repetition: 5))")
print("Time for sort Marge arrayReverce 4000 element: \(timeSortMarge(arr: reverceArray4k, repetition: 5))")
print("Time for sort Marge arrayReverce 8000 element: \(timeSortMarge(arr: reverceArray8k, repetition: 5))")
print("Time for sort Marge arrayReverce 16000 element: \(timeSortMarge(arr: reverceArray16k, repetition: 5))")

print("Time for sort Quick arrayReverce 1000 element: \(timeSortQuick(arr: reverceArray1k, repetition: 5))")
print("Time for sort Quick arrayReverce 2000 element: \(timeSortQuick(arr: reverceArray2k, repetition: 5))")
print("Time for sort Quick arrayReverce 4000 element: \(timeSortQuick(arr: reverceArray4k, repetition: 5))")
print("Time for sort Quick arrayReverce 8000 element: \(timeSortQuick(arr: reverceArray8k, repetition: 5))")
print("Time for sort Quick arrayReverce 16000 element: \(timeSortQuick(arr: reverceArray16k, repetition: 5))")









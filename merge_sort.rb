def merge_sort(array)
  return array if array.length <= 1

  middle = array.length / 2

  p1 = merge_sort(array[...middle])
  p2 = merge_sort(array[middle...])

  result = []
  while p1.length + p2.length > 0
    if p1.empty?
      result += p2
      break
    elsif p2.empty?
      result += p1
      break
    else
      if p1[0] < p2[0]
        result << p1.shift
      else
        result << p2.shift
      end
    end
  end

  result
end

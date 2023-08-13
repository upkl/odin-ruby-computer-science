# frozen_string_literal: true

def merge_sort(array)
  return array if array.length <= 1

  middle = array.length / 2

  p1 = merge_sort(array[...middle])
  p2 = merge_sort(array[middle...])

  result = []
  while (p1.length + p2.length).positive?
    if p1.empty?
      result += p2
      break
    elsif p2.empty?
      result += p1
      break
    else
      result << if p1[0] < p2[0]
                  p1.shift
                else
                  p2.shift
                end
    end
  end

  result
end

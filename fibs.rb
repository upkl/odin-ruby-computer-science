# frozen_string_literal: true

def fibs(len)
  result = [0, 1]
  result << result[-2] + result[-1] while result.length < len
  result[0..len]
end

def fibs_rec(num)
  return [0, 1][0..num] if n <= 2

  res = fibs_rec(num - 1)
  p num, res
  res << res[-2] + res[-1]
  res
end

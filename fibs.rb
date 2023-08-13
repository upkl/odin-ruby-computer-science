def fibs len
  result = [0, 1]
  while result.length < len
    result << result[-2] + result[-1]
  end
  result[0..len]
end

def fibs_rec n
  if n <= 2
    return [0, 1][0..n]
  end

  r = fibs_rec(n - 1)
  p n, r
  r << r[-2] + r[-1]
  r
end

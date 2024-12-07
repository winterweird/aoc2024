results = eval(gets)
operands = eval(gets)

def process(os)
  a, b, *rest = os
  if rest.empty?
    [a*b, a+b]
  elsif rest.length == 1
    c = rest.first
    [a*b+c,a*b*c,a+b+c,(a+b)*c]
  else
    r1 = process([a*b,*rest])
    r2 = process([a+b,*rest])
    return r1+r2
  end
end

operands.each_with_index do |os, i|
  #puts
  #puts os.to_s
  opts = process(os)
  #puts opts.to_s
  #puts opts.to_s
  if opts.any? { _1 == results[i] }
    puts results[i]
  end
end

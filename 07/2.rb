results = eval(gets)
operands = eval(gets)

def process(os)
  a, b, *rest = os
  if rest.empty?
    [a*b, a+b, (a.to_s+b.to_s).to_i]
  else
    #puts "#{a}*#{b} -- #{rest}"
    #puts "#{a}+#{b} -- #{rest}"
    #puts "#{a}||#{b} -- #{rest}"
    r1 = process([a*b,*rest])
    r2 = process([a+b,*rest])
    r3 = process([(a.to_s+b.to_s).to_i,*rest])
    #puts r1,r2,r3
    return r1+r2+r3
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

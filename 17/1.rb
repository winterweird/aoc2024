$a = gets.split(" ").last.to_i
$b = gets.split(" ").last.to_i
$c = gets.split(" ").last.to_i
gets
$p = gets.split(" ").last.split(",").map(&:to_i)
$output=[]

def combo(op)
  { 4 => $a, 5 => $b, 6 => $c, 7 => nil }.fetch(op, op)
end
def oper(idx)
  $p[idx+1]
end

def adv(idx)
  $a = $a/(2**combo(oper(idx)))
  idx+2
end
def bxl(idx)
  $b = $b ^ oper(idx)
  idx+2
end
def bst(idx)
  $b = combo(oper(idx)) % 8
  idx+2
end
def jnz(idx)
  !$a.zero? ? oper(idx) : idx+2
end
def bxc(idx)
  $b = $b ^ $c
  idx+2
end
def out(idx)
  $output << combo(oper(idx))%8
  idx+2
end
def bdv(idx)
  $b = $a/(2**combo(oper(idx)))
  idx+2
end
def cdv(idx)
  $c = $a/(2**combo(oper(idx)))
  idx+2
end

opc = {
  0 => method(:adv),
  1 => method(:bxl),
  2 => method(:bst),
  3 => method(:jnz),
  4 => method(:bxc),
  5 => method(:out),
  6 => method(:bdv),
  7 => method(:cdv),
}

idx = 0
loop do
  idx = opc[$p[idx]].(idx)
  break if idx >= $p.length
end
puts $output.join(",")

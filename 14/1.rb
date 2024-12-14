rs = eval(gets)

WIDTH=101
HEIGHT=103

q1=0
q2=0
q3=0
q4=0
rs.each do |x,y,dx,dy|
  px,py = (x+dx*100)%WIDTH, (y+dy*100)%HEIGHT
  if px<WIDTH/2&&py<HEIGHT/2
    q1+=1
  elsif px<WIDTH/2&&py>HEIGHT/2
    q2+=1
  elsif px>WIDTH/2&&py<HEIGHT/2
    q3+=1
  elsif px>WIDTH/2&&py>HEIGHT/2
    q4+=1
  end
end
puts q1*q2*q3*q4

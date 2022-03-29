r = Ractor.new do
  puts "(-1) Output from within Ractor. #{Ractor.recv}"
end

10.times do |n|
  r = Ractor.new r, n do |x, i|
    cnt = Ractor.recv
    puts "(#{i}) Output from within Ractor. #{cnt}"
    x.send(cnt+1)
  end
end

r.send(1)

sleep(5)

# (9) Output from within Ractor. 1
# (8) Output from within Ractor. 2
# (7) Output from within Ractor. 3
# (6) Output from within Ractor. 4
# (5) Output from within Ractor. 5
# (4) Output from within Ractor. 6
# (3) Output from within Ractor. 7
# (2) Output from within Ractor. 8
# (1) Output from within Ractor. 9
# (0) Output from within Ractor. 10
# (-1) Output from within Ractor. 11

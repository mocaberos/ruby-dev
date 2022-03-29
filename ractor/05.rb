10.times do |n|
  r = Ractor.new do
    puts "Output from within Ractor. #{Ractor.recv}"
    sleep(1)
  end
  r.send(n)
end

sleep(5)

# Output from within Ractor. 1
# Output from within Ractor. 0
# Output from within Ractor. 2
# Output from within Ractor. 3
# Output from within Ractor. 4
# Output from within Ractor. 5
# Output from within Ractor. 6
# Output from within Ractor. 7
# Output from within Ractor. 8
# Output from within Ractor. 9

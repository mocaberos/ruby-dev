r = Ractor.new do
  10.times do |n|
    puts "Output from within Ractor. #{n}"
    sleep(1)
  end
end

r.take

# Output from within Ractor. 0
# Output from within Ractor. 1
# Output from within Ractor. 2
# Output from within Ractor. 3
# Output from within Ractor. 4
# Output from within Ractor. 5
# Output from within Ractor. 6
# Output from within Ractor. 7
# Output from within Ractor. 8
# Output from within Ractor. 9

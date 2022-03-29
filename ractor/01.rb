# 処理が終わるのを待たないと途中で切られる。

Ractor.new do
  10.times do |n|
    puts "Output from within Ractor. #{n}"
    sleep(1)
  end
end

sleep(5)

# Output from within Ractor. 0
# Output from within Ractor. 1
# Output from within Ractor. 2
# Output from within Ractor. 3
# Output from within Ractor. 4

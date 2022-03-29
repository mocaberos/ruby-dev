# 外部スコープから分離されるため、外のオブジェクトにアクセスできない
# 外のオブジェクトは引数として渡しておくと、アクセスができる

10.times do |n|
  Ractor.new n do |x|
    puts "Output from within Ractor. #{x}"
    sleep(1)
  end
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

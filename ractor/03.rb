# 外部スコープから分離されるため、外のオブジェクトにアクセスできない

10.times do |n|
  Ractor.new do
    puts "Output from within Ractor. #{n}"
    sleep(1)
  end
end

sleep(5)

# <internal:ractor>:267:in `new': can not isolate a Proc because it accesses outer variables (n). (ArgumentError)
def greeting
    sayWhat = ARGV.shift
    ARGV.each do |sayWho|
        puts "#{sayWhat}, #{sayWho}!"
    end
end

greeting
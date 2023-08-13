FIELDS = (1..8).to_a.product((1..8).to_a)
START = [3, 3]
GOAL = [4, 3]

def check field
    1 <= field[0] and field[0] <= 8 and 1 <= field[1] and field[1] <= 8
end

destinations = {}
FIELDS.each do |field|
    destinations[field] = [
        [field[0] + 2, field[1] + 1],
        [field[0] + 1, field[1] + 2],
        [field[0] + 2, field[1] - 1],
        [field[0] + 1, field[1] - 2],
        [field[0] - 2, field[1] + 1],
        [field[0] - 1, field[1] + 2],
        [field[0] - 2, field[1] - 1],
        [field[0] - 1, field[1] - 2],
].filter{|dest| check dest}
end

queue = [[START, [START]]]
found = false

until queue.empty? or found
    field, path = queue.shift
    destinations[field].each do |dest|
        next if path.include? dest
        new_path = path + [dest]
        if dest == GOAL
            found = true
            puts "You made it in #{path.length} moves!  Here's your path:"
            new_path.each{|f| puts "   #{f}"}
        else
            queue.append([dest, new_path])
        end
    end
end

puts "Not found" unless found
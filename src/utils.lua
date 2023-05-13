function BottomCollision(a, b, y_diff)
    if math.abs(a.y - b.y) > y_diff then
        return false
    end
    if a.x + a.width < b.x then -- aaaaa...... b
        return false
    end
    if b.x + b.width < a.x then -- bbbbb...... a
        return false
    end
    return true
end
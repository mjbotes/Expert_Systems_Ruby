def solveRPN(exp, vals)
    index = -1
    truth = []
    syms = ["&", "|", "^"]
    alpha = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    exp.each do |e|
        e.strip!
        syms.include?(e)
            if e === "+"
                index -= 1
                if truth[index + 1] === 1 && truth[index] === 1
                    truth[index] = 1
                else
                    truth[index] = 0
                end
                truth.delete_at(index + 1)
            elsif e === "|"
                index -= 1
                if truth[index + 1] === 1 || truth[index] === 1
                    truth[index] = 1
                else
                    truth[index] = 0
                end
                truth.delete_at(index + 1)
            elsif e === "^"
                index -= 1
                if (truth[index + 1] === 1 && truth[index] === 0)|| (truth[index] === 1 && truth[index + 1] === 0)
                    truth[index] = 1
                else
                    truth[index] = 0
                end
                truth.delete_at(index + 1)
            end
        alpha.include?(e)
            pl = 0
            is_n = 0
            if e[0] === '!'
                is_n=1
                pl=1
            end
            i = e[pl].ord - 'A'.ord
            if (i > -1 && i < 26)
                if is_n === 1 
                    if (vals[i] === 1)
                        p_val = 0
                    else
                        p_val = 1
                    end
                else
                    p_val = vals[i]
                end
                truth.push(p_val)
                index += 1
            end
    end
    truth[0]
end



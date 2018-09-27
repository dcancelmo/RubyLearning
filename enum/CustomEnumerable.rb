module CustomEnumerable
    def custom_collect
        arr = []
        # For each element, place in new array the value yielded by other method with parameter e
        each do |e|
            res = yield e
            arr.push(res)
        end
        arr
    end

    def custom_inject(base = nil)
        if base == nil
            base = 0
        end
        num = base
        # Take the base and perform the action defined in block onto it using the info in each element of the array
        each do |e|
            num = yield num, e
        end
        num
    end

    def custom_select
        arr = []
        # For each element of the array check if the yielded block returns true, if yes add to array to return
        custom_collect do |e|
            if yield e
                arr.push(e)
            end
        end
        arr
    end

    def custom_max(&block)
        maxi = self[0]
        # If there is a block it is a <=> comparison and thus will result in -1, 0, or 1
        # Else a simple comparison can be made
        # For each element of the array perform the comparison and if e is greater than maxi, set maxi to e
        if block != nil
            custom_collect do |e|
                if (yield maxi, e) == -1
                    maxi = e
                end
            end
            maxi
        else
            custom_collect do |e|
                if e > maxi
                    maxi = e
                end
            end
            maxi
        end
    end

    def custom_max_by
        maxi = self[0]
        # For each element in the array yield that element and the current maxi to the block
        # If the result of yielding e is higher than result of maxi set maxi to e
        custom_collect do |e|
            if (yield e) > (yield maxi)
                maxi = e
            end
        end
        maxi
    end
end
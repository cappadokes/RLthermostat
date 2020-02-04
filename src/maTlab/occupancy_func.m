function new_people = occupancy_func(old_people, max_num)

if old_people == 1
    %same_num = 0.9;
    plus_one = 0.09;
    plus_two = 0.01;
    chance = rand;
    if chance <= plus_two
        new_people = 3;
    elseif chance <= plus_one
        new_people = 2;
    else
        new_people = 1;
    end
elseif old_people < max_num
    %same_num = 0.9;
    plus_one = 0.04;
    min_one = 0.04;
    plus_two = 0.01;
    min_two = 0.01;
    chance = rand;
    if (chance <= min_two || chance >= (1-plus_two))
        chance2 = rand;
        if chance2 <= 0.5
            new_people = old_people+2;
        else
            new_people = old_people-2;
        end
        if new_people < 1
            new_people = 1;
        end
        if new_people > max_num
            new_people = max_num;
        end
    elseif (chance <= min_two+min_one || chance >= (1-plus_two-plus_one))
        chance2 = rand;
        if chance2 <= 0.5
            new_people = old_people+1;
        else
            new_people = old_people-1;
        end
    else
        new_people = old_people;
    end
else
    %same_num = 0.9;
    min_one = 0.09;
    min_two = 0.01;
    chance = rand;
    if chance <= min_two
        new_people = max_num-2;
    elseif chance <= min_one
        new_people = max_num-1;
    else
        new_people = max_num;
    end   
end


end
function set = make_sets(complete_set,number)
rng(123)
set1 = [];
set2 = [];
set3 = [];
set4 = [];
total_len = length(complete_set);
if rem(total_len,4)>0
    total_len = total_len - rem(total_len,4);
end
for i = 1:total_len
    j = false;
    while j==false
        aleat = rand();
        if aleat < 0.25
            if length(set1) < total_len/4
                set1 =[set1; complete_set(i,:)];
                j=true;
            end
        elseif aleat < 0.5
            if length(set2) < total_len/4
                set2 =[set2; complete_set(i,:)];
                j=true;
            end
        elseif aleat < 0.75
            if length(set3) < total_len/4
                set3 =[set3; complete_set(i,:)];
                j=true;
            end
        else
            if length(set4) < total_len/4
                set4 =[set4; complete_set(i,:)];
                j=true;
            end
        end
    end
end
if number == 1
    set = set1;
elseif number == 2
    set = set2;
elseif number == 3
    set = set3;
elseif number == 4
    set = set4;
end
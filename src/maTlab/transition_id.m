function trans_spec = transition_id(start_region, end_region, start_fang, end_fang)

if end_region == 1
    trans_spec = 1;
elseif end_region == 3
    if start_region == 2
        trans_spec = 1;
    elseif start_region == 1
        trans_spec = 3;
    else
        trans_spec = 2;
    end
else
    if start_region ~= 2
        trans_spec = 3;
    else
        trans_spec = 2;
    end
end

if trans_spec ~= 2
    return;
else
    if start_fang >= 0
        if end_fang >= 0
            if end_fang >= start_fang
                trans_spec = 3;
                return;
            end
        else
            if abs(end_fang) >= abs(start_fang)
                trans_spec = 3;
                return;
            end
        end
    else
        if (end_fang <= 0) && (start_fang >= end_fang)
            trans_spec = 3;
        elseif (end_fang >= 0) && (abs(end_fang) >= abs(start_fang))
            trans_spec = 3;
        end
        return;
    end
end

end
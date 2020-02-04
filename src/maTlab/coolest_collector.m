function C = coolest_collector(energy_spent, start_fang, end_fang, tradeoff, resultsview, me, se, mf, sf)

start_region = 0;
end_region = 0;

pmv_start = 10*abs(start_fang);
pmv_end = 10*abs(end_fang);

if pmv_start < 7.5
    start_region = 1;
end
if pmv_end < 7.5
    end_region = 1;
end

E = energy_spent;

df = pmv_start-pmv_end;

if (start_region == 0 && end_region == 0 && df <= 0) || (start_region == 1 && end_region == 0)
    if ~resultsview
        C = 10;
    else
        if ~isempty(me)
            C = tradeoff*(E-me)/se + (1-tradeoff)*(abs(end_fang)-mf)/sf;
        else
            C = rand;
        end
    end
else
    if ~isempty(me)
        C = tradeoff*(E-me)/se + (1-tradeoff)*(abs(end_fang)-mf)/sf;
    else
        C = rand;
    end
end

end
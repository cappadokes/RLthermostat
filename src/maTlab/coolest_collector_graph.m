function [C, olde_max] = coolest_collector_graph(energy_spent, start_fang, end_fang, tradeoff, resultsview, E_max)

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
        C = 1.5;
    else
        C = tradeoff*E/E_max + (1-tradeoff)*abs(end_fang);
    end
else
    C = tradeoff*E/E_max + (1-tradeoff)*abs(end_fang);
end

end
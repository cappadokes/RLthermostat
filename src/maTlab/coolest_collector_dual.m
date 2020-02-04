function [C_fang, C_en] = coolest_collector_dual(energy_spent, start_fang, end_fang, tradeoff)

E_max = 2000;

start_region_en = 0;
end_region_en = 0;

pmv_start = abs(start_fang);
pmv_end = abs(end_fang);

if pmv_start < 1
    start_region_en = 1;
end
if pmv_end < 1
    end_region_en = 1;
end

start_region_fang = 0;
end_region_fang = 0;

if pmv_start < 0.75
    start_region_fang = 1;
end
if pmv_end < 0.75
    end_region_fang = 1;
end

E = energy_spent;

df = pmv_start-pmv_end;

if (start_region_en == 0 && end_region_en == 0 && df <= 0)
    C_en = 90;
    if (start_region_fang == 0 && end_region_fang == 0 && df <= 0)
        C_fang = 90;
    else
        C_fang = (1-tradeoff)*(1-cos(pi/2*end_fang));
    end
elseif (start_region_fang == 0 && end_region_fang == 0 && df <= 0)
    C_fang = 90;
    if (start_region_en == 0 && end_region_en == 0 && df <= 0)
        C_en = 90;
    else
        C_en = tradeoff*E/E_max;
    end    
else
    C_en = tradeoff*E/E_max; C_fang = (1-tradeoff)*(1-cos(pi/2*end_fang));
end

end
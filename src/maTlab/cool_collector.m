function C = cool_collector(energy_spent, start_fang, end_fang, tradeoff, results_view)

start_region = 0;
end_region = 0;

if abs(start_fang) < 1
    start_region = 1;
end
if abs(end_fang) < 1
    end_region = 1;
end

E = energy_spent/200;
df = (abs(start_fang) - abs(end_fang));
if (~results_view)
    if start_region == 0 && end_region == 0 && df <= 0
        C = 15;
    else
        C = tradeoff*E + (1-tradeoff)*abs(end_fang)*10;
    end
else
    C = tradeoff*E + (1-tradeoff)*abs(end_fang)*10;
end

end
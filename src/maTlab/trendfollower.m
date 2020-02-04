function [TB, mini_TB] = trendfollower (TB, evec, fvec, me, se, mf, sf, tradeoff)

energy_part = (evec-me)/se;
fang_part = (fvec-mf)/sf;

for i = 1:size(TB,2)
    if (TB(end,i) ~= 10)
        TB(end,i) = tradeoff*energy_part(i)+(1-tradeoff)*fang_part(i);
    end
end

start_idx = 1;
%start_idx = max(1, size(TB,2) - 500 + 1);

mini_TB = TB(:,start_idx:end);

end
g = 1;

net_step = 2;
arch_count = 0;

bestperfs = zeros(25,25);

for lay_1 = net_step:net_step:50
    for lay_2 = net_step:net_step:50
        arch_count = arch_count+1;
        net = [];
        [net, tr] = neural_trainer_cont(arch_count, my_TB, [], g, [lay_1 lay_2]);
        bestperfs(lay_1, lay_2) = tr.best_vperf;
        surf(bestperfs); drawnow;
    end
end
%If e_0 is empty, our exploration needs to be initialized.
if isempty(e_0)
    disp('Initializing exploration stuff...');
    e_0 = 1;
    if agent_ready
        e_0 = e;
        if e_0 == 0
            e_0 = 0.1;
        end
    end
    disp(['e_0 = ' num2str(e_0)]);
    pause(1);
    e = e_0;
    N_0 = 2*schedule_length;
    N_d = 0.25;
    theta = e_0/(N_d*N_0);
    N = N_0;
    n = 1;
    N_w = schedule_length;
    N_p = 0;
end

if n >= N
    disp('AGENT READY');
    agent_ready = true;
    e_0 = [];
end

if n < N && t_c > 0
    if mod(n,N_w) ~= 0
        disp('Window open!');
        e = e - theta;
        if e <= 0
            e = 0;
        end
        if ~isempty(TD) && TD(end) < 0.15
            N_p = N_p+1;
        end
    else
        disp('Window closed!');
        lambda = N_p/N_w;
        if lambda <= 0
            lambda = 0;
        end
        lambda_vec = [lambda_vec lambda];
        disp(['λ = ' num2str(lambda)]);
        if lambda == 1
            e = 0;
        else
            e = k*(1-lambda) + (1-k)*e;
        end
        if e <= 0
            e = 0;
        end
        disp(['e = ' num2str(e)]);
        pause(1);
        N_r = floor(e/(N_d*theta)-mod((e/(N_d*theta)), N_w)+N_w);
        N = n + N_r;
        N_p = 0;
    end
    n = n+1;
    e_vec = [e_vec; e];
end
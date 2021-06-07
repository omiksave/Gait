classdef kalmanrt < handle
    properties (Access = public)
        t;%Time Step
        sol = [0;0];
    end
    properties (Access = private) 
        A;
        B;
        Q;
        R;
        P;
        K;
    end
    properties (Access = private)
        p_kf = 0;
        v_kf = 0;
        P0 = [3.5 1.5;1.5 1.6]*10^-3;
        sigma_sq = 2.9;
        sigma_p = sqrt(0.6e-3);
        sigma_v = sqrt(7.2e-3);
    end
    methods
        function filt = kalmanrt(int)
            filt.t = int;
            filt.A = [1 filt.t;0 1];
            filt.B = [0.5*filt.t^2;filt.t];
            filt.Q = filt.B*filt.B'*filt.sigma_sq;
            filt.R = [filt.sigma_p;filt.sigma_v]*[filt.sigma_p filt.sigma_v];
            filt.P = filt.P0;
            filt.K = filt.P*((filt.P + filt.R)^-1);
        end
        function loopesh(filt,a_x,v_x,p_x,contact)
            filt.sol = filt.A*filt.sol+filt.B*a_x;
            filt.P = filt.A*filt.P*filt.A' + filt.B'*filt.Q*filt.B;
            if contact
                filt.K = filt.P*((filt.P + filt.R)^-1);
                filt.sol = filt.sol + filt.K*([p_x;v_x]-filt.sol);
                filt.P = (eye(2)-filt.K)*filt.P;
            end
        end
    end
end

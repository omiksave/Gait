classdef filter_rt < matlab.System
    % Untitled5 Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties
        order;
        cutoff;
        freq;
    end
    properties(Access = private)
        channel = 4;
        state;
    end
    % Pre-computed constants
    properties(Access = private,Nontunable)
        num;
        den;
    end
    methods
        function obj = filter_rt(varargin)
            setProperties(obj,nargin,varargin{:})
        end
    end
    methods (Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            obj.state = zeros(1,3);
            [obj.num,obj.den] = butter(obj.order,obj.cutoff/(0.5*obj.freq));
        end
        
        function y = stepImpl(obj,MyClient)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            MyClient.GetFrame();
            obj.state = [-MyClient.GetGlobalForceVector(2,1).ForceVector(2);
                        MyClient.GetGlobalCentreOfPressure(2,1).CentreOfPressure(2);
                        MyClient.GetGlobalCentreOfPressure(1,1).CentreOfPressure(2)];
            y = [filter(obj.num,obj.den,obj.state(1)) filter(obj.num,obj.den,obj.state(2)) filter(obj.num,obj.den,obj.state(3))];
            %y = u;
        end

        function resetImpl(obj)
            obj.state(:) = 0;
        end
    end
end

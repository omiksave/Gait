function [large,small] = large_small(raw, x0)

large = 0.5*(((exp(raw-x0)-1)./(exp(raw-x0)+1))+1);
if isnan(large)
    large = 1;
end
small = 1-large;
end

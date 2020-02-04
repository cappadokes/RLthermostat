function output = sim_RVM(input, weights, basisWidth)

BASIS	= exp(-distSquared(input,input)/(basisWidth^2));
output = BASIS*weights;

end
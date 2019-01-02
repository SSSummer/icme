function [out, gaussianProb] = gmmEval(data, mu, sigma, w);
% gmmEval: Evaluation of a GMM (Gaussian mixture model)
%	Usage: out = evalgmm(data, mu, sigma, w);
%		data: dim x dataNum matrix where each column is a data point
%		mu: dim x gaussianNum matrix where each column is a mean vector
%		sigma: dim x 1 vector where each element represents the covariance of a variable
%		w: 1 x gaussianNum vector where each element is a weighting coefficient
%		out: 1 x dataNum vector of output probabilities

%	Roger Jang, 20000602

if nargin==0, selfdemo; return; end

[dim, dataNum] = size(data);
gaussianNum = size(mu, 2);
gaussianProb = zeros(gaussianNum, dataNum);	% gaussianProb(i,j) is the prob. of data j to Gaussian i

for i = 1:gaussianNum,
	gaussianProb(i,:) = gaussian(data, mu(:, i), sigma(i)*eye(dim));
end
out = w(:)'*gaussianProb;


% ====== Self demo
function selfdemo

mu = [-3 3; 3 -3]';
sigma = [1 4];
w = [.2, .8];

bound = 8;
pointNum = 31;
x = linspace(-bound, bound, pointNum);
y = linspace(-bound, bound, pointNum);
[xx, yy] = meshgrid(x, y);

data = [xx(:), yy(:)]';
out = feval(mfilename, data, mu, sigma, w);
zz = reshape(out, pointNum, pointNum);

mesh(xx, yy, zz);
axis([-inf inf -inf inf -inf inf]);
set(gca, 'box', 'on');
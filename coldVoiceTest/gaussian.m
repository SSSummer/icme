function out = gaussian(data, mu, sigma);
% gaussian: Multi-dimensional Gaussian propability density function
%	Usage: out = gaussian(data, mu, sigma)
%	data: d x n data matrix, representing n data vector of dimension d
%	mu: d x 1 vector
%	sigma: d x d matrix
%		d x 1 or 1 x d vector
%		1 x 1 scalar
%	out: 1 x n vector
%
%	Type "gaussian" for a self demo.

%	Roger Jang, 20000602

if nargin<1, selfdemo; return; end
[dim, dataNum]=size(data); 

if size(sigma,1)*size(sigma,2)==dim	% Vector
	sigma=diag(sigma);
elseif size(sigma,1)*size(sigma,2)==1	% Scalar
	sigma=sigma*eye(dim);
end

invSigma = inv(sigma);		% For repeated invocation of this function, this step should be moved out of this function
dataMinusMu = data-mu*ones(1, dataNum);
out = exp(-sum(dataMinusMu.*(invSigma*dataMinusMu), 1)/2)/((2*pi)^(dim/2)*sqrt(det(sigma)));

% ====== Self demo ======
function selfdemo
% Plot 1-D Gaussians
x = linspace(-10, 10);
subplot(2,1,1);
hold on
for i = 1:20,
	y = feval(mfilename, x, 0, i);
	plot(x,y);
end
hold off; box on

% Plot 2-D Gaussians
mu = [0; 0];
sigma = [9 3; 3, 4];

bound = 8;
pointNum = 31;
x = linspace(-bound, bound, pointNum);
y = linspace(-bound, bound, pointNum);
[xx, yy] = meshgrid(x, y);

data = [xx(:), yy(:)]';
out = feval(mfilename, data, mu, sigma);
zz = reshape(out, pointNum, pointNum);

subplot(2,2,3);
mesh(xx, yy, zz);
axis([-inf inf -inf inf -inf inf]);
set(gca, 'box', 'on');

subplot(2,2,4);
contour(xx, yy, zz, 15);
axis image;

area = quad('gaussian', -10, 10, [], [], 1, 2);
fprintf('The integration from -10 to 10 for a Gaussian is %g.\n', area);

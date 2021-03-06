function [features] = Soares2006(I)
%
% Copyright (C) 2006  Jo?o Vitor Baldini Soares
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor,
% Boston, MA 02110-1301, USA.
%


scales = [5 6 7 8 9 10];
I = im2double(I);

% Inverting so vessels become brighter.
I = 1 - I;

features = [];

% Below, creates the maximum wavelet response over angles and adds
% them as pixel features
bigimg = I;
fimg = fft2(bigimg);

k0x = 0;

for k0y = [3]
  for a = scales
    for epsilon = [4]
      % Maximum transform over angles.
      trans = maxmorlet(fimg, a, epsilon, [k0x k0y], 10);
      
      % Adding to features
      features = cat(3, features, trans);
    end
  end
end

features = max(features, [], 3);

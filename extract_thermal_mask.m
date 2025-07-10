function Mthermal = extract_thermal_mask(ir_gray)
lambda = 1;
sigma = 1;
gamma = 1;

u = wls_filter_structtensor(ir_gray, lambda, sigma, gamma);
%figure; imshow(u,[])
R = abs(ir_gray - u);
% figure; imshow(R,[])
Mthermal=R;
%T = graythresh(R);
%Mthermal = imbinarize(R, T);
end

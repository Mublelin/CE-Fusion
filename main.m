clc; clear; close all;

addpath('./');

%%read
vis = im2double(imread('vis.png')); 
ir = im2double(rgb2gray(imread('ir.png'))); 

[h, w, ~] = size(vis);
ir = imresize(ir, [h, w]);

if size(ir, 3) == 1
    ir = repmat(ir, 1, 1, 3);
end


%% Detail enhancement (visible light)
vis_enhanced = enhance_visible_detail(vis);

%% Thermal target enhancement (infrared)
Mthermal = extract_thermal_mask(ir(:,:,1)); 

%% 
levels = 4;
vis_pyr = build_laplacian_pyramid(vis_enhanced, levels);
ir_pyr  = build_laplacian_pyramid(ir, levels);

%% fusion
fused_pyr = fuse_pyramids_with_mask(vis_pyr, ir_pyr, Mthermal);

%% 
fused_img = reconstruct_from_pyramid(fused_pyr);

% end

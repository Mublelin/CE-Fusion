function fused_pyr = fuse_pyramids_with_mask(vis_pyr, ir_pyr, Mthermal)
levels = length(vis_pyr);
fused_pyr = cell(1, levels);

for l = 1:levels-1    
    [h_l, w_l, ~] = size(vis_pyr{l});

    hsv_vis = rgb2hsv(vis_pyr{l});
    Vsharp = hsv_vis(:,:,3); 

    [grad_x, grad_y] = gradient(Vsharp);
    grad_mag = sqrt(grad_x.^2 + grad_y.^2);

    % Resize 
    grad_mag_resized = imresize(grad_mag, [h_l, w_l]);
    Mresized = imresize(Mthermal, [h_l, w_l]);

    % Wdetail 
    epsilon = 1e-3;
    Wdetail = (1 - Mresized) .* (grad_mag_resized ./ (grad_mag_resized + epsilon));
    Wdetail = repmat(Wdetail, 1, 1, 3);  

    fused_pyr{l} = Wdetail .* vis_pyr{l} + (1 - Wdetail) .* ir_pyr{l};
end


[h_low, w_low, ~] = size(vis_pyr{levels});
alpha = 0.8 * Mthermal + 0.2 * (1 - Mthermal);
alpha = imresize(alpha, [h_low, w_low]);
alpha = repmat(alpha, 1, 1, 3);

fused_pyr{levels} = alpha .* ir_pyr{levels} + (1 - alpha) .* vis_pyr{levels};
end

function vis_enhanced = enhance_visible_detail(vis)

hsv_vis = rgb2hsv(vis);
V = hsv_vis(:,:,3);

% CLAHE
V_clahe = adapthisteq(V, 'NumTiles', [16 16], 'ClipLimit', 0.02);


G = imgaussfilt(V_clahe, 1.5);
V_sharp = V_clahe + 0.8 * (V_clahe - G);


hsv_vis(:,:,3) = mat2gray(V_sharp);
vis_enhanced = hsv2rgb(hsv_vis);
end

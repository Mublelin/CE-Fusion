function visualize_and_save_pyramid(pyr, prefix)
% 可视化并保存每一层金字塔图像

levels = length(pyr);
figure;
for l = 1:levels
    subplot(1, levels, l);
    imshow(mat2gray(pyr{l}));
    title(['Level ', num2str(l)]);
    
    % 保存
    filename = sprintf('%s_pyramid_level%d.png', prefix, l);
    imwrite(mat2gray(pyr{l}), filename);
end
end

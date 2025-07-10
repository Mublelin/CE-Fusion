function pyr = build_laplacian_pyramid(img, levels)
% Laplacian

pyr = cell(1, levels);
current = img;
for l = 1:levels-1
    down = imresize(current, 0.5, 'bilinear');
    up = imresize(down, size(current(:,:,1)), 'bilinear');
    pyr{l} = current - up;
    current = down;
end
pyr{levels} = current;
end

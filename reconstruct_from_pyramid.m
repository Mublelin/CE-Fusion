function img = reconstruct_from_pyramid(pyr)

levels = length(pyr);
img = pyr{levels};
for l = levels-1:-1:1
    up = imresize(img, size(pyr{l}(:,:,1)), 'bilinear');
    img = up + pyr{l};
end
end

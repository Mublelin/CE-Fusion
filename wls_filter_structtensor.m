function output = wls_filter_structtensor(I, lambda, sigma, gamma)
[h, w] = size(I);
N = h * w;

[Gx, Gy] = gradient(I);

% λ_max
J11 = imgaussfilt(Gx.^2, 1);
J22 = imgaussfilt(Gy.^2, 1);
J12 = imgaussfilt(Gx .* Gy, 1);
lambda_max = 0.5 * (J11 + J22 + sqrt((J11 - J22).^2 + 4 * J12.^2));
% figure;imshow(lambda_max, []);
% title('\lambda_{max} Structure Tensor Response');

dx = diff(I, 1, 2); dx = padarray(dx, [0 1], 'post');
dy = diff(I, 1, 1); dy = padarray(dy, [1 0], 'post');

denom = sigma^2 + gamma * lambda_max;
Wx = exp( - (dx.^2) ./ (denom + eps) );
Wy = exp( - (dy.^2) ./ (denom + eps) );

i = [];
j = [];
v = [];
idx = @(x, y) sub2ind([h, w], x, y);

for x = 1:h
    for y = 1:w
        k = idx(x, y);
        val = 1;

        if y < w
            k_r = idx(x, y+1);
            wij = Wx(x, y);
            i = [i; k; k];
            j = [j; k; k_r];
            v = [v; lambda * wij; -lambda * wij];
            val = val + lambda * wij;
        end

        if x < h
            k_d = idx(x+1, y);
            wij = Wy(x, y);
            i = [i; k; k];
            j = [j; k; k_d];
            v = [v; lambda * wij; -lambda * wij];
            val = val + lambda * wij;
        end

        i = [i; k];
        j = [j; k];
        v = [v; val];
    end
end

A = sparse(i, j, v, N, N);
b = I(:);

u = A \ b;
output = reshape(u, h, w);
end

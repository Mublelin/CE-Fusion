function high_low_frequency_analysis(img)
% 融合结果高频低频特征分析

gray_img = rgb2gray(img);
lowpass = imgaussfilt(gray_img, 5);
highpass = gray_img - lowpass;

figure;
subplot(1,3,1); imshow(gray_img); title('融合图（灰度）');
subplot(1,3,2); imshow(mat2gray(lowpass)); title('低频成分');
subplot(1,3,3); imshow(mat2gray(highpass)); title('高频成分');

imwrite(mat2gray(lowpass), 'lowpass_component.png');
imwrite(mat2gray(highpass), 'highpass_component.png');

end

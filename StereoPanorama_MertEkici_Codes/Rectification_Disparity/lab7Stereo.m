clear all ; close all ; clc;
    img_right = imread(['11080086_l.PNG']);
    img_right = rgb2gray(img_right);
    img_right = double(img_right);
    [row, column,ch] = size (img_right);
    %img_right = imresize(img_right,[4000,4000])
    img_left = imread('11080086_r.PNG');
    img_left = rgb2gray(img_left);
    img_left = double(img_left);
    %img_left = imresize(img_left,[4000,4000])

    [row, column,ch] = size (img_left);
    
    k= 9;
    omega = 38;
    offset = omega + k;


    img_L = padarray(img_left,[offset offset],'both');
    img_R = padarray(img_right,[offset offset],'both');
    [ydim,xdim]=size(img_L);




    for xL = offset+1:1:xdim-offset-1
        for yL = offset+1:1:ydim-offset-1
        dist = [];
        subL =img_L(yL-k:yL+k,xL-k:xL+k);
            for xR = xL:-1:xL-omega
                subR = img_R(yL-k:yL+k,xR-k:xR+k);
                C = sum(sum(-1.*(subL-subR).^2));
    
                dist=[dist;xL-xR C];
            end
        ind = find(dist(:,2) == max(dist(:,2)));
        d = dist(ind(1),1);
        disparity(yL,xL)=d;
        %disparity=disparity(yL,xL);
        end 
    end

imshow(stereoAnaglyph(uint8(img_L),uint8(img_R)));
% Show disparity map with colorbar
figure; imagesc(uint8(disparity)); colormap jet; colorbar
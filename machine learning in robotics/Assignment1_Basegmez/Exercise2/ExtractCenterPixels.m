%% ExtractCenterPixels: function description
function [CenterPixels] = ExtractCenterPixels(ImageName, p)
    % Extract Pixels from the rectangular region around the center of the
    % image

    % if p>1 || p<0
    %     error('p is not element of [0,1]')
    % end
    % % Reads the image into a matrix
    % Im = imread(ImageName);

    % % figure()
    % % imshow(Im)

    % % Imagesize
    % [H,W] = size(Im(:,:,1));

    % H_center = floor(p*H);
    % W_center = floor(p*W);
    % % Difference between Image size and the size of the center-window
    % H_dif = H-H_center;
    % W_dif = W-W_center;
    % % case-sensitive determination of the indices which are needed for the
    % % extraction of the center-pixels
    % if H_dif==1
    %     rows = [1:H-1];
    % elseif H_dif==0
    %     rows = [1:H];
    % elseif H_dif>=2 && H_dif<H
    %     a = floor(H_dif/2);
    %     rows = [1+a:a+H_center];
    % elseif H_dif==H
    %     error('Window height is zero. Choose another p')
    % end
    % if W_dif==1
    %     cols = [1:W-1];
    % elseif W_dif==0
    %     cols = [1:W];
    % elseif W_dif>=2 && W_dif<W
    %     a = floor(W_dif/2);
    %     cols = [1+a:a+W_center];
    % elseif W_dif==W
    %     error('Window height is zero. Choose another p')
    % end
    % % Extracting of the center pixels
    % CenterPixels = Im(rows,cols,:);

    % figure()
    % imshow(CenterPixels)
    % end


    im = imread(ImageName);
    [H, W] = size(im(:, :, 1));
    H_rect = floor(p*H);
    W_rect = floor(p*W);
    h_diff = floor((H - H_rect)/2); % actually half of the diff
    w_diff = floor((W - W_rect)/2);

    rect_h_start = 1 + h_diff;
    rect_w_start = 1 + w_diff;
    rect_h_end = h_diff + H_rect;
    rect_w_end = w_diff + W_rect;

    rect_h = [rect_h_start:rect_h_end];
    rect_w = [rect_w_start:rect_w_end];

    CenterPixels = im(rect_h, rect_w, :);
    figure()
    imshow(CenterPixels)

end

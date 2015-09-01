%% Exercise2: function description
function [outputs] = Exercise2(Image)
    % outputs = ;
    im = imread(Image);


    dir1 = 'George_W_Bush';
    n1 = 20;
    p1 = 0.2;
    [mu_s, Sigma_s] = LearnModelParameters(dir1, n1, p1);
    mu_s
    Sigma_s
    LikValues_s = EvaluateLikelihood(Image, mu_s, Sigma_s);


    dir2 = 'BackgroundImages';
    n2 = 22; % 22 images in BackgroundImages
    p2 = 1;
    [mu_b, Sigma_b] = LearnModelParameters(dir2, n2, p2);
    mu_b
    Sigma_b
    LikValues_b = EvaluateLikelihood(Image, mu_b, Sigma_b);


    % c)
    figure()
    imshow(LikValues_s/max(max(LikValues_s)))
    title('P(x|skin model)')
    % d)
    figure()
    imshow(LikValues_b/max(max(LikValues_b)))
    title('P(x|background model)')
    % e)
    binary_im = (LikValues_s./LikValues_b)>=1;
    figure()
    imshow(binary_im)
    hold on
    title('Binary image')
    % f)
    [X, Y] = FindBiggestComp(binary_im);
    figure()
    imshow(im)
    hold on
    title('Face recognition');
    plot([X,X(1)],[Y,Y(1)],'r');

end

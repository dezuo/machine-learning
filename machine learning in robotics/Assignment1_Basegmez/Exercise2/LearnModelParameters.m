%% LearnModelParameters: function description
function [mu, Sigma] = LearnModelParameters(DirectoryName, n, p)
    % mu = ;
    % Sigma = ;

    files = dir(DirectoryName);
    rgbValues = [];
    initial_file = 4; % . .. .DS_Store are [1:3]
    last_file = 4+n-1;

    for file=initial_file:last_file
        filename = files(file).name;
        filepath = fullfile(DirectoryName, filename);
        CenterPixels = ExtractCenterPixels(filepath, p);
        rgbValues = [rgbValues; reshape(CenterPixels,[size(CenterPixels,1)*size(CenterPixels,2),3])];
    end

    mu = mean(double(rgbValues))';
    Sigma = cov(double(rgbValues));

end

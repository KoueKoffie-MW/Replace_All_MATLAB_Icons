
% Start with the largest size possible. This is limited to the max font
% size of 200. I found that 450x450 worked well.
imgFile = "mathworks-logo_300x300.png";
[img,~,imgAlpha]= imread(imgFile);

imgSize = size(img,1:2);


% Create string array of releases
T = combinations(23:30,["a","b"]);
txtrelease = join(T{:,:},''); % Covert table into text and join

txtPosition = round(imgSize.*[0.55, 0.5]);


for i=1:length(txtrelease)
    fprintf("icon: %s\n",txtrelease(i))
    
    % Write text with a white border to correctly get the alpha mask. Desire is to have a black
    % border but it is problematic since the background comes in black from imread.
    borderColor = [255,255,255];
    imgText = insertTextWithBorder(img, txtPosition, txtrelease(i),borderColor,...
        Font = "Roboto Condensed Bold",...
        FontColor = "white",...
        FontSize = 150,...
        AnchorPoint = "Center",...
        BoxOpacity = 0);

    txtAlpha = rgb2gray(imgText-img);
    txtAlpha(txtAlpha~=0) = 255;

    % Combine both alpha layers
    alpha = max(imgAlpha,txtAlpha);

    % insert release text on top of base image now with the correct black border.
    borderColor = [0,0,0];
    imgFinal = insertTextWithBorder(img, txtPosition, txtrelease(i),borderColor,...
        Font = "Roboto Condensed Bold",...
        FontColor = "white",...
        FontSize = 150,...
        AnchorPoint = "Center",...
        BoxOpacity = 0);

    icoFile = "matlab.icons\matlab_" + txtrelease(i) + ".ico";
    pngFile = "png\matlab_" + txtrelease(i) + ".png";

    % Include the alpha values when writing the png
    imwrite(imgFinal,pngFile,Alpha=alpha)

    % convert PNG to ICO with ImageMagick
    cmd = sprintf( "imagemagick\\magick convert %s -define icon:auto-resize=" + ...
        "256,128,96,64,48,32,16 -compress zip -colors 256 %s",pngFile,icoFile);
    system(cmd);


end

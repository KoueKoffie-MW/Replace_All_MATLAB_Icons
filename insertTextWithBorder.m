function [img,TextMask] = insertTextWithBorder(I, position, text, border_color, varargin)

%TEXTBORDER Display text with border.
%   TEXTBORDER(X, Y, STRING)
%   Creates text on the current figure with a one-pixel border around it.
%   The default colors are white text on a black border, which provides
%   high contrast in most situations.
%
%   TEXTBORDER(X, Y, STRING, TEXT_COLOR, BORDER_COLOR)
%   Optional TEXT_COLOR and BORDER_COLOR specify the colors to be used.
%
%   Optional properties for the native TEXT function (such as 'FontSize')
%   can be supplied after all the other parameters.
%   Since usually the units of the parent axes are not pixels, resizing it
%   may subtly change the border of the text out of position. Either set
%   the right size for the figure before calling TEXTBORDER, or always
%   redraw the figure after resizing it.
%
%   Author: João F. Henriques, April 2010

if isempty(text), return; end

%border around the text, composed of 4 text objects
s = 6;
% S = (-s:s)';
% N = length(S);
% C = repmat(s,N,1);
% offsets = [-C,S; C,S; S,-C; S,C];
[X,Y] = ndgrid(-s:s,-s:s);
idx = find((X(:).^2 + Y(:).^2) <= (s+0.5).^2);
offsets = round([X(idx),Y(idx)]);

img = I;

imgComplement = reshape(imcomplement(border_color)*255,1,1,[]);
TextMask = ones(size(I)).*imgComplement;

%% insert
idx = find([varargin{:}]=="FontColor");

if ~isempty(idx)
    isDefaultFontColor = false;
    FontColor = varargin{idx+1}; % Save font color
    varargin{idx+1} = border_color;
    
else
    isDefaultFontColor = true;
    idx = lenght(varargin) + 1;
    varargin{idx} = "FontColor";
    varargin{idx+1} = border_color;
end


for k = 1:height(offsets)
    img = insertText(img, position + offsets(k,:), text, varargin{:});
    TextMask = insertText(TextMask,position + offsets(k,:), text, varargin{:});
end


%% insert text
if isDefaultFontColor
    varargin{idx+1} = [1 1 1];
else
    varargin{idx+1} = FontColor;
end

img = insertText(img, position, text, varargin{:});
TextMask = uint8(~all(TextMask == imgComplement,3)*255);




end


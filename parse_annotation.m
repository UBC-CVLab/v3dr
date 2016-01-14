function [ entries ] = parse_annotation( annotation, nframes, ratio )
% PARSE_ANNOTATION Parses an annotation like the ones we made for the cmu
% dataset.
%
% Input
%   Annotation : String. Something like 'all', '1-17' or '2- 16, 90 - 120'.
%   nframes    : Integer. The number of frames in the mocap sequences.
%   ratio      : Float. Annotation framerate / mocap framerate.
% Output
%   

% --
% Julieta

if nargin < 3,
    ratio = 0.8;
end

% Define the output.
entries = {};

if isempty( annotation ),
    return;
end

% Trim the annotation.
annotation = strtrim( annotation );

% See if it is emptyummary of this function goes here
%   Detailed explanation goes here after trimming.
if isempty( annotation ),
    return;
end

if strcmp( annotation, 'all'),
    entries{1} = [ 2, nframes ];
    return;
end

% Separate by commas.
if exist('strsplit', 'file'),
    xx = strsplit( annotation, ',');
else
    % For older matlab < 2013.
    xx = strread( annotation, '%s', 'delimiter', ',');
end

for i = 1:numel(xx),
    
    % Trim the ith entry.
    trimmed_entry = strtrim( xx{i} );
    
    % Parse the 2 numbers.    
    if exist('strsplit', 'file'), % for newer matlab > 2013
        yy = strsplit( trimmed_entry, '-');
    else
        % For older matlab < 2013.
        yy = strread( trimmed_entry, '%s', 'delimiter', '-');
    end
        
    bg = floor( str2double( strtrim( yy{1} ) ) * ratio);
    if bg == 0
        bg = 1;
    end
    nd = floor( str2double( strtrim( yy{2} ) ) * ratio);
    
    if bg >= nd,
        error('The annotion is wrong.');
    end
    
    entries{ end+1 } = [bg, nd];
    
end

end


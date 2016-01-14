%% Example script to load CMU annotations.

% Add path.
addpath('extern/');
addpath('data/');

%% 
file_details   = csv2cell('cmu-2000-shortest-files.csv', 'fromfile');


file_details   = file_details(2:end, :); % Get rid of the first row.
file_names     = file_details(:, 1);
file_len_24fps = cellfun(@str2num, file_details(:, 2), 'UniformOutput', false);

%% Parse the annotation file.
labels_cell    = get_annotation_labels('cmu-annotation-24fps.csv', file_names, file_len_24fps);


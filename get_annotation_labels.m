function labels = get_annotation_labels(anno_file, mocap_file_list, mocap_file_sizes)
% GET_ANNOTATION_LABELS 
% loads all the labels for the cmu dataset.
% It loads annotation for the files in handles.appData.fileNames
%
%
% Input
%   Handles describing various parameters
% Output
%   Nx2 cells. where 1st column is filename. N is total number of files
%    2nd column is a cell length equal to number of frames in mocap data.
%    Each cell may be string or empty depending on annotated (string is the annotation) or not

if nargin < 1 || isempty(anno_file)
    anno_file = 'cmu-annotation-24fps.csv';
end

ACTIONS = {
    'file', ...             %1
    '1 - check watch', ...  %2
    '2 - cross arms', ...   %3
    '3 - scratch head', ... %4
    '4 - sit down', ...     %5
    '5 - get up', ...       %6
    '6 - turn', ...         %7
    '7 - walk', ...         %8
    '8 - wave', ...         %9
    '9 - punch', ...        %10
    '10 - kick', ...        %11
    '11 - point', ...       %12
    '12 - pick up', ...     %13
    '13 - throw oh', ...    %14
    '14 - throw b.',...     %15
    '15 - run'};            %16

% read_csv  = csvimport(anno_file, 'columns', ACTIONS);
data     = csv2cell(anno_file, 'fromfile');
f_row    = data(1, :);
select   = false(1, numel(f_row));
for a_i = 1:numel(ACTIONS),
     select = select | strcmp(f_row, ACTIONS{a_i});
end
read_csv = data(2:end, select);

annotationFPS = 24;
videoFPS      = 24;

labels = cell(numel(mocap_file_list), 2);
ratio  = videoFPS/annotationFPS;

% parse annotations for each file, if it exists
for i=1:length(mocap_file_list)
    idx = cellfun(@strcmp, repmat(mocap_file_list(i),[length(read_csv) 1]), read_csv(:,1));
    nframes = mocap_file_sizes{i} ;
    temp = false(nframes,length(ACTIONS));
    
    if ~isempty(find(idx, 1))
        for p = 2:length(read_csv(idx,:))
            annot     = parse_annotation(read_csv{idx,p},nframes,ratio);            
            temp(:,p) = annotation2bool(annot, nframes);
        end
    end
    
    % assign action name to the label if the entry in temp is 1
    % corresponding to that action. Also note that temp(:,1) is always
    % false
    labels{i,1} = mocap_file_list{i};
    labels{i,2} = cell(nframes,1);
    
    for k = 1:nframes
        j = find(temp(k,:));
        if ~isempty(j)
            labels{i,2}{k} = j - 1; % subtracting one for the file column.
        end
    end
end
end

function [ entries ] = annotation2bool( parsed_annotation, nframes )
%ANNOTATION2BOOL Converts a parsed annotation to a boolean array.

% --
% Julieta

% Define the output.
entries = false( nframes, 1 );

for i = 1:numel( parsed_annotation ),
   
    bg =  parsed_annotation{i}(1);
    nd =  parsed_annotation{i}(2);
    
    entries( bg:nd ) = true;
    
end



end


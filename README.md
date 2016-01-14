# v3dr code
*Code accompanying the UBC V3dR dataset.*

We provide code for reading frame-level CMU annotations in Matlab.

These are the 8 classes and their corresponding IDs used in the annotation file:
1. get_up (5)
2. kick (10)
3. pick_up (12)
4. punch (9)
5. sit_down (4)
6. throw_overhead (13)
7. walk (7)

## Accessing annotations in Matlab
The main function to read the annotation is:

labels_cell = get_annotation_labels(<CSV annotation file path>, ...);

See script RUN_GET_LABELS for an example.

## The final labels_cell data format:
2000 x 2 cell array.
- First column is the file name.
- Second column is another cell array with length = number of frames 
-- Each cell block at the frame holds IDs of the labelled actions for that frame.

Note: the annotations are provided assuming that the mocap data has already been subsampled to 24 fps (originally at 120 fps).



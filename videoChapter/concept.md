[[begin concept]]
ConceptName
Name: video TOC

Purpose: display the chapters of a video as a textual table of contents

State: the only state is the input video name, for now just a file

Actions:
- display(video): text based display of chapters, numbered, with second
  resolution timestamps

Operating Principles:
- after a new video is requested, the output is updated. If no chapter
  information is found, a display of "no TOC available" is shown
[[end concept]]

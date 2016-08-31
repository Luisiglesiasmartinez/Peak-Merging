ReadMe Peak Merging and Reading

This program merges ChIP-seq narrowpeak bed files downloaded form ENCODE of the CTCF transcription factor. 
Two peaks are considered the same if one of the centre of one of them overlaps with the other peak. 
The program reads the ChIP-seq files and outputs a cell file containing one matrix per chromosme. 
The number of rows of the matrix correspond to the number fo peaks. The first column contains the start 
of the peak, the second the end of the peak, the third the centre and the fourth column contains a count 
of how many times the peak appears in all datasets. 

  
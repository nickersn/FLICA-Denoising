function [dims,scales,bpp,endian,datatype] = read_avw_hdr(fname)
% [dims,scales,bpp,endian] = READ_AVW_HDR(fname)
%
%  Extracts the 4 dimensions (dims), 
%   4 scales (scales) and bytes per pixel (bpp) for voxels 
%   contained in the Analyse header file (fname)
%   Also returns endian = 'l' for little-endian or 'b' for big-endian
%
%  See also: READ_AVW, READ_AVW_IMG, SAVE_AVW, SAVE_AVW_HDR, SAVE_AVW_IMG

% remove extension if it exists
if ( (length(findstr(fname,'.hdr'))>0) | ...
	(length(findstr(fname,'.img')>0)) ),
  fname=fname(1:(length(fname)-4));
end
fnhdr=strcat(fname,'.hdr');

% open file in big-endian
endian='b';
fid=fopen(fnhdr,'r','b');
testval = fread(fid,1,'int32');
% check if this gives the correct header size - if not use little-endian
if (testval~=348),
  fclose(fid);
  fid=fopen(fnhdr,'r','l');
  endian='l';
  testval = fread(fid,1,'int32');
  if (testval~=348),
    disp('Can not read this file format');
    return;
  end
end
	% ditch the remaining initial header stuff
  dummy=fread(fid,36,'char');
	% ditch dim[0] = No. dimensions
  dummy=fread(fid,1,'int16');
  dims=fread(fid,4,'int16');
  dummy=fread(fid,3,'int16');
  dummy=fread(fid,14,'char');
  datatype=fread(fid,1,'int16');  
  bpp=fread(fid,1,'int16');
  dummy=fread(fid,2,'char');
  dummy=fread(fid,1,'float');
  scales=fread(fid,4,'float');
fclose(fid);
return;

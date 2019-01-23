function [img,dims,scales,bpp,endian] = read_avw(fname)
% [img, dims,scales,bpp,endian] = READ_AVW(fname)
%
%  Read in an analyse file into either a 3D or 4D
%  array (depending on the header information)
%  Ouput coordinates are in MEDx convention
%  except that all dimensions start at 1 rather than 0
%  Note: automatically detects char, short, long or double formats
%  Extracts the 4 dimensions (dims), 
%  4 scales (scales) and bytes per pixel (bpp) for voxels 
%  contained in the Analyse header file (fname)
%  Also returns endian = 'l' for little-endian or 'b' for big-endian
%
%  See also: READ_AVW_HDR, READ_AVW_IMG, SAVE_AVW, SAVE_AVW_HDR, SAVE_AVW_IMG

  img=read_avw_img(fname);
  [dims,scales,bpp,endian]= read_avw_hdr(fname);
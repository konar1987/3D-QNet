D = 'E:\3D-QNet\MICCAI_BraTS_2019_Data_Training\HGG\BraTS19_CBICA_AAG_1\';
Ou = 'E:\3D-QNet\Brats2019_3D Code\T1C-QMUSIG_C8_S2\';
V = zeros(240,240,155);
%T =ones(240,240);
F = dir(fullfile(D, '*BraTS19_CBICA_*.gz')); 
for p = 1:numel(F)
    S = fullfile(D,F(p).name);
    dot = find(F(p).name == '.');
    if isempty(dot)
        bname = F(p).name;
    else
        bname = F(p).name(1:dot(1)-1);
    end
    %[fold, bname, ext] = fileparts(S);
    gunzip(S);
    V = niftiread(S);
    V = im2uint8(rescale(V));
dims = size(V);
%mkdir([Ou, bname]);
out_loc = strcat(Ou, strcat(bname,'\'));
%mkdir([ou, bname]);
for i = 1:dims(3)
    %S = fullfile(D,F(p).name);
   I = V(:,:,i);
 filename=sprintf('Slice%d.png',i-1);
        %filename= strcat(bname,slice);
 imwrite(I,strcat(out_loc,filename));
end
% Normalization
for i = 1:dims(3)
    I = V(:,:,i);
  
    M = double(I-min(I(:)))./double(max(I(:))-min(I(:)));
   % V(:,:,i) =double(V(:,:,i)-min(V(:,:,i)))./double(max(V(:,:,i))-min(V(:,:,i)));
   V(:,:,i) = M;
   %V(:,:,i)=T-double(V(:,:,i));
end
%V = double(V)./255;
% Transform into Quantum Phase [0, pi/2]
V = double((pi/2)*V);
Z = fuzzyimage3(V);
niftiwrite(Z,bname);
Z = im2uint8(rescale(Z));
 k=4;
L = imsegkmeans3(Z,k);
L = im2uint8(rescale(L));
%mkdir([ou_loc, bname]);
post_loc = strcat(Ou, strcat(bname,'_Post\'));
for j = 1:dims(3)
    %S = fullfile(D,F(p).name);
   M = L(:,:,j);
%O = ind2rgb(I, jet(256));
% for j = 1:dims(3)
     
        file=sprintf('Slice%d.png',j-1);
        %filename= strcat(bname,slice);
        imwrite(M,strcat(post_loc,file));
end
ovr_loc = strcat(Ou, strcat(bname,'_Overlay\'));
%mkdir([ovr_loc, bname]);
for l =1:155
H = strcat(out_loc, sprintf('Slice%d.png',l-1)); 
G = strcat(post_loc, sprintf('Slice%d.png',l-1));
Ip =imread(H);
Op =imread(G);
B = labeloverlay(Ip,Op);

 cfile=strcat(bname, sprintf('_%d.png',l-1));
 imwrite(B,strcat(ovr_loc, cfile));

fclose('all');
end
 end
    %S(k).data = I; % optional, save data

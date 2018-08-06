function [ imBin ] = binariser( imEntre )
%--------------------------------------------------------------
%-------------------- © Nader Trabelsi ------------------------
%--------------------------------------------------------------
imBin=false(size(imEntre,1),size(imEntre,2));
if size(imEntre,3)==1
    s=((max(max(imEntre)))-(min(min(imEntre))))/2;
    for i=1:size(imEntre,1)
        for j=1:size(imEntre,2)
            if imEntre(i,j)>s
                imBin(i,j)=1;
            end
        end
    end
    e=ones(3,3);e(2,2)=0;
    imEntre=imdilate()
else
    
    imEntre=rgb2gray(imEntre);
    s=((max(max(imEntre)))-(min(min(imEntre))))/2;
    for i=1:size(imEntre,1)
        for j=1:size(imEntre,2)
            if imEntre(i,j)>s
                imBin(i,j)=1;
            end
        end
    end
    
end

end
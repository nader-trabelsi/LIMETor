function [ imSor ] = egaliserHisto( imEntre )
%--------------------------------------------------------------
%-------------------- © Nader Trabelsi ------------------------
%--------------------------------------------------------------

d = 0:1:255;
histCu = cumsum(histc(imEntre(:),d));

nbPixels=size(imEntre,1)*size(imEntre,2);

for i=1:size(imEntre,1)
    for j=1:size(imEntre,2)
        imSor(i,j)=255*(histCu(imEntre(i,j))/nbPixels);
    end
end

imSor=uint8(imSor);

end
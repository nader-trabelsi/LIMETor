function [ imageFlippee ] = myFlip( imgEntree,Dim ) 
%--------------------------------------------------------------
%-------------------- © Nader Trabelsi ------------------------
%--------------------------------------------------------------

% Cette fonction effectue une opération de Flip de 'imgEntree' selon la
% dimension 'Dim'

if Dim==1
    
    nbLig=size(imgEntree,1);
    
    if size(imgEntree,3)==3
        
        % Initialisation des composantes :
        rComp=zeros(size(imgEntree,1),size(imgEntree,2));
        vComp=zeros(size(imgEntree,1),size(imgEntree,2));
        bComp=zeros(size(imgEntree,1),size(imgEntree,2));
        
        
        
        
        for i=1:3
            if rem(nbLig,2)==0
                for j=1:nbLig
                    if(i==1)
                        rComp(j,:)=imgEntree(nbLig-j+1,:,i);
                    elseif i==2
                        vComp(j,:)=imgEntree(nbLig-j+1,:,i);
                    else
                        bComp(j,:)=imgEntree(nbLig-j+1,:,i);
                    end
                end
            else
                ligIntouch=round(nbLig/2);
                
                for j=1:nbLig
                    if j==ligIntouch
                        if(i==1)
                            rComp(ligIntouch,:)=imgEntree(ligIntouch,:,i);
                        elseif i==2
                            vComp(ligIntouch,:)=imgEntree(ligIntouch,:,i);
                        else
                            bComp(ligIntouch,:)=imgEntree(ligIntouch,:,i);
                        end
                    else
                        if(i==1)
                            rComp(j,:)=imgEntree(nbLig-j+1,:,i);
                        elseif i==2
                            vComp(j,:)=imgEntree(nbLig-j+1,:,i);
                        else
                            bComp(j,:)=imgEntree(nbLig-j+1,:,i);
                        end
                    end
                end
                
            end
        end
        imageFlippee = uint8(cat(3, rComp, vComp, bComp));
    else
        if rem(nbLig,2)==0
            for j=1:nbLig
                    imageFlippee(j,:)=imgEntree(nbLig-j+1,:);
            end
        else
            ligIntouch=round(nbLig/2);
            
            for j=1:nbLig
                if j==ligIntouch
                        imageFlippee(ligIntouch,:)=imgEntree(ligIntouch,:);
                else
                        imageFlippee(j,:)=imgEntree(nbLig-j+1,:);
                end
            end
            
        end
        
        imageFlippee=uint8(imageFlippee);
        
    end
elseif Dim==2
    
    nbCol=size(imgEntree,2);
    
    if size(imgEntree,3)==3
        
        % Initialisation des composantes :
        rComp=zeros(size(imgEntree,1),size(imgEntree,2));
        vComp=zeros(size(imgEntree,1),size(imgEntree,2));
        bComp=zeros(size(imgEntree,1),size(imgEntree,2));
        
        
        
        
        for i=1:3
            if rem(nbCol,2)==0
                for j=1:nbCol
                    if(i==1)
                        rComp(:,j)=imgEntree(:,nbCol-j+1,i);
                    elseif i==2
                        vComp(:,j)=imgEntree(:,nbCol-j+1,i);
                    else
                        bComp(:,j)=imgEntree(:,nbCol-j+1,i);
                    end
                end
            else
                colIntouch=round(nbCol/2);
                
                for j=1:nbCol
                    if j==colIntouch
                        if(i==1)
                            rComp(:,colIntouch)=imgEntree(:,colIntouch,i);
                        elseif i==2
                            vComp(:,colIntouch)=imgEntree(:,colIntouch,i);
                        else
                            bComp(:,colIntouch)=imgEntree(:,colIntouch,i);
                        end
                    else
                        if(i==1)
                            rComp(:,j)=imgEntree(:,nbCol-j+1,i);
                        elseif i==2
                            vComp(:,j)=imgEntree(:,nbCol-j+1,i);
                        else
                            bComp(:,j)=imgEntree(:,nbCol-j+1,i);
                        end
                    end
                end
                
            end
        end
        imageFlippee = uint8(cat(3, rComp, vComp, bComp));
    else
        if rem(nbCol,2)==0
            for j=1:nbCol
                    imageFlippee(:,j)=imgEntree(:,nbCol-j+1);
            end
        else
            colIntouch=round(nbCol/2);
            
            for j=1:nbCol
                if j==colIntouch
                        imageFlippee(:,colIntouch)=imgEntree(:,colIntouch);
                else
                        imageFlippee(:,j)=imgEntree(:,nbCol-j+1);
                end
            end
            
        end
        
        imageFlippee=uint8(imageFlippee);
        
    end
    
end


end
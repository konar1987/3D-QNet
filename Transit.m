function [Z, W]= Transit(V,ht,wt,dt,lamda)   % I is a input matrix, Ht is height of a matrix , wt is width of a matrixand q0 is lamda

    B=cardinality(V,ht,wt,dt);
   
    A=(pi*2)*B;
    
    alphas = 0;
    
    % Create Padding on all sides
    V_paded = padarray(V,[1 1 1],0,'both');

    %cluster =[0 0.25 0.75 1]; % Set 1 for cluaster 4
    %cluster =[0 0.25 0.50 1];  % Set 2 for cluaster 4
    %cluster =[0 0.50 0.75 1];  % Set 3 for cluaster 4
    %cluster =[0 0.33 0.66 1];  % Set 4 for cluaster 4

    %cluster =[0 0.20 0.40 0.60 0.80 1]; % Set 1 for cluaster 6
    %cluster =[0 0.15 0.35 0.55 0.75 1]; % Set 2 for cluaster 6
    %cluster =[0 0.20 0.35 0.50 0.65 1]; % Set 3 for cluaster 6
    %cluster =[0 0.10 0.20 0.80 0.90 1]; % Set 4 for cluaster 0,0.164706,0.243137,0.321569,0.443137,0.827451,16

    %cluster =[0 0.25 0.45 0.65 0.80 0.95 1]; % Set 1 for cluaster 7
    %cluster =[0 0.15 0.35 0.55 0.75 0. 90 1]; % Set 1 for cluaster 7
    %cluster =[0 0.20 0.40 0.60 0.80 0.95 1]; % Set 1 for cluaster 7
    %cluster =[0 0.30 0.45 0.60 0.75 0.95 1]; % Set 1 for cluaster 7

    %cluster =[0 0.15 0.29 0.43 0.57 0.71 0.85 1]; % Set 1 for cluaster 8
    %cluster =[0 0.16 0.30 0.44 0.58 0.72 0.86 1]; % Set 2 for cluaster 8
    %cluster =[0 0.15 0.30 0.45 0.60 0.75 0.90 1]; % Set 3 for cluaster 8
    %cluster =[0 0.16 0.31 0.46 0.61 0.76 0.91 1]; % Set 3 for c1uaster 8

    %cluster =[0 0.17 0.34 0.51 0.68 0.85 0.95 1]; % Set 5 for cluaster 8
     cluster =[0 0.16 0.32 0.48 0.64 0.80 0.96 1]; % Set 1 for cluaster 8
    %cluster =[0 0.14 0.28 0.42 0.56 0.70 0.90 1]; % Set 2 for cluaster 8
    %cluster =[0 0.13 0.26 0.39 0.52 0.75 0.91 1]; % Set 3 for cluaster 8
    %cluster =[0 0.18 0.36 0.54 0.72 0.90 0.97 1]; % Set 4 for cluaster 8

    cluster=(pi/2)*cluster;
    d= size(cluster,2); % size of cluster
    Z=zeros(ht,wt,dt);
    W=zeros(ht,wt,dt);

% -------------------------------------------------------------------------
    
    
for a=1:ht
    for b=1:wt
        for c=1:dt
            sum=0.00;

            % Alpha calculation
            for i=1:d-1
                if (V(a,b,c)>=cluster(i)) && (V(a,b,c)<=cluster (i+1))
                    alphas =double(B(a,b,c)/(cluster(i+1)-cluster(i))); 
                    break;
                end
            end

            % Volume Traversal
            for p=1:3
                for q=1:3
                    for r=1:3
                        
                        W(a,b,c)=double(pi*2)*(pi/2 - (V_paded((p+a-1),(q+b-1),(r+c-1)) - V(a,b,c)));
                        
                        z=(V_paded((p+a-1),(q+b-1),(r+c-1))) * cos(W(a,b,c) - A(a,b,c));             
                        y= 1/(alphas+exp(-(lamda)*(double(z)-B(a,b,c))));    

                        sum=sum+y;  
                    end
                end
            end
            Z(a,b,c)=sum;
        end
    end
end

end

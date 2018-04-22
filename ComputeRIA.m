function [ RIA ] = ComputeRIA( D )

      feat_num = size(D,2);
      RIA = zeros(feat_num, feat_num);
      for  i = 1 : feat_num
             for  j = 1 : feat_num
                   RIA(i,j) = ComputePearsonCorr(D(:,i), D(:,j));
             end
      end
      
end


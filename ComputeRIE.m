function [ RIE ] = ComputeRIE( D1, D2 )

      feat_num1 = size(D1,2);
      feat_num2 = size(D2,2);
      RIE = zeros(feat_num1, feat_num2);
      for i = 1 : feat_num1
          for j = 1 : feat_num2
               RIE(i,j) = ComputePearsonCorr(D1(:,i), D2(:,j));
          end
      end

end


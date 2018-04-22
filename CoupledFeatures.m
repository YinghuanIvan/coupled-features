function [ MCF ] = CoupledFeatures( M, expand_num )

      [num_sample, num_feature] = size(M);
      
      % matrix expansion
      ME = zeros(num_sample, num_feature*expand_num);
      
      for i = 1 : num_feature
          temp_feature = M(:,i);
          for j = 1 : expand_num
               pivot = (i-1)*expand_num + j;
               ME(:,pivot) = temp_feature.^j;
          end
      end
      
      MCF = [];
      
      w = zeros(1,expand_num);
      for i = 1 : expand_num
            w(i) = 1/factorial(i);
      end
      W_array = [];
      for i = 1 : num_feature-1
           W_array = [W_array, w];
      end
      
      % computing the intra- and inter- coupling
      for index = 1 : num_feature
           % for the current feature
           st_index = (index-1)*expand_num+1;
           ed_index = index*expand_num;           
           D1 = ME(:,st_index:ed_index);
           if st_index == 1
              D2 = ME(:,ed_index+1:num_feature*expand_num);
           elseif ed_index == num_feature*expand_num
               D2 = ME(:,1:st_index-1);
           else
                  D2 = [ME(:,1:st_index-1),ME(:,ed_index+1:num_feature*expand_num)];
           end
           RIA = ComputeRIA(D1);
           RIE = ComputeRIE(D1,D2);
           for i = 1 : num_sample
                 D1(i,:) = D1(i,:).*w;
                 D2(i,:) = D2(i,:).*W_array;
           end
           tmp_CF = D1*RIA'+D2*RIE';
           fprintf('%d/%d Features\n', index, num_feature);
           MCF = [MCF, tmp_CF];
      end

end


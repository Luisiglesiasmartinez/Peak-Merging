%% Script to Merge Peaks

%% Read File Into a Cell Array

UniPks = cell(24,1);

Success = cell(24,1);

fileID = fopen('8.narrowPeak');


f = fgets(fileID);

Total_Peaks = 0;
while ischar(f) 
Lines = strread(f,'%s');
Total_Peaks = Total_Peaks +1 ;

Results =[ str2double(Lines(2)) str2double(Lines(3)) str2double(Lines(2))+str2double(Lines(10))];

%% Build Hash Map

Chr = Lines(1);

if (Chr{1}(4)~= 'X' && Chr{1}(4) ~= 'Y')

Index = str2double(Chr{1}(4:end));

if (size(UniPks{Index,1},1)>0)

    UniPks{Index,1} = [UniPks{Index,1};Results, 1];
    
else
    
    UniPks{Index,1} = [Results, 1];

    
end

elseif (Chr{1}(4) == 'X')
    
    Index = 23;
    
if (size(UniPks{Index,1},1)>0)
UniPks{Index,1} = [UniPks{Index,1};Results, 1];

else
    
    UniPks{Index,1} = [Results, 1];

    
end
else  
    
    Index = 24;
    
if (size(UniPks{Index,1},1)>0)
UniPks{Index,1} = [UniPks{Index,1};Results, 1];

else
    
    UniPks{Index,1} = [Results, 1];

    
end
end

f = fgets(fileID);

end
    %% Variable to store the number of times we find the same peak!
    
Success = 0;

 
for i = 9:98
    
    %% File number!
    
    disp(i);
   
s = num2str(i);
ending = '.narrowPeak';

file = strcat(s,ending);

    fileID = fopen(file);


f = fgets(fileID);

while ischar(f) 
Lines = strread(f,'%s');

Total_Peaks = Total_Peaks +1;
Results =[ str2double(Lines(2)) str2double(Lines(3)) str2double(Lines(2))+str2double(Lines(10))];

%% Build Hash Map

Chr = Lines(1);

if (Chr{1}(4)~= 'X' && Chr{1}(4) ~= 'Y')

Index = str2double(Chr{1}(4:end));

if (size(UniPks{Index,1},1)>0)
     
    F1 = find((UniPks{Index,1}(:,1)<Results(3)));
    F2 = find((UniPks{Index,1}(:,2)>Results(3)));
 V = F1(ismember(F1,F2 ));
 
    if length(V)>1
        % Find closer peak
         Success = Success + 1;
       [m,ind] = min(abs(Results(3)-UniPks{Index,1}(V,3)));
        
       UniPks{Index,1}(V(ind),:) = [(Results+ UniPks{Index,1}(V(ind),1:3))/2, UniPks{Index,1}(V(ind),4)+1];
    elseif length(V) == 1
        Success = Success + 1;
        UniPks{Index,1}(V,:) = [(Results+ UniPks{Index,1}(V,1:3))/2, UniPks{Index,1}(V,4)+1];
        
    
    
    else
UniPks{Index,1} = [UniPks{Index,1};Results, 1];
    end
else
    
    % Find Peaks that are within the range 
    
   
        UniPks{Index,1} = [Results, 1];
    
    
end

elseif (Chr{1}(4) == 'X')
    
    Index = 23;
    
if (size(UniPks{Index,1},1)>0)
  F1 = find((UniPks{Index,1}(:,1)<Results(3)));
    F2 = find((UniPks{Index,1}(:,2)>Results(3)));
 V = F1(ismember(F1,F2 ));
 
    if length(V)>1
        % Find closer peak
         Success = Success +1;
       [m,ind] = min(abs(Results(3)-UniPks{Index,1}(V,3)));
        
       UniPks{Index,1}(V(ind),:) = [(Results+ UniPks{Index,1}(V(ind),1:3))/2, UniPks{Index,1}(V(ind),4)+1];
    elseif length(V) == 1
     UniPks{Index,1}(V,:) = [(Results+ UniPks{Index,1}(V,1:3))/2, UniPks{Index,1}(V,4)+1];
         Success = Success + 1;
    
    else
UniPks{Index,1} = [UniPks{Index,1};Results, 1];
    end
else
    
    UniPks{Index,1} = [Results, 1];

    
end
else  
    
    Index = 24;
    
if (size(UniPks{Index,1},1)>0)
    
    F1 = find((UniPks{Index,1}(:,1)<Results(3)));
    F2 = find((UniPks{Index,1}(:,2)>Results(3)));
 V = F1(ismember(F1,F2 ));
 
    
   if length(V)>1
        % Find closer peak
          Success = Success + 1;
       [m,ind] = min(abs(Results(3)-UniPks{Index,1}(V,3)));
        
       UniPks{Index,1}(V(ind),:) = [(Results+ UniPks{Index,1}(V(ind),1:3))/2, UniPks{Index,1}(V(ind),4)+1];
    elseif length(V) == 1
        UniPks{Index,1}(V,:) = [(Results+ UniPks{Index,1}(V,1:3))/2, UniPks{Index,1}(V,4)+1];
         
     Success = Success + 1;
    else
UniPks{Index,1} = [UniPks{Index,1};Results, 1];
    end
else
    
    UniPks{Index,1} = [Results, 1];

    
end
end

f = fgets(fileID);

end
    
    
    
    
    
end
    
    
    
    
    


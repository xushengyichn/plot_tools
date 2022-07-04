%%

clc
clear all
close all



MainDir='C:\Cloud\OD_OWP\Work\Matlab\Github\plot_tools\'

SubDir={'plot_time_freq' 'utils' };

FuncListAll={};
for k=1:length(SubDir)
    
    
    Files{k}=listFiles('dir',[MainDir '\' SubDir{k}],'name','.m')
    k
    for m=1:length(Files{k})
        
        if Files{k}{m}(1)=='_'; continue; end
        
        FuncListTemp=listFunctions(Files{k}{m});
        
        FuncListAll=mergecell(FuncListAll,FuncListTemp).'
    end
    
end
    
%%



FuncListAll=unique(FuncListAll).'
    
    
    
%     listFunctions(

% subdir={};
% for k=1:length(content)
%     
%     if content(k).isdir==true
%         subdir{end+1}= content(k).name;
%     end
% end

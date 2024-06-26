function axislabelmulti(h_handle,label_cell,axislabel_number,delete_ticks,x_or_y,interpreter)

%% Add axis label to multiple subfigures
%
% Inputs:
% h_handle: handle to figure or axes
% label_cell: e.g. 'Time [s]' or {'Time 1' 'Time 2' 'Time 3'}
% axislabel_number: axes number or string, 'bottom' or 'bottom2' etc
% delete_ticks: true/false, delete ticks of axes without labels
% x_or_y: 'x' or 'y'
% interpreter: interpreter for label, e.g. 'latex'
%
% Outputs:
%
%% Default inputs

if nargin<6
    interpreter='';
end

if nargin<5 | isempty(x_or_y)
    x_or_y='x';
end

if nargin<4
    delete_ticks=false;
end

%%

% Find axes handles
if isempty(h_handle)
    hax=gethandle(gcf);
else
    hax=gethandle(h_handle);
end

% If label for bottom row
if ischar(axislabel_number)
    if strcmpi(axislabel_number,'bottom') 
        axislabel_number=length(hax);

        % Find centered position of all axes (vertical coordinate)
        for k=1:length(hax)
            pos_tmp=get(hax(k),'Position');
            pos_all(k)=pos_tmp(2)+pos_tmp(4)/2;
        end

        % Find all within 0.05 of the minimum
        pos_min=min(pos_all);
        axislabel_number=find(abs(pos_all-pos_min)<0.05);

    elseif strcmpi(axislabel_number,'bottom1')
        axislabel_number=length(hax)+[0];
    elseif strcmpi(axislabel_number,'bottom2')
        axislabel_number=length(hax)+[-1 0];
    elseif strcmpi(axislabel_number,'bottom3')
        axislabel_number=length(hax)+[-2 -1 0];
    elseif strcmpi(axislabel_number,'bottom4')
        axislabel_number=length(hax)+[-3 -2 -1 0];
    elseif strcmpi(axislabel_number,'bottom5')
        axislabel_number=length(hax)+[-4 -3 -2 -1 0];
    elseif strcmpi(axislabel_number,'bottom6')
        axislabel_number=length(hax)+[-5 -4 -3 -2 -1 0];
    end
end

% If no axes number given, apply to all
if isempty(axislabel_number)
    axislabel_number=1:length(hax);
end

if ~iscell(label_cell)
    label_cell={label_cell};
end

% Create cell with labels
if length(label_cell)==1
    label_cell=repcell(label_cell,1,length(hax));
elseif length(label_cell)==length(axislabel_number)
    xlabel0=label_cell;
    label_cell=repcell('',1,length(h_handle));
    
    no=0;
    for k=axislabel_number
        no=no+1;
        label_cell{k}=xlabel0{no};
    end
end

%% Set labels

if strcmpi(x_or_y,'x')
    labelname='XLabel'; 
    tickname='XTick'; 
    ticklabelname='XTickLabel'; 
elseif strcmpi(x_or_y,'y')
    labelname='YLabel'; 
    tickname='YTick'; 
    ticklabelname='YTickLabel';     
end

for j=1:length(hax)
    
        if ~any(j==axislabel_number)
            set(get(hax(j),labelname),'String','');
            if delete_ticks
                current_ticks=get(hax(j),tickname);
                set(hax(j),ticklabelname,repcell('',1,length(current_ticks)));
            end
        else
            set(get(hax(j),labelname),'String',label_cell{j});
            
            if ~isempty(interpreter)
                set(get(hax(j),labelname),'Interpreter',interpreter);
            end
            
        end
        
end
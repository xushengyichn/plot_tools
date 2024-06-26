function ha=plotfreq(varargin)

%% Input handling

% Separate into numeric and varargin
[data_cell,parameter_struct_in]=separatedataparameter(varargin{:});

% Separate x and y data
[x,y,nSignals,nSources]=separatexy(data_cell);

%% Default parameters

parameter_struct_default=struct();

parameter_struct_default.xlabel=repcell('Frequency [Hz]',1,nSignals);
parameter_struct_default.xlim=[0 3];

parameter_struct=mergestruct(parameter_struct_default,parameter_struct_in);

%% Plot

for k=1:length(x)
    dt=diff(x{k}(1:2));
    [x_freq{k},y_freq{k}]=fft_function(y{k},dt,2);
    
    % Delete negative part
    ind_del=x_freq{k}<0;
    x_freq{k}(ind_del)=[];
    y_freq{k}(:,ind_del)=[];
    
    y_freq{k}=abs(y_freq{k});

    if isfield(parameter_struct,'unit') & strcmpi(parameter_struct.unit,'rad/s')
        x_freq{k}=x_freq{k}*2*pi;
    end
end

[ha hp]=plot_main(x_freq,y_freq,parameter_struct);



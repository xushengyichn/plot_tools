function A=stackVertical(varargin)

%% Function to stack matrices horizontally
% Matrix sizes must be equally wide

% Examples: 
% A=randn(3,3);
% B=randn(1,3);
% C=stackHorizontal(A,B)

% D{1}=randn(3,3);
% D{2}=randn(1,3);
% C=stackHorizontal(D)

%%

if nargin==1 & isempty(varargin{1})
    A=[]; return
end

if iscell(varargin{1});
    stackCells=varargin{1};
else
    stackCells=varargin;
end

for k=1:length(stackCells)
    [s1(k),s2(k)]=size(stackCells{k});
    s_sparse(k)=issparse(stackCells{k});
end

indEmpty=find(all([s1;s2]==0,1));

stackCells(indEmpty)=[];
s1(indEmpty)=[];
s2(indEmpty)=[];

if isempty(stackCells)
    A=[]; return
end
if any(s2(1)~=s2);
    error('Matrix size');
end

if all(s_sparse)
    A=sparse(sum(s1),s2(1));
else
    A=zeros(sum(s1),s2(1));
end

for k=1:length(stackCells)
%     if any(k==indEmpty); continue; end
    range=sum(s1(1:(k-1)))+[1:s1(k)];
    A(range,:)=stackCells{k};
end

% return
%%
% A=stackCells{1};
% Bcell=stackCells(2:end);
% 
% for k=1:length(Bcell)
%     B=Bcell{k};
%     
%     range=stackRange(A,B,'vertical');
%     A(range,:)=B;
% end
function approxequal(x,y,e)
%check if the length match
if length(x) ~= length(y)
    disp ('The langth of the two vectors do not match.');
    return
end
%check if e id proper
if e < 0
    disp('e is supposed to be not smaller than 0.');
    return
end

%do the function
t = 1;
for i = 1:length(x)
    %disp(abs(x(i)-y(i)));
    if abs(x(i)-y(i)) > e
        t = 0;
    end
end
disp(t); %return 1 if it is true
end


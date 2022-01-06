function sum = addprimes(s, e)
%check if e>=s
if e < s
    disp('s is supposed to be smaller than e.');
    return
end

%check if e and s >= 0
if e < 0 || s<0
    disp('e and s should be not smaller than 0.');
    return
end


%do the function
sum = 0;
for i = s:1:e
    if isprime(i) % 检查i是否为素数
        sum = sum + i;
    end
end  
end


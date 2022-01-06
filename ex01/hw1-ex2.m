clear
%(a) define A and b, then solve Ax=b for x
A = [2,2,0;0,8,3]

A =

     2     2     0
     0     8     3

b = [5;15]

b =

     5
    15

%(b) Define a matrix B equal to A.
B = A

B =

     2     2     0
     0     8     3

%(c) Change the second element in the first row of A to 4.
A(1,2) = 4

A =

     2     4     0
     0     8     3

%(d)Compute the following
c = 0;
for i = -4:4:4 %from -4 to 4, step is 4
c = c + i * transpose(A)* b
end

c =

   -40
  -560
  -180


c =

   -40
  -560
  -180


c =

     0
     0
     0

%(e)Compare A .* B and A’ * B and explain the difference
% .*相当于每个元素分别相乘
A .* B

ans =

     4     8     0
     0    64     9

% A' 在此处相当于转置（若有复数元素要求共轭)
A

A =

     2     4     0
     0     8     3

A'

ans =

     2     0
     4     8
     0     3

A' * B

ans =

     4     4     0
     8    72    24
     0    24     9

diary off

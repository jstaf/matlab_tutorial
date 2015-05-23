%% MATLAB tutorial
% Jeff Stafford

% comments (beginning with '%') are not run

% normal math
1 + 1
2 - 1
4 * 3
12 / 2

% order of operations is respected
3 + 4 / 2
% parentheses changes order stuff is done in, use them defensively
(3 + 4) / 2
3 + (4 / 2)

% variables 
a = 1
a
a * 2
b = 3
a + b

% semicolons suppress output and act as a line break
5;
c = a + b; % notice how now output is produced
c
c = 2 * c;
c

%% strings

% you can store ANYTHING as a variable (anything!)
% one type of variable that gets used a lot are strings

% a 'string' is a string of characters (like words and sentences)
'this is a string'

a = 'this is a string';
a

% NOTE: don't do math on strings or things that math won't work with unless
% you want to be confused
'6' + 4

%% vectors, matrices, and arrays

% a vector is a 1-dimensional collection of elements
a = [1, 2, 3, 4, 5];
a

% you can do all of the same math that you would normally do to normal
% numbers
a + 10
% notice how everything is added element-wise
b = [9, 8, 7, 6, 5];
a + b
% what happens when the dimensions don't match?
a + [2, 4]

% a matrix is a 2-dimensional collection of numbers
a = [1, 2, 3, 4, 5;
    6, 7, 8, 9, 10];
a
% all the same rules of vectors apply to matrices (in MATLAB, vectors are
% actually just 1-dimensional matrices!)
a + 1
a + a

% concatenating things
% The square brackets '[]' concatenate (read: combine) things

a = [1, 3, 4, 5, 6]
% horizontally concatenate
[a, a] 
% vertically concatenate
[a; a]
% things need to be the same dimensions (in the dimension you are
% concatenating) to be combined
vector2 = [13, 553, 44];
% this works
[a, vector2]
% this doesn't
[a; vector2]

% strings are just concatenated when you try to make a matrix of them
c = ['this', 'is', 'weird'];

% matrices can be any dimension (3+ dimensional matrices are usually
% called arrays)

dimensional(:, :, 1) = [1, 4, 5; 5, 8, 97];
dimensional(:, :, 2) = [4, 5, 6; 9, 7, 5];
% this array is 3x2x2
dimensional

%% indexing

% what if we wanted to get a certain value from a matrix or vector?

% b is a 1D matrix
b
b(1) % grab first element
b(2) % grab second element
b(end) % grab last element

% you even can do math inside the parentheses
b(1 + 1)

% create a sequence of numbers with the ':'
% syntax = start:end
1:4
% to create a sequence of numbers by increments
% syntax = start:increment:end
1:2:10 

% this is REALLY useful for indexing
% get elements 1-4
b(1:4)
% get every other element all the way to the end
b(1:2:end)
% get ALL the elements!
b(:)
% this is the same as:
b(1:end)

% we can use the same tricks for 2D matrices too!
a
a(1, 1) % grab top-left element

% let's firgure out which number corresponds to which element
a(2, 1)
a(1, 2)

% so from our little experiment, you grab rows THEN columns
% to grab an entire row
a(2, :) 
% grab an entire column
a(:, 4)
% grab elements 1:3 of the second row
a(2, 1:3)

%% functions (how to actually start doing things)

% functions are special operations that DO things (vague, I know, but they
% are all different and special)

% what is the general syntax of using functions?
% ans = functionName(argument1)

% the simplest function is disp
disp('This prints a string to the console');

% example:
% lets test that assumption that vectors are 1D matrices
size(b)
% b's dimensions are 1x5

% functions can have multiple arguments like this:
% ans = functionName(arg1, arg2)

% size has an optional argument: dimension
% return the size of dimension 2
size(b, 2)

% here's another function: isempty()
% isempty() returns whether or not a matrix has no elements:
% - 1 if it's empty
% - 0 if it has stuff in it

[] % this creates an empty vector
isempty([])
a % a is not empty
isempty(a)

% how do you know how to use a function? they're all different! and have
% different arguments!
% let's look at the documentation!
doc isempty
% you can also hit f1 when your mouse is on a function

%% boolean operators

% Control statements are the key to any program that is able to do things
% and interpret data intelligently. They revolve around the whole concept
% of true or false.

% These are boolean values
true
false

% You can make comparisons using comparison operators
% '==' is equal to
true == true
% notice that true is equivalent to 1 and false == 0
true == 1
false == 0

% '~' means NOT
~true
~true == false

% '~=' not equal to
true ~= true
true ~= false

% these work on anything
5 == 2 + 3
5 ~= 4
% dont compare objects of different types, it gets weird
5 == '5'
'cheesecake' == 1
% use strcmp() to compare strings
strcmp('llama', 'llama')
strcmp('llama', 'sheep')

% you can convert objects with some functions
5 == str2num('5')
5 == str2num('five')

% note that functions can be nested inside each other
strcmp(num2str(5), '5')

% You can also make standard numerical comparisons like '>='
5 >= 3
5 > 5
4 < 3
4 <= 10

% Linear indexing just takes elements in the order they appear (treating a
% any matrix as a 1D vector)
a = [1, 6, 8, 11, 53; 65 32, 23.4, 4, 3];
a(2:7)
% You can be clever and use this to your advantage.
lessThan = a < 10;
a(lessThan)
% or simply
a(a < 10)

%% control statements

% Control statements let a program decide what code to execute. Very
% powerful!

% if executes something if its conditions are met (use parentheses
% defensively!)
% usage:
% if (condition)
%   do something
% end

% conditions met- displays something
if (4 < 100)
    disp('if conditions met');
end

% conditions not met- displays nothing
if (4 > 100)
    disp('if conditions met');
end

% else gets executed otherwise if 'if' conditions are not met
if (4 > 100)
    disp('if conditions met');
else 
    disp('executing the else statement');
end

% elseif - test multiple conditions
a = 3;
if (a < 3)
    disp('a is less than 3');
elseif (a == 3)
    disp('a is equal to three');
else
    disp('a is greater than 3');
end

%% loops

% for loops iterate over a set of variables that you specify. REALLY
% POWERFUL

% for i equal to 1 thru 5
for i = 1:5
    % print 10 - i
    disp(10 - i);
end

% while loops are also useful. While a condition is true, they continue to
% loop. 

% DON'T get stuck in an endless loop
% this would be a bad idea:
% while (true)
%     % do something FOREVERRRRR
% end

% IMPORTANT
% You can break a loop/other operation by pressing ctrl+c in the console

a = -4;
while (a < 5)
    a = a + 2;
    disp(a);
end


/* Homework Assignment 2
   Programming Languages
   CS471, Spring 2016
   Binghamton University */

/* <h1>Instructions</h1> */

/* This section deals with general submission instructions. First, grab this assignments <a href="hw4.asn">template source file</a>. BEFORE MOVING ON RENAME hw4.asn to hw4.pl. You will be able to code in and run the file in the prolog interpreter directly. I recommend reading this assignment directly from the source file.

We will be using swipl for our prolog environment: To load/reload this file, cd to its directory and run swipl. Then, in the prompt, type [hw4].

cd PATH_TO_FILE
swipl
[hw4].

From then on you may execute queries (goals) in the prompt. As usual, you should provide your answers in the designated spot. Once you have added some code to the file, rerun [hw4]. in the swipl prompt to reload.

In addition, there are unit tests for each problem. These are there to help you better understand what the question asks for, as well as check your code. They are included in our "database" as queries and are initially commented out -- % is a Prolog line comment.

%:- member_times(4,[3,3,2,3],0). % SUCCEED
%:- member_times(4,[1,2,3],3).   % FAIL

After you have finished a problem and are ready to test, remove the initial % for each test for the associated problem and reload the assignment file ([hw4].). Each SUCCEED line should silently load and succeed, and each FAIL line should throw a WARNING. If a SUCCEED line throws a WARNING, or a FAIL line fails to, then you solution is not correct. If you pass the tests there is a good chance that your code is correct, but not guaranteed; the tests are meant as guided feedback and are not a check for 100% correctness. */

/* <h1>Submission</h1> */

/* For this assignment -- and the remaining Prolog assignments -- you must submit only the source (template) file. There is no need to tar anything as all coding should be done directly in hw4.pl. */

/* <h1>Homework 4</h1> */

/* Due: Wednesday, 2/24 at 11:59 PM */

/* Purpose: To get comfortable with backtracking, and using Prolog to gather all solutions for a predicate. */

my_append([],Ys,Ys).
my_append([X|Xs],Ys,[X|Zs]) :- my_append(Xs,Ys,Zs).

my_prefix(_,[]).
my_prefix([X|Xs], [X|Ys]) :- my_prefix(Xs,Ys).
/* <h3>Problem 0A (NOT GRADED):</h3>
Using the preceding predicates, draw the execution trees for the following queries (goals). You should also enter the queries in swipl to test.

my_append([a,b],[c],Z).
my_append(Xs,[c],[a,b,c]).
my_append(Xs,Ys,[a,b,c]).
my_prefix([a,b,c],Z).

After drawing the execution trees, enable tracking on my_append and my_prefix by running (two separate queries)

trace(my_append).
trace(my_prefix).

in swipl. Now, execute the above queries and try and match what you drew to the way the actual query is executed in swipl. */

my_member(X,[X|_]).
my_member(X,[_|Ys]) :- my_member(X,Ys).

/* <h3>Problem 1:</h3>
We discussed the predicate findall/3 in class: findall(Object,Goal,List) will attempt to solve Goal and save all solutions that Object is unified too. For example, the query findall(X,my_member(X,[1,2,1]),Y) will solve my_member(X,[1,2,1]) for ALL solutions and store each unified X in a list Y.

Execute the following queries in swipl to gain a better understanding of backtracking. Respond to each resolution with a semicolon to tell prolog to continue searching for solutions.

my_member(X,[1,2,1]).
my_member(1,[1,2,1]).
findall(X,my_member(X,[1,2,1]),Y).
my_append(Xs,Ys,[1,2,3,4]).
findall(Ys,my_append(Xs,Ys,[1,2,3,4]),Z).

Now, using the predicate my_prefix above and findall, write a predicate all_prefix(X,Y) which succeeds if Y is a list containing all the prefixes of X. */

/* <h3>Problem 1 Answer:</h3> */

all_prefix(X,Y):-
  findall(Z, my_prefix(X,Z), Y).


/* <h3>Problem 1 Test:</h3> */
%:- all_prefix([1,2,3],[[],[1],[1,2],[1,2,3]]).  % SUCCEED
%:- all_prefix([a],[[],[a]]).                    % SUCCEED

%:- all_prefix([a,b],[[a]]).                     % FAIL

/* <h3>Problem 2</h3>
Write a predicate permutation(N,X,Y) that succeeds if Y is a sublist of X of length N.

For example, the following is an entire execution of permutation(2,[a,b,c],Z):
Z = [a, b] ;
Z = [a, c] ;
Z = [b, a] ;
Z = [b, c] ;
Z = [c, a] ;
Z = [c, b] ;
false.

Hint: You should use the select/3 predicate, and let Prolog handle the backtracking. State what you know is true and let Prolog handle the rest. */

/* <h3>Problem 2 Answer:</h3> */
permutation(0,X,[]).
permutation(0, X, Y):-
  fail.
permutation(N,X,[]):-
  fail.
permutation(N, X, [Y|Ys]):-
  Z is N -1, select(Y, X, R), permutation(Z, R, Ys).


/* <h3>Problem 2 Test:</h3> */
%:- permutation(0,[a,b,c,d,e],[]).         %SUCCEED
%:- permutation(1,[a,b,c,d,e],[a]).        %SUCCEED
%:- permutation(1,[a,b,c,d,e],X), X = [a]. %SUCCEED
%:- permutation(1,[a,b,c,d,e],[c]).        %SUCCEED
%:- permutation(3,[a,b,c,d,e],[a,b,c]).    %SUCCEED
%:- permutation(3,[a,b,c,d,e],[b,c,a]).    %SUCCEED
%:- permutation(3,[a,b,c,d,e],[e,c,a]).    %SUCCEED
%:- permutation(4,[a,b,c,d,e],[e,c,a,b]).  %SUCCEED
%:- permutation(4,[a,b,c,d,e],X), X = [e,c,a,b].  %SUCCEED

%:- permutation(2,[a,b,c,d,e],[a,b,c]).    %FAIL
%:- permutation(3,[a,b,c,d,e],[b,c,f]).    %FAIL

/* <h3>Problem 3</h3>
Using your permutation/3 predicate, write a predicate all_permutations_of(N,X,Y) that succeeds if Y is a list containing all permutations of X of length N. */

/* <h3>Problem 3 Answer:</h3> */

all_permutations_of(N,X,Y):-
  findall(Z, permutation(N,X,Z), Y).


/* <h3>Problem 3 Test</h3> */
%:- all_permutations_of(2,[a,b,c],[[a, b], [a, c], [b, a], [b, c], [c, a], [c, b]]).                    %SUCCEED
%:- all_permutations_of(1,[a,b,c],[[a],[b],[c]]).                                                       %SUCCEED
%:- all_permutations_of(3,[a,b,c],[[a, b, c], [a, c, b], [b, a, c], [b, c, a], [c, a, b], [c, b, a]]).  %SUCCEED

%:- all_permutations_of(2,[a,b,c,d],[[a, b], [a, c], [b, a], [b, c], [c, a], [c, b]]).                  %FAIL

/* <h3>Problem 4</h3>
Now, write a predicate all_permutations(X,Y) that succeeds if Y is a list containing ALL permutations of the list X.

NOTE: You may use the builtins length/2 and append/3. The test queries may fail if you have defined your version of all_permutations differently that I have defined mine -- i.e. the order in which the permutations appear in the list differs. The queries are provided as is for reference. */

/* <h3>Problem 4 Answer:</h3> */

all_permutations(X,Y):-
  findall(Z, permutation(Q,X,Z), Y).


/* <h3>Problem 4 Test:</h3> */
%:- all_permutations([a,b],[[],[a],[b],[a,b],[b,a]]). %SUCCEED
%:- all_permutations([a,b,c],[[], [a], [b], [c], [a, b], [a, c], [b, a], [b, c], [c, a], [c, b], [a, b, c], [a, c, b], [b, a, c], [b, c, a], [c, a, b], [c, b, a]]). % SUCEED

%:- all_permutations([a,b],[[],[a],[b],[a,b],[b]]). %FAIL

/* <h3>Problem 5</h3>
We will use a predicate edge(X,Y) to encode a graph -- just like we did in class. edge(X,Y) is true if there is a directed edge from X to Y. The following is a mini graph encoded in Prolog. */
edge(a,b).
edge(a,e).
edge(a,c).
edge(b,a).
edge(b,c).
edge(b,d).
edge(c,e).
edge(f,e).

/* Using your knowledge of backtracking and the findall predicate, write predicates outgoing/2 and incoming/2.

outgoing(X,Y) should succeed if Y is a list of all immediate vertices reached from Xs outgoing edges. incoming(X,Y) should succeed if Y is a list of all vertices that have outgoing edges to X.  */

/* <h3>Problem 5 Answer</h3> */

/* <h3>Problem 5 Test</h3> */
%:- outgoing(a,X), X = [b,e,c].  %SUCCEED
%:- outgoing(e,X), X = [].       %SUCCEED
%:- outgoing(a,X), X = [b,e,c].  %SUCCEED
%:- incoming(a,X), X = [b].       %SUCCEED
%:- incoming(f,X), X = [].       %SUCCEED

%:- outgoing(e,X), X = [a].      %FAIL
%:- incoming(e,X), X = [].       %FAIL

/* <h3>Problem 6</h3>
In class we discussed green and red cuts (!). A green cut is a cut that DOES NOT change correctness (the answer returned) but simply improved efficiency by preventing unnecessary backtracking. Red cuts change correctness -- if a predicate is correct and contains a cut that, when removed, is no longer correct, it is a red cut.

Insert cuts into the following 3 predicates. The first two my_member1/2 and my_max/3 are already correct, but using a cut (green) will improve their efficiency. The last, my_max1/3 is wrong, but inserting a cut (red) will make it correct.  */

/* <h3>Problem 6 Answer</h3> */
my_member1(X,[X|_]).
my_member1(X,[_|Ys]) :- my_member1(X,Ys).

my_max(X,Y,Y) :- X =< Y.
my_max(X,Y,X) :- X > Y.

my_max1(X,Y,Z) :- X =< Y, Y = Z.
my_max1(X,_,X).

/* <h3>Problem 7</h3>
Place a cut in the definition of my_prefix1 below so only following goal will only find the first non-empty prefix of the list. You must place a cut, do not modify my_prefix1 in another other way.

:- my_prefix([1,2,3],X).
   X = [] ;
   X = [1] ;
   fail. */

/* <h3>Problem 7 Answer </h3> */
my_prefix1(_,[]).
my_prefix1([X|Xs], [X|Ys]) :- my_prefix1(Xs,Ys).

/* <h3>Problem 0B (NOT GRADED):</h3>
The following are examples from class; they will not be graded as part of this assignment, but you will be expected to understand them before the test. You should be able to solve them yourself and I highly recommend answering them.

0B.1. Write a predicate pack(X,Y) that succeeds if Y is the list X with all successive occurences of the same element element packed together...
pack([a,a,a,a,b,b,a,c,c,c],Y). will succeed with Y = [a,b,a,c]

0B.2. Write a predicate encode(X,Y) that succeeds if Y is the list X with all successive occurences of the same element elements packed together in [Occurence,Element] form..
encode([a,a,a,a,b,b,a,c,c,c],Y). will succeed with Y = [[4,a],[2,b],[1,a],[3,c]].

0B.3. Write a predicate decode(X,Y) that succeeds if Y is the list of encoded [Occurence,Element] decoded from X...
decode([[4,a],[2,b],[1,a],[3,c]],Y). will succeed with Y = [a,a,a,a,b,b,a,c,c,c]. */

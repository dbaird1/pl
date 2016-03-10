/* Homework Assignment 5
   Programming Languages
   CS471, Spring 2016
   Binghamton University */

/* <h1>Instructions</h1> */

/* This section deals with general submission instructions. First, grab this assignment's <a href="hw5.asn">template source file</a>. BEFORE MOVING ON RENAME hw5.asn to hw5.pl. You will be able to code in and run the file in the prolog interpreter directly. I recommend reading this assignment directly from the source file.

We will be using swipl for our prolog environment: To load/reload this file, cd to its directory and run swipl. Then, in the prompt, type [hw5].

cd PATH_TO_FILE
swipl
[hw5].

From then on you may execute queries (goals) in the prompt. As usual, you should provide your answers in the designated spot. Once you have added some code to the file, rerun [hw5]. in the swipl prompt to reload.

In addition, there are unit tests for each problem. These are there to help you better understand what the question asks for, as well as check your code. They are included in our "database" as queries and are initially commented out -- % is a Prolog line comment.

%:- member_times(4,[3,3,2,3],0). % SUCCEED
%:- member_times(4,[1,2,3],3).   % FAIL

After you have finished a problem and are ready to test, remove the initial % for each test for the associated problem and reload the assignment file ([hw5].). Each SUCCEED line should silently load and succeed, and each FAIL line should throw a WARNING. If a SUCCEED line throws a WARNING, or a FAIL line fails to, then you solution is not correct. If you pass the tests there is a good chance that your code is correct, but not guaranteed; the tests are meant as guided feedback and are not a check for 100% correctness. */

/* <h1>Submission</h1> */

/* For this assignment -- and the remaining Prolog assignments -- you must submit only the source (template) file. There is no need to tar anything as all coding should be done directly in hw5.pl. */

/* <h1>Homework 5</h1> */

/* Due: Tuesday, 3/1 at 11:59 PM */

/* Purpose: To get comfortable with unfication and pattern matching. */

/* <h3>Problem 1:</h3>
In class we discussed that we can encode a binary search tree in Prolog using complex terms: i.e, the following BST

        5
       / \
      3   7
     / \
    1   4

can be encoded as node(5,node(3,node(1,nil,nil),node(4,nil,nil)),node(7,nil,nil)).

Write a predicate insert(X,Y,Z) that succeeds if Z is the tree Y with X inserted (insert X into Y). You may assume you have a binary search tree. Yes, we did this example in class. */

/* <h3>Problem 1 Answer:</h3> */

inseRgt(X,nil,node(X,nil,nil)).
inseRgt(X, node(X,Lft,Rgt), node(X,Lft,Rgt)).
inseRgt(X, node(V,Lft,Rgt), node(V,Lft1,Rgt)):-
  X < V, inseRgt(X,Lft,Lft1).
inseRgt(X, node(V,Lft,Rgt), node(V,Lft,Rgt1)):-
  X > V, inseRgt(X,Rgt,Rgt1).

/* <h3>Problem 1 Test:</h3> */
%:- insert(5,node(5,nil,nil),X), X = node(5,nil,nil).                                                                            %SUCCEED
%:- insert(3,node(5,nil,nil),X), X = node(5,node(3,nil,nil),nil).                                                                %SUCCEED
%:- insert(7,node(5,nil,nil),X), X = node(5,nil,node(7,nil,nil)).                                                                %SUCCEED
%:- insert(1,node(5,node(3,nil,nil),node(7,nil,nil)),X), X = node(5,node(3,node(1,nil,nil),nil),node(7,nil,nil)).                 %SUCCEED
%:- insert(1,node(5,node(3,node(2,nil,nil),nil),node(7,nil,nil)),X), X = node(5,node(3,node(2,node(1,nil,nil),nil),nil),node(7,nil,nil)). %SUCCEED

%:- insert(3,node(5,node(3,node(2,nil,nil),nil),node(7,nil,nil)),X), X = node(5,node(3,node(2,node(3,nil,nil),nil)),node(7,nil,nil)). %FAIL

/* <h3>Problem 2:</h3>
Using the same encoding for a binary search tree, write a predicate to_list(X,Y) that succeeds if Y is an in-order list of the elements of all the nodes of tree X (Y should show an inorder traversel of X). If you are rusty and do not remember what an inorder traversal is, give https://en.wikipedia.org/wiki/Tree_traversal#In-order a quick glance.

For example...
to_list(node(5,node(3,node(1,nil,nil),node(4,nil,nil)),node(7,nil,nil)),X) will succeed with X = [1,3,4,5,7]. */

/* <h3>Problem 2 Answer:</h3>  */

to_list(nil, []).

to_list(node(X, Lft, Rgt), R) :-
   to_list(Lft,Rs), to_list(Rgt,Rss), append(Rs,[X|Rss],R).

/* <h3>Problem 2 Tests:</h3>  */
%:- to_list(node(3,nil,nil),L), L = [3]. %SUCCEED
%:- to_list(node(5,node(3,nil,nil),nil),L), L = [3,5].  %SUCCEED
%:- to_list(node(5,node(3,node(1,nil,nil),node(4,nil,nil)),node(7,nil,nil)),L), L = [1,3,4,5,7]. %SUCCEED

%:- to_list(node(3,nil,nil),L), L = [5]. %FAIL

/* <h3>Problem 3:</h3>
Write a predicate right_rotate(X,Y) that succeeds if Y is the tree X rotated right at its root. Read https://en.wikipedia.org/wiki/Tree_rotation to refresh tree rotation in full. This problem may seem hard at first, but once you "see" the answer it really demonstrates the elegance of unfication/pattern matching. You do not need to handle error cases.

For example, the following shows a right rotation at the root.

        5                        3
       / \                      / \
      3   7         -->        2   5
     / \                          / \
    2   4                        4   7

*/

/* <h3>Problem 3 Answer:</h3> */

right_rotate(node(node(Q,Ql,Qr), node(P,Pl,Pr), Rgt), node(P,Pl,node(Q,Pr,Rgt))).


/* <h3>Problem 3 Test:</h3> */
%:- right_rotate(node(5,node(3,node(2,nil,nil),node(4,nil,nil)),node(7,nil,nil)),X), X = node(3, node(2, nil, nil), node(5, node(4, nil, nil), node(7, nil, nil))). %SUCCEED
%:- right_rotate(node(5,node(3,nil,node(4,nil,nil)),node(7,nil,nil)),X), X = node(3, nil, node(5, node(4, nil, nil), node(7, nil, nil))). %SUCCEED
%:- right_rotate(node(3,node(2,node(1,nil,nil),nil),nil),X), right_rotate(X,Y), Y = node(1,nil,node(2,nil,node(3,nil,nil))). %SUCCEED

%:- right_rotate(node(5,nil,node(7,nil,nil)),_). %FAIL

/* <h3>Problem 4:</h3>
Write a predicate drop_level(X,N,Y) that succeeds if Y is the tree X with all nodes "below" level N removed. We will consider the root node level 0.

For example, "dropping" at level 2 will result in the following.

        5                        5
       / \                      / \
      3   7         -->        3   7
     / \   \
    2   4   9

or

drop_level(node(5,node(3,node(2,nil,nil),node(4,nil,nil)),node(7,nil,node(9,nil,nil))),2,X) will succeed with X = node(5,node(3,nil,nil),node(7,nil,nil)).  */

/* <h3>Problem 4 Answer:</h3>  */
drop_level(node(X,Xl,Xr),0,nil).

drop_level(node(X,Xl,Xr),N,node(E,nil,nil)).

drop_level(node(X,Xl,Xr),N,node(X,Yl,Yr)):-
  N > 1, W is N - 1, drop_level(Xl, W, Yl), drop_level(Xr, W , Yr).

/* <h3>Problem 4 Tests:</h3>  */
%:- drop_level(node(5,nil,nil),1,X), !, X = node(5,nil,nil).
%:- drop_level(node(5,nil,nil),0,X), !, X = nil.
%:- drop_level(node(5,node(3,node(2,nil,nil),node(4,nil,nil)),node(7,nil,node(9,nil,nil))),2,X), !, X = node(5,node(3,nil,nil),node(7,nil,nil)).

%:- drop_level(node(5,node(3,node(2,nil,nil),node(4,nil,nil)),node(7,nil,node(9,nil,nil))),1,X), !, X = node(5,node(3,nil,nil),node(7,nil,nil)).

/* <h3>Problem 5:</h3>
We will encode a mini-AST in Prolog using complex data structures. A "node" will consist of either a nb(Functor,LeftExpr,RightExpr), nu(Functor,Expr) or nn(Number).

nb(Functor,LeftExpr,RightExpr) -- "node binary", Functor is guaranteed to be a binary arithmatic predicate that can be evaluated with `is`. LeftExpr and RightExpr are recursively defined "nodes".

nu(Functor,Expr) -- "node unary", Functor is guaranteed to be a unary arithmatic predicate that can be evaluated with `is`. Expr is a recursively defined "node".

nn(Number) -- "node number", Number is guaranteed to be just that.

Hence, the following AST
      +
     / \
    *   random
   / \       \
  2  3        5
would be encoded as nb(+,nb(*,nn(2),nn(3)),nu(random,nn(5))).

Write a predicate run(X,Y) that succeeds if Y is the result obtained run "running" (evaluating) X. You will need to use the =.. predicate. It may be helped to view some of the binary and unary arithmetic predicates -- http://www.swi-prolog.org/man/arith.html. If you write your predicate correctly, you do not need to concern yourself with the actual arithmetic functor supplied in the nodes. */

/* <h3>Problem 5 Answer:</h3> */

/* <h3>Problem 5 Tests:</h3> */
%:- run(nb(+,nb(*,nn(2),nn(3)),nu(random,nn(5))),_).
%:- run(nb(+,nb(*,nn(2),nn(3)),nn(3)),E), E=9.
%:- run(nb(+,nb(*,nn(2),nn(3)),nb(-,nn(6),nn(3))),E), E=9.
%:- run(nn(2),E), E=2.
%:- run(nu(abs,nn(-2)),E), E=2.

%:- run(nb(+,nb(*,nn(2),nn(3)),nb(-,nn(6),nn(3))),E), E=8.

/* <h3>Problem 6:</h3>
We discussed cons cells in class and how they can be encoded as a complex structure in Prolog. We will use a slightly modified encoding for this problems. A cons cell will either be nil, cons(v,Car,Cdr), or cons(c,Car,Cdr). The v/c is a "tag" that indicates whether the Car contains a value (v) or a cons cell itself (c).

For example, the following are both valid cons cell encodings...
cons(v,1,cons(v,2,nil))
cons(c,cons(v,1,nil),cons(v,2,nil))

We will write a predicate cons_list(X,Y) that converts our cons encoding into a prolog list.  For example...
cons_list(cons(v,1,cons(v,2,nil)),Y) will succeed with Y = [1,2]
cons_list(cons(c,cons(v,1,nil),cons(v,2,nil)),Y) will succeed with Y = [[1],2] */

/* <h3>Problem 6 Answer:</h3> */

/* <h3>Problem 6 Tests:</h3> */
%:- cons_list(nil,Y), Y = [].
%:- cons_list(cons(v,1,cons(v,2,nil)),Y), Y = [1,2].
%:- cons_list(cons(c,cons(v,1,nil),cons(v,2,nil)),Y), Y = [[1],2].
%:- cons_list(cons(v,1,cons(c,cons(v,2,cons(v,3,nil)),cons(v,4,nil))),Y), Y = [1,[2,3],4].

%:- cons_list(cons(v,cons(v,1,nil),cons(v,2,nil)),Y), Y = [1,2].

/* <h3>Problem 7:</h3>
In class we discussed difference lists and how to append two of them in "constant" time.

Write a predicate, append3DL(A,B,C,D) that succeeds if D is the difference lists A, B, and C appended.
*/

/* <h3>Problem 7 Answer:</h3> */
append3DL(A-B, B-C, C-D, A-D).
/* <h3>Problem 7 Tests:</h3> */
%:- append3DL([1,2|A]-A,[3,4|B]-B,[5,6|[]]-[],L), L = [1,2,3,4,5,6]-[].

%:- append3DL([1,2|A]-A,[3,4|B]-B,[5,6|[]]-[],L), L = [1,2,3,4,5]-[].

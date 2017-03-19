/*-----------------------------*/
/* Projet de IA02: Jeu de Khan */
/* Marion Chan, Lila Sintes    */
/*-----------------------------*/

/* Initialisation des variables */

/* Prédicat dynamique donnant la liste des coordonnees occupées par des pions */
:- dynamic(listPions/1).
listPions([]).

/* Prédicat dynamique permettant de stocker les coordonnées du coup à jouer par l'ordinateur */
:- dynamic(best/1).
best([]).

/* Prédicat dynamique permettant de savoir la valeur du Khan */
:- dynamic(khan/1).
khan(3).

/* Prédicat dynamique donnant la liste des mouvements possibles pour les pions (A VERIFIER) */
:- dynamic(listPossiblePions/1).
listPossiblePions([]).

/* Prédicat dynamique permettant de modéliser les pions */
:- dynamic(pion/6).
pion(rouge,0,0,0,0,khalista).
pion(rouge,1,0,0,0,sbire).
pion(rouge,2,0,0,0,sbire).
pion(rouge,3,0,0,0,sbire).
pion(rouge,4,0,0,0,sbire).
pion(rouge,5,0,0,0,sbire).
pion(ocre,0,0,0,0,khalista).
pion(ocre,1,0,0,0,sbire).
pion(ocre,2,0,0,0,sbire).
pion(ocre,3,0,0,0,sbire).
pion(ocre,4,0,0,0,sbire).
pion(ocre,5,0,0,0,sbire).

/* Prédicats permettant de modéliser le plateau de jeu */
:- dynamic(board/1).
board([]).
tab1([[1,2,2,3,1,2],[3,1,3,1,3,2],[2,3,1,2,1,3],[2,1,3,2,3,1],[1,3,1,3,1,2],[3,2,2,1,3,2]]).
tab2([[3,1,2,2,3,1],[2,3,1,3,1,2],[2,1,3,1,3,2],[1,3,2,2,1,3],[3,1,3,1,3,1],[2,2,1,3,2,2]]).
tab3([[2,2,3,1,2,2],[1,3,1,3,1,3],[3,1,2,2,3,1],[2,3,1,3,1,2],[2,1,3,1,3,2],[1,3,2,2,1,3]]).
tab4([[2,3,1,2,2,3],[2,1,3,1,3,1],[1,3,2,3,1,2],[3,1,2,1,3,2],[2,3,1,3,1,3],[2,1,3,2,2,1]]).

tab1g([['   1   ','   2   ','   2   ','   3   ','   1   ','   2   '],['   3   ','   1   ','   3   ','   1   ','   3   ','   2   '],['   2   ','   3   ','   1   ','   2   ','   1   ','   3   '],['   2   ','   1   ','   3   ','   2   ','   3   ','   1   '],['   1   ','   3   ','   1   ','   3   ','   1   ','   2   '],['   3   ','   2   ','   2   ','   1   ','   3   ','   2   ']]).
tab2g([['   3   ','   1   ','   2   ','   2   ','   3   ','   1   '],['   2   ','   3   ','   1   ','   3   ','   1   ','   2   '],['   2   ','   1   ','   3   ','   1   ','   3   ','   2   '],['   1   ','   3   ','   2   ','   2   ','   1   ','   3   '],['   3   ','   1   ','   3   ','   1   ','   3   ','   1   '],['   2   ','   2   ','   1   ','   3   ','   2   ','   2   ']]).
tab3g([['   2   ','   2   ','   3   ','   1   ','   2   ','   2   '],['   1   ','   3   ','   1   ','   3   ','   1   ','   3   '],['   3   ','   1   ','   2   ','   2   ','   3   ','   1   '],['   2   ','   3   ','   1   ','   3   ','   1   ','   2   '],['   2   ','   1   ','   3   ','   1   ','   3   ','   2   '],['   1   ','   3   ','   2   ','   2   ','   1   ','   3   ']]).
tab4g([['   2   ','   3   ','   1   ','   2   ','   2   ','   3   '],['   2   ','   1   ','   3   ','   1   ','   3   ','   1   '],['   1   ','   3   ','   2   ','   3   ','   1   ','   2   '],['   3   ','   1   ','   2   ','   1   ','   3   ','   2   '],['   2   ','   3   ','   1   ','   3   ','   1   ','   3   '],['   2   ','   1   ','   3   ','   2   ','   2   ','   1   ']]).


/* Prédicat dynamique permettant d'afficher le plateau de jeu graphiquement */
:-dynamic(showBoard/1).
showBoard([]).

/* Prédicat dynamique permettant de savoir quel joueur est entrain de jouer */
:- dynamic(joueur/1).
joueur(rouge).


/* Prédicat donnant la liste des mouvements possibles (A VERIFIER) */
:- dynamic(possibleMoveList/1).
possibleMoveList([]).

/* ??? */
:- dynamic(history/1).
history([]).

empty([]).

/* Prédicats permettant de modéliser les mouvements des pions */
mvts(avancer(1)).
mvts(reculer(1)).
mvts(droite(1)).
mvts(gauche(1)).

move(I,J,avancer(1),If,Jf) :- If is I+1, Jf is J.
move(I,J,reculer(1),If,Jf) :- If is I-1, Jf is J.
move(I,J,droite(1),If,Jf) :- If is I, Jf is J+1.
move(I,J,gauche(1),If,Jf) :- If is I, Jf is J-1.


/*--------------------------------------------------------------*/
/* Prédicats affichage graphique */

replaceGraphism(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  	append(A,[Row|B],OldTab),     
  	length(A,Ligne) ,                 
  	append(C,[_|D],Row) ,   
  	length(C,Col), 
	append(A1,[Row1|_],X),     
  	length(A1,Ligne) ,                 
  	append(C1,[E1|_],Row1) ,   
  	length(C1,Col) ,
  	E1=1, 
	append(C,['   1   '|D],RowNew) ,
  append(A,[RowNew|B],Res).  

replaceGraphism(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  	append(A,[Row|B],OldTab),     
  	length(A,Ligne) ,                 
  	append(C,[_|D],Row) ,   
  	length(C,Col), 
	append(A1,[Row1|_],X),     
  	length(A1,Ligne) ,                 
  	append(C1,[E1|_],Row1) ,   
  	length(C1,Col) ,
  	E1=2, 
	append(C,['   2   '|D],RowNew) ,
  	append(A,[RowNew|B],Res). 

  replaceGraphism(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  	append(A,[Row|B],OldTab),     
  	length(A,Ligne) ,                 
  	append(C,[_|D],Row) ,   
  	length(C,Col), 
	append(A1,[Row1|_],X),     
  	length(A1,Ligne) ,                 
  	append(C1,[E1|_],Row1) ,   
  	length(C1,Col) ,
  	E1=3, 
	append(C,['   3   '|D],RowNew) ,
  	append(A,[RowNew|B],Res). 

replaceGraphismSbO(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=1, 
append(C,['sO 1   '|D],RowNew) ,
  append(A,[RowNew|B],Res).  

replaceGraphismSbO(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=2, 
append(C,['sO 2   '|D],RowNew) ,
  append(A,[RowNew|B],Res). 

  replaceGraphismSbO(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=3, 
append(C,['sO 3   '|D],RowNew) ,
  append(A,[RowNew|B],Res). 


replaceGraphismSb(X, OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=1, 
append(C,['sR 1   '|D],RowNew) ,
  append(A,[RowNew|B],Res).  

replaceGraphismSb(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=2, 
append(C,['sR 2   '|D],RowNew) ,
  append(A,[RowNew|B],Res). 

  replaceGraphismSb(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=3, 
append(C,['sR 3   '|D],RowNew) ,
  append(A,[RowNew|B],Res). 

replaceGraphismK(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=1, 
append(C,['kR 1   '|D],RowNew) ,
  append(A,[RowNew|B],Res).

replaceGraphismK(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=2, 
append(C,['kR 2   '|D],RowNew) ,
  append(A,[RowNew|B],Res). 

  replaceGraphismK(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=3, 
append(C,['kR 3   '|D],RowNew) ,
  append(A,[RowNew|B],Res).

replaceGraphismKO(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=1, 
append(C,['kO 1   '|D],RowNew) ,
  append(A,[RowNew|B],Res).

replaceGraphismKO(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=2, 
append(C,['kO 3   '|D],RowNew) ,
  append(A,[RowNew|B],Res).

  replaceGraphismKO(X,OldTab,I,J,Res) :-
	Ligne is I-1,
	Col is J-1,
  append(A,[Row|B],OldTab),     
  length(A,Ligne) ,                 
  append(C,[_|D],Row) ,   
  length(C,Col), 
append(A1,[Row1|_],X),     
  length(A1,Ligne) ,                 
  append(C1,[E1|_],Row1) ,   
  length(C1,Col) ,
  E1=3, 
append(C,['kO 3   '|D],RowNew) ,
  append(A,[RowNew|B],Res).


/* Prédicats permettant de modifier le plateau de jeu affiché */
 modifyGraphismSb(I,J) :-
    showBoard(Tab),
    board(X),
    replaceGraphismSb(X,Tab,I,J,Res),
    retractall(showBoard(_)),
    asserta(showBoard(Res)),
    printGraphism(_).

 modifyGraphismSbO(I,J) :-
    showBoard(Tab),
    board(X),
    replaceGraphismSbO(X,Tab,I,J,Res),
    retractall(showBoard(_)),
    asserta(showBoard(Res)),
    printGraphism(_).

 modifyGraphismK(I,J) :-
    showBoard(Tab),
    board(X),
    replaceGraphismK(X,Tab,I,J,Res),
    retractall(showBoard(_)),
    asserta(showBoard(Res)),
    printGraphism(_).

 modifyGraphismKO(I,J) :-
    showBoard(Tab),
    board(X),
    replaceGraphismKO(X,Tab,I,J,Res),
    retractall(showBoard(_)),
    asserta(showBoard(Res)),
    printGraphism(_).



/*--------------------------------------------------------------*/
/* Fonctions utiles */
flatten2([], []) :- !.
flatten2([L|Ls], FlatL) :-
    !,
    flatten2(L, NewL),
    flatten2(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatten2(L, [L]).

indexOf([Element|_], Element, 1).
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1), 
  Index is Index1+1.  

findElem(Tab,Elem,If,Jf) :-
	flatten2(Tab,TabRes),
	indexOf(TabRes, Elem, Index),
	I is (Index//6)+1,
	J is Index mod 6,
	valid(I,J,If,Jf).

valid(I,0,If,Jf) :-
	If is I-1,
	Jf is 6,
	!.
valid(I,J,I,J).

/* Prédicat permettant la négation d'un autre prédicat */
non(X) :- X,!,fail.
non(_). 

/* Prédicat qui renvoie vrai si les arguments sont differents */
diff(X,Y) :- non(X==Y).

/* Prédicat qui renvoie vrai si l'élement X est un élement d'une liste */
element(X,[X|_]).
element(X,[_|Q]) :- element(X,Q).

ind([X|_],1,X) :- !, true.
ind([_|Q],I,R) :- 
	I>1, 
	I1 is I-1, 
	ind(Q,I1,R).

replace([_|T],1,X,[X|T]). 
replace([H|T],I,X,[H|R]) :-
	I1 is I-1, 
	replace(T,I1,X,R).

findElement(L,I,J,R) :-
	ind(L,I,R1),
	ind(R1,J,R).

findLign([X|_],1,X) :- !, true.
findLign([_|Q],A,Tab2) :-
	A>1,
	A1 is A-1,
	findLign(Q,A1,Tab2).

replaceElement(I,J,New,R) :-
	board(X),
	ind(X,I,Lign),
	replace(Lign,J,New,R).

/* Prédicats permettant l'affichage du plateau */
printTab([]) :- write('-------------------------------------------------'),nl.
printTab([X|Q]) :-
	write('-------------------------------------------------'),
	nl, 
	write('|'), 
	printLign(X),nl,
	printTab(Q),
	!.
printLign([]).		
printLign([X|Q]) :-
	write(X),
	write('|'), 
	printLign(Q).
printBoard(_) :-
	board(X),
	printTab(X).

printGraphism(_) :-
	showBoard(X),
	printTab(X).

/* Prédicat permettannt de lire des coordonnees entrées au clavier */
choosePlace(X,Y) :-
	write('Choix des coordonnees'),nl,
	write('Ligne:'),
	read(X),
	write('Colonne:'),
	read(Y).


/* Prédicat permettant de changer la valeur du prédicat dynamique Joueur à la fin de chaque tour de jeu */
changer_joueur :- 
	( joueur(J), 
	  J = rouge
	  -> retract(joueur(_)),
	  asserta(joueur(ocre))
	  ; retract(joueur(_)),
	  asserta(joueur(rouge))
	).

/* Prédicat qui renvoie vrai si la case du plateau passée en argument est occupée */
occupied(X,Y) :- pion(_,_,X,Y,_,_).

/* Prédicats permettant de déplacer un pion : différents prédicats dans le cas ou le joueur est le rouge ou le ocre, et du type de pion déplacé */
setPion(Player,I,Xf,Yf) :-
	Player = rouge,
	I = 0,
	board(Board),
	showBoard(OldTab),
	pion(Player,I,X,Y,_,Pion),
	possibleMoves(Player,List),
	element([X,Y,Xf,Yf],List),
	occupied(Xf,Yf),
	eatPion(Player,Xf,Yf),
	findElement(Board,Xf,Yf,Khan),
	setKhan(Khan),
	replaceGraphism(Board,OldTab,X,Y,Res),
	retractall(showBoard(_)),
    asserta(showBoard(Res)),
	modifyGraphismK(Xf,Yf),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPion(Player,I,Xf,Yf) :-
	Player = rouge,
	I = 0,
	board(Board),
	showBoard(OldTab),
	pion(Player,I,X,Y,_,Pion),
	possibleMoves(Player,List),
	element([X,Y,Xf,Yf],List),
	findElement(Board,Xf,Yf,Khan),
	setKhan(Khan),
	replaceGraphism(Board,OldTab,X,Y,Res),
	retractall(showBoard(_)),
    asserta(showBoard(Res)),
	modifyGraphismK(Xf,Yf),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPion(Player,I,Xf,Yf) :-
	Player = rouge,
	I >0,
	board(Board),
	showBoard(OldTab),
	pion(Player,I,X,Y,_,Pion),
	possibleMoves(Player,List),
	element([X,Y,Xf,Yf],List),
	occupied(Xf,Yf),
	eatPion(Player,Xf,Yf),
	findElement(Board,Xf,Yf,Khan),
	setKhan(Khan),
	replaceGraphism(Board,OldTab,X,Y,Res),
	retractall(showBoard(_)),
    asserta(showBoard(Res)),
	modifyGraphismSb(Xf,Yf),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPion(Player,I,Xf,Yf) :-
	Player = rouge,
	I > 0,
	board(Board),
	showBoard(OldTab),
	pion(Player,I,X,Y,_,Pion),
	possibleMoves(Player,List),
	element([X,Y,Xf,Yf],List),
	findElement(Board,Xf,Yf,Khan),
	setKhan(Khan),
	replaceGraphism(Board,OldTab,X,Y,Res),
	retractall(showBoard(_)),
    asserta(showBoard(Res)),
	modifyGraphismSb(Xf,Yf),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).



setPion(Player,I,Xf,Yf) :-
	Player = ocre, 
	I = 0,
	board(Board),
	showBoard(OldTab),
	pion(Player,I,X,Y,_,Pion),
	possibleMoves(Player,List),
	element([X,Y,Xf,Yf],List),
	occupied(Xf,Yf),
	eatPion(Player,Xf,Yf),
	findElement(Board,Xf,Yf,Khan),
	setKhan(Khan),
	replaceGraphism(Board,OldTab,X,Y,Res),
	retractall(showBoard(_)),
    	asserta(showBoard(Res)),
	modifyGraphismKO(Xf,Yf),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPion(Player,I,Xf,Yf) :-
	Player = ocre,
	I = 0,
	board(Board),
	showBoard(OldTab),
	pion(Player,I,X,Y,_,Pion),
	possibleMoves(Player,List),
	element([X,Y,Xf,Yf],List),
	findElement(Board,Xf,Yf,Khan),
	setKhan(Khan),
	replaceGraphism(Board,OldTab,X,Y,Res),
	retractall(showBoard(_)),
    	asserta(showBoard(Res)),
	modifyGraphismKO(Xf,Yf),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPion(Player,I,Xf,Yf) :-
	Player = ocre, 
	I > 0,
	board(Board),
	showBoard(OldTab),
	pion(Player,I,X,Y,_,Pion),
	possibleMoves(Player,List),
	element([X,Y,Xf,Yf],List),
	occupied(Xf,Yf),
	eatPion(Player,Xf,Yf),
	findElement(Board,Xf,Yf,Khan),
	setKhan(Khan),
	replaceGraphism(Board,OldTab,X,Y,Res),
	retractall(showBoard(_)),
    	asserta(showBoard(Res)),
	modifyGraphismSbO(Xf,Yf),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPion(Player,I,Xf,Yf) :-
	Player = ocre,
	I > 0,
	board(Board),
	showBoard(OldTab),
	pion(Player,I,X,Y,_,Pion),
	possibleMoves(Player,List),
	element([X,Y,Xf,Yf],List),
	findElement(Board,Xf,Yf,Khan),
	setKhan(Khan),
	replaceGraphism(Board,OldTab,X,Y,Res),
	retractall(showBoard(_)),
    	asserta(showBoard(Res)),
	modifyGraphismSbO(Xf,Yf),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPion(Player,_,_,_) :-
	write('Mouvement impossible'),nl,
	choosePion(I),
	choosePlace(X,Y),
	setPion(Player,I,X,Y).

/* Prédicat permettant à un joueur de "manger" un pion de l'autre joueur */
eatPion(Player,X,Y) :-
	autreJoueur(Player,Player2),	
	retract(pion(Player2,I,X,Y,_,Pion)),
	asserta(pion(Player2,I,0,0,0,Pion)).

/* Prédicat permettant de récuperer la valeur du joueur adverse (ocre ou rouge) */
autreJoueur(rouge,ocre).
autreJoueur(ocre,rouge).

/* Prédicats permettant l'initialisation des pions des joueurs */
setPionInit(Player,I,Xf,Yf) :-
	board(Board),
	I=0,
	Player = rouge,
	modifyGraphismK(Xf,Yf),
	findElement(Board,Xf,Yf,Khan),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPionInit(Player,I,Xf,Yf) :-
	board(Board),
	I>0,
	Player = rouge,
	modifyGraphismSb(Xf,Yf),
	findElement(Board,Xf,Yf,Khan),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPionInit(Player,I,Xf,Yf) :-
	board(Board),
	I=0,
	Player = ocre,
	modifyGraphismKO(Xf,Yf),
	findElement(Board,Xf,Yf,Khan),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPionInit(Player,I,Xf,Yf) :-
	board(Board),
	I>0,
	Player = ocre,
	modifyGraphismSbO(Xf,Yf),
	findElement(Board,Xf,Yf,Khan),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

/* Prédicats permettant de déplacer le premier pion de la partie (le joueur rouge commence toujours) */
setPionFirst(Player,I,Xf,Yf) :-
	board(Board),
	I = 0,
	showBoard(OldTab),
	pion(Player,I,X,Y,_,Pion),
	setKhan(Khan),
	possibleMoves(Player,List),
	element([X,Y,Xf,Yf],List),
	replaceGraphism(Board,OldTab,X,Y,Res),
	retractall(showBoard(_)),
    	asserta(showBoard(Res)),
	findElement(Board,Xf,Yf,Khan),
	setKhan(Khan),
	modifyGraphismK(Xf,Yf),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPionFirst(Player,I,Xf,Yf) :-
	board(Board),
	I > 0,
	showBoard(OldTab),
	pion(Player,I,X,Y,Khan,Pion),
	setKhan(Khan),
	possibleMoves(Player,List),
	element([X,Y,Xf,Yf],List),
	replaceGraphism(Board,OldTab,X,Y,Res),
	retractall(showBoard(_)),
    	asserta(showBoard(Res)),
	findElement(Board,Xf,Yf,Khan),
	setKhan(Khan),
	modifyGraphismSb(Xf,Yf),
	retract(pion(Player,I,_,_,_,Pion)),
	asserta(pion(Player,I,Xf,Yf,Khan,Pion)).

setPionFirst(Player,_,_,_) :-
	write('Mouvement impossible'),nl,
	choosePion(I),
	choosePlace(X,Y),
	setPionFirst(Player,I,X,Y).

/* Prédicat permettant de changer la valeur du Khan */
setKhan(X) :-
	retract(khan(_)),
	asserta(khan(X)).

/* Prédicat permettant de réinitialiser les paramêtres du jeu (plateau choisi, placement des pions etc) */
reinit :-
	retract(joueur(_)),
	retract(board(_)),
	asserta(board([])),
	asserta(joueur(rouge)),
	retractall(pion(_,_,_,_,_,_)),
	asserta(pion(rouge,0,0,0,0,khalista)),
	asserta(pion(rouge,1,0,0,0,sbire)),
	asserta(pion(rouge,2,0,0,0,sbire)),
	asserta(pion(rouge,3,0,0,0,sbire)),
	asserta(pion(rouge,4,0,0,0,sbire)),
	asserta(pion(rouge,5,0,0,0,sbire)),
	asserta(pion(ocre,0,0,0,0,khalista)),
	asserta(pion(ocre,1,0,0,0,sbire)),
	asserta(pion(ocre,2,0,0,0,sbire)),
	asserta(pion(ocre,3,0,0,0,sbire)),
	asserta(pion(ocre,4,0,0,0,sbire)),
	asserta(pion(ocre,5,0,0,0,sbire)).

/*--------------------------------------------------------------*/
/* Initialisation des pions et du tableau */

/* Prédicat permettant de choisir l'orientation du tableau */
chooseBoard(1) :- 
	tab1(Y),
	tab1g(Z),
	retractall(board(_)),
	asserta(board(Y)),
	retractall(showBoard(_)),
	asserta(showBoard(Z)).
chooseBoard(2) :- 
	tab2(Y),
	tab2g(Z),
	retractall(board(_)),
	asserta(board(Y)),
	retractall(showBoard(_)),
	asserta(showBoard(Z)).
chooseBoard(3) :- 
	tab3(Y),
	tab3g(Z),
	retractall(board(_)),
	asserta(board(Y)),
	retractall(showBoard(_)),
	asserta(showBoard(Z)).
chooseBoard(4) :- 
	tab4(Y),
	tab4g(Z),
	retractall(board(_)),
	asserta(board(Y)),
	retractall(showBoard(_)),
	asserta(showBoard(Z)).

/* Prédicats d'affichage du menu du jeu */
boucle_menu :-
	repeat,
	menu,
	!.

menu :-
	nl,
	write('1. Humain vs Humain'),nl,
	write('2. Humain vs Ordinateur'),nl,
	write('3. Ordinateur vs Ordinateur'),nl,
	write('4. Quitter'),nl,
	write('Entrez un choix :'),
	read(Choix),nl,
	appel(Choix),
	Choix=4,
	nl.

/* Prédicats permettant de choisir entre les differents modes de jeu*/
appel(1) :- 
	nl,
	write('Vous avez choisi "Humain vs Humain".'),
	nl,
	init(hh).
appel(2) :- 
	nl,
	write('Vous avez choisi "Humain vs Ordinateur".'),
	nl,
	init(ho).
appel(3) :-
	nl,
	write('Vous avez choisi "Ordinateur vs Ordinateur".'),
	nl,
	init(oo).
appel(4) :- write('Vous avez choisi de quitter.').

/* Prédicat permettant d'initialiser le jeu dans le mode Humain vs Humain */
init(hh) :-
	write('                      1 ='),nl,
	write('    |  2  |  3  |  1  |  2  |  2  |  3  |'),nl,
	write('    |  2  |  1  |  3  |  1  |  3  |  1  |'),nl,
	write('2 = '),write('|  1  |  3  |  2  |  3  |  1  |  2  |'),write(' = 3'),nl,
	write('    |  3  |  1  |  2  |  1  |  3  |  2  |'),nl,
	write('    |  2  |  3  |  1  |  3  |  1  |  3  |'),nl,
	write('    |  2  |  1  |  3  |  2  |  2  |  1  |'),nl,
	write('                      4 ='),nl,
	write('Choisissez une direction:'),
	read(X),
	chooseBoard(X),
	printGraphism(_),
	boucle_init_rougeH,
	boucle_init_ocreH,
	playFirstMove,
	play(hh,0),
	reinit,
	boucle_menu,
	!.

/* Prédicat permettant d'initialiser le jeu dans le mode Humain vs Ordinateur */
init(ho) :-
	write('                      1 ='),nl,
	write('    |  2  |  3  |  1  |  2  |  2  |  3  |'),nl,
	write('    |  2  |  1  |  3  |  1  |  3  |  1  |'),nl,
	write('2 = '),write('|  1  |  3  |  2  |  3  |  1  |  2  |'),write(' = 3'),nl,
	write('    |  3  |  1  |  2  |  1  |  3  |  2  |'),nl,
	write('    |  2  |  3  |  1  |  3  |  1  |  3  |'),nl,
	write('    |  2  |  1  |  3  |  2  |  2  |  1  |'),nl,
	write('                      4 ='),nl,
	write('Choisissez une direction:'),
	read(X),
	chooseBoard(X),
	printGraphism(_),
	boucle_init_rougeH,
	boucle_init_ocreO,
	playFirstMove,
	play(ho,0),
	reinit,
	boucle_menu,
	!.

/* Prédicat permettant d'initialiser le jeu dans le mode Ordinateur vs Ordinateur */	
init(oo) :-
	write('                      1 ='),nl,
	write('    |  2  |  3  |  1  |  2  |  2  |  3  |'),nl,
	write('    |  2  |  1  |  3  |  1  |  3  |  1  |'),nl,
	write('2 = '),write('|  1  |  3  |  2  |  3  |  1  |  2  |'),write(' = 3'),nl,
	write('    |  3  |  1  |  2  |  1  |  3  |  2  |'),nl,
	write('    |  2  |  3  |  1  |  3  |  1  |  3  |'),nl,
	write('    |  2  |  1  |  3  |  2  |  2  |  1  |'),nl,
	write('                      4 ='),nl,
	write('choix du tableau :'),
	random(1,5,Y),
	write(Y),nl,
	chooseBoard(Y),
	printGraphism(_),
	boucle_init_rougeO,
	boucle_init_ocreO,
	findall([A,B],pion(rouge,_,A,B,_,_),List1),
	findall([C,D],pion(ocre,_,C,D,_,_),List2),
	write(List1),nl,
	write(List2),nl,
	playFirstMoveO,
	play(oo,0),
	reinit,
	boucle_menu,
	!.

/* Prédicat permettant d'initialiser les pions du joueur humain rouge */
boucle_init_rougeH :-
	repeat,
	write('Initialisation des pions rouges'),nl,
	initialisation(1),
	!.

/* Prédicat permettant d'initialiser les pions du joueur humain ocre */
boucle_init_ocreH :-
	repeat,
	write('Initialisation des pions ocres'),nl,
	initialisation(1),
	!.

/* Prédicat permettant d'initialiser les pions de l'ordinateur rouge */
boucle_init_rougeO :-
	repeat,
	write('Initialisation des pions rouges'),nl,
	initialisationO(0),
	!.

/* Prédicat permettant d'initialiser les pions de l'ordinateur ocre */
boucle_init_ocreO :-
	repeat,
	write('Initialisation des pions ocres'),nl,
	initialisationO(0),
	!.

/* Prédicat général permettant d'initialiser les coordonées des différents pions du jeu dans le cas d'un joueur humain*/
initialisation(7):- changer_joueur,!.
initialisation(6) :-
	joueur(Joueur),
	Joueur = rouge,
	write('Initialisation de la khalista rouge'),nl,
	choosePlace(X,Y),
	X > 4, X < 7,
	Y > 0, Y < 7,
	non(occupied(X,Y)),
	setPionInit(Joueur,0,X,Y),
	initialisation(7).
initialisation(6) :-
	joueur(Joueur),
	Joueur = ocre,
	write('Initialisation de la khalista ocre'),nl,
	choosePlace(X,Y),
	X < 3, X > 0,
	Y < 7, Y > 0,
	non(occupied(X,Y)),
	setPionInit(Joueur,0,X,Y),
	initialisation(7).
initialisation(6) :-
	initialisation(6).
initialisation(I) :-
	I<7,
	joueur(Joueur),
	Joueur = rouge,
	choosePlace(X,Y),
	X > 4, X < 7,
	Y > 0, Y < 7,
	non(occupied(X,Y)),
	setPionInit(Joueur,I,X,Y),
	I1 is I+1,
	initialisation(I1).
initialisation(I) :-
	I<7,
	joueur(Joueur),
	Joueur = ocre,
	choosePlace(X,Y),
	X < 3, X > 0,
	Y < 7, Y > 0,
	non(occupied(X,Y)),
	setPionInit(Joueur,I,X,Y),
	I1 is I+1,
	initialisation(I1).
initialisation(I) :-
	write('Erreur dans les coordonnees'),nl,
	initialisation(I).

/* Prédicat général permettant d'initialiser les coordonées des différents pions du jeu dans le cas d'un joueur de type ordinateur */

initialisationO(6) :- changer_joueur,!.
initialisationO(I) :-
	I<7,
	joueur(Joueur),
	Joueur = ocre,
	random(1,3,X),
	random(1,7,Y),
	non(occupied(X,Y)),
	setPionInit(Joueur,I,X,Y),
	I1 is I+1,
	initialisationO(I1),!.
initialisationO(I) :-
	I<7,
	joueur(Joueur),
	Joueur = rouge,
	random(5,7,X),
	random(1,7,Y),
	non(occupied(X,Y)),
	setPionInit(Joueur,I,X,Y),
	I1 is I+1,
	initialisationO(I1),!.
initialisationO(I) :-
	initialisationO(I).

/*--------------------------------------------------------------*/
/* HUMAIN vs HUMAIN */

/* Prédicats permettant d'écrire à la console quel joueur a gagné la partie */
play(_,1) :- joueur(J), J = rouge, write('Rouge a gagne'),nl.
play(_,1) :- joueur(J), J = ocre, write('Ocre a gagne'),nl.

/* Prédicat permettant de jouer une partie dans le mode Humain vs Humain */
play(hh,0) :-
	nl,
	joueur(Joueur),
	khan(Khan),
	write('Khan: '),write(Khan),nl,
	write('Joueur: '),write(Joueur),nl,
	afficherSbires(Joueur),nl,
	afficherKhalista(Joueur),nl,
	choosePion(I),
	choosePlace(X,Y),
	setPion(Joueur,I,X,Y),
	isFinale(Rep),
	play(hh,Rep).


/* Prédicat permettant de jouer une partie dans le mode Humain vs Ordinateur */
play(ho,0) :-
	nl,
	joueur(Joueur),
	Joueur = rouge,
	khan(Khan),
	write('Khan: '),write(Khan),nl,
	write('Joueur: '),write(Joueur),nl,
	afficherSbires(Joueur),nl,
	afficherKhalista(Joueur),nl,
	choosePion(I),
	choosePlace(X,Y),
	setPion(Joueur,I,X,Y),
	isFinale(Rep),
	play(ho,Rep).
play(ho,0) :-
	joueur(Joueur),
	Joueur = ocre,
	khan(Khan),
	write('Khan: '),write(Khan),nl,
	write('Joueur: '),write(Joueur),nl,
	iaMove(Joueur),
	isFinale(Rep),
	play(ho,Rep).


/* Prédicat permettant de jouer une partie dans le mode Ordinateur vs Ordinateur */	
play(oo,0) :-
	joueur(Joueur),
	khan(Khan),
	write('Khan: '),write(Khan),nl,
	write('Joueur: '),write(Joueur),nl,
	iaMove(Joueur),
	isFinale(Rep),
	play(oo,Rep).

/* Prédicat permettant de jouer le premier tour humain de jeu d'une partie */
playFirstMove :-
	nl,
	joueur(Joueur),
	afficherSbires(Joueur),nl,
	afficherKhalista(Joueur),nl,
	choosePion(I),
	choosePlace(X,Y),
	setPionFirst(Joueur,I,X,Y),
	changer_joueur.

/* Prédicat permettant de jouer le premier tour de jeu de l'ordinateur d'une partie */
playFirstMoveO :-
	joueur(Joueur),
	setKhan(3),
	iaMove(Joueur),
	changer_joueur.

/* Prédicat permettant de vérifier si la partie est terminée ou non (Khalista mangée par un sbire adverse) */
isFinale(Rep) :-
	pion(_,0,0,0,_,khalista),
	Rep is 1.
isFinale(Rep) :-
	Rep is 0,
	changer_joueur.

/* Prédicat permettant d'afficher la liste des coordonnées des sbires d'un joueur */
afficherSbires(Joueur) :- 
	write('Vos sbire: '),
	afficherPion(Joueur,1).

/* Prédicat permettant d'afficher les coordonnées de la khalista d'un joueur */
afficherKhalista(Joueur) :- 
	write('Votre khalista: '),
	afficherPion(Joueur,0).

/* Prédicat permettant d'afficher les coordonnées d'un pion */
afficherPion(Joueur,0) :- 
	pion(Joueur,0,X,Y,K,khalista),
	write('('),write(0),write(')'),write(':'),
	write('['),write(X),write(','),write(Y),write('] '),write(','),write(K),nl.
afficherPion(_,6).
afficherPion(Joueur,I) :-
	pion(Joueur,I,X,Y,K,sbire),
	write('('),write(I),write(')'),write(':'),
	write('['),write(X),write(','),write(Y),write('] '),write(','),write(K),
	I1 is I+1,
	afficherPion(Joueur, I1).

/* Prédicat permettant de choisir un pion à déplacer */
choosePion(I) :-
	write('Choisissez un pion : '),
	read(I),
	I < 6.


/*--------------------------------------------------------------*/
/* Possible moves */

/* Prédicat donnant la liste des mouvements possibles pour un joueur en fonction des règles du jeu et de l'état actuel du plateau*/
possibleMoves(Player,PossibleMoveList) :-
	khan(Khan),
	empty(TestList),
	findall([X,Y],pion(Player,_,X,Y,Khan,_), List),
	diff(TestList,List),
	allKhanMoves(Player,Khan,List),
	possibleMoveList(PossibleMoveList),
	diff(TestList,PossibleMoveList),
	retractall(possibleMoveList(_)),
	asserta(possibleMoveList([])),
	!.
possibleMoves(Player,PossibleMoveList) :-
	khan(Khan),
	empty(TestList),
	findall([X,Y],pion(Player,_,X,Y,Khan,_), List),
	diff(TestList,List),
	allKhanMoves(Player,Khan,List),
	possibleMoveList(PossibleMoveList),
	non(diff(TestList,PossibleMoveList)),
	khan(Khan),
	board(B),
	findall([Xnew,Ynew],findElem(B,Khan,Xnew,Ynew),EmptyCasesList),
	entrerPion(EmptyCasesList),
	findall([X,Y,K],pion(Player,_,X,Y,K,_),AllList),
	allMoves(Player,AllList),
	possibleMoveList(PossibleMoveList),
	retractall(possibleMoveList(_)),
	asserta(possibleMoveList([])),
	!.
possibleMoves(Player,PossibleMoveList) :-
	khan(Khan),
	board(B),
	findall([Xnew,Ynew],findElem(B,Khan,Xnew,Ynew),EmptyCasesList),
	entrerPion(EmptyCasesList),
	findall([X,Y,K],pion(Player,_,X,Y,K,_),AllList),
	allMoves(Player,AllList),
	possibleMoveList(PossibleMoveList),
	retractall(possibleMoveList(_)),
	asserta(possibleMoveList([])),
	!.

/* Prédicat permettant de prendre en compte la valeur du Khan dans les mouvements possibles d'un pion (A VERIFIER) */
allKhanMoves(_,_,[]).
allKhanMoves(Player, Khan, [[X,Y]|Pions]) :-
	setof([X,Y,Xf,Yf],oneMove(X,Y,Khan,Xf,Yf),R),
	possibleMoveList(List),
	append(R,List,Tmp),
	retractall(possibleMoveList(_)),
	asserta(possibleMoveList(Tmp)),
	retract(history(_)),
	asserta(history([])),
	allKhanMoves(Player,Khan,Pions).
allKhanMoves(Player, Khan, [[_,_]|Pions]) :-
	allKhanMoves(Player,Khan,Pions).


/* Prédicat permettant de faire revenir un pion sur le plateau de jeu */
entrerPion([]).
entrerPion([[Xnew,Ynew]|Pions]) :-
	non(occupied(Xnew,Ynew)),
	possibleMoveList(List),
	append([[0,0,Xnew,Ynew]],List,Tmp),
	retractall(possibleMoveList(_)),
	asserta(possibleMoveList(Tmp)),
	entrerPion(Pions),!.
entrerPion([[_,_]|Pions]) :-
	entrerPion(Pions),!.

/* Prédicat qui renvoie la liste de tous les mouvements possibles (A VERIFIER) */
allMoves(_,[]).
allMoves(Player, [[X,Y,K]|Pions]) :-
	diff(X,0),diff(Y,0),diff(K,0),
	setof([X,Y,Xf,Yf],oneMove(X,Y,K,Xf,Yf),R),
	possibleMoveList(List),
	append(R,List,Tmp),
	retractall(possibleMoveList(_)),
	asserta(possibleMoveList(Tmp)),
	retract(history(_)),
	asserta(history([])),
	allMoves(Player,Pions),!.
allMoves(Player, [[_,_,_]|Pions]) :-
	allMoves(Player,Pions),!.

/* Prédicat permettant de modéliser un mouvement de pion */
oneMove(X,Y,0,X,Y).
oneMove(X,Y,1,Xf,Yf) :-
	mvts(Mvt),
	move(X,Y,Mvt,Xtmp,Ytmp),
	Xtmp > 0, Xtmp < 7,
	Ytmp > 0, Ytmp < 7,
	history(History),
	non(element([Xtmp,Ytmp],History)),
	joueur(J),
	findall([A,B],pion(J,_,A,B,_,_),ListPions),
	non(element([Xtmp,Ytmp],ListPions)),
	append([[Xtmp,Ytmp]],History,Res),
	retract(history(_)),
	asserta(history(Res)),
	oneMove(Xtmp,Ytmp,0,Xf,Yf).
oneMove(X,Y,Khan,Xf,Yf) :-
	history(History),
	Khan > 0,
	mvts(Mvt),
	move(X,Y,Mvt,Xtmp,Ytmp),
	Xtmp > 0, Xtmp < 7,
	Ytmp > 0, Ytmp < 7,
	non(occupied(Xtmp,Ytmp)),
	non(element([Xtmp,Ytmp],History)),
	Khan1 is Khan-1,
	append([[Xtmp,Ytmp]],History,Res),
	retract(history(_)),
	asserta(history(Res)),
	oneMove(Xtmp,Ytmp,Khan1,Xf,Yf).



/*--------------------------------------------------------------*/
/* IA */

/* Prédicat permettant de lister les coordonnées des pions d'un joueur */
listerPions(_,6,ListF) :- listPions(ListF), retractall(listPions(_)),asserta(listPions([])),!.
listerPions(Player,I,ListF) :-
	I<6,
	I1 is I+1,
	listPions(List),
	pion(Player,I,X,Y,_,_),
	append([[X,Y]],List,Res),
	retract(listPions(_)),
	asserta(listPions(Res)),
	listerPions(Player,I1,ListF).

/* Prédicat permettant de modifier les coordonnées d'un pion dans une liste */
remplacerPion(X,Y,Xf,Yf,List,Res) :-
	indexOf(List,[X,Y],I),
	replace(List,I,[Xf,Yf],Res).

/* Prédicat renvoyant la liste des pions pouvant être déplacés lors d'un tour de jeu */
possiblePionsList([],_,ListPossiblePions) :- listPossiblePions(ListPossiblePions), retractall(listPossiblePions(_)), asserta(listPossiblePions([])).
possiblePionsList([[X,Y,Xf,Yf]|Moves],ListPions,ListPossiblePions)  :-
	diff(X,0),diff(Y,0),
	remplacerPion(X,Y,Xf,Yf,ListPions,NewList),
	listPossiblePions(L),
	append([NewList],L,NewL),
	retract(listPossiblePions(_)),
	asserta(listPossiblePions(NewL)),
	possiblePionsList(Moves,ListPions,ListPossiblePions).
possiblePionsList([[_,_,_,_]|Moves],ListPions,ListPossiblePions)  :-
	possiblePionsList(Moves,ListPions,ListPossiblePions).


/* Prédicat renvoyant la valeur minimal entre deux valeurs */
min(Val1, Val2, Min) :-
	Val1 < Val2,
	Min is Val1,
	!.
min(Val1, Val2, Min) :-
	Val1 > Val2,
	Min is Val2,
	!.
min(Val1, Val2, Min) :-
	Val1 = Val2,
	Min is Val2,
	!.

/* Prédicat permettant de calculer la distance entre deux pions en fonction de leurs coordonnées respectives */
dist(Xa,Ya,Xb,Yb,Dist) :-
	square(Xb-Xa,Res1),square(Yb-Ya,Res2),
	Res is Res1+Res2,
	Dist is sqrt(Res).

/* Prédicat permettant de calculer le carré d'une valeur numérique */
square(X,Res) :-
	Res is X*X.

/* Prédicat permettant de calculer la distance minimale entre plusieurs coordonnées */
bestDist([],_,_,10000).
bestDist([[X,Y]|Pions],Xk,Yk,BestDist) :-
	bestDist(Pions,Xk,Yk,Res),
	dist(X,Y,Xk,Yk,Dist),
	min(Res,Dist,BestDist).

/* Prédicat permettant de renvoyer la valeur de la différence entre les différentes distances calculées */
value(ListPions1,ListPions2,Xk,Yk,Xk2,Yk2,Value) :-
	bestDist(ListPions1,Xk2,Yk2,Best),
	bestDist(ListPions2,Xk,Yk,Best2),
	Value is Best - Best2.

/* Prédicat permettant de choisir le meilleur coup à jouer par l'ordinateur selon l'état actuel du jeu */
bestCoup(_,[],10000).
bestCoup(Joueur,[Pions1|Moves],BestValue) :-
	bestCoup(Joueur,Moves,Value1),
	autreJoueur(Joueur,Joueur2),
	pion(Joueur2,_,Xk2,Yk2,_,khalista),
	listerPions(Joueur2,0,Pions2),
	ind(Pions1,6,[Xk,Yk]),
	value(Pions1,Pions2,Xk,Yk,Xk2,Yk2,Value2),
	min(Value1,Value2,BestValue),
	BestValue = Value1.
bestCoup(Joueur,[Pions1|Moves],BestValue) :-
	bestCoup(Joueur,Moves,Value1),
	autreJoueur(Joueur,Joueur2),
	pion(Joueur2,_,Xk2,Yk2,_,khalista),
	listerPions(Joueur2,0,Pions2),
	ind(Pions1,6,[Xk,Yk]),
	value(Pions1,Pions2,Xk,Yk,Xk2,Yk2,Value2),
	min(Value1,Value2,BestValue),
	BestValue = Value2,
	retractall(best(_)),
	asserta(best(Pions1)).

/* Prédicat permettant d'effectuer le mouvement qui aura été choisi */
moveBestCoup(_,[],_).
moveBestCoup(Joueur,[[X,Y]|_],I) :-
	pion(Joueur,I,Xprev,Yprev,_,_),
	diff([Xprev,Yprev],[X,Y]),
	setPion(Joueur,I,X,Y).
moveBestCoup(Joueur,[_|Pions],I) :-
	I1 is I-1,
	moveBestCoup(Joueur,Pions,I1).

/* Prédicat qui effectue un tour de jeu dans le cas d'un joueur ordinateur */
iaMove(Joueur) :-
	listerPions(Joueur,0,Pions),
	possibleMoves(Joueur,Moves),
	possiblePionsList(Moves,Pions,Res),
	bestCoup(Joueur,Res,_),
	best(X),
	moveBestCoup(Joueur,X,5),
	retract(best(_)),
	asserta(best([])),
	retractall(listPions(_)),
	asserta(listPions([])),
	!.
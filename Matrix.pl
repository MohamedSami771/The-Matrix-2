:- include('KB').

neo_loc(X,Y,S,CH,H):-
	(
		A = up,
		U is X+1,
		grid(GX,_),
		U < GX,
		X >= 0,
		S = result(A,S1),
		neo_loc(U,Y,S1,CH,H)
	);
	(
		A = down,
		D is X-1,
		grid(GX,_),
		D >= 0,
		X < GX,
		S = result(A,S1),
		neo_loc(D,Y,S1,CH,H)
	);
	(
		
		A = right,
		R is Y-1,
		R >= 0,
		grid(_,GY),
		Y < GY,
		S = result(A,S1),
		neo_loc(X,R,S1,CH,H)
	);
	(
		A = left,
		L is Y+1,
		grid(_,GY),
		L < GY,
		GY >= 0,
		S = result(A,S1),
		neo_loc(X,L,S1,CH,H)
	);
	(
		A = carry,
		S = result(A,S1),
		cancarry(H,[X,Y]),
		length(H,HS), HS > 0,
		length(CH,NC),
		capacity(C),
		NC < C,
		remove([X,Y],H,NH),
		append([[X,Y]],CH,NCH),
		neo_loc(X,Y,S1,NCH,NH)
	);
	(
		A = drop,
		booth(X,Y),
		length(CH,NC),
		NC > 0,
		S = result(A,S1),
		neo_loc(X,Y,S1,[],H)
	).
	
cancarry([[H1,H2]], [H1, H2]).
cancarry([[H1,H2],_|_], [H1, H2]).
cancarry([[_,_],H3|T], [X, Y]) :- cancarry([H3|T], [X, Y]).

remove([X,Y],[],[]).
remove([X,Y],[[X,Y]|T],L2):- remove([X,Y],T,L2).
remove([X,Y],[[A,B]|T],[[A,B]|S]):- 
	[X,Y]\=[A,B],
	remove([X,Y],T,S). 
	
goal(S):-
	neo_loc(X,Y),
	hostages_loc(H),
	neo_loc(X,Y,S,[],H),
	booth(BX,BY),
	X == BX, Y == BY,
	length(H,LH1), LH1 == 0, 
	print(LH1).

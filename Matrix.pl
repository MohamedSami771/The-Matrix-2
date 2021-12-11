:- include('KB').
neo_loc(X,Y,s0,H,[],[]):- neo_loc(X,Y), hostages_loc(H).
neo_loc(X,Y,S,H,CH,[DH|DT]):-
	(
		A = drop,
		booth(X,Y),
		length(CH,NC),
		capacity(C),
		NC < C,
		append([DH],CH,NCH),
		S = result(A,S1),
		neo_loc(X,Y,S1,H,NCH,DT)
	);
	(
		A = carry,
		cancarry(CH,[X,Y]),	
		
		length(CH,NC),
		capacity(C),
		NC =< C,

		remove([X,Y],CH,NCH),
		append([[X,Y]],H,NH),
		S = result(A,S1),
		neo_loc(X,Y,S1,NH,NCH,[DH|DT])
	);
	(
		A = up,
		U is X+1,
		grid(GX,_),
		U < GX,
		X >= 0,
		S = result(A,S1),
		neo_loc(U,Y,S1,H,CH,[DH|DT])
	);
	(
		A = down,
		D is X-1,
		grid(GX,_),
		D >= 0,
		X < GX,
		S = result(A,S1),
		neo_loc(D,Y,S1,H,CH,[DH|DT])
	);
	(
		
		A = right,
		R is Y-1,
		R >= 0,
		grid(_,GY),
		Y < GY,
		S = result(A,S1),
		neo_loc(X,R,S1,H,CH,[DH|DT])
	);
	(
		A = left,
		L is Y+1,
		grid(_,GY),
		L < GY,
		GY >= 0,
		S = result(A,S1),
		neo_loc(X,L,S1,H,CH,[DH|DT])
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
	booth(X,Y),
	hostages_loc(DH),
	neo_loc(X,Y,S,[],[],DH).

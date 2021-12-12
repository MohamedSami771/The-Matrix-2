:- include('KB').

neo_loc(X,Y,s0,C,H):- neo_loc(X,Y), capacity(C), hostages_loc(H).
neo_loc(X,Y,result(A,S1),C,H):-
	(
		neo_loc(D,Y,S1,C,H),
		A = down,
		X is D+1,
		grid(GX,_),
		D >= 0,
		D < GX
	);
	(
		neo_loc(U,Y,S1,C,H),
		A = up,
		X is U-1,
		grid(GX,_),
		U >= 0,
		U < GX
	);
	(
		neo_loc(X,R,S1,C,H),
		A = right,
		Y is R+1,
		grid(_,GY),
		R < GY
	);
	(
		neo_loc(X,L,S1,C,H),
		A = left, 
		Y is L-1,
		grid(_,GY),
		L >= 0,
		L < GY
	);
	(
		neo_loc(X,Y,S1,OC,H1),
		A = carry,
		member([X,Y],H1),
		delete(H1,[X,Y],H),
		C is OC - 1,
		OC > 0
	);
	(
		neo_loc(X,Y,S1,_,H),
		A = drop,
		capacity(C)
	).
	
goal(S):-
	booth(X,Y),
	neo_loc(X,Y,S,1,[]).
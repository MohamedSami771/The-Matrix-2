:- include('KB').

neo_loc(_,_,s0,[],[]).
neo_loc(X,Y,S,CH,DH):-
	(
		A = up,
		U is X+1,
		grid(GX,_),
		U < GX,
		X >= 0,
		S = result(A, S1),
		neo_loc(U,Y,S1,CH,DH)
	);
	(
		A = down,
		D is X-1,
		grid(GX,_),
		D >= 0,
		X < GX,
		S = result(A, S1),
		neo_loc(D,Y,S1,CH,DH)
	);
	(
		
		A = right,
		R is Y-1,
		R >= 0,
		grid(_,GY),
		Y < GY,
		S = result(A,S1),
		neo_loc(X,R,S1,CH,DH)
	);
	(
		A = left,
		L is Y+1,
		grid(_,GY),
		L < GY,
		GY >= 0,
		S = result(A,S1),
		neo_loc(X,L,S1,CH,DH)
	);
	(
		A = carry,
		hostages_loc([[[HX,HY]]|HT]),
		X == HX,
		Y == HY,
		length(CH,NH),
		capacity(C),
		NH < C,
		S = result(A,S1),
		neo_loc(X,Y,S1,[CH|[[HX,HY]]],DH)
	);
	(
		A = drop,
		booth(BX,BY),
		X == BX,
		Y == BY,
		length(CH,LH),
		LH > 0,
		S = result(A,S1),
		neo_loc(X,Y,S1,[],[[CH]|[DH]])
	).
	
goal(S):-
	neo_loc(X,Y),
	neo_loc(X,Y,S,CH,DH),
	booth(BX,BY),
	X == BX, Y == BY,
	hostages_loc(H),
	length(H,LH1), length(DH,LH2), LH1 == LH2, 
	print(LH1).
	

	
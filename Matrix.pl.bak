:- include('KB').


neo_loc(X,Y,S):-
	(
		A = up,
		U is X+1,
		grid(GX,_),
		U < GX,
		X >= 0,
		S = result(A, S1),
		neo_loc(U,Y,S1)
	);
	(
		A = down,
		D is X-1,
		grid(GX,_),
		D >= 0,
		X < GX,
		S = result(A, S1),
		neo_loc(D,Y,S1)
	);
	(
		
		A = right,
		R is Y-1,
		R >= 0,
		grid(_,GY),
		Y < GY,
		S = result(A,S1),
		neo_loc(X,R,S1)
	);
	(
		A = left,
		L is Y+1,
		grid(_,GY),
		L < GY,
		GY >= 0,
		S = result(A,S1),
		neo_loc(X,L,S1)
	);
	(
		A = carry,
		
	);
	(
		A = drop,
		
	)
	
goal(S):-
	neo_loc(X,Y),
	S = result(A, S1)
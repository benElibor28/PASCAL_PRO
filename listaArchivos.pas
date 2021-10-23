unit listaArchivos;

Interface
	uses crt;


	
  Type
	  TStudRec = Record
		nombre : String[40];
		 Age : Integer;
	End;

	  TNodePtr = ^TNode;
	  TNode = Record
		StudRec : TStudRec;
		NodePtr : TNodePtr;
	End;

	Var
	 Head, Tail : TNodePtr;
	 SampRec : TStudRec;

	 Procedure    InitLinkedList;
	 Procedure    AddNode(StudRec : TStudRec);
   Procedure    Imprimir;
	IMPLEMENTATION


	Procedure InitLinkedList;
	Begin
	
		Head := nil;
		Tail := Head;
	End;
	
	Procedure AddNode(StudRec : TStudRec);
	Var
		Node : TNode;
	Begin
		Node.StudRec := StudRec;
		New(Node.NodePtr);
		If Head = nil Then
		Begin
			New(Head);
			New(Tail);
			Head^ := Node;
		End Else
		Begin
			Tail^.NodePtr^ := Node;
		End;
		Tail^ := Node;
	End;

  
  Procedure imprimir;
	var
	 tmp: TNodePtr;
	 begin
	 tmp:= Head;
	 while tmp <> nil do
	  begin
	   writeln ('!',tmp^.StudRec.nombre);
	   tmp:= tmp^.NodePtr
	  end;
	end;  

	


End.
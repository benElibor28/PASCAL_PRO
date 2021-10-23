unit lista2;

Interface
	uses crt;



	  Type
		  TStudRec = Record
			nombre : String;
		End;


		encabezado= ^Tencabezado;
	  Tencabezado = Record
		nombre : String;
		usess : String;
	  End;
	
	  variables= ^Tvariables;
	  Tvariables = Record
		nombre : String;
		tipo : String;
		sigV :  variables;
	  end;

    cuerpoP =^TcuerpoC;
		TcuerpoC = Record
		sentencia: String;
		sigC : cuerpoP;
		End;

	  procedimientos= ^Tprocedimientos;
	  Tprocedimientos = Record
		nombre : String;
		cuerpo : cuerpoP;
		sigP : procedimientos;
	  End;

	  main= ^Tmain;
	  Tmain = Record
		sentencia : String;
		sigM : main;
	  End;


	  Codigo = ^TNode;
	  TNode = Record
		StudRec : TStudRec;
		cabeza : encabezado;
    vars:   variables;
		pros: procedimientos;
		ma :  main;
		NodePtr : Codigo;
	End;

	Var
	 Head, Tail : Codigo;
	 SampRec : TStudRec;
	 pasCode : text;

	 Procedure    InitLinkedList;
	 {Procedure    AddNode(StudRec : TStudRec); }
   Procedure    Imprimir(Cod : TNode);

	 
	IMPLEMENTATION

	Procedure InitLinkedList;
	Begin

		Head := nil;
		Tail := Head;
	End;

	{Procedure AddNode(StudRec : TStudRec);
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
		tail^ := Node;
	End;}


  Procedure imprimir(cod : TNode);
	var
	 tmp: TNode;
	 tmp2: TNode;
	 begin


	

   if cod.cabeza <> Nil Then
	 Begin
	    Assign(pasCode,'C:\Users\Ruben\Downloads\Paradigmas De Programacion\Archivos Pascal\'+cod.cabeza^.nombre+'.pas');
      ReWrite(pasCode);
			Writeln(pasCode,cod.cabeza^.nombre);
			Writeln(pasCode,cod.cabeza^.usess);
			
	 End;


	 if cod.vars <> Nil Then
	 Begin
				new(tmp.vars);
				
			  tmp.vars := cod.vars;
				Writeln(pasCode,cod.vars^.nombre+' : '+cod.vars^.tipo);

				while tmp.vars^.sigV <> nil do
			  begin
				tmp.vars:= tmp.vars^.sigV;
			  writeln (tmp.vars^.nombre,' ',tmp.vars^.tipo);
				Writeln(pasCode,tmp.vars^.nombre+' : '+tmp.vars^.tipo);

			  end;

	 End;


	 if cod.ma <> Nil Then
	 Begin
				new(tmp2.ma);

			  tmp2.ma := cod.ma;
				Writeln(pasCode,cod.ma^.sentencia);    



				while tmp2.ma^.sigM <> nil do
			  begin
				tmp2.ma:= tmp2.ma^.sigM;
			  writeln (tmp2.ma^.sentencia);
				Writeln(pasCode,tmp2.ma^.sentencia);

			  end;

				Writeln(pasCode,'End.');
				Close(pasCode);
	 End;



	 

	end;




End.
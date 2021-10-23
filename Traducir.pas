Unit Traducir;

Interface
uses crt,Dos,lista2;

    Type
		  Variables = Record
			nombre : String;
			tipo : String;

		End;

		List_vars = ^TNode2;
	  TNode2 = Record
		nomV : Variables;
		sigV : List_vars;
    End;


var lineaTotal : String;
       StudRec : TNode;
			  nomPrograma : String;
						Head, Tail : List_vars;
						

Procedure GetArchivoP(var RCK: Text);
Procedure GetCaracterP(var C: char);
Procedure Val_InicioP(var line: String);
Procedure Val_variables(var line: String);
Procedure Val_variablesTipo(var tipo: String;var nom: String);
Procedure Val_ProceOEscriP(var line: String);
Procedure Val_AsignacionValP(var line: String);
Procedure Val_EscriP(var line: String);
Procedure llenarlista;
Procedure llenarVariables (cod : TNode ; nom : String; tip : String);
Procedure llenarCuerpoMain (cod : TNode ; nom : String);
Procedure Val_DeclaracionOasignacionP(var line: String);
Procedure IniciarListaV;
Procedure AddNode(StudRec2 : Variables);
Procedure imprimirListaVars;

IMPLEMENTATION

Procedure  GetArchivoP(var RCK: Text);
var linea: Char;
var numLineas : Integer;
Begin
  numLineas:=0;
	lineaTotal:='';
	IniciarListaV;
	new(StudRec.ma);
	StudRec.ma^.sentencia := 'Begin';
	StudRec.ma^.sigM := nil;
	while not eof( RCK) do
   begin
       read( RCK, linea );
       {write(linea);}
			 GetCaracterP(linea);
			 numLineas:=numLineas+1;
   end;
	 {WriteLn('li ',numLineas);}
	 llenarlista;
	 imprimirListaVars;
   close( RCK );
end;



Procedure   GetCaracterP(var C: char);
var linea : char;
var llaveCierre : Boolean;
Begin
   	lineaTotal:=Concat(lineaTotal,C);

		if C = '}' Then
		Begin
		  { WriteLn('n::: ',lineaTotal);}
			 Val_InicioP(lineaTotal);

			 lineaTotal:='';
		End;
		if C = '.' Then
		Begin
		   {WriteLn('variblae detecte: ',lineaTotal);}
			 Val_DeclaracionOasignacionP(lineaTotal);
			 lineaTotal:='';
		End;
		if C = ';' Then
		Begin
		   {WriteLn('variblae detecte: ',lineaTotal);}
			 Val_ProceOEscriP(lineaTotal);
			 lineaTotal:='';
		End;

End;


Procedure Val_DeclaracionOasignacionP(var line: String);
var lineaValidad : String;
var i:Integer;
var doa : Boolean;
Begin


	doa := false;

  for  i:=1 to length(line) Do
		Begin

				if line[i] = '=' Then
				Begin
					  doa:=true;
				End;
		End;

	{lineaValidad:=  line[length(line)-1];}
	if doa = True Then
	Begin
			WriteLn(line,'  es uj asignacion ');
			Val_AsignacionValP(line);
	End Else
	Begin
		  Val_variables(lineaTotal);
	End;


end;


Procedure Val_ProceOEscriP(var line: String);
var lineaValidad : String;
Begin

	lineaValidad:=  line[length(line)-1];
	if lineaValidad =')'Then
	Begin
	   Val_EscriP(line);
	End Else
	Begin
		 {es llamada a procedimiento}

	End;


end;




Procedure Val_EscriP(var line: String);
var i: Integer;
var nombreV : String;
var tipoV :String;
var valNombre : Boolean;
var valTipo : Boolean;
var nombreVar :Variables;
var sentencia : String;
var comilla : String;
Begin



    {inicializacion de Variables}
		valNombre := false;
		valTipo := false;
		nombreV :='';
		tipoV :='';
		comilla := chr(39);
		for  i:=0 to length(line) Do
		Begin

				if Ord(line[i]) = 10 Then
				Begin
					  line[i]:='/';
				    {Delete(line,i,1);}
				End;
		End;

			for  i:=1 to length(line) Do
		  Begin

				if line[i] = '/'  Then
				Begin
				  valNombre:=True;
				end;

				{separara elnombre de la variable del tipo}
        if valNombre = true Then
				Begin
				  if  line[i] <> ' ' Then
					Begin
					  nombreV:=Concat(nombreV,line[i]);
					End
					Else
					Begin
							valNombre:=False;
					End;
				end;

				if line[i] = ' ' Then
				Begin
				    valTipo:=True;
				End;
				{separara el tipo de la variable del nombre}
        if valTipo = true Then
				Begin
				  if  line[i] <> ';' Then
					Begin
					  tipoV:=Concat(tipoV,line[i]);
					End
					Else
					Begin
							valTipo:=False;
					End;
				end;


		End;


		Delete(nombreV,1,3);
		Delete(tipoV,1,1);

		
		WriteLn('{est es el escri }');
		WriteLn(nombreV);
		WriteLn(tipoV);

		{quita los parentesis}
		 Delete(tipoV,1,1);
		 Delete(tipoV,length(tipoV),1);


		 sentencia := 'WriteLn('+comilla+tipoV+comilla+');';

		 llenarCuerpoMain(StudRec,sentencia );

		 
		

End;




Procedure Val_AsignacionValP(var line: String);
var i: Integer;
var nombreV : String;
var tipoV :String;
var valNombre : Boolean;
var valTipo : Boolean;
var nombreVar :Variables;
var sentencia : String;
var comilla : String;
Begin


    {inicializacion de Variables}
		valNombre := false;
		valTipo := false;
		nombreV :='';
		tipoV :='';
		comilla := chr(39);
		for  i:=0 to length(line) Do
		Begin

				if Ord(line[i]) = 10 Then
				Begin
					  line[i]:='/';
				    {Delete(line,i,1);}
				End;
		End;

			for  i:=1 to length(line) Do
		  Begin

				if line[i] = '/'  Then
				Begin
				  valNombre:=True;
				end;

				{separara elnombre de la variable del tipo}
        if valNombre = true Then
				Begin
				  if  line[i] <> '=' Then
					Begin
					  nombreV:=Concat(nombreV,line[i]);
					End
					Else
					Begin
							valNombre:=False;
					End;
				end;

				if line[i] = '=' Then
				Begin
				    valTipo:=True;
				End;
				{separara el tipo de la variable del nombre}
        if valTipo = true Then
				Begin
				  if  line[i] <> '.' Then
					Begin
					  tipoV:=Concat(tipoV,line[i]);
					End
					Else
					Begin
							valTipo:=False;
					End;
				end;


		End;


		Delete(nombreV,1,3);
		Delete(tipoV,1,3);
		WriteLn('esta es la asignacion');
		WriteLn(nombreV);
		WriteLn(tipoV);

		Delete(tipoV,length(tipoV),1);
		sentencia := nombreV+':='+comilla+tipoV+comilla+';';

		llenarCuerpoMain(StudRec,sentencia);

		

End;

Procedure  Val_InicioP(var line: String);

var i: Integer;
Begin
			nomPrograma:='';

	 if  line[1]= '{' Then
	 Begin
	   for  i:=2 to length(line) Do
	   Begin

			if line[i] <> '}'  Then
			Begin
		     nomPrograma:=Concat(nomPrograma,line[i]);
			End;
		End;

	 End;

	 WriteLn('nc ',nomPrograma);

End;


 Procedure llenarVariables (cod : TNode ; nom : String; tip : String);
 var  aux, va : TNode;
 Begin
     new(va.vars);
		 va.vars^.nombre := nom;
		 va.vars^.tipo := tip;
		 va.vars^.sigV := nil;


		 if cod.vars = nil Then
		 Begin
		    {WriteLn('llega a meter el primero');}
				cod.vars^.nombre := nom;
				cod.vars^.tipo := tip;
		 End
		 Else
		 Begin
		    {WriteLn('llega a meter el Masssss '); }
		 		new(aux.vars);
		 		aux := cod;
				While  aux.vars^.sigV <> nil Do
				Begin
				    {WriteLn('wwwwwwww');}
						aux.vars :=  aux.vars^.sigV;
				End;

					aux.vars^.sigV := va.vars;

		 End;

 End;




 Procedure llenarCuerpoMain(cod : TNode ; nom : String);
 var  aux, va : TNode;
 Begin
     new(va.ma);
		 va.ma^.sentencia := nom;
		 va.ma^.sigM := nil;


		 if cod.ma = nil Then
		 Begin
		    {WriteLn('llega a meter el primero');}
				cod.ma^.sentencia := nom;
		 End
		 Else
		 Begin
		    {WriteLn('llega a meter el Masssss '); }
		 		new(aux.ma);
		 		aux := cod;
				While  aux.ma^.sigM <> nil Do
				Begin
				    {WriteLn('wwwwwwww');}
						aux.ma :=  aux.ma^.sigM;
				End;

					aux.ma^.sigM := va.ma;

		 End;

 End;



	
Procedure llenarlista;
var tmp: List_vars;
var cont : Integer;
Begin
		cont:=0;
    new(StudRec.cabeza);
		new(StudRec.vars);
		StudRec.cabeza^.nombre := 'Program '+ nomPrograma+';' ;
		StudRec.cabeza^.usess := 'uses crt;';
		


	   tmp:= Head;
		 while tmp^.sigV <> nil do
	   begin
		       if cont = 0 Then
					 Begin
					      StudRec.vars^.nombre := 'var '+tmp^.nomV.nombre;
								StudRec.vars^.tipo := tmp^.nomV.tipo+';';
								StudRec.vars^.sigV := nil;
								cont:=48;
					 End Else
					 Begin
					   llenarVariables(StudRec,tmp^.nomV.nombre, tmp^.nomV.tipo+';');
					 End;

	         tmp := tmp^.sigV;
	   end;





		WriteLn('');
		WriteLn('');
		WriteLn('lista codogo total es ');
		WriteLn('');
		imprimir(StudRec);
End;




Procedure Val_variables(var line: String);
var i: Integer;
var nombreV : String;
var tipoV :String;
var valNombre : Boolean;
var valTipo : Boolean;

Begin




    {inicializacion de Variables}
		valNombre := false;
		valTipo := false;
		nombreV :='';
		tipoV :='';

		for  i:=0 to length(line) Do
		Begin

				if Ord(line[i]) = 10 Then
				Begin
					  line[i]:='/';
				    {Delete(line,i,1);}
				End;
		End;



   for  i:=1 to length(line) Do
		Begin

				if line[i] = '/'  Then
				Begin
				  valNombre:=True;
				end;

				{separara elnombre de la variable del tipo}
        if valNombre = true Then
				Begin
				  if  line[i] <> ' ' Then
					Begin
					  nombreV:=Concat(nombreV,line[i]);
					End
					Else
					Begin
							valNombre:=False;
					End;
				end;

				if line[i] = ' ' Then
				Begin
				    valTipo:=True;
				End;
				{separara el tipo de la variable del nombre}
        if valTipo = true Then
				Begin
				  if  line[i] <> '.' Then
					Begin
					  tipoV:=Concat(tipoV,line[i]);
					End
					Else
					Begin
							valTipo:=False;
					End;
				end;


		End;

		Delete(nombreV,1,3);
		Delete(tipoV,1,1);
		{WriteLn(nombreV); }
		{WriteLn(tipoV);}

		
    Val_variablesTipo(tipoV,nombreV);
		
End;

Procedure Val_variablesTipo(var tipo: String; var nom: String);
var nombreVar :Variables;
var tipoTraducido :String;
Begin
  if tipo = 'numero' Then
	Begin
		 tipoTraducido:='Integer'
	End
	else if tipo = 'decimal' Then
	Begin
			tipoTraducido:='Real'
	End
	else if tipo = 'letra' Then
	Begin
			tipoTraducido:='String'
	End Else
	Begin


	End ;


	nombreVar.nombre :=nom;
	nombreVar.tipo :=tipoTraducido;
	AddNode(nombreVar);

End;

Procedure IniciarListaV;
Begin
	Head := nil;
	Tail := Head;
End;


Procedure AddNode(StudRec2 : Variables);
Var
	Node : TNode2;
Begin
	Node.nomV := StudRec2;
	New(Node.sigV);
	If Head = nil Then
	Begin
		New(Head);
		New(Tail);
		Head^ := Node;
	End Else
	Begin
		Tail^.sigV^ := Node;
	End;
	Tail^ := Node;
End;


Procedure imprimirListaVars;
var tmp: List_vars;
Begin
  tmp:= Head;
	while tmp^.sigV <> nil do
  begin
   writeln(tmp^.nomV.nombre);
	 WriteLn(tmp^.nomV.tipo);
   tmp := tmp^.sigV;
   end
End;



End.
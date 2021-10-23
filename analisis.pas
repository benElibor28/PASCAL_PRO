Unit analisis;

Interface
uses crt,Dos;

    Type
		  Variables = Record
			nombre : String;
			tipo : String;

		End;

		List_vars = ^TNode;
	  TNode = Record
		nomV : Variables;
		sigV : List_vars;
    End;


var lineaTotal : String;
    Error : String;
		codigoTotal : String;
		Head, Tail : List_vars;
		ErrorSintactico : Boolean;
		ErrorSintacticoEscri : Boolean;



Procedure GetArchivo(var RCK: Text);
Procedure GetCaracter(var C: char);
Procedure Val_Inicio(var line: String);
Procedure Val_Cierres(var totCodigo: String; tipcierre: Integer);
Procedure Val_variables(var line: String);
Procedure Val_variablesTipo(var tipo: String);
Procedure Val_variablesNombre(var nombre: String);
Procedure Val_ProceOEscri(var line: String);
Procedure Val_Escri(var line: String);
Procedure Val_NombreEscri(var line: String);
Procedure Val_DeclaracionOasignacion(var line: String);
Procedure Val_ParametroEscri(var line: String);
Procedure Val_AsignacionVal(var line: String);
Procedure Val_NombreAsignacion(var line: String);
Procedure Val_ValorAsignacion(var line: String;var lineNom: String);
Procedure IniciarListaV;
Procedure AddNode(StudRec : Variables);
Procedure imprimirListaVars;





IMPLEMENTATION

Procedure  GetArchivo(var RCK: Text);
var linea: Char;
var numLineas : Integer;
Begin
  numLineas:=0;
	lineaTotal:='';
	Error := '';
	IniciarListaV;
	ErrorSintactico := True;
	ErrorSintacticoEscri := True;
	

	while not eof( RCK) do
   begin
       read( RCK, linea );
       {write(linea);}
			 if ErrorSintactico = True Then
			 Begin
			   GetCaracter(linea);
			 End;
			 numLineas:=numLineas+1;
   end;
	 {WriteLn('li ',numLineas);}
	 Val_Cierres(codigoTotal,1);
	 WriteLn(Error);
   close( RCK );
end;


Procedure   GetCaracter(var C: char);
var linea : char;
 var llaveCierre : Boolean;
Begin
   	lineaTotal:=Concat(lineaTotal,C);
		codigoTotal:=Concat(codigoTotal,C);
		if C = '}' Then
		Begin
		  { WriteLn('n::: ',lineaTotal);}
			 Val_Inicio(lineaTotal);
			 
			 lineaTotal:='';
		End;
		if C = '.' Then
		Begin
		   {WriteLn('variblae detecte: ',lineaTotal);}
			 Val_DeclaracionOasignacion(lineaTotal);
			 lineaTotal:='';
		End;
		if C = ';' Then
		Begin
		   {WriteLn('variblae detecte: ',lineaTotal);}
			 Val_ProceOEscri(lineaTotal);
			 lineaTotal:='';
		End;

End;

Procedure Val_DeclaracionOasignacion(var line: String);
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
			Val_AsignacionVal(line);
	End Else
	Begin
		 Val_variables(lineaTotal);
	End;


end;


Procedure Val_ProceOEscri(var line: String);
var lineaValidad : String;
Begin

	lineaValidad:=  line[length(line)-1];
	if lineaValidad =')'Then
	Begin
	   Val_Escri(line);
	End Else
	Begin
		 {es llamada a procedimiento}
		 
	End;
	

end;


{este}
Procedure Val_AsignacionVal(var line: String);
var i: Integer;
var nombreV : String;
var tipoV :String;
var valNombre : Boolean;
var valTipo : Boolean;
var nombreVar :Variables;
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
		Delete(tipoV,1,1);
		WriteLn(nombreV);
		WriteLn(tipoV);

		Val_NombreAsignacion(nombreV);
		Val_ValorAsignacion(tipoV,nombreV);

End;

{este}
Procedure Val_ValorAsignacion(var line: String; var lineNom: String);
Var i : Integer;
var valValor : Boolean;
var tmp: List_vars;
var tipo : Integer;
Begin
    valValor := False;
		tipo:=0;
		for  i:=1 to length(line) Do
		Begin
				 if line[i] ='"'  Then
				 Begin
							valValor:= True;
				 End;
		End;


		if valValor = True Then
		Begin
		if  line[length(line)] <> '"' Then
			Begin
				  ErrorSintactico := False;
					Error := 'Error/Variable ('+lineNom+')  en la asignacion del valor, falta el caracter " ;';
			End;
		End;
		{eliminar comillas "" }
		Delete(line,length(line),1);
		Delete(line,1,2);


				WriteLn(' valco ',line);


    {buscar tipo de variable antes definida}
		tmp:= Head;
		while tmp^.sigV <> nil do
		begin
			 writeln(tmp^.nomV.nombre,' ',tmp^.nomV.tipo);
			 if lineNom =  tmp^.nomV.nombre Then
			 Begin
						 if tmp^.nomV.tipo = 'letra'  Then
						 Begin
									tipo:=1;
						 End Else
						 Begin
								  tipo:=2;
						 End;
			 End;

			 tmp := tmp^.sigV;
		end;

    if tipo = 1 Then
		Begin
				     if valValor = true  Then
						 Begin
                 WriteLn('esta bien el tipo letra ');
						 End Else
						 Begin
								  ErrorSintactico := False;
									Error := 'Error/Variable ('+lineNom+') se le asigna un numero, correcto letra';
						 End;
		
		End Else
		Begin
		         if valValor = true  Then
						 Begin
                  errorSintactico := False;
									Error := 'Error/Variable ('+lineNom+') se le asigna un letra, correcto numero';
						 End Else
						 Begin
								  WriteLn('esta bien el tipo numero');
						 End;

		End;


End;




{este}
Procedure Val_NombreAsignacion(var line: String);
var tmp: List_vars;
var val_variable : Boolean;
var i:Integer;
Begin

		Delete(line,length(line),1);
		val_variable:=False;
	 {Revisar si esta en la lista de variables}
   tmp:= Head;
	 while tmp^.sigV <> nil do
   begin
		 if line =  tmp^.nomV.nombre Then
		 Begin
			   val_variable := True;
		 End;
	   tmp := tmp^.sigV;
   end;

	 if  val_variable = False Then
	 Begin
			ErrorSintactico := False;
      Error := 'Error/La variable ('+line+') que desea asignar un valor, NO esta previamente declarada; ';
	 End;

End;







Procedure Val_Escri(var line: String);
var i: Integer;
var nombreV : String;
var tipoV :String;
var valNombre : Boolean;
var valTipo : Boolean;
var nombreVar :Variables;
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
		{WriteLn(nombreV);
		WriteLn(tipoV);}

    Val_NombreEscri(nombreV);


		if ErrorSintacticoEscri = True Then
		Begin
		   Val_ParametroEscri(tipoV);
		End;
End;


Procedure Val_NombreEscri(var line: String);
var i : Integer;
Begin
     if line = 'Escri' Then
		 Begin

		 End Else
		 Begin

		 		ErrorSintactico := False;
				ErrorSintacticoEscri := False;
				Error := 'Error/Comando ('+line+') invalido,  comando valido (Escri)';
		 End;

End;

Procedure Val_ParametroEscri(var line: String);
var i:Integer;
var tmp: List_vars;
var comilla: String;
var val_variable : Boolean;
Begin

		val_variable := False;

     if line[1] = '(' Then
		 Begin
					 if line[2] = '"' Then
		       Begin
		 				   comilla:= line[length(line)-1];
							 if comilla = '"' Then
		           Begin
		 				      WriteLn('line-1 ',line[length(line)-1],' ',line );

		           End Else
						   Begin
				            {falta " }
									 	ErrorSintactico := False;
				            Error := 'Error/Comando Escri invalido falta el caracter " ; ';
						   End;
		       End Else
					 Begin
			         {es con parametros}
					     comilla:= line[length(line)-1];
							 if comilla = '"' Then
		           Begin
		 				        ErrorSintactico := False;
				            Error := 'Error/Comando Escri invalido existe caracter " ; ';
		           End;
							 {quita los parentesis}
							 Delete(line,1,1);
							 Delete(line,length(line),1);
							 {WriteLn('pasc ',line);}
								 {Revisar si esta en la lista de variables}
                 tmp:= Head;
								 while tmp^.sigV <> nil do
							   begin
									 if line =  tmp^.nomV.nombre Then
									 Begin
										   val_variable := True;
									 End;
								   tmp := tmp^.sigV;
							   end;

								 if  val_variable = False Then
								 Begin
										ErrorSintactico := False;
				            Error := 'Error/La variable ('+line+') que desea imprimir, NO esta previamente declarada; ';
								 End;


							 
					 End;

		 End Else
		 Begin

		 		ErrorSintactico := False;
				Error := 'Error/Comando Escri invalido falta el caracter ( ;';
		 End; 

End;



Procedure Val_variables(var line: String);
var i: Integer;
var nombreV : String;
var tipoV :String;
var valNombre : Boolean;
var valTipo : Boolean;
var nombreVar :Variables;
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
		{WriteLn(nombreV);}
		{WriteLn(tipoV); }

		nombreVar.nombre :=nombreV;
		nombreVar.tipo :=tipoV;
		AddNode(nombreVar);
    Val_variablesTipo(tipoV);
		Val_variablesNombre(nombreV);
		imprimirListaVars ;
End;


Procedure Val_variablesNombre(var nombre: String);
var i: Integer;
Begin
   
   for  i:=2 to length(nombre) Do
	 Begin

			if nombre[i] = '/' Then
			Begin
			  ErrorSintactico := False;
				Error := 'Error/Instrucciones antes de la declaracion invalidas';
			End;
	 End;


End;

Procedure Val_variablesTipo(var tipo: String);
Begin
  if tipo = 'numero' Then
	Begin
	
	End
	else if tipo = 'decimal' Then
	Begin

	End
	else if tipo = 'letra' Then
	Begin

	End Else
	Begin
	    ErrorSintactico := False;
			Error := 'Error/Tipo de  variable ('+tipo+') incorrecto. tipos permitidos (numero, decimal, letra) ';
	End ;

End;




Procedure  Val_Inicio(var line: String);
Begin

   {WriteLn('ln',line[0]);}

	 if  line[1]= '{' Then
	 Begin
	    {WriteLn('tiene binpom',length(line));}
			
	 End Else
	 Begin
	      ErrorSintactico := False;
				Error := 'Error/Falta llave "{" en nombre del programa ';
				
	 End;

End;



Procedure  Val_Cierres(var totCodigo: String; tipcierre: Integer);
var i: Integer;
var b: Boolean;
var v: Boolean;
Begin
		{inicializar booleans}
    b:=False;
		v:=False;


		
  	for  i:=1 to length(totCodigo) Do
		Begin
							
				if totCodigo[i] = '}' Then
				Begin
				    b:=True;
				End;
				if totCodigo[i] = ' ' Then
				Begin
				    v:=True;

				End;

				
		End;

    if b = false Then
		Begin
		       ErrorSintactico := False;
				 Error := 'Error/Falta llave "}" = {nombre del Programa}  ';
		End;

		
End;


Procedure IniciarListaV;
Begin
	Head := nil;
	Tail := Head;
End;


Procedure AddNode(StudRec : Variables);
Var
	Node : TNode;

Begin
	Node.nomV := StudRec;
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
   writeln(tmp^.nomV.nombre,' ',tmp^.nomV.tipo);
   tmp := tmp^.sigV;
   end
End;


End.
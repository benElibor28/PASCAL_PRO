program HelloWorld;
uses crt,Dos,analisis,Traducir;


var
 Salida: boolean;
 arch: boolean;
 Opc: integer;
 DirInfo: SearchRec;
 RCK: Text;
 Archivo: array [1..30] of string;
 seleccionado:integer;
 cont: integer;
 valor:string[2];
 cod:integer;




Procedure leerArchivo;
var linea: String;
Begin

		writeln('Digite el numero del Archivo');
		Readln(valor);
		Val(valor,seleccionado,cod);
	  if cod = 0 Then begin
		 if  (seleccionado >= 0) and (seleccionado < cont) Then
			 Begin
		     assign( RCK,Archivo[seleccionado]);
		     reset( RCK );
	       
				 arch := true;
				 writeln('Archivo Cargado correctamente (ENTER volver menu principa)');
			 End
		 Else
		     Begin
			 	 writeln('Digite el numero del Archivo entre los parametros correctos');
					  	leerArchivo;
				 End;
    end
		Else Begin
				 writeln('Digite el numero del Archivo entre los parametros correctos');
					  	leerArchivo;
		end;
End;



Procedure leerDirectorio;
  begin
  FindFirst('*.RCK', Archive, DirInfo); { Igual que DIR *.PAS }
	  while DosError = 0 do
	  begin
	    Writeln(cont ,') ',DirInfo.Name);
			Archivo[cont] := DirInfo.Name;
	    FindNext(DirInfo);
			cont := cont + 1;
	  end;
		leerArchivo;
  end;




procedure CargarArchivo;
Begin
  ClrScr;
  writeln('Archivos para Cargar son: ');
	writeln('');
	cont := 0;
	leerDirectorio;
  readln;
End;



procedure AnalisisSintactico;
Begin
  ClrScr;
	if arch = True Then
	Begin
		writeln('Analizando sintaxis del archivo');
		WriteLn('');
		GetArchivo(RCK);
	end
	Else
    writeln('Cargue Archivo primero');
  readln;
End;

procedure AnalisisSemantico;
Begin
  ClrScr;
  if arch = True Then

	Else
  writeln('Cargue Archivo primero');
  readln;
End;

procedure GenerarPas;
Begin
  ClrScr;
  if arch = True Then
	Begin
		writeln('Generando Archivo .pas');
		WriteLn('');
		GetArchivoP(RCK);
	End
	Else
  writeln('Cargue Archivo primero');
  readln;
End;

procedure MostrarMenuPrincipal;
Begin
  gotoxy(33,2); writeln('MENU PRINCIPAL');
  gotoxy(21,5); writeln('1.- Cargar Archivo.');
  gotoxy(21,7); writeln('2.- Ver analisis Semantico.');
  gotoxy(21,9); writeln('3.- Ver analisis Sintaxico.');
	gotoxy(21,11); writeln('4.- Crear Archivo .pas.');
	gotoxy(21,13); writeln('5.- Salir.');
End;


Procedure opcionesMenu;
Begin
	Salida:= false;
	arch:= false;
  Repeat
    ClrScr;
    MostrarMenuPrincipal;
    gotoxy(40,15); write('Opcion: ');
		readln(valor);
		Val(valor,Opc,cod);
	  if cod = 0 Then
		Begin
     case Opc of
	   1: CargarArchivo;
	   2: AnalisisSemantico;
		 3: AnalisisSintactico;
		 4: GenerarPas;
	   5: Salida:= true;
		end;

	end;
  Until (Salida=true);
End;






{Main}
begin
    {listar;}
    opcionesMenu;

   readkey;
end.
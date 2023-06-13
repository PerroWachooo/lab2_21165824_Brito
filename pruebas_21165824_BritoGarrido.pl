

%Script Profesor

% Creando un sistema, con el disco C, dos usuarios: “user1” y “user2”, 
% se hace login con "user1”, se utiliza el disco "C", se crea la carpeta “folder1”, 
% “folder2”, se cambia al directorio actual “folder1", 
% se crea la carpeta "folder11" dentro de "folder1", 
% se hace logout del usuario "user1", se hace login con “user2”, 
% se crea el archivo "foo.txt" dentro de “folder1”, se acceder a la carpeta c:/folder2, 
% se crea el archivo "ejemplo.txt" dentro de c:/folder2

system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), 
systemSwitchDrive(S5, "C", S6),systemMkdir(S6, "folder1", S7),systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9),systemMkdir(S9, "folder11", S10),
systemLogout(S10, S11), systemLogin(S11, "user2", S12),systemSwitchDrive(S12, "C", S13), systemCd(S13, "folder1", S14), file( "foo.txt", "hello world", F1), 
systemAddFile(S14, F1, S15),systemCd(S15, "/", S16),systemCd(S16,"folder2",S17),file( "ejemplo.txt", "otro archivo", F2), systemAddFile(S17, F2, S18).


% Casos que deben retornar false:
% si se intenta añadir una unidad con una letra que ya existe
system("newSystem", S1), systemRegister(S1, "user1", S2), systemRegister(S2, "user1", S3).

% si se intenta hacer login con otra sesión ya iniciada por este usuario u otro, entrega falso.
system("newSystem", S1), systemRegister(S1, "user1", S2), systemRegister(S2, "user2", S3), systemLogin(S3, "user1", S4), systemLogin(S4, "user2", S5).

% si se intenta usar una unidad inexistente
system("newSystem", S1), systemRegister(S1, "user1", S2), systemLogin(S2, "user1", S3), systemSwitchDrive(S3, "K", S4).


% si se intenta crear un archivo con un nombre que ya existe
system("newSystem", S1), systemRegister(S1, "user1", S2), systemLogin(S2, "user1", S3), systemSwitchDrive(S3, "C", S4), file( "foo.txt", "hello world", F1),
systemAddFile(S4, F1, S5), file( "foo.txt", "hello world", F2), systemAddFile(S5, F2, S6).

% si se intenta crear un archivo en un directorio inexistente
system("newSystem", S1), systemRegister(S1, "user1", S2), systemLogin(S2, "user1", S3), systemSwitchDrive(S3, "C", S4), file( "foo.txt", "hello world", F1),
systemAddFile(S4, F1, S5), systemCd(S5, "folder1", S6), file( "foo.txt", "hello world", F2), systemAddFile(S6, F2, S7).


%-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

%crea 3 system distintos
system("newSystem", S1), system("newSystem", S2), system("newSystem", S3).

%se añaden 3 drives a cada system
systemAddDrive(S1, "C", "OS", 10000000000, S2), 
systemAddDrive(S2, "D", "DATA", 10000000000, S3), 
systemAddDrive(S3, "E", "DATA", 10000000000, S4),
%Se intenta crear un drive con una letra que ya existe, entrega falso
systemAddDrive(S4, "C", "DATA", 10000000000, S5).


%se crean 2 usuarios en un system
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemRegister(S2, "Juan", S3).

%se crea un usuario en un system y se intenta crear otro con el mismo nombre, deberia entregar falso
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemRegister(S2, "Jorge", S3).

%comprueba que un nombre exista en una lista con la funcion existeNombre, entrega true
existeNombre( ["Jorge", "Juan"],"Jorge").
%comprueba que un nombre exista en una lista con la funcion existeNombre, entrega false
existeNombre( ["Jorge", "Juan"],"Pedro").

%se crea un usuario en un system y se intenta hacer login con otro usuario, deberia entregar falso
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Juan", S3).

%se crea un usuario en un system y se hace login con el usuario, y se hace denuevo login con el mismo usuario, deberia entregar el mismo system.
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemLogin(S3, "Jorge", S4).


%se crea un usuario en un system y se hace login con el usuario, y se hace logout, deberia entregar el mismo system.
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemLogout(S3, S4).

%se crea un usuario en un system y se hace login con el usuario, y se hace logout, y se hace logout denuevo, deberia entregar falso.
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemLogout(S3, S4), systemLogout(S4, S5).



%se crea un drive en un system, y un usuario, se cambia a ese drive.
system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "Jorge", S3), systemLogin(S3, "Jorge", S4), systemSwitchDrive(S4, "C", S5).
%se crean 2 drives y un usuario, se cambia a un drive y se cambia al otro.
system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemAddDrive(S2, "D", "DATA", 10000000000, S3), systemRegister(S3, "Jorge", S4), systemLogin(S4, "Jorge", S5), systemSwitchDrive(S5, "C", S6), systemSwitchDrive(S6, "D", S7).

%se crea un drive en un system, y un usuario, se cambia a ese drive, y se intenta cambiar a un drive que no existe, deberia entregar falso.
system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "Jorge", S3), systemLogin(S3, "Jorge", S4), systemSwitchDrive(S4, "C", S5), systemSwitchDrive(S5, "D", S6).


%se crea un folder en un drive, y un usuario, se cambia a ese drive, se cambia a ese folder.
system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "Jorge", S3), systemLogin(S3, "Jorge", S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemCd(S6, "folder1", S7).

%se crea un usuario, un drive, un folder, luego se crea un folder con el mismo nombre.
system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "Jorge", S3), systemLogin(S3, "Jorge", S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemMkdir(S6, "folder1", S7).

%se crea un usuario, un drive, un folder, luego se crea un folder, se ingresa a el y se crea un archivo dentro, luego vuelve atras y se crea otro folder con el mismo nombre, pero vacio, se remplaza la carpeta existente
system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "Jorge", S3), systemLogin(S3, "Jorge", S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemCd(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "..", S9), systemMkdir(S9, "folder1", S10).


%Comprueba que un elemento esta en una lista, entrega la lista, devuelve lel elemento
estaenlalista( [["Jorge",5], ["Juan",2]],"Jorge", X). %Devuelve 

%Comprueba que un elemento esta en una lista, entrega la lista, devuelve false
estaenlalista( [["Jorge",5], ["Juan",2]],"Pedro", X).

%Comprueba que un elemento esta en una lista, entrega la lista, devuelve true
estaenlalista( [["Jorge",5], ["Juan",2]],"Juan", _).


%Usa noestaenlalista y Devuelve los elementos que no esten en la lista.
noestaenlalista( [["Jorge",5], ["Juan",2]],"Jorge", X). %Devuelve [["Juan",2]]

%Usa noestaenlalista y Devuelve los elementos que no esten en la lista.
noestaenlalista( [["Jorge",5], ["Juan",2]],"Pedro", X). %Devuelve [["Jorge",5], ["Juan",2]]

%Usa noestaenlalista y entrega true
noestaenlalista( [["Jorge",5], ["Juan",2]],"Pedro", _). %Devuelve true


%se crea un system, se crea y loguea un usuario, se crea un drive y se cambia a el, se crean con folder y subfolders, y se ingresa y vuelve a la raiz.
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemCd(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "/", S9).

%se crea un systema, usuario, se loguea el usuario, se crea un drive y se cambia a el, se crea una carpeta y se usa cdsystem con la variante que te deja donde mismo.
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemCd(S6, "folder1", S7), systemCd(S7, ".", S8).

%lo mismo
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemCd(S6, "folder1", S7), systemCd(S7, ""./././.", S8).

%lo mismo
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemCd(S6, "folder1", S7), systemCd(S7, "./", S8).


%divide "/folder" por slash y lo deja en una lista
dividir_string_por_slash("/folder", X).%Entrega ["folder"]
%divide "folder" por slash y lo deja en una lista
dividir_string_por_slash("folder", X).%Entrega ["folder"]

%lo mismo pero por punto
dividir_string_por_punto("folder", X).%Entrega ["folder"]
dividir_string_por_punto("archivo.txt", X).%Entrega ["archivo", "txt"]

%se crea un systema con usuario, drive,una carpeta, y un archivo y se le añade un file a la carpeta creada
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemCd(S6, "folder1", S7), 
file("archivo.txt", "contenido", F1), systemAddFile(S7, F1, S8).

%lo mismo que el anterior, pero se crea un archivo con el mismo nombre pero distinto contenido y formato 
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemCd(S6, "folder1", S7),
file("archivo.txt", "contenido", F1), systemAddFile(S7, F1, S8), file("archivo.doc", "papa", F2), systemAddFile(S8, F2, S9).

%se inserta 2 files con el mismo nombre, pero distinto contenido. %Se replaza el archivo anterior por el nuevo.
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5),
file("archivo.txt", "contenido", F1), systemAddFile(S5, F1, S6), file("archivo.txt", "papa", F2), systemAddFile(S6, F2, S7).

%Crea un archivo y luego lo borra
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), file("archivo.txt", "papa", F2), systemAddFile(S5, F2, S6),systemaDel(S6,"archivo.txt",S7).

%lo mismo que el anterior pero con una carpeta
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4),systemSwitchDrive(S4, "C", S5),
systemMkdir(S5, "folder1", S6), systemaDel(S6,"folder1",S7).

%lo mismo que el anterior pero se usa "*.*"
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), file("archivo.txt", "papa", F2), systemAddFile(S5, F2, S6),systemaDel(S6,"*.*",S7).

%se intenta borrar un archivo que no existe, el systema no cambia.
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3),
systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5),
systemMkdir(S5, "folder1", S6), systemCd(S6, "folder1", S7), systemaDel(S7,"archivo.txt",S8).

%Se crean 2 carpetas un archivo dentro de la primera y se copia a la otra carpeta
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemMkdir(S6, "folder2", S7),
systemCd(S7, "folder1", S8), 
file("archivo.txt","contenido", F1), systemAddFile(S8, F1, S9),systemCopy(S9,"archivo.txt","C:/folder2",S10).

%se crea un file y se le cambia el nombre
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemMkdir(S6, "folder2", S7),
systemCd(S7, "folder1", S8), 
file("archivo.txt","contenido", F1), systemAddFile(S8, F1, S9),systemRen(S9,"archivo.txt","Prueba.hola",S10).

%Se crean 2 carpetas y se muestra con dir
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemMkdir(S6, "folder2", S7),
systemCd(S7, "/", S8), systemDir(S8,[],String).


%Se crea un drive con dos carpetas y luego se formatea el drive
system("newSystem", S1), systemRegister(S1, "Jorge", S2), systemLogin(S2, "Jorge", S3), systemAddDrive(S3, "C", "OS", 10000000000, S4), systemSwitchDrive(S4, "C", S5), systemMkdir(S5, "folder1", S6), systemMkdir(S6, "folder2", S7),
systemFormat(S7,"C","NewOS",S8).

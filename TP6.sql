--Ex1
CREATE  OR REPLACE  FUNCTION quiEsTu (codeAc IN number) 
     return varchar2  is nomAc varchar2(60);
  
BEGIN
   select Nom into nomAc from acteur WHERE codeAc=codea;
   return nomac;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
     return 'no data found';
         
END quiEsTu;
set serveroutput on;
DECLARE
funct varchar2(60) ;
 
BEGIN
funct :=quiEsTu(1004);
dbms_output.put_line(funct);
--select quiEsTu(codeAc) into funct from dual;
END;
select * from Acteur;
select * from jouer;
--Ex2
select * from Film;


SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE mesFilms  (codeACT IN number)as titrefilm film.titre%type;
cursor c1 is select titre  from film  f , jouer j , acteur a 
where f.codef=j.codef and a.codea=j.codea and a.codea=codeACT;
begin
open c1;
loop
fetch c1 into titrefilm;
exit when c1%notfound;
DBMS_OUTPUT.put_line ('Le film n"existe pas');
end loop ;
close c1;
exception 
when  NO_DATA_FOUND THEN
DBMS_OUTPUT.put_line('no data ');
end mesFilms;

BEGIN
mesFilms(1001);
END;


--Ex3
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE maxMinSalaire(codeMaxA out number,codeMinA out number) as  
maxJouer NUMBER(10);
minJouer NUMBER(10);
begin
select max(salaire),min(salaire) into maxJouer,minJouer from jouer;
select codeA into codeMaxA from jouer where maxJouer=salaire;
select codeA into codeMinA from jouer where minJouer=salaire;
DBMS_OUTPUT.PUT_LINE(codeMaxA || codeMaxA);
end;

SET SERVEROUTPUT ON
declare 
v_max NUMBER(5);
v_min NUMBER(5);
n_Max varchar2(20);
n_Min varchar2(20);
BEGIN
maxMinSalaire(v_max,v_min);
select nom into n_Max from acteur where codeA=v_max;
select nom into n_Min from acteur where codeA=v_min;
DBMS_OUTPUT.PUT_LINE('max '||n_Max || ' min ' || n_Min);
END;



--Ex4
create or replace procedure majAge (codeAc in number) as ageAc number;
BEGIN
  select age into ageAc from acteur where codea=codeac;
  ageAc:=ageAc+1;
  update acteur set age=ageAc where codea=codeac;
END majAge;
SET SERVEROUTPUT ON
declare
BEGIN
majAge(1001);
DBMS_OUTPUT.PUT_line('opération terminée');
end;




--Ex5
create or replace procedure insertion (codeAc out number , codeF out number ,salaire out number) 
as codeAc jouer.codea%type ;
codeFilm jouer.codef%type;
salaireAc jouer.salaire%type;
begin
codeAc:=&donner_code_acteur;
codeFilm:=&donner_code_film;
salaireAc:=&donner_salaire;
insert into jouer(codea, codef, salaire) values (codeAc,codeFilm,salaireAc);
DBMS_OUTPUT.PUT_line('Ligne insérée avec succès');
end;



--Ex6
create or replace FUNCTION messalaires (codeAct in number)  return number 
as saltotale NUMBER(20);
begin
select Sum(salaire) into saltotale from jouer where codea=codeact;
if saltotale is null then
   return 0;
   end if;
return  saltotale;
end;

SET SERVEROUTPUT ON 
DECLARE
Sal number(20) ;
BEGIN
Sal :=messalaires(1004);
dbms_output.put_line(Sal);
END;
select * from jouer;

--Ex7
create or replace PROCEDURE mesacteurs (codefilm in number) as nomAct acteur.nom%type;
cursor c1 is select nom from acteur a , jouer j, film f where codefilm=f.codef and j.codef=f.codef and a.codea=j.codea;
BEGIN
  open c1;
  DBMS_OUTPUT.PUT_LINE('acteurs jouent : ');
  loop
  FETCH c1 INTO nomAct;
  exit when c1%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE(nomAct);
  end loop;
END;
SET SERVEROUTPUT ON 
BEGIN
mesacteurs(104);
END;




--Ex8

create or replace procedure mesdepenses  (codeFilm number) as salary jouer.salaire%type;
BEGIN
  select Sum(salaire) into salary from acteur a, jouer j where a.codea=j.codea and j.codef=codeFilm;
  if salary is null then
   salary:= 0;
   end if;
    DBMS_OUTPUT.PUT_LINE(salary);
END;

SET SERVEROUTPUT ON 

BEGIN
mesdepenses(102);
END;

select * from jouer;

--NewTP
create table participant (
numP number(5) primary key,
nom varchar2(30),
dateNaiss date,
ville varchar2(20));

create table competition (
codeC number(4) primary key,
design varchar2(20),
type varchar2(20),
dateDebut date,
dateFin date,
tempsQualif number);

create table resultat (
numP number(5) references participant(numP),
codeC number(4) references competition(codeC),
dateRes date,
temps number,
qualifie varchar2(5),
constraint resultat_pk primary key (numP,codeC,dateRes));

insert into participant values 
(10000, 'Amine Hached', '12/04/2000', 'Korba');
insert into participant values
(10001, 'Rihab Hilel', '06/02/1998', 'Tunis');
insert into participant values
(10002, 'Donia Amri', '10/10/2001', 'Nabeul');
insert into participant values
(10003, 'Hedi Kaabi', '19/11/1999', 'Hammamet');
insert into participant values
(10004, 'Fadi Sebai', '27/09/2000', 'Djerba');
insert into participant values
(10005, 'Majdi Baklouti', '24/12/2002', 'Zaghouan');

insert into competition values 
(2000, 'Run with me','Course', '30/01/2021','30/01/2021', 45);
insert into competition values 
(2001, 'Marathon ensemble','Marathon', '10/02/2021','10/02/2021', 400);
insert into competition values 
(2002, 'Course de chevaux','Equitation', '04/03/2021','05/03/2021', 20);

insert into resultat values
(10000, 2000, '30/01/2021', 44, NULL);
insert into resultat values
(10002, 2000, '30/01/2021', 45, NULL);
insert into resultat values
(10003, 2000, '30/01/2021', 46, NULL);
insert into resultat values
(10005, 2000, '30/01/2021', 43, NULL);
insert into resultat values
(10001, 2001, '10/02/2021', 404, NULL);
insert into resultat values
(10002, 2001, '10/02/2021', 395, NULL);
insert into resultat values
(10004, 2001, '10/02/2021', 386, NULL);
insert into resultat values
(10005, 2001, '10/02/2021', 393, NULL);
insert into resultat values
(10000, 2002, '04/03/2021', 18, NULL);
insert into resultat values
(10001, 2002, '04/03/2021', 21, NULL);
insert into resultat values
(10002, 2002, '04/03/2021', 20, NULL);
insert into resultat values
(10003, 2002, '05/03/2021', 16, NULL);
insert into resultat values
(10004, 2002, '05/03/2021', 19, NULL);
insert into resultat values
(10005, 2002, '05/03/2021', 17, NULL);


create table etudiant (
cin number(8) primary key,
nom varchar2(30),
classe varchar2(30),
NNP number(4),
DS number(4),
exam number(4),
moyenne number(4));

insert into etudiant values (11111111, 'mohamed sahli','DSI23',10,11,12,13);
insert into etudiant values (22222222, 'salma sahli','DSI22',12,13,12,10);
insert into etudiant values (33333333, 'selim khalil','DSI21',17,15,12,13);
insert into etudiant values (44444444, 'aziz selim','DSI22',16,12,12,14);
insert into etudiant values (55555555, 'khalil aziz','DSI23',10,15,15,15);
insert into etudiant values (66666666, 'firas ben hassine','DSI23',18,11,18,17);
insert into etudiant values (77777777, 'amal hlioui','DSI21',19,18,14,16);
insert into etudiant values (88888888, 'rim driss','DSI22',10,15,19,14);
insert into etudiant values (99999999, 'wiem farhat','DSI21',10,15,15,14);

--ex1
create or replace FUNCTION produits (nb1  number,nb2  number) 
return number is multiplication number;

begin
multiplication:=nb1*nb2;
RETURN multiplication;
end;


SET SERVEROUTPUT ON ;
DECLARE
    functMult NUMBER; 
BEGIN
    functMult := produits(10, 2);
    dbms_output.put_line(functMult);
END;

create or replace procedure permuter (nbr1 in out number , nbr2 in out number) as  aux number;
begin
 aux:=nbr1;
 nbr1:=nbr2;
 nbr2:=aux;
 end; 
 
 set serveroutput on;
 declare
 a number:=10;
 b number:=20;
 begin
 dbms_output.put_line(a || b);
 permuter(a,b);
  dbms_output.put_line(a || b);
 end;

--
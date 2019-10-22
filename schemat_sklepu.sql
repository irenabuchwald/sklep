drop table if exists szczegoly;
drop table if exists produkty;
drop table if exists stawka_VAT;
drop table if exists statusy_zamowien;
drop table if exists statusy_zamówień;
drop table if exists zamowienia;
drop table if exists zamówienia;
drop table if exists klienci;

/*
delete from statusy_zamowien;
delete from zamowienia;
delete from produkty;
delete from klienci;
delete from stawka_VAT;
*/

create table stawka_VAT (id_stawka_VAT int primary key,	-- nazwa kolumny stawka_VAT.id_stawka_VAT				
					nazwa  varchar (150),
                    procent numeric (3,2)); 

create table produkty (id_produktu int auto_increment primary key,
					nazwa varchar (150) not null,
                    cena_netto DECIMAL(10,2),
                    id_stawka_VAT int not null,
					foreign key (id_stawka_VAT) references stawka_VAT(id_stawka_VAT));   
                    
create table klienci (id_klienta int auto_increment primary key,
								nazwa varchar(500) not null,
                                kraj varchar(16) default 'Polska',
                                kod_pocztowy varchar (6),
								miasto varchar(64),
								ulica varchar (128),
								numer varchar(10));
             
create table zamowienia (id_zamowienia int auto_increment primary key,
						id_klienta int not null,
						foreign key (id_klienta) references klienci(id_klienta));
                        
                      --  select * from zamowienia;
                        
create table statusy_zamowien (id_zamowienia int,
								data datetime,
                                status varchar(20) not null,
                                primary key(id_zamowienia, data),
                                foreign key (id_zamowienia) references zamowienia(id_zamowienia));
                                
create table szczegoly (id_zamowienia int,
						LP int,
                        id_produktu int,
                        ilosc numeric(8,2) not null,
                        rabat numeric(3,2),
                        primary key(id_zamowienia, LP),
                        foreign key(id_zamowienia) references zamowienia(id_zamowienia),
                        foreign key(id_produktu) references produkty(id_produktu));
                        
                        
create or replace view szczegoly_zamowien as
select id_zamowienia,
       LP,
	   produkty.nazwa as nazwa_produktu,
       ilosc,
       cena_netto,
       ifnull(rabat, '--') as rabat,
       FORMAT(cena_netto*ilosc*(1-ifnull(rabat, 0)), 2) as wartosc_netto,
       stawka_VAT.nazwa as stawka_vat,
       FORMAT(cena_netto*ilosc*(1-ifnull(rabat, 0)*procent), 2) as VAT,
       FORMAT(cena_netto*ilosc*(1-ifnull(rabat, 0)*(procent+1)), 2) as wartosc_brutto
 from szczegoly, produkty, stawka_VAT
where produkty.id_produktu = szczegoly.id_produktu
  and produkty.id_stawka_VAT = stawka_VAT.id_stawka_VAT;
  
insert into stawka_VAT(id_stawka_VAT, nazwa, procent) values(1,'23%',0.23);

insert into stawka_VAT(id_stawka_VAT, nazwa, procent) values(2,'8%',0.08);

insert into stawka_VAT(id_stawka_VAT, nazwa, procent) values(3, '5%',0.05);

insert into stawka_VAT(id_stawka_VAT, nazwa, procent) values(4, '0%',0.00);

insert into stawka_VAT(id_stawka_VAT, nazwa, procent) values(5, 'nie podlega',0.00);


-- select * from stawka_VAT;
                            
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('zielony rowerek biegowy', '754.00', 1);
set @ziel_ro_bieg = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('hulajnoga elektryczna', '1645.50', 2);
set @hul_ele = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('wrotki retro', '399.99', 1);
set @wrotki_retro = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('rolki', '549.22', 1);
set @rolki = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('czerwony rowerek biegowy', '954.00', 1);
set @czer_ro_bie = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('hulajnoga napędzana noga', '905.00', 2);
set @hul_nap_noga = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('ochraniacze na lokcie', '150.23', 4);
set @ochr_na_lok = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('ochraniacze na kolana', '170.78', 4);
set @ochr_na_lok = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('ochraniacz na twarz', '650.00', 4);
set @ochr_na_twa = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('kask sportowy zielony', '458.00', 5);
set @kask_spor_ziel = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('kask sportowy czerwony', '505.00', 5);
set @kask_spor_czer = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('wrotki nowoczesne', '299.99', 1);
set @wrot_nowo = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('deskorolka elektryczna', '599.99', 3);
set @desko_elek = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('gokard elektryczny zielony', '5999.99', 3);  
set @go_elek_ziel = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('gokard elektryczny czarny', '6500.00', 3); 
set @go_elek_czar = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('segway', '4300.00', 1); 
set @segway = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('monocykl elektryczny', '1000.00', 3); 
set @mono_elektr= last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('skuter elektryczny czarny', '12199.99', 2); 
set @sku_elek_czarny = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('skuter elektryczny bialy', '13199.99', 2);
set @sku_elek_bialy= last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('niebieski rowerek biegowy', '754.00', 1);
set @nie_ro_bie = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('czerwony rowerek biegowy', '123.00', 1);
set @czer_ro_bie = last_insert_id();

-- select *from produkty;

-- select * from szczegoly;
							
alter table klienci auto_increment=10000;
-- zamowienie 1. 3 pozycje, rabat w 3.

                                
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Jasio Wysoki', 'Polska', '52-658', 'lodz', 'sw. Teresy od Dzieciatka Jezus', '289');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @kask_spor_czer, 2);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 2, @ziel_ro_bieg, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 3, @czer_ro_bie, 1, 0.05);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-01 12:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-10 10:13:15','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2020-01-11 11:13:15','zrealizowane');

-- zamowienie 2, cztery poztycje, rabat w 2

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values  ('Ministerstwo Sprawiedliwosci', 'Polska', '00-950', 'Warszawa', 'Al. Ujazdowskie', '11');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @go_elek_czar, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 2, @czer_ro_bie, 2, 0.02);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 3, @kask_spor_czer, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 4, @sku_elek_czarny, 1);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-03 12:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-03 12:13:30','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2020-01-10 11:13:15','zrealizowane');


-- zamówienie 3, jedna pozycja, bez rabatu

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Gabinet Dziwnych Krokow', 'Polska', '00-000', 'Warszawa', 'Zartobliwa', '18');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @ziel_ro_bieg, 1);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-06 01:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-08 19:25:50','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2020-01-12 15:25:15','zrealizowane');
-- 4 zamowienie

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values  ('Surf&Skate Wave Summer Camp', 'Polska', '59-258', 'Warszawa', 'Gorczewska', '147');
set @last_klient_id = last_insert_id();

insert into zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 1, @czer_ro_bie, 2, 0.02);
insert into szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 2, @hul_ele, 12, 0.06);
insert into szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 3, @wrotki_retro, 3, 0.02);
insert into szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 4, @rolki, 1);
insert into szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 5, @czer_ro_bie, 3, 0.05);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-04 02:23:35','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-04 02:25:00','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2020-01-21 08:43:36','zrealizowane');

--
/*
select LP,
	   produkty.nazwa,
       ilosc,
       cena_netto,
       ifnull(rabat, '--') as rabat,
       FORMAT(cena_netto*ilosc*(1-ifnull(rabat, 0)), 2) as wartosc_netto,
       stawka_VAT.nazwa,
       FORMAT(cena_netto*ilosc*procent*(1-ifnull(rabat, 0)), 2) as VAT,
       FORMAT(cena_netto*ilosc*(procent+1)*(1-ifnull(rabat, 0)), 2) as wartosc_brutto
 from zamowienia, szczegoly, produkty, stawka_VAT
where szczegoly.id_zamowienia = zamowienia.id_zamowienia
  and produkty.id_produktu = szczegoly.id_produktu
  and produkty.id_stawka_VAT = stawka_VAT.id_stawka_VAT
order by LP;
*/
/*
select * from szczegoly_zamowien
where id_zamowienia = 1
order by id_zamowienia, LP;

select id_zamowienia, sum(wartosc_netto), sum(vat), sum(wartosc_brutto) from szczegoly_zamowien
where id_zamowienia = 1
group by id_zamowienia;

select id_zamowienia, status 
  from statusy_zamowien z1
 where data = (select max(data) from statusy_zamowien z2 where data<NOW() and z2.id_zamowienia=z1.id_zamowienia);

select id_zamowienia, max(data)
from statusy_zamowien
where data<NOW()
group by id_zamowienia;
*/
/*
iNSERT INTO zamowienia (id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-01 12:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-10 10:13:15','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-11 11:13:15','zrealizowane');
iNSERT INTO zamowienia (id_klienta, data) values (@last_klient_id, NOW());
set @last_zamowienie_id = last_insert_id();

iNSERT INTO zamowienia (id_klienta, data) values (@last_klient_id, NOW());
set @last_zamowienie_id = last_insert_id();
-- ...
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('EURO-net Sp. z o.o.', 'Polska', '02-447', 'Warszawa',  'Muszkieterow', '254');
set @last_klient_id = last_insert_id();
iNSERT INTO zamowienia (id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();






insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Centrum Leczniczo-Rehabilitacyjne i Medycyny Pracy ATTIS Sp. z o.o.', 'Polska', '55-650','Warszawa', 'Gorczewska', '78');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Osrodek Wypoczynkowy Marysienka', 'Polska', '26-400', 'Przysucha', 'Topornia', '23');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Osrodek Wypoczynkowy Relax', 'Polska', '85-134', 'Radom', 'Klasztorna', '65');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Osrodek Reprezentacyjny Ministerstwa Obrony Narodowej', 'Polska', '05-800', 'Pruszkow', 'Grodziska', '1');					
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Department of Child and Adolescent Psychiatry', 'Polska', '60-567', 'Poznan', 'Szpitalna', '27/33');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Poradnia Rehabilitacyjna dla Dzieci im. Wladyslawa Basiaka', 'Polska', '26-610', 'Radom', 'Mikolaja Reja', '26');
 
select *from klienci;

                                           
select*from zamowienia;    
				                      
insert into statusy_zamowien (id_zamowienia, data, status) values (2,'2019-03-10 10:05:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (3,'2019-05-10 10:22:22','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (4,'2019-05-15 11:25:59','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (5,'2019-05-15 12:34:25','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (6,'2019-05-16 19:39:23','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (7,'2019-05-16 22:00:57','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (8,'2019-05-20 01:04:12','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (9,'2019-05-20 18:29:04','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (10,'2019-06-08 15:48:14','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (11,'2019-06-09 22:15:16','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (12,'2019-06-09 23:23:03','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (13,'2019-06-11 07:03:07','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (14,'2019-06-12 08:12:58','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (15,'2019-06-16 08:22:23','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (16,'2019-06-18 10:23:34','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (17,'2019-06-18 22:28:54','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (18,'2019-06-18 02:12:24','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (19,'2019-06-19 23:58:58','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (20,'2019-06-20 03:54:28','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (21,'2019-06-21 13:23:23','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (22,'2019-06-20 13:14:23','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (23,'2019-06-22 12:19:49','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (24,'2019-06-23 13:12:42','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (25,'2019-06-24 23:22:22','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (26,'2019-06-25 05:06:02','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (27,'2019-06-28 20:19:25','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (28,'2019-06-30 02:25:28','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (29,'2019-06-30 12:00:00','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (30,'2019-06-30 18:45:25','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (31,'2019-07-02 12:49:45','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (32,'2019-07-03 22:52:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (33,'2019-07-04 15:12:45','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (34,'2019-07-04 22:32:54','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (35,'2019-07-05 12:22:22','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (36,'2019-07-05 22:15:45','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (37,'2019-07-08 08:23:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (38,'2019-07-12 04:00:01','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (39,'2019-07-15 08:18:23','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (40,'2019-07-14 17:23:45','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (41,'2019-07-15 11:24:49','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (42,'2019-07-16 22:29:28','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (43,'2019-07-17 12:09:45','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (44,'2019-07-18 10:15:58','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (45,'2019-07-22 21:22:21','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (46,'2019-07-22 23:59:21','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (47,'2019-07-25 02:59:44','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (48,'2019-07-27 04:25:55','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (49,'2019-07-28 12:32:45','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (50,'2019-07-28 22:35:33','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (2,'2019-03-11 10:05:15','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (3,'2019-05-10 10:50:22','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (4,'2019-07-31 19:59:29','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (5,'2019-05-15 12:25:39','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (6,'2019-05-16 20:00:23','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (7,'2019-05-16 22:05:48','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (8,'2019-05-20 01:10:03','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (9,'2019-05-31 15:04:24','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (10,'2019-06-02 13:45:44','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (11,'2019-06-09 15:28:35','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (12,'2019-06-11 10:14:46','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (13,'2019-06-09 23:45:43','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (14,'2019-06-11 07:03:07','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (15,'2019-06-16 10:22:28','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (16,'2019-06-18 18:56:58','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (17,'2019-06-18 22:35:24','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (18,'2019-06-22 04:14:43','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (19,'2019-06-20 00:15:24','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (20,'2019-06-25 12:45:45','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (21,'2019-06-21 15:13:26','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (22,'2019-06-22 17:13:54','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (23,'2019-06-24 12:15:43','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (24,'2019-06-22 15:14:45','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (25,'2019-06-25 04:02:22','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (26,'2019-06-28 15:16:12','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (27,'2019-06-28 21:18:32','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (28,'2019-07-12 12:45:32','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (29,'2019-06-30 13:00:00','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (30,'2019-07-14 08:49:57','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (31,'2019-07-02 12:52:09','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (32,'2019-07-07 14:16:45','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (33,'2019-07-04 18:22:15','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (34,'2019-07-24 12:35:34','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (35,'2019-07-06 14:25:45','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (36,'2019-07-06 08:26:49','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (37,'2019-07-08 08:28:28','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (38,'2019-07-12 08:05:41','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (39,'2019-07-29 18:23:20','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (40,'2019-07-14 17:29:58','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (41,'2019-07-16 10:54:31','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (42,'2019-07-18 02:09:20','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (43,'2019-07-17 12:10:55','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (44,'2019-07-18 10:19:05','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (45,'2019-07-22 21:25:31','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (46,'2019-07-26 03:09:29','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (47,'2019-07-27 04:25:55','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (48,'2019-07-27 04:31:52','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (49,'2019-07-30 08:52:48','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (50,'2019-07-28 22:43:42','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (2,'2019-03-12 12:55:15','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (3,'2019-05-11 10:50:22','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (4,'2019-08-03 23:59:29','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (5,'2019-05-19 12:31:29','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (6,'2019-05-20 12:00:23','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (7,'2019-05-19 15:04:12','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (8,'2019-05-21 08:19:00','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (9,'2019-06-02 13:45:44','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (10,'2019-06-10 09:15:22','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (11,'2019-06-12 14:14:14','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (12,'2019-06-13 09:15:15','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (13,'2019-06-12 08:08:47','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (14,'2019-06-18 10:59:58','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (15,'2019-06-19 10:50:50','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (16,'2019-06-23 11:13:30','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (17,'2019-06-19 11:12:58','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (18,'2019-06-20 00:15:24','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (19,'2019-06-21 08:14:45','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (20,'2019-06-28 18:49:05','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (21,'2019-06-23 12:18:57','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (22,'2019-06-26 10:19:03','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (23,'2019-06-27 11:10:53','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (24,'2019-06-25 15:03:12','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (25,'2019-06-26 09:59:59','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (26,'2019-06-30 09:22:42','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (27,'2019-06-29 09:48:52','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (28,'2019-07-13 14:16:58','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (29,'2019-07-30 18:10:35','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (30,'2019-07-18 09:15:07','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (31,'2019-07-04 08:12:21','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (32,'2019-07-10 11:15:23','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (33,'2019-07-06 16:29:55','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (34,'2019-07-31 08:21:04','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (35,'2019-07-10 15:04:45','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (36,'2019-07-08 08:15:03','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (37,'2019-07-09 11:35:48','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (38,'2019-07-15 15:55:58','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (39,'2019-07-31 12:45:45','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (40,'2019-07-17 14:59:08','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (41,'2019-07-18 08:54:58','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (42,'2019-07-19 12:07:58','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (43,'2019-07-17 12:12:55','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (44,'2019-07-18 12:19:05','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (45,'2019-07-23 17:42:28','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (46,'2019-07-28 08:12:45','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (47,'2019-07-29 10:22:59','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (48,'2019-07-27 16:22:21','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (49,'2019-07-31 16:45:18','zrealizowane');
insert into statusy_zamowien (id_zamowienia, data, status) values (50,'2019-07-31 12:48:52','zrealizowane');

select*from statusy_zamowien; 
*/

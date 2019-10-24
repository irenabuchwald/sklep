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
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('hulajnoga napedzana noga', '905.00', 2);

set @hul_nap_noga = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('ochraniacze na lokcie', '150.23', 4);
set @ochr_na_lok = last_insert_id();
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('ochraniacze na kolana', '170.78', 4);
set @ochr_na_kol = last_insert_id();
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
-- zamowienie 1. 3 pozycje, rabat w 3, zamowienie zrealizowane po roku

                                
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Jasio Wysoki', 'Polska', '52-658', 'Lodz', 'sw. Teresy od Dzieciatka Jezus', '289');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @kask_spor_czer, 2);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 2, @ziel_ro_bieg, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 3, @czer_ro_bie, 1, 0.05);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-01 12:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-10 10:13:15','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2020-01-11 11:13:15','zrealizowane');

-- zamowienie 2, cztery poztycje, rabat w 2, niezrealizowane, po oplaceniu status zlozone

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
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-10 11:13:15','zlozone');


-- zamówienie 3, jedna pozycja, bez rabatu

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Gabinet Dziwnych Krokow', 'Polska', '00-000', 'Warszawa', 'Zartobliwa', '18');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @ziel_ro_bieg, 1);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-06 01:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-08 19:25:50','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-12 15:25:15','zrealizowane');
-- 4 zamowienie, 3 pozycje z rabatem, jedna bez rabatu, różne stawki rabatu, w 1 i 5 pozycji zamowienia jest ten sam towar, ale z roznym rabatem

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values  ('Surf&Skate Wave Summer Camp', 'Polska', '59-258', 'Warszawa', 'Gorczewska', '147');
set @last_klient_id = last_insert_id();

insert into zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 1, @czer_ro_bie, 2, 0.02);
insert into szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 2, @hul_ele, 2, 0.06);
insert into szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 3, @wrotki_retro, 3, 0.02);
insert into szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 4, @rolki, 1);
insert into szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 5, @czer_ro_bie, 1, 0.05);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-04 02:23:35','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-04 02:25:00','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-21 08:43:36','zrealizowane');

-- zamowienie 5. przelom roku, jeda pozycja z rabatem, zlozone w 2018, zrealizowane w 2019.

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Centrum Leczniczo-Rehabilitacyjne i Medycyny Pracy ATTIS Sp. z o.o.', 'Polska', '55-650','Warszawa', 'Gorczewska', '78');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 1, @hul_nap_noga, 1, 0.05);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 2, @ochr_na_lok, 1, 0.02);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 3, @ochr_na_kol, 1, 0.01);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 4, @ochr_na_twa, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 5, @kask_spor_ziel, 1, 0.03);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2018-12-30 12:03:05','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2018-12-31 14:25:00','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-02 08:43:36','zrealizowane');


-- zamowienie 6. powtorzone zamowienie nr 1,  3 pozycje, rabat w 3, zamowienie zrealizowane po roku
                                
-- insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Jasio Wysoki', 'Polska', '52-658', 'Lodz', 'sw. Teresy od Dzieciatka Jezus', '289');
-- set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @kask_spor_czer, 2);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 2, @ziel_ro_bieg, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 3, @czer_ro_bie, 1, 0.05);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-01 12:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-10 10:13:15','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2020-01-11 11:13:15','zrealizowane');

-- zamowienie 7. Dwie pozycje bez rabatu

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Osrodek Wypoczynkowy Marysienka', 'Polska', '26-400', 'Przysucha', 'Topornia', '23');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @wrot_nowo, 4);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 2, @desko_elek, 1);


insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-11 02:52:55','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-10 11:18:35','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-11 19:43:28','zrealizowane');


-- zamowienie 8. Dwie pozycje bez rabatu. Natychmiastowa platnosc.

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Osrodek Wypoczynkowy Relax', 'Polska', '85-134', 'Radom', 'Klasztorna', '65');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1,  @go_elek_ziel, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 2, @go_elek_czar, 1);


insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-12 08:55:05','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-12 08:59:35','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-16 09:04:45','zrealizowane');

-- zamowienie 9. Trzy pozycje, w trzeciej jest rabat. 
                                
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Osrodek Reprezentacyjny Ministerstwa Obrony Narodowej', 'Polska', '05-800', 'Pruszkow', 'Grodziska', '1');	
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1,  @sku_elek_czarny, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 2,  @sku_elek_bialy, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 3,  @kask_spor_czer, 2, 0.05);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-18 12:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-21 10:13:15','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-28 01:13:15','zrealizowane');


-- zamowienie 10. Nabywca ten sam co w zamowieniu 9. Bez rabatu.


-- insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Osrodek Reprezentacyjny Ministerstwa Obrony Narodowej', 'Polska', '05-800', 'Pruszkow', 'Grodziska', '1');	
-- set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1,  @nie_ro_bie, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 2,  @cze_ro_bie, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 3,  @kask_spor_czer, 1);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-21 10:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-21 10:21:35','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-25 11:43:45','zrealizowane');

-- zamowienie 11. Bez rabatu.

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Department of Child and Adolescent Psychiatry', 'Polska', '60-567', 'Poznan', 'Szpitalna', '27/33');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1,  @hul_ele , 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 2,  @wrotki_retro, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 3,  @kask_spor_czer, 1);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-28 12:34:34','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-01 18:15:34','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-12 21:43:44','zrealizowane');

-- zamowienie 12. Bardzo duza ilosc produktow. Bez rabatu.

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values  ('Poradnia Rehabilitacyjna dla Dzieci im. Wladyslawa Basiaka', 'Polska', '26-610', 'Radom', 'Mikolaja Reja', '26');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1,  @hul_ele , 100);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 2,  @wrotki_retro, 100);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 3,  @kask_spor_czer, 199);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-28 12:34:34','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-01 18:15:34','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-12 21:43:44','zrealizowane');


-- zamowienie 13. Najpierw oplacone, nastepnie zlozone i zrealizowane. Bez rabatu.

-- insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values  ('Poradnia Rehabilitacyjna dla Dzieci im. Wladyslawa Basiaka', 'Polska', '26-610', 'Radom', 'Mikolaja Reja', '26');
-- set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1,  @rolki , 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 2,  @wrotki_retro, 1);


insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-09 16:45:39','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-01 17:00:34','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-10 01:43:44','zrealizowane');

-- zamowienie 14. Ponowne zamowienie z Osrodka MON. Z rabatem. 

-- insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Osrodek Reprezentacyjny Ministerstwa Obrony Narodowej', 'Polska', '05-800', 'Pruszkow', 'Grodziska', '1');	
-- set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc, rabat) values (@last_zamowienie_id, 3, @czer_ro_bie, 10, 0.04);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-11 10:43:35','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-11 20:34:32','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-03-12 21:35:35','zrealizowane');

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

*/
 
select *from klienci;



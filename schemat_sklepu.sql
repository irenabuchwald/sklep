drop table if exists produkty;
drop table if exists stawka_VAT;
drop table if exists statusy_zamówień;
drop table if exists zamówienia;
drop table if exists klienci;



create table stawka_VAT (id_stawka_VAT int primary key,					
					nazwa  varchar (150),
                    procent numeric (8,0));
               
  
insert into stawka_VAT(id_stawka_VAT, nazwa, procent) values(1,'23%',23);

insert into stawka_VAT(id_stawka_VAT, nazwa, procent) values(2,'8%',8);

insert into stawka_VAT(id_stawka_VAT, nazwa, procent) values(3, '5%',5);

insert into stawka_VAT(id_stawka_VAT, nazwa, procent) values(4, '0%',0);

insert into stawka_VAT(id_stawka_VAT, nazwa, procent) values(5, 'nie podlega',0);


	select * from stawka_VAT;
              
                    
	

create table produkty (id_produktu int auto_increment primary key,
					nazwa varchar (150) not null,
                    cena_netto DECIMAL(10,2),
                    id_stawka_VAT int not null,
					foreign key (id_stawka_VAT) references stawka_VAT(id_stawka_VAT));
                    
                    
                    
                    
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('zielony rowerek biegowy', '754.00', 1);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('hulajnoga elektryczna', '1645.50', 2);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('wrotki retro', '399.99', 1);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('rolki', '549.22', 1);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('czerwony rowerek biegowy', '954.00', 1);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('hulajnoga napędzana nogą', '905.00', 2);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('ochraniacze na łokcie', '150.23', 4);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('ochraniacze na kolana', '170.78', 4);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('ochraniacz na twarz', '650.00', 4);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('kask sportowy zielony', '458.00', 5);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('kask sportowy czerwony', '505.00', 5);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('wrotki nowoczesne', '299.99', 1);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('deskorolka elektryczna', '599.99', 3);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('gokard elektryczny zielony', '5999.99', 3);    
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('gokard elektryczny czaerny', '6500.00', 3); 
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('segway', '4300.00', 1); 
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('monocykl elektryczny', '1000.00', 3); 
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('skuter elektryczny czarny', '12199.99', 2); 
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('skuter elektryczny bialy', '13199.99', 2);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('niebieski rowerek biegowy', '754.00', 1);
insert into produkty (nazwa, cena_netto, id_stawka_VAT) values ('czerwony rowerek biegowy', '123.00', 1);

select *from produkty;

create table klienci (id_klienta int auto_increment primary key,
								nazwa varchar(500) not null,
                                kraj varchar(16) default 'Polska',
                                kod_pocztowy varchar (6),
								miasto varchar(64),
								ulica varchar (128),
								numer varchar(10));
                                
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Jasio Wysoki', 'Polska', '52-658', 'Łódż', 'św. Teresy od Dzieciątka Jezus', '289');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('EURO-net Sp. z o.o.', 'Polska', '02-447', 'Warszawa',  'Muszkieterów', '254');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Jasio Wysoki', 'Niemcy', '52658', 'Berlin', 'Buchstrasse', '2');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Ministerstwo Sprawiedliwości', 'Polska', '00-950', 'Warszawa', 'Al. Ujazdowskie', '11');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Gabinet Dziwnych Kroków', 'Polska', '00-000', 'Warszawa', 'Żartobliwa', '18');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Surf&Skate Wave Summer Camp', 'Polska', '59-258', 'Warszawa', 'Górczewska', '147');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Centrum Leczniczo-Rehabilitacyjne i Medycyny Pracy ATTIS Sp. z o.o.', 'Polska', '55-650','Warszawa', 'Górczewska', '78');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Ośrodek Wypoczynkowy Marysieńka', 'Polska', '26-400', 'Przysucha', 'Topornia', '23');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Ośrodek Reprezentacyjny Ministerstwa Obrony Narodowej', 'Polska', '05-800', 'Pruszków', 'Grodziska', '1');					
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Department of Child and Adolescent Psychiatry', 'Polska', '60-567', 'Poznań', 'Szpitalna', '27/33');
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Poradnia Rehabilitacyjna dla Dzieci im. Władysława Basiaka', 'Polska', '26-610', 'Radom', 'Mikołaja Reja', '26');

 
 
select *from klienci;




create table zamówienia (id_zamówienia int auto_increment primary key,
						id_klienta int not null,
						data datetime not null,
						foreign key (id_klienta) references klienci(id_klienta));
                        
					

                      
iNSERT INTO zamówienia (id_klienta, data) values (1, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (2, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (3, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (4, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (5, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (6, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (7, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (8, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (9, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (10, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (11, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (1, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (1, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (1, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (3, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (1, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (4, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (5, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (5, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (6, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (7, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (8, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (9, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (6, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (10, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (1, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (11, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (2, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (3, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (1, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (11, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (10, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (9, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (8, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (5, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (7, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (5, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (9, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (8, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (4, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (1, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (2, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (4, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (5, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (10, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (11, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (9, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (8, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (7, NOW());
iNSERT INTO zamówienia (id_klienta, data) values (4, NOW());
                                           
		

select*from zamówienia;    
				                      
                        


create table statusy_zamówień (id_zamówienia int,
								data datetime,
                                status varchar(20) not null,
                                primary key(id_zamówienia, data),
                                foreign key (id_zamówienia) references zamówienia(id_zamówienia));
           

insert into statusy_zamówień (id_zamówienia, data, status) values (1,'2019-01-01 12:13:15','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (2,'2019-03-10 10:05:15','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (3,'2019-05-10 10:22:22','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (4,'2019-05-15 11:25:59','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (5,'2019-05-15 12:34:25','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (6,'2019-05-16 19:39:23','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (7,'2019-05-16 22:00:57','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (8,'2019-05-20 01:04:12','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (9,'2019-05-20 18:29:04','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (10,'2019-06-08 15:48:14','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (11,'2019-06-09 22:15:16','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (12,'2019-06-09 23:23:03','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (13,'2019-06-11 07:03:07','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (14,'2019-06-12 08:12:58','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (15,'2019-06-16 08:22:23','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (16,'2019-06-18 10:23:34','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (17,'2019-06-18 22:28:54','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (18,'2019-06-18 02:12:24','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (19,'2019-06-19 23:58:58','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (20,'2019-06-20 03:54:28','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (21,'2019-06-21 13:23:23','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (22,'2019-06-20 13:14:23','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (23,'2019-06-22 12:19:49','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (24,'2019-06-23 13:12:42','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (25,'2019-06-24 23:22:22','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (26,'2019-06-25 05:06:02','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (27,'2019-06-28 20:19:25','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (28,'2019-06-30 02:25:28','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (29,'2019-06-30 12:00:00','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (30,'2019-06-30 18:45:25','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (31,'2019-07-02 12:49:45','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (32,'2019-07-03 22:52:15','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (33,'2019-07-04 15:12:45','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (34,'2019-07-04 22:32:54','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (35,'2019-07-05 12:22:22','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (36,'2019-07-05 22:15:45','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (37,'2019-07-08 08:23:15','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (38,'2019-07-12 04:00:01','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (39,'2019-07-15 08:18:23','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (40,'2019-07-14 17:23:45','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (41,'2019-07-15 11:24:49','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (42,'2019-07-16 22:29:28','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (43,'2019-07-17 12:09:45','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (44,'2019-07-18 10:15:58','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (45,'2019-07-22 21:22:21','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (46,'2019-07-22 23:59:21','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (47,'2019-07-25 02:59:44','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (48,'2019-07-27 04:25:55','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (49,'2019-07-28 12:32:45','złożone');
insert into statusy_zamówień (id_zamówienia, data, status) values (50,'2019-07-28 22:35:33','złożone');



insert into statusy_zamówień (id_zamówienia, data, status) values (1,'2019-01-10 10:13:15','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (2,'2019-03-11 10:05:15','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (3,'2019-05-10 10:50:22','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (4,'2019-07-31 19:59:29','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (5,'2019-05-15 12:25:39','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (6,'2019-05-16 20:00:23','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (7,'2019-05-16 22:05:48','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (8,'2019-05-20 01:10:03','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (9,'2019-05-31 15:04:24','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (10,'2019-06-02 13:45:44','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (11,'2019-06-09 15:28:35','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (12,'2019-06-11 10:14:46','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (13,'2019-06-09 23:45:43','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (14,'2019-06-11 07:03:07','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (15,'2019-06-16 10:22:28','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (16,'2019-06-18 18:56:58','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (17,'2019-06-18 22:35:24','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (18,'2019-06-22 04:14:43','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (19,'2019-06-20 00:15:24','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (20,'2019-06-25 12:45:45','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (21,'2019-06-21 15:13:26','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (22,'2019-06-22 17:13:54','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (23,'2019-06-24 12:15:43','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (24,'2019-06-22 15:14:45','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (25,'2019-06-25 04:02:22','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (26,'2019-06-28 15:16:12','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (27,'2019-06-28 21:18:32','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (28,'2019-07-12 12:45:32','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (29,'2019-06-30 13:00:00','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (30,'2019-07-14 08:49:57','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (31,'2019-07-02 12:52:09','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (32,'2019-07-07 14:16:45','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (33,'2019-07-04 18:22:15','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (34,'2019-07-24 12:35:34','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (35,'2019-07-06 14:25:45','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (36,'2019-07-06 08:26:49','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (37,'2019-07-08 08:28:28','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (38,'2019-07-12 08:05:41','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (39,'2019-07-29 18:23:20','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (40,'2019-07-14 17:29:58','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (41,'2019-07-16 10:54:31','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (42,'2019-07-18 02:09:20','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (43,'2019-07-17 12:10:55','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (44,'2019-07-18 10:19:05','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (45,'2019-07-22 21:25:31','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (46,'2019-07-26 03:09:29','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (47,'2019-07-27 04:25:55','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (48,'2019-07-27 04:31:52','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (49,'2019-07-30 08:52:48','opłacone');
insert into statusy_zamówień (id_zamówienia, data, status) values (50,'2019-07-28 22:43:42','opłacone');


insert into statusy_zamówień (id_zamówienia, data, status) values (1,'2019-01-11 11:13:15','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (2,'2019-03-12 12:55:15','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (3,'2019-05-11 10:50:22','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (4,'2019-08-03 23:59:29','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (5,'2019-05-19 12:31:29','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (6,'2019-05-20 12:00:23','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (7,'2019-05-19 15:04:12','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (8,'2019-05-21 08:19:00','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (9,'2019-06-02 13:45:44','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (10,'2019-06-10 09:15:22','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (11,'2019-06-12 14:14:14','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (12,'2019-06-13 09:15:15','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (13,'2019-06-12 08:08:47','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (14,'2019-06-18 10:59:58','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (15,'2019-06-19 10:50:50','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (16,'2019-06-23 11:13:30','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (17,'2019-06-19 11:12:58','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (18,'2019-06-20 00:15:24','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (19,'2019-06-21 08:14:45','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (20,'2019-06-28 18:49:05','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (21,'2019-06-23 12:18:57','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (22,'2019-06-26 10:19:03','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (23,'2019-06-27 11:10:53','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (24,'2019-06-25 15:03:12','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (25,'2019-06-26 09:59:59','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (26,'2019-06-30 09:22:42','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (27,'2019-06-29 09:48:52','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (28,'2019-07-13 14:16:58','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (29,'2019-07-30 18:10:35','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (30,'2019-07-18 09:15:07','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (31,'2019-07-04 08:12:21','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (32,'2019-07-10 11:15:23','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (33,'2019-07-06 16:29:55','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (34,'2019-07-31 08:21:04','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (35,'2019-07-10 15:04:45','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (36,'2019-07-08 08:15:03','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (37,'2019-07-09 11:35:48','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (38,'2019-07-15 15:55:58','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (39,'2019-07-31 12:45:45','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (40,'2019-07-17 14:59:08','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (41,'2019-07-18 08:54:58','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (42,'2019-07-19 12:07:58','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (43,'2019-07-17 12:12:55','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (44,'2019-07-18 12:19:05','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (45,'2019-07-23 17:42:28','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (46,'2019-07-28 08:12:45','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (47,'2019-07-29 10:22:59','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (48,'2019-07-27 16:22:21','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (49,'2019-07-31 16:45:18','zrealizowane');
insert into statusy_zamówień (id_zamówienia, data, status) values (50,'2019-07-31 12:48:52','zrealizowane');


select*from statusy_zamówień; 


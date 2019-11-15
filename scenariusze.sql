
/* Pobranie wspólnych zmiennych */
set @ziel_ro_bieg = (select id_produktu from produkty where nazwa = 'zielony rowerek biegowy');
set @hul_ele = (select id_produktu from produkty where nazwa = 'hulajnoga elektryczna');

/* Czyszczenie wszystkich danych testowych */
/* Ten identyfikator pasuje do kazdegow wzorca Klient S-001-P01, wiec usuniemy wszystkie dane wszystkich scenariuszy */
set @identyfikator_scenariusza = 'Klient S-___-___' COLLATE utf8mb4_unicode_ci;

/* Usuwamy statusy zamowien zlozonych przez klientow pasujacych do wzorca */
delete from statusy_zamowien where id_zamowienia in (select id_zamowienia from zamowienia, klienci 
                                                     where zamowienia.id_klienta = klienci.id_klienta 
                                                       and klienci.nazwa like @identyfikator_scenariusza);

/* Usuwamy szczegoly zamowien zlozonych przez klientow pasujacych do wzorca */
delete from szczegoly where id_zamowienia in (select id_zamowienia from zamowienia, klienci 
                                              where zamowienia.id_klienta = klienci.id_klienta 
                                              and klienci.nazwa like @identyfikator_scenariusza);

/* Usuwamy zamowienia zlozone przez klientow pasujacych do wzorca */
delete from zamowienia where id_klienta in (select id_klienta from klienci 
                                            where nazwa like @identyfikator_scenariusza);

/* Na koniec usuwamy klientow pasujacych do wzorca */
delete from klienci where nazwa like @identyfikator_scenariusza;


/* Scenariusz S-001-P01 tworzenie danych */
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Klient S-001-P01', 'Niemcy', 'D-1215', 'Berlin', 'Alexanderplatz', '12');
set @last_klient_id = last_insert_id();

INSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @ziel_ro_bieg, 1);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-01 12:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-10 10:13:15','oplacone');

/* Scenariusz S-001-N01 tworzenie danych */
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Klient S-001-N01', 'Polska', '01-333', 'Warszawa', 'Marszałkowska', '15');
set @last_klient_id = last_insert_id();

INSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @hul_ele, 3);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-01 12:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-10 10:13:15','oplacone');

/* Zapytania zdefiniowane w scenariuszach testowych */

/* Scenariusz S-001 - kwerenda wybierająca zamówienia klientów zagranicznych */
/* select klienci.nazwa, zamowienia.id_zamowienia, szczegoly_zamowien.LP, szczegoly_zamowien.nazwa_produktu 
  from klienci, zamowienia, szczegoly_zamowien
 where zamowienia.id_klienta = klienci.id_klienta
   and szczegoly_zamowien.id_zamowienia = zamowienia.id_zamowienia
 
   and klienci.kraj <> 'Polska';*/

/* ------------------------------------------------------------------------------------------------------------------------------*/

/* Pobranie wspólnych zmiennych */
set @ziel_ro_bieg = (select id_produktu from produkty where nazwa = 'zielony rowerek biegowy');
set @hul_ele = (select id_produktu from produkty where nazwa = 'hulajnoga elektryczna');
set @czer_ro_bie = (select id_produktu from produkty where nazwa = 'czerwony rowerek biegowy');
set @wrotki_retro = (select id_produktu from produkty where nazwa = 'wrotki retro');



/* Czyszczenie wszystkich danych testowych */
/* Ten identyfikator pasuje do kazdegow wzorca Klient S-001-P01, wiec usuniemy wszystkie dane wszystkich scenariuszy */
set @identyfikator_scenariusza = 'Klient S-___-___' COLLATE utf8mb4_unicode_ci;

/* Usuwamy statusy zamowien zlozonych przez klientow pasujacych do wzorca */
delete from statusy_zamowien where id_zamowienia in (select id_zamowienia from zamowienia, klienci 
                                                     where zamowienia.id_klienta = klienci.id_klienta 
                                                       and klienci.nazwa like @identyfikator_scenariusza);

/* Usuwamy szczegoly zamowien zlozonych przez klientow pasujacych do wzorca */
delete from szczegoly where id_zamowienia in (select id_zamowienia from zamowienia, klienci 
                                              where zamowienia.id_klienta = klienci.id_klienta 
                                              and klienci.nazwa like @identyfikator_scenariusza);

/* Usuwamy zamowienia zlozone przez klientow pasujacych do wzorca */
delete from zamowienia where id_klienta in (select id_klienta from klienci 
                                            where nazwa like @identyfikator_scenariusza);

/* Na koniec usuwamy klientow pasujacych do wzorca */
delete from klienci where nazwa like @identyfikator_scenariusza;



/* Scenariusz S-002 - tworzenie danych:


| ID | Opis scenariusza testowego | Nazwy klientów | Opis zamówienia |Status zamówienia |
|S-002 | Zamówienie opłacone w ciągu dwóch tygodni | S-002-N01 | nieistotne | opłacone |
*/

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Klient S-002-N01', 'Niemcy', 'D-1215', 'Berlin', 'Alexanderplatz', '12');
set @last_klient_id = last_insert_id();

INSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @ziel_ro_bieg, 1);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-01 12:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-10 10:13:15','oplacone');


/* Scenariusz S-002 - tworzenie danych:
ID | Opis scenariusza testowego | Nazwy klientów | Opis zamówienia |Status zamówienia |
|S-002 | Zamówienie nie opłacone w ciągu dwóch tygodni | S-002-P01 | nieistotne | nie opłacone |
*/ 


insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Klient S-002-P01', 'Polska', '01-235', 'Warszawa', 'Jacka Placka', '1');
set @last_klient_id = last_insert_id();

INSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @czer_ro_bie, 1);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-01 12:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-28 10:13:15','oplacone');

/* Scenariusz S-002 - tworzenie danych:
ID | Opis scenariusza testowego | Nazwy klientów | Opis zamówienia |Status zamówienia |
|S-002 | Zamówienie nie opłacone | S-002-P02 | nieistotne | nie opłacone |
*/ 


insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Klient S-002-P02', 'Polska', '01-005', 'Warszawa', 'Kaczencowa', '8');
set @last_klient_id = last_insert_id();

INSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @wrotki_retro, 1);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-02-11 12:13:15','zlozone');





  select klienci.nazwa, zamowienia.id_zamowienia, statusy_zamowien.data as data_zlozenia
  from zamowienia, statusy_zamowien, klienci
 where klienci.id_klienta = zamowienia.id_klienta
   and zamowienia.id_zamowienia = statusy_zamowien.id_zamowienia
   and statusy_zamowien.status = 'zlozone';

  
  
 -- and status = 'oplacone';
 
 
 --  and SELECT DATEDIFF('zlozone', 'oplacone') AS 'Result'
--   from statusy_zamowien;
  
-- select klienci.nazwa, zamowienia.id_zamowienia, szczegoly_zamowien.LP, szczegoly_zamowien.nazwa_produktu, statusy_zamowien.status

-- S-001 Zamówienia klientow zagranicznych, klient  S-001-P01 - adres w Niemczech | Helga Muller| Lutzowplatz 17, 10785 Berlin, Germany| skuter elektryczny bialy, 1 szt.|
 
insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Helga Muller', 'Niemcy', '10785', 'Berlin', 'Lutzowplatz', '17');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @sku_elek_bialy, 1);


insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-02 12:13:15','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-02 12:14:18','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2020-01-11 11:13:15','zrealizowane');


-- S-001 Zamówienia klientow zagranicznych, klient S-001-N01 - adres w Polsce | Kindergarten No. 318 "Green Corner" | Jana Kochanowskiego 9A, 01-864 Warszawa | zielony rowerek biegowy i czerwony rowerek biegowy | 

insert into klienci (nazwa, kraj, kod_pocztowy, miasto, ulica, numer) values ('Kindergarten No. 318 "Green Corner"', 'Polska', '01-864', 'Warszawa', 'Jana Kochanowskiego', '9a');
set @last_klient_id = last_insert_id();

iNSERT INTO zamowienia(id_klienta) values (@last_klient_id);
set @last_zamowienie_id = last_insert_id();

INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 1, @ziel_ro_bieg, 1);
INSERT INTO szczegoly(id_zamowienia, LP, id_produktu, ilosc) values (@last_zamowienie_id, 2, @czer_ro_bieg, 1);

insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-05 08:13:20','zlozone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2019-01-06 10:14:45','oplacone');
insert into statusy_zamowien (id_zamowienia, data, status) values (@last_zamowienie_id,'2020-01-09 21:23:25','zrealizowane');
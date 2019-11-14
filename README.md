# Implementacja schematu bazy danych sklepu internetowego w języku SQL

Celem tego ćwiczenia jest przetestowanie znajomości języka SQL w zakresie tworzenia obiektów bazodanowych,
jak również projektowania i wykonywania bardziej skomplikowanych kwerend.

## Opis schematu

W bazie danych występują następujące tabele:
1. `stawki_VAT` - zawiera dane referencyjne (stawki VAT wraz z opisami)
2. `produkty` - słownik produktów dostępnych w sklepie (dane konfiguracyjne)
3. `klienci` - klienci sklepu wraz z podstawowymi danymi
4. `zamowienia` - zamówienia złożone w sklepie
5. `statusy_zamowien` - zawiera historię zamówień (wszystkie wydarzenia związane z zamówieniem takie jak 
złożenie, opłacenie, wysyłka, anulowanie)
6. `szczegoly` - zawiera szczegóły zamówień (połączenie zamówienia z produktami)

Do tego utworzony został widok `szczegoly_zamowien`, w którym przeprowadzane są obliczenia kwot netto/brutto z uwzględnieniem rabatu dla szczegółów zamówień. 

### Tabela `stawki_VAT`

Tabela `stawki_VAT` zawiera następujące kolumny:

| Nazwa | Typ | Parametry | Opis |
| --- | --- | --- | --- |
| id_stawka_VAT | `int` | primary key | Identyfikator stawki VAT (wprowadzany ręcznie) |
| nazwa | `varchar(150)` | | Opis stawki (do wyświetlenia klientowi) |
| procent | `numeric(3,2)` | | Wysokość stawki (używany przy obliczeniach) |

### Tabela `produkty`

Tabela `produkty` zawiera następujące kolumny:

| Nazwa | Typ | Parametry | Opis |
| --- | --- | --- | --- |
| id_produktu | `int` | auto_increment primary key | Automatycznie generowany unikalny identyfikator produktu |
| nazwa | `varchar(150)` | not null | Nazwa produktu |
| cena_netto | `decimal(10,2)` | | Cena netto sztuki produktu |
| id_stawka_VAT | `int` | not null | Klucz obcy do tabeli `stawki_VAT` |

> Warto zwrócić uwagę na klucz obcy do tabeli `stawki_VAT` - wymaga on istnienia definicji stawek VAT przed wstawianiem do tabeli `produkty`

**KOLEJNE TABELE MOŻEMY UDOKUMENTOWAĆ TUTAJ**

# Scenariusze testowe i przykładowe dane

Na etapie tworzenia schematu powstały również przykładowe dane do testowania zapytań SQL. Opisy scenariuszy testowych poniżej.

| LP | Opis scenariusza testowego | Nazwa klienta | Opis zamówienia |
| --- | --- | --- | --- |
| 1 | Trzy pozycje w zamówieniu, rabat dla każdej pozycji, zamowienie zrealizowane po upływie roku | Jasio Wysoki | Kask sportowy czerwony, Zielony rowerek biegowy, Czerwony rowerek biegowy | 
| 2 | Cztery pozycje, rabat tylko dla dwóch z nich, po oplaceniue status zlozone zamiast zrealizowane czy oplacone| Minsterstwo Sprawiedliwości | Gokart elektryczny czarny i inne... |
| 3 | Jedna pozycja, bez rabatu | Gabinet Dziwnych Kroków | Zielony rowerek biegowy |
| 4 | Trzy  pozycje z rabatem, jedna bez rabatu, różne stawki rabatu, w 1 i 5 pozycji zamowienia jest ten sam towar, ale z roznym rabatem| Surf&Skate ... | Czerwony rowerek biegowy |
| 5 | Przelom roku, jeda pozycja z rabatem, zlozone  i oplacone w 2018, zrealizowane w 2019 | Centrum Leczniczo-Rehabilitacyjne i Medycyny Pracy ATTIS | Hulajnoga napędzana noga i inne ...|
| 6 | Powtorzone zamowienie nr 1 | Trzy pozycje w zamówieniu, rabat dla każdej pozycji, zamowienie zrealizowane po upływie roku | Jasio Wysoki | Kask sportowy czerwony, Zielony rowerek biegowy, Czerwony rowerek biegowy 
| 7 | Dwie pozycje bez rabatu | Osrodek Wypoczynkowy Marysienka | Wrotki nowoczesne i inne ... |
| 8 | Dwie pozycje bez rabatu. Natychmiastowa platnosc | Osrodek Wypoczynkowy Relax | Gokard elektryczny zielony i inne...|
| 9 | Trzy pozycje, w trzeciej jest rabat | Osrodek Reprezentacyjny Ministerstwa Obrony Narodowej | Skuter elektryczny czarny i inne ...|
|10 | Nabywca ten sam co w zamowieniu 9. Bez rabatu | Osrodek Reprezentacyjny Ministerstwa Obrony Narodowej | Niebieski rowerek biegowy i inne ...|
|11 | Bez rabatu | Department of Child and Adolescent Psychiatry | Hulajnoga elektryczna, Wrotki retro, Kask sportowy czerwony |
|12 | Bardzo duza ilosc produktow. Bez rabatu. | Poradnia Rehabilitacyjna dla Dzieci im. Wladyslawa Basiaka | Hulajnoga elektryczna, Wrotki retro, Kask sportowy czerwony |
|13 | Najpierw oplacone, nastepnie zlozone i zrealizowane. Bez rabatu. | Poradnia Rehabilitacyjna dla Dzieci im. Wladyslawa Basiaka | Rolki, Wrotki retro |
|14 | Ponowne zamowienie z Osrodka MON. Z rabatem. | Osrodek Reprezentacyjny Ministerstwa Obrony Narodowej | Czerwony rowerek biegowy|
|15 | Zamówienia klientow zagranicznych:
      Klient S-001-P01 - adres w Niemczech | Helga Muller| Lützowplatz 17, 10785 Berlin, Germany| skuter elektryczny bialy, 1 szt.|
      Klient S-001-N01 - adres w Polsce | Kindergarten No. 318 "Green Corner" | Jana Kochanowskiego 9A, 01-864 Warszawa | zielony rowerek biegowy i czerwony rowerek biegowy | 





**Kolejne scenariusze testowe dopisujemy tutaj**

# Konkretne przypadki testowe

Oto lista konkretnych przypadków testowych i danych utworzonych na ich potrzeby.

| ID | Opis scenariusza testowego | Nazwy klientów | Opis zamówienia |
| --- | --- | --- | --- | 
| S-001 | Zamówienia klientów zagranicznych | S-001-P01, S-001-N01 | Nieistotne |

# Kwerendy zawierające rozwiązania przypadków testowych

## S-001 - Zamówienia klientów zagranicznych

Kwerenda SQL wybierająca poszukiwane dane

```sql
select klienci.nazwa, zamowienia.id_zamowienia, szczegoly_zamowien.LP, szczegoly_zamowien.nazwa_produktu 
  from klienci, zamowienia, szczegoly_zamowien
 where zamowienia.id_klienta = klienci.id_klienta
   and szczegoly_zamowien.id_zamowienia = zamowienia.id_zamowienia
   and klienci.kraj <> 'Polska';
```

# Konkretne przypadki testowe

| ID | Opis scenariusza testowego | Nazwy klientów | Opis zamówienia |Status zamówienia |
|S-002 | Zamówienie opłacone w ciągu dwóch tygodni | S-002-N01 | nieistotne | opłacone |
|S-002 | Zamówienie nie opłacone w ciągu dwóch tygodni | S-002-P01 | nieistotne | nie opłacone |
|S-002 | Zamówienie nie opłacone | S-002-P02 | nieistotne | nie opłacone |

## S-002 - Zamówienia, które nie zostały opłacone przez dwa tygodnie

Kwerenda SQL wybierająca poszukiwane dane

```sql

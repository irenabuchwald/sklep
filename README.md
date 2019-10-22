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
| 1 | Trzy pozycje w zamówieniu, rabat dla każdej pozycji | Jasio Wysoki | Kask sportowy czerwony, Zielony rowerek biegowy, Czerwony rowerek biegowy |
| 2 | Cztery pozycje, rabat tylko dla dwóch z nich | Minsterstwo Sprawiedliwości | Gokart elektryczny czarny i inne... |
| 3 | Jedna pozycja, bez rabatu | Gabinet Dziwnych Kroków | Zielony rowerek biegowy |
| 4 | Czwarte zamówienie... | Surf&Skate ... | Czerwony rowerek biegowy |

**Kolejne scenariusze testowe dopisujemy tutaj**
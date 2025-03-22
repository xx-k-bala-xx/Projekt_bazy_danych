----------------------------------------------------------
---------------- INSERTY DO TABEL ------------------------
----------------------------------------------------------

--uzupelnianie tabeli limity--
insert into limity(liczba) values (1);
insert into limity(liczba) values (3);
insert into limity(liczba) values (5);
insert into limity(liczba) values (10);

-- uzupelnianie tabeli typ_szkoly--
insert into typ_szkoly(nazwa) values ('podstawowa');
insert into typ_szkoly(nazwa) values ('ponadpodstawowa');
insert into typ_szkoly(nazwa) values ('nie dotyczy');

-- uzupelnianie tabeli przedmioty--
insert into przedmioty(nazwa) values ('jezyk polski');
insert into przedmioty(nazwa) values ('jezyk angielski');
insert into przedmioty(nazwa) values ('jezyk niemiecki');
insert into przedmioty(nazwa) values ('jezyk francuski');
insert into przedmioty(nazwa) values ('matematyka');
insert into przedmioty(nazwa) values ('historia');
insert into przedmioty(nazwa) values ('fizyka');
insert into przedmioty(nazwa) values ('biologia');
insert into przedmioty(nazwa) values ('chemia');
insert into przedmioty(nazwa) values ('geografia');
insert into przedmioty(nazwa) values ('informatyka');
insert into przedmioty(nazwa) values ('wiedza o spoleczenstwie');

-- uzupełnianie tabeli status_grupy--
insert into status_grupy(opis) values ('planowana');
insert into status_grupy(opis) values ('aktywna');
insert into status_grupy(opis) values ('nieotwarta - brak odpowiedniego limitu osob');
insert into status_grupy(opis) values ('zakonczona');

-- uzupelnianie tabeli termin_zajec--
insert into termin_zajec(dzien_tygodnia, godzina) values ('poniedzialek','16:00-16:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('poniedzialek','17:00-17:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('poniedzialek','18:00-18:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('poniedzialek','19:00-19:45');

insert into termin_zajec(dzien_tygodnia, godzina) values ('wtorek','16:00-16:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('wtorek','17:00-17:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('wtorek','18:00-18:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('wtorek','19:00-19:45');

insert into termin_zajec(dzien_tygodnia, godzina) values ('sroda','16:00-16:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('sroda','17:00-17:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('sroda','18:00-18:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('sroda','19:00-19:45');

insert into termin_zajec(dzien_tygodnia, godzina) values ('czwartek','16:00-16:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('czwartek','17:00-17:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('czwartek','18:00-18:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('czwartek','19:00-19:45');

insert into termin_zajec(dzien_tygodnia, godzina) values ('piatek','16:00-16:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('piatek','17:00-17:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('piatek','18:00-18:45');
insert into termin_zajec(dzien_tygodnia, godzina) values ('piatek','19:00-19:45');

-- uzupełnianie tabeli typ_kursu--
insert into typ_kursu(nazwa) values ('standardowy');
insert into typ_kursu(nazwa) values ('intensywny');

INSERT INTO rodzaje_uzytkownikow(nazwa) values
 ('administrator'),
 ('nauczyciel'),
 ('uczen');

-- uzupełnianie tabeli uzytkownicy--

-- uzupełnianie tabeli uzytkownicy dla nauczycieli--

-- musimy załozyc, ze rodzaje_uzytkownikow i typ_szkoly maja odpowiednie wartosci, bo korzystamy z default 
INSERT INTO uzytkownicy (login, haslo,stopien_uprawnien_uzytkownika, imie, nazwisko, mail, id_typ_szkoly) VALUES
('marta_kowalska', 'haslo_marty',2, 'Marta', 'Kowalska', 'marta_kowalska@nauczyciele.szkola.edu.pl',3),
('dawid_nowak', 'haslo_dawida', 2, 'Dawid', 'Nowak', 'dawid_nowak@nauczyciele.szkola.edu.pl',3),
('katarzyna_wisniewska', 'haslo_katarzyny',2, 'Katarzyna', 'Wisniewska', 'katarzyna_wisniewska@nauczyciele.szkola.edu.pl',3),
('piotr_jankowski', 'haslo_piotra', 2, 'Piotr', 'Jankowski', 'piotr_jankowski@nauczyciele.szkola.edu.pl',3),
('aleksandra_nowicka', 'haslo_aleksandry', 2, 'Aleksandra', 'Nowicka', 'aleksandra_nowicka@nauczyciele.szkola.edu.pl',3),
('michal_szymanski', 'haslo_michala', 2, 'Michal', 'Szymanski', 'michal_szymanski@nauczyciele.szkola.edu.pl',3),
('magdalena_kaczmarek', 'haslo_magdaleny',2, 'Magdalena', 'Kaczmarek', 'magdalena_kaczmarek@nauczyciele.szkola.edu.pl',3),
('krzysztof_wojciechowski', 'haslo_krzysztofa', 2, 'Krzysztof', 'Wojciechowski', 'krzysztof_wojciechowski@nauczyciele.szkola.edu.pl',3),
('anna_tomaszewska', 'haslo_anny', 2, 'Anna', 'Tomaszewska', 'anna_tomaszewska@nauczyciele.szkola.edu.pl',3),
('lukasz_kowalczyk', 'haslo_lukasza',2, 'Lukasz', 'Kowalczyk', 'lukasz_kowalczyk@nauczyciele.szkola.edu.pl',3),
('ewa_zielinska', 'haslo_ewy',2, 'Ewa', 'Zielinska', 'ewa_zielinska@nauczyciele.szkola.edu.pl',3),
('marek_malinowski', 'haslo_marka',2, 'Marek', 'Malinowski', 'marek_malinowski@nauczyciele.szkola.edu.pl',3),
('natalia_kubiak', 'haslo_natalii', 2, 'Natalia', 'Kubiak', 'natalia_kubiak@nauczyciele.szkola.edu.pl',3),
('adrian_kwiatkowski', 'haslo_adriana',2, 'Adrian', 'Kwiatkowski', 'adrian_kwiatkowski@nauczyciele.szkola.edu.pl',3),
('agnieszka_krol', 'haslo_agnieszki',2, 'Agnieszka', 'Krol', 'agnieszka_krol@nauczyciele.szkola.edu.pl',3),
('jan_kaczmarczyk', 'haslo_jana',2, 'Jan', 'Kaczmarczyk', 'jan_kaczmarczyk@nauczyciele.szkola.edu.pl',3),
('joanna_pawlowska', 'haslo_joanny',2, 'Joanna', 'Pawlowska', 'joanna_pawlowska@nauczyciele.szkola.edu.pl',3),
('rafal_wojcik', 'haslo_rafala',2, 'Rafal', 'Wojcik', 'rafal_wojcik@nauczyciele.szkola.edu.pl',3),
('monika_zajac', 'haslo_moniki',2, 'Monika', 'Zajac', 'monika_zajac@nauczyciele.szkola.edu.pl',3),
('grzegorz_adamczyk', 'haslo_grzegorza',2, 'Grzegorz', 'Adamczyk', 'grzegorz_adamczyk@nauczyciele.szkola.edu.pl',3);
 
-- uzupełnianie tabeli uzytkownicy dla uczniów--
INSERT INTO uzytkownicy (login, haslo,stopien_uprawnien_uzytkownika, imie, nazwisko, mail, id_typ_szkoly) VALUES 
('martyna_kowal', 'haslo_martyny', 3, 'Martyna', 'Kowal', 'martyna_kowal@uczniowie.szkola.edu.pl',1),
('robert_krajewski', 'haslo_roberta',3,'Robert', 'Krajewski', 'robert_krajewski@uczniowie.szkola.edu.pl',1),
('kinga_glowacka', 'haslo_kingi',3,'Kinga', 'Glowacka', 'kinga_glowacka@uczniowie.szkola.edu.pl',2),
('patryk_sobczak', 'haslo_patryka',3,'Patryk', 'Sobczak', 'patryk_sobczak@uczniowie.szkola.edu.pl',1),
('dorota_lukasiewicz', 'haslo_doroty',3,'Dorota', 'Lukasiewicz', 'dorota_lukasiewicz@uczniowie.szkola.edu.pl',2),
('artur_szewczyk', 'haslo_artura',3,'Artur', 'Szewczyk', 'artur_szewczyk@uczniowie.szkola.edu.pl',1),
('agata_marciniak', 'haslo_agaty',3,'Agata', 'Marciniak', 'agata_marciniak@uczniowie.szkola.edu.pl',2),
('lukasz_chmielewski', 'haslo_lukasza',3,'Lukasz', 'Chmielewski', 'lukasz_chmielewski@uczniowie.szkola.edu.pl',1),
('karolina_kowalewska', 'haslo_karoliny',3,'Karolina', 'Kowalewska', 'karolina_kowalewska@uczniowie.szkola.edu.pl',2),
('szymon_kaczor', 'haslo_szymona',3,'Szymon', 'Kaczor', 'szymon_kaczor@uczniowie.szkola.edu.pl',1),
('weronika_zawadzka', 'haslo_weroniki',3,'Weronika', 'Zawadzka', 'weronika_zawadzka@uczniowie.szkola.edu.pl',2),
('mateusz_wrobel', 'haslo_mateusza',3,'Mateusz', 'Wrobel', 'mateusz_wrobel@uczniowie.szkola.edu.pl',1),
('julia_slowik', 'haslo_julii',3,'Julia', 'Slowik', 'julia_slowik@uczniowie.szkola.edu.pl',2),
('radoslaw_pietrzak', 'haslo_radoslawa',3,'Radoslaw', 'Pietrzak', 'radoslaw_pietrzak@uczniowie.szkola.edu.pl',1),
('izabela_klimczak', 'haslo_izabeli',3,'Izabela', 'Klimczak', 'izabela_klimczak@uczniowie.szkola.edu.pl',2),
('jakub_wojcik', 'haslo_jakuba',3,'Jakub', 'Wojcik', 'jakub_wojcik@uczniowie.szkola.edu.pl',1),
('aneta_kowalczyk', 'haslo_anety',3,'Aneta', 'Kowalczyk', 'aneta_kowalczyk@uczniowie.szkola.edu.pl',2),
('marcin_sikora', 'haslo_marcina',3,'Marcin', 'Sikora', 'marcin_sikora@uczniowie.szkola.edu.pl',1),
('oliwia_jasinska', 'haslo_oliwii',3,'Oliwia', 'Jasinska', 'oliwia_jasinska@uczniowie.szkola.edu.pl',2),
('daniel_kowalewski', 'haslo_daniela',3,'Daniel', 'Kowalewski', 'daniel_kowalewski@uczniowie.szkola.edu.pl',1),
('justyna_dudek', 'haslo_justyny',3,'Justyna', 'Dudek', 'justyna_dudek@uczniowie.szkola.edu.pl',2),
('kamil_nowicki', 'haslo_kamila',3,'Kamil', 'Nowicki', 'kamil_nowicki@uczniowie.szkola.edu.pl',1),
('dominika_gorka', 'haslo_dominiki',3,'Dominika', 'Gorka', 'dominika_gorka@uczniowie.szkola.edu.pl',2),
('pawel_mazur', 'haslo_pawla',3,'Pawel', 'Mazur', 'pawel_mazur@uczniowie.szkola.edu.pl',1),
('gabriela_kubicka', 'haslo_gabrieli',3,'Gabriela', 'Kubicka', 'gabriela_kubicka@uczniowie.szkola.edu.pl',2),
('arkadiusz_zieba', 'haslo_arkadiusza',3,'Arkadiusz', 'Zieba', 'arkadiusz_zieba@uczniowie.szkola.edu.pl',1),
('wiktoria_czarnecka', 'haslo_wiktorii',3,'Wiktoria', 'Czarnecka', 'wiktoria_czarnecka@uczniowie.szkola.edu.pl',2),
('mateusz_kozlowski', 'haslo_mateusza',3,'Mateusz', 'Kozlowski', 'mateusz_kozlowski@uczniowie.szkola.edu.pl',1);
 
INSERT INTO uzytkownicy (login, haslo, stopien_uprawnien_uzytkownika, imie, nazwisko, mail, id_typ_szkoly)
VALUES 
('adam_nowak', 'haslo_adama', 3, 'Adam', 'Nowak', 'adam_nowak@uczniowie.szkola.edu.pl', 2),
('natalia_kaczmarek', 'haslo_natalii', 3, 'Natalia', 'Kaczmarek', 'natalia_kaczmarek@uczniowie.szkola.edu.pl', 1),
('michal_lewandowski', 'haslo_michala', 3, 'Michal', 'Lewandowski', 'michal_lewandowski@uczniowie.szkola.edu.pl', 2),
('tomasz_dabrowski', 'haslo_tomasza', 3, 'Tomasz', 'Dabrowski', 'tomasz_dabrowski@uczniowie.szkola.edu.pl', 2),
('magdalena_jakubowska', 'haslo_magdaleny', 3, 'Magdalena', 'Jakubowska', 'magdalena_jakubowska@uczniowie.szkola.edu.pl', 1),
('kamil_adamczyk', 'haslo_kamila', 3, 'Kamil', 'Adamczyk', 'kamil_adamczyk@uczniowie.szkola.edu.pl', 2),
('agnieszka_nowakowska', 'haslo_agnieszki', 3, 'Agnieszka', 'Nowakowska', 'agnieszka_nowakowska@uczniowie.szkola.edu.pl', 1),
('jan_kaminski', 'haslo_jana', 3, 'Jan', 'Kaminski', 'jan_kaminski@uczniowie.szkola.edu.pl', 2),
('ewa_jozwiak', 'haslo_ewy', 3, 'Ewa', 'Jozwiak', 'ewa_jozwiak@uczniowie.szkola.edu.pl', 1),
('mateusz_adamczyk', 'haslo_mateusza', 3, 'Mateusz', 'Adamczyk', 'mateusz_adamczyk@uczniowie.szkola.edu.pl', 2),
('natalia_kowalczyk', 'haslo_natalii', 3, 'Natalia', 'Kowalczyk', 'natalia_kowalczyk@uczniowie.szkola.edu.pl', 1),
('krzysztof_nowak', 'haslo_krzysztofa', 3, 'Krzysztof', 'Nowak', 'krzysztof_nowak@uczniowie.szkola.edu.pl', 2);

-- uzupełnianie tabeli uzytkownicy dla administratora--
 INSERT INTO uzytkownicy (login, haslo,stopien_uprawnien_uzytkownika, imie, nazwisko, mail, id_typ_szkoly) VALUES
 ('admin', 'haslo_administratora',1, 'Administrator', 'Admin', 'admin@administrator.szkola.eDu.pl', 3);

--uzupelnianie tabeli poziomy--
INSERT INTO poziomy (nazwa, id_typ_szkoly) VALUES
('egzamin osmoklasisty', (SELECT id FROM typ_szkoly WHERE nazwa = 'podstawowa')),
('matura', (SELECT id FROM typ_szkoly WHERE nazwa = 'ponadpodstawowa'));

-- uzupelnianie tabeli ceny --
INSERT INTO ceny(id_limitu, id_poziomu, id_typu, cena_za_kurs) VALUES
((SELECT id FROM LIMITY WHERE liczba = 1),(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'), (SELECT id FROM TYP_KURSU WHERE nazwa = 'standardowy'), 800), 
((SELECT id FROM LIMITY WHERE liczba = 1),(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'), (SELECT id FROM TYP_KURSU WHERE nazwa = 'intensywny'), 1600),
((SELECT id FROM LIMITY WHERE liczba = 1),(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'standardowy'),900),
((SELECT id FROM LIMITY WHERE liczba = 1),(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'intensywny'),1800),
((SELECT id FROM LIMITY WHERE liczba = 3),(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'standardowy'),700),
((SELECT id FROM LIMITY WHERE liczba = 3),(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'intensywny'),1400),
((SELECT id FROM LIMITY WHERE liczba = 3),(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'standardowy'), 800),
((SELECT id FROM LIMITY WHERE liczba = 3),(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'intensywny'), 1600),
((SELECT id FROM LIMITY WHERE liczba = 5),(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'standardowy'),600),
((SELECT id FROM LIMITY WHERE liczba = 5),(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'intensywny'), 1200),
((SELECT id FROM LIMITY WHERE liczba = 5),(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'standardowy'),700),
((SELECT id FROM LIMITY WHERE liczba = 5),(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'intensywny'),1400),
((SELECT id FROM LIMITY WHERE liczba = 10),(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'standardowy'),500),
((SELECT id FROM LIMITY WHERE liczba = 10),(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'intensywny'),1000),
((SELECT id FROM LIMITY WHERE liczba = 10),(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'standardowy'),600),
((SELECT id FROM LIMITY WHERE liczba = 10),(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM TYP_KURSU WHERE nazwa = 'intensywny'),1200);

-- uzupelnianie tabeli daty_kursu --
INSERT INTO daty_kursu (poczatek_zapisow, koniec_zapisow, poczatek_zajec, koniec_zajec, id_typ_kursu) VALUES
('2022-08-01', '2022-09-10', '2022-09-02', '2023-02-04',(SELECT id FROM typ_kursu WHERE nazwa = 'standardowy')),
('2023-08-01', '2023-09-10', '2023-09-02', '2024-02-04',(SELECT id FROM typ_kursu WHERE nazwa = 'standardowy')),
('2024-08-01', '2024-09-10', '2024-09-02', '2025-02-04',(SELECT id FROM typ_kursu WHERE nazwa = 'standardowy')),
('2022-02-01', '2022-03-01', '2022-02-14', '2022-06-30',(SELECT id FROM typ_kursu WHERE nazwa = 'standardowy')),
('2023-02-01', '2023-03-01', '2023-02-14', '2023-06-30',(SELECT id FROM typ_kursu WHERE nazwa = 'standardowy')),
('2024-01-29', '2024-03-01', '2024-02-14', '2024-06-30',(SELECT id FROM typ_kursu WHERE nazwa = 'standardowy')),
('2022-02-01', '2022-03-01', '2022-02-14', '2022-06-30',(SELECT id FROM typ_kursu WHERE nazwa = 'intensywny')),
('2023-02-01', '2023-03-01', '2023-02-14', '2023-06-30',(SELECT id FROM typ_kursu WHERE nazwa = 'intensywny')),
('2024-01-29', '2024-03-01', '2024-02-14', '2024-06-30',(SELECT id FROM typ_kursu WHERE nazwa = 'intensywny'));

-- uzupelnianie tabeli grupy 
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES 
('J. angielski dla szkoly podstawowej, grupa jednoosobowa', (SELECT id FROM LIMITY WHERE liczba = 1),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') ,(SELECT id FROM uzytkownicy WHERE mail = 'marta_kowalska@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('J. angielski dla szkoly podstawowej, grupa jednoosobowa', (SELECT id FROM LIMITY WHERE liczba = 1),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') ,(SELECT id FROM uzytkownicy WHERE mail = 'marek_malinowski@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('J. angielski dla szkoly podstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') ,(SELECT id FROM uzytkownicy WHERE mail = 'marek_malinowski@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('J. angielski dla szkoly ponadpodstawowej, grupa piecioosobowa', (SELECT id FROM LIMITY WHERE liczba = 5),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') ,(SELECT id FROM uzytkownicy WHERE mail = 'krzysztof_wojciechowski@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('J. polski dla szkoly podstawowej, grupa jednoosobowa', (SELECT id FROM LIMITY WHERE liczba = 1),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') ,(SELECT id FROM uzytkownicy WHERE mail = 'anna_tomaszewska@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('J. polski dla szkoly podstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') ,(SELECT id FROM uzytkownicy WHERE mail = 'anna_tomaszewska@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('J. polski dla szkoly podstawowej, grupa piecioosobowa', (SELECT id FROM LIMITY WHERE liczba = 5),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') ,(SELECT id FROM uzytkownicy WHERE mail = 'michal_szymanski@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('J. polski dla szkoly ponadpodstawowej, grupa piecioosobowa', (SELECT id FROM LIMITY WHERE liczba = 5),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') ,(SELECT id FROM uzytkownicy WHERE mail = 'anna_tomaszewska@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Matematyka dla szkoly podstawowej, grupa dziesiecioosobowa', (SELECT id FROM LIMITY WHERE liczba = 10),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') ,(SELECT id FROM uzytkownicy WHERE mail = 'jan_kaczmarczyk@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'nieotwarta-brak odpowiedniego limitu osob'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Matematyka dla szkoly podstawowej, grupa jednoosobowa', (SELECT id FROM LIMITY WHERE liczba = 1),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') ,(SELECT id FROM uzytkownicy WHERE mail = 'jan_kaczmarczyk@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Matematyka dla szkoly podstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') ,(SELECT id FROM uzytkownicy WHERE mail = 'piotr_jankowski@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Matematyka dla szkoly ponadpodstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') ,(SELECT id FROM uzytkownicy WHERE mail = 'natalia_kubiak@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'nieotwarta-brak odpowiedniego limitu osob'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Historia dla szkoly ponadpodstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'historia') ,(SELECT id FROM uzytkownicy WHERE mail = 'adrian_kwiatkowski@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Historia dla szkoly ponadpodstawowej, grupa jednoosobowa', (SELECT id FROM LIMITY WHERE liczba = 1),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'historia') ,(SELECT id FROM uzytkownicy WHERE mail = 'adrian_kwiatkowski@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Geografia dla szkoly ponadpodstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'geografia') ,(SELECT id FROM uzytkownicy WHERE mail = 'magdalena_kaczmarek@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Geografia dla szkoly ponadpodstawowej, grupa dziesiecioosobowa', (SELECT id FROM LIMITY WHERE liczba = 10),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'geografia') ,(SELECT id FROM uzytkownicy WHERE mail = 'magdalena_kaczmarek@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'nieotwarta-brak odpowiedniego limitu osob'));
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES 
('Fizyka dla szkoly ponadpodstawowej, grupa dziesiecioosobowa', (SELECT id FROM LIMITY WHERE liczba = 10),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'fizyka') ,(SELECT id FROM uzytkownicy WHERE mail = 'agnieszka_krol@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'nieotwarta-brak odpowiedniego limitu osob')); 
	
-- kursy planowane
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Geografia dla szkoly ponadpodstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'geografia') ,(SELECT id FROM uzytkownicy WHERE mail = 'magdalena_kaczmarek@nauczyciele.szkola.edu.pl'),6,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'planowana'));

INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES 
('Fizyka dla szkoly ponadpodstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'fizyka') ,(SELECT id FROM uzytkownicy WHERE mail = 'agnieszka_krol@nauczyciele.szkola.edu.pl'),6,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'planowana'));  

INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES 
('J. angielski dla szkoly ponadpodstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') ,(SELECT id FROM uzytkownicy WHERE mail = 'marek_malinowski@nauczyciele.szkola.edu.pl'),6,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'planowana')); 

INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Chemia dla szkoly ponadpodstawowej, grupa piecioosobowa', (SELECT id FROM LIMITY WHERE liczba = 5),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'chemia') ,(SELECT id FROM uzytkownicy WHERE mail = 'joanna_pawlowska@nauczyciele.szkola.edu.pl'),6,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'planowana'));

INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('J. angielski dla szkoly podstawowej, grupa jednoosobowa', (SELECT id FROM LIMITY WHERE liczba = 1),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') ,(SELECT id FROM uzytkownicy WHERE mail = 'marek_malinowski@nauczyciele.szkola.edu.pl'),6,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'planowana'));

INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Matematyka dla szkoly podstawowej, grupa jednoosobowa', (SELECT id FROM LIMITY WHERE liczba = 1),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') ,(SELECT id FROM uzytkownicy WHERE mail = 'jan_kaczmarczyk@nauczyciele.szkola.edu.pl'),6,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'planowana'));

INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES 
('Informatyka dla szkoly ponadpodstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'informatyka') ,(SELECT id FROM uzytkownicy WHERE mail = 'ewa_zielinska@nauczyciele.szkola.edu.pl'),6,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'planowana'));
	
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES 
('J. polski dla szkoly podstawowej, grupa piecioosobowa', (SELECT id FROM LIMITY WHERE liczba = 5),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') ,(SELECT id FROM uzytkownicy WHERE mail = 'michal_szymanski@nauczyciele.szkola.edu.pl'),6,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'planowana'));
	
-- planowane kursy intensywne
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Matematyka dla podstawowej, grupa jednoosobowa', (SELECT id FROM LIMITY WHERE liczba = 1),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') ,(SELECT id FROM uzytkownicy WHERE mail = 'piotr_jankowski@nauczyciele.szkola.edu.pl'),9,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'planowana'));

INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('Matematyka dla szkoly podstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') ,(SELECT id FROM uzytkownicy WHERE mail = 'jan_kaczmarczyk@nauczyciele.szkola.edu.pl'),9,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'planowana'));

INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES 
('Fizyka dla szkoly ponadpodstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'fizyka') ,(SELECT id FROM uzytkownicy WHERE mail = 'agnieszka_krol@nauczyciele.szkola.edu.pl'),9,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'planowana'));


--uzupelnianie tabeli terminy_zajec_grup --
INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='poniedzialek' AND godzina ='16:00-16:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'J. angielski dla szkoly podstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'marta_kowalska@nauczyciele.szkola.edu.pl') and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='wtorek' AND godzina ='16:00-16:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'J. angielski dla szkoly podstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'marek_malinowski@nauczyciele.szkola.edu.pl') and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='sroda' AND godzina ='17:00-17:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'J. angielski dla szkoly podstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'marek_malinowski@nauczyciele.szkola.edu.pl') and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='poniedzialek' AND godzina ='17:00-17:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'J. angielski dla szkoly ponadpodstawowej, grupa piecioosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 5) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'krzysztof_wojciechowski@nauczyciele.szkola.edu.pl') and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='czwartek' AND godzina ='16:00-16:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'J. polski dla szkoly podstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'anna_tomaszewska@nauczyciele.szkola.edu.pl') and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='czwartek' AND godzina ='16:00-16:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Fizyka dla szkoly ponadpodstawowej, grupa dziesiecioosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 10) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'fizyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'agnieszka_krol@nauczyciele.szkola.edu.pl') and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'nieotwarta-brak odpowiedniego limitu osob'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='wtorek' AND godzina ='17:00-17:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Geografia dla szkoly ponadpodstawowej, grupa dziesiecioosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 10) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'geografia') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'magdalena_kaczmarek@nauczyciele.szkola.edu.pl') and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'nieotwarta-brak odpowiedniego limitu osob'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='sroda' AND godzina ='18:00-18:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Historia dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'historia') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'adrian_kwiatkowski@nauczyciele.szkola.edu.pl') and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna'))));

-- dla kursow planowanych
INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='czwartek' AND godzina ='18:00-18:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Fizyka dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'fizyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'agnieszka_krol@nauczyciele.szkola.edu.pl') and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='wtorek' AND godzina ='16:00-16:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Geografia dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'geografia') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'magdalena_kaczmarek@nauczyciele.szkola.edu.pl') and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='sroda' AND godzina ='19:00-19:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'J. angielski dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'marek_malinowski@nauczyciele.szkola.edu.pl') and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='sroda' AND godzina ='19:00-19:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Chemia dla szkoly ponadpodstawowej, grupa piecioosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 5) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'chemia') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'joanna_pawlowska@nauczyciele.szkola.edu.pl') and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='poniedzialek' AND godzina ='16:00-16:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'J. angielski dla szkoly podstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'marek_malinowski@nauczyciele.szkola.edu.pl') and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='wtorek' AND godzina ='18:00-18:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Matematyka dla szkoly podstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'jan_kaczmarczyk@nauczyciele.szkola.edu.pl') and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='poniedzialek' AND godzina ='19:00-19:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Informatyka dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'informatyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'ewa_zielinska@nauczyciele.szkola.edu.pl') and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='wtorek' AND godzina ='18:00-18:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'J. polski dla szkoly podstawowej, grupa piecioosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 5) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'michal_szymanski@nauczyciele.szkola.edu.pl') and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));
	
-- podwójne terminy dla planowanych intensywnych
INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='wtorek' AND godzina ='18:00-18:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Matematyka dla podstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'piotr_jankowski@nauczyciele.szkola.edu.pl') and id_daty_kursu = 9 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='poniedzialek' AND godzina ='18:00-18:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Matematyka dla podstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'piotr_jankowski@nauczyciele.szkola.edu.pl') and id_daty_kursu = 9 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));
	

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='sroda' AND godzina ='19:00-19:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Matematyka dla szkoly podstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'jan_kaczmarczyk@nauczyciele.szkola.edu.pl') and id_daty_kursu = 9 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));
	
INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='piatek' AND godzina ='17:00-17:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Matematyka dla szkoly podstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'jan_kaczmarczyk@nauczyciele.szkola.edu.pl') and id_daty_kursu = 9 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));


INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='piatek' AND godzina ='17:00-17:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Fizyka dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'fizyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'agnieszka_krol@nauczyciele.szkola.edu.pl') and id_daty_kursu = 9 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));

INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='wtorek' AND godzina ='18:00-18:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'Fizyka dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'fizyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'agnieszka_krol@nauczyciele.szkola.edu.pl') and id_daty_kursu = 9 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));


-- uzupelnianie tabeli zajecia_ucznia z uzyciem funkcji
SELECT dodaj_zajecia_ucznia((SELECT id FROM uzytkownicy WHERE mail = 'natalia_kaczmarek@uczniowie.szkola.edu.pl'), (SELECT ID FROM grupy WHERE (nazwa = 'J. angielski dla szkoly podstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'marta_kowalska@nauczyciele.szkola.edu.pl' and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna')))));
--NOWE
SELECT dodaj_zajecia_ucznia((SELECT id FROM uzytkownicy WHERE mail = 'kinga_glowacka@uczniowie.szkola.edu.pl'), (SELECT ID FROM grupy WHERE (nazwa = 'Historia dla szkoly ponadpodstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'historia') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'adrian_kwiatkowski@nauczyciele.szkola.edu.pl' and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna')))));
--
SELECT dodaj_zajecia_ucznia((SELECT id FROM uzytkownicy WHERE mail = 'karolina_kowalewska@uczniowie.szkola.edu.pl'), (SELECT ID FROM grupy WHERE (nazwa = 'Informatyka dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'informatyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'ewa_zielinska@nauczyciele.szkola.edu.pl' and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana')))));
	
SELECT dodaj_zajecia_ucznia((SELECT id FROM uzytkownicy WHERE mail = 'agata_marciniak@uczniowie.szkola.edu.pl'), (SELECT ID FROM grupy WHERE (nazwa = 'Informatyka dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'informatyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'ewa_zielinska@nauczyciele.szkola.edu.pl' and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana')))));
	
SELECT dodaj_zajecia_ucznia((SELECT id FROM uzytkownicy WHERE mail = 'patryk_sobczak@uczniowie.szkola.edu.pl'), (SELECT ID FROM grupy WHERE (nazwa = 'Matematyka dla szkoly podstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'matematyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'jan_kaczmarczyk@nauczyciele.szkola.edu.pl' and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana')))));


--pokazowy uczen, pokazowy nauczyciel

--powtorzony insert

-- przykladowa uczennica, chodzi do szkoly ponadpodstawowej i jest zapisana na do kilku grup 
INSERT INTO uzytkownicy (login, haslo,stopien_uprawnien_uzytkownika, imie, nazwisko, mail, id_typ_szkoly) VALUES
('aneta_kowalczyk', 'haslo_anety',3,'Aneta', 'Kowalczyk', 'aneta_kowalczyk@uczniowie.szkola.edu.pl',2);

select dodaj_zajecia_ucznia((SELECT id from uzytkownicy where mail = 'aneta_kowalczyk@uczniowie.szkola.edu.pl'), (SELECT id from grupy where (nazwa = 'Historia dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'historia') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'adrian_kwiatkowski@nauczyciele.szkola.edu.pl' and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna')))));
	
	
select dodaj_zajecia_ucznia((SELECT id from uzytkownicy where mail = 'aneta_kowalczyk@uczniowie.szkola.edu.pl'), (SELECT id from grupy where (nazwa = 'J. angielski dla szkoly ponadpodstawowej, grupa piecioosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 5) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk angielski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'krzysztof_wojciechowski@nauczyciele.szkola.edu.pl' and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna')))));	
	

select zapisz_sie_do_grupy((SELECT id FROM uzytkownicy WHERE mail = 'aneta_kowalczyk@uczniowie.szkola.edu.pl'), (SELECT id from grupy where (nazwa = 'Fizyka dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'fizyka') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'agnieszka_krol@nauczyciele.szkola.edu.pl' and id_daty_kursu = 9 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana')))));
	
select zapisz_sie_do_grupy((SELECT id FROM uzytkownicy WHERE mail = 'aneta_kowalczyk@uczniowie.szkola.edu.pl'), (SELECT id from grupy where (nazwa = 'Chemia dla szkoly ponadpodstawowej, grupa piecioosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 5) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'chemia') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'joanna_pawlowska@nauczyciele.szkola.edu.pl' and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana')))));
	
	
-- przykladowa nauczycielka 
INSERT INTO uzytkownicy (login, haslo,stopien_uprawnien_uzytkownika, imie, nazwisko, mail, id_typ_szkoly) VALUES
('aleksandra_nowicka', 'haslo_aleksandry', 2, 'Aleksandra', 'Nowicka', 'aleksandra_nowicka@nauczyciele.szkola.edu.pl',3);

-- Aneta Kowalczyk bedzie mogla zapisac sie do grupy Aleksandry Nowickiej jako druga osoba

-- pierwsza grupa, aktywna
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('J. polski dla szkoly podstawowej, grupa jednoosobowa', (SELECT id FROM LIMITY WHERE liczba = 1),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') ,(SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
	
INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='piatek' AND godzina ='17:00-17:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'J. polski dla szkoly podstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl') and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna'))));
	

select dodaj_zajecia_ucznia((SELECT id from uzytkownicy where mail = 'artur_szewczyk@uczniowie.szkola.edu.pl'), (SELECT id from grupy where (nazwa = 'J. polski dla szkoly podstawowej, grupa jednoosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 1) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl' and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna')))));
	
-- druga grupa, aktywna	
INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES
('J. polski dla szkoly podstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') ,(SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl'),2,
	(SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty'),(SELECT id FROM status_grupy WHERE opis = 'aktywna'));
	
INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='wtorek' AND godzina ='16:00-16:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'J. polski dla szkoly podstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl') and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna'))));
	
	
select dodaj_zajecia_ucznia((SELECT id from uzytkownicy where mail = 'mateusz_wrobel@uczniowie.szkola.edu.pl'), (SELECT id from grupy where (nazwa = 'J. polski dla szkoly podstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl' and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna')))));
	
select dodaj_zajecia_ucznia((SELECT id from uzytkownicy where mail = 'agnieszka_nowakowska@uczniowie.szkola.edu.pl'), (SELECT id from grupy where (nazwa = 'J. polski dla szkoly podstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl' and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna')))));
	
select dodaj_zajecia_ucznia((SELECT id from uzytkownicy where mail = 'ewa_jozwiak@uczniowie.szkola.edu.pl'), (SELECT id from grupy where (nazwa = 'J. polski dla szkoly podstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl' and id_daty_kursu = 2 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'egzamin osmoklasisty') and id_status = (SELECT id FROM status_grupy WHERE opis = 'aktywna')))));
	
-- trzecia grupa, planowana

INSERT INTO grupy (nazwa, id_limitu, id_przedmiotu, id_nauczyciela, id_daty_kursu, id_poziomu, id_status)
VALUES 
('J. polski dla szkoly ponadpodstawowej, grupa trzyosobowa', (SELECT id FROM LIMITY WHERE liczba = 3),
	(SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') ,(SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl'),6,
	(SELECT id FROM POZIOMY WHERE nazwa = 'matura'),(SELECT id FROM status_grupy WHERE opis = 'planowana'));
	
INSERT into terminy_zajec_grup(id_termin_zajec, id_grupy) values
((SELECT id FROM termin_zajec WHERE dzien_tygodnia ='piatek' AND godzina ='19:00-19:45'), (SELECT id FROM GRUPY WHERE (nazwa = 'J. polski dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl') and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana'))));
	
select zapisz_sie_do_grupy((SELECT id from uzytkownicy where mail = 'karolina_kowalewska@uczniowie.szkola.edu.pl'), (SELECT id from grupy where (nazwa = 'J. polski dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl' and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana')))));
	
select zapisz_sie_do_grupy((SELECT id from uzytkownicy where mail = 'aneta_kowalczyk@uczniowie.szkola.edu.pl'), (SELECT id from grupy where (nazwa = 'J. polski dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl' and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana')))));
	

select wypisz_ucznia((SELECT id from uzytkownicy where mail = 'aneta_kowalczyk@uczniowie.szkola.edu.pl'), (SELECT id from grupy where (nazwa = 'J. polski dla szkoly ponadpodstawowej, grupa trzyosobowa' and id_limitu = (SELECT id FROM LIMITY WHERE liczba = 3) and
	id_przedmiotu = (SELECT id FROM PRZEDMIOTY WHERE nazwa = 'jezyk polski') and id_nauczyciela = (SELECT id FROM uzytkownicy WHERE mail = 'aleksandra_nowicka@nauczyciele.szkola.edu.pl' and id_daty_kursu = 6 and 
	id_poziomu = (SELECT id FROM POZIOMY WHERE nazwa = 'matura') and id_status = (SELECT id FROM status_grupy WHERE opis = 'planowana')))));
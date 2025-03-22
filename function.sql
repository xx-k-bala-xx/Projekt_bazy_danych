-----------------------------------------------------------------------------------
-------------------------------------- FUNKCJE ------------------------------------
-----------------------------------------------------------------------------------

---- ZWYKLE FUNKCJE DODAJACE DO POSZCZEGOLNYCH TABEL -----------

-- limity --

drop function dodaj_limit cascade;
create or replace function dodaj_limit(nowy_limit_liczba integer)
returns text as $$
declare 
	czy_limit_istnieje boolean;
begin
	select count(1)>0 into czy_limit_istnieje from limity where liczba=nowy_limit_liczba;

		if czy_limit_istnieje then
		return 'Istnieje juz taki limit!';
		end if;

		if nowy_limit_liczba is null then
			return 'Liczba w limicie osób nie moze miec wartosci NULL!';
		end if;

	insert into limity (liczba) values (nowy_limit_liczba);
	return 'Dodanie nowego limitu zakonczone powodzeniem!';
end;
$$ language 'plpgsql';

-- przedmioty --

drop function dodaj_przedmiot cascade;
create or replace function dodaj_przedmiot(nowa_nazwa_przedmiotu text)
returns text as $$
declare 
	czy_przedmiot_istnieje boolean;
begin
	select count(1)>0 into czy_przedmiot_istnieje from przedmioty where nazwa=nowa_nazwa_przedmiotu;

		if czy_przedmiot_istnieje then
		return 'Istnieje juz przedmiot o tej nazwie!';
		end if;

		if nowa_nazwa_przedmiotu is null then
			return 'Nazwa przedmiotu nie moze przyjmowac wartosci NULL!';
		end if;

	insert into przedmioty (nazwa) values (nowa_nazwa_przedmiotu);
	return 'Dodanie nowego przedmiotu zakonczone powodzeniem!';
end;
$$ language 'plpgsql';

-- status grupy --

drop function dodaj_status_grupy cascade;
create or replace function dodaj_status_grupy(nowy_opis_statusu_grupy text)
returns text as $$
declare 
	czy_status_istnieje boolean;
begin
	select count(1)>0 into czy_status_istnieje from status_grupy where opis=nowy_opis_statusu_grupy;

		if czy_status_istnieje then
		return 'Istnieje juz status grupy o takim opisie!';
		end if;

		if nowy_opis_statusu_grupy is null then
			return 'Opis statusu grupy nie moze przyjmowac wartosci NULL!';
		end if;

	insert into status_grupy (opis) values (nowy_opis_statusu_grupy);
	return 'Dodanie nowego statusu grupy zakonczone powodzeniem!';
end;
$$ language 'plpgsql';

-- typ szkoly --

drop function dodaj_typ_szkoly cascade;
create or replace function dodaj_typ_szkoly(nowa_nazwa_typu_szkoly text)
returns text as $$
declare 
	czy_typ_szkoly_istnieje boolean;
begin
	select count(1)>0 into czy_typ_szkoly_istnieje from typ_szkoly where nazwa=nowa_nazwa_typu_szkoly;

		if czy_typ_szkoly_istnieje then
		return 'Istnieje juz typ szkoly o tej nazwie!';
		end if;

		if nowa_nazwa_typu_szkoly is null then
			return 'Nazwa typu szkoly nie moze przyjmowac wartosci NULL!';
		end if;

		if nowa_nazwa_typu_szkoly not in ('podstawowa', 'ponadpodstawowa') then
			return 'Firma korepetytorska nie obsuguje takiego typu szkoly!';
		end if;

	insert into typ_szkoly (nazwa) values (nowa_nazwa_typu_szkoly);
	return 'Dodanie nowego typu szkoly zakonczone powodzeniem!';
end;
$$ language 'plpgsql';

-- typ kursu --

drop function dodaj_typ_kursu cascade;
create or replace function dodaj_typ_kursu(nowa_nazwa_typu_kursu text)
returns text as $$
declare 
	czy_typ_kursu_istnieje boolean;
begin
	select count(1)>0 into czy_typ_kursu_istnieje from typ_kursu where nazwa=nowa_nazwa_typu_kursu;

		if czy_typ_kursu_istnieje then
		return 'Istnieje juz typ kursu o tej nazwie!';
		end if;

		if nowa_nazwa_typu_kursu is null then
			return 'Nazwa typu kursu nie moze przyjmowac wartosci NULL!';
		end if;

	insert into typ_kursu (nazwa) values (nowa_nazwa_typu_kursu);
	return 'Dodanie nowego typu kursu zakonczone powodzeniem!';
end;
$$ language 'plpgsql';

-- termin zajec --

drop function dodaj_termin_zajec cascade;
create or replace function dodaj_termin_zajec(nowy_dzien_tygodnia text, nowa_godzina varchar(11))
returns text as $$
declare 
	czy_termin_istnieje boolean;
begin
	select count(1)>0 into czy_termin_istnieje from termin_zajec where dzien_tygodnia=nowy_dzien_tygodnia and godzina=nowa_godzina;

		if czy_termin_istnieje then
		return 'Istnieje juz taki termin zajec!';
		end if;

		if nowy_dzien_tygodnia is null then
			return 'Dzien tygodnia nie moze przyjmowac wartosci NULL!';
		end if;

		if nowa_godzina is null then
			return 'Godzina nie moze przyjmowac wartosci NULL!';
		end if;

		if nowy_dzien_tygodnia not in ('poniedzialek', 'wtorek', 'sroda', 'czwartek', 'piatek', 'sobota') then
			return 'Szkola nie pracuje w takim dniu tygodnia!';
		end if;

		if nowa_godzina not in ('15:00-15:45','16:00-16:45', '17:00-17:45', '18:00-18:45', '19:00-19:45', '20:00-20:45') then
			return 'Szkola nie pracuje w takich godzinach!';
		end if;


	insert into termin_zajec (dzien_tygodnia, godzina) values (nowy_dzien_tygodnia,nowa_godzina);
	return 'Dodanie nowego terminu zajec zakonczone powodzeniem!';
end;
$$ language 'plpgsql';

-- rodzaje uzytkowników --

drop function dodaj_rodzaj_uzytkownika cascade;
create or replace function dodaj_rodzaj_uzytkownika(nowa_nazwa_rodzaju_uzytkownika text)
returns text as $$
declare 
	czy_rodzaj_uzytkownika_istnieje boolean;
begin
	select count(1)>0 into czy_rodzaj_uzytkownika_istnieje from rodzaje_uzytkownikow where nazwa=nowa_nazwa_rodzaju_uzytkownika;

		if czy_rodzaj_uzytkownika_istnieje then
		return 'Istnieje juz rodzaj uzytkownika o tej nazwie!';
		end if;

		if nowa_nazwa_rodzaju_uzytkownika is null then
			return 'Nazwa rodzaju u¿ytkownika nie moze przyjmowac wartosci NULL!';
		end if;

		if nowa_nazwa_rodzaju_uzytkownika not in  ('administrator', 'nauczyciel', 'uczen', 'stazysta') then
			return 'Firma korepetytorska nie obsluguje takiego rodzaju uzytkownika!';
		end if;

	insert into rodzaje_uzytkownikow (nazwa) values (nowa_nazwa_rodzaju_uzytkownika);
	return 'Dodanie nowego rodzaju uzytkownika zakonczone powodzeniem!';
end;
$$ language 'plpgsql';


-- uzytkownicy --

drop function dodaj_uzytkownika cascade;
create or replace function dodaj_uzytkownika(nowy_login varchar(30), nowe_haslo varchar(20), nowy_st_upr integer,nowe_imie varchar(20),nowe_nazwisko varchar(20),nowy_mail varchar(50), nowy_id_typ_szkoly integer)
returns text as $$
declare 
	czy_uzytkownik_istnieje boolean;
	czy_mail_istnieje boolean;
	czy_stopien_uprawnien_istnieje boolean;
	czy_id_typ_szkoly_istnieje boolean;
begin
	select count(1)>0 into czy_uzytkownik_istnieje from uzytkownicy where login=nowy_login;
	select count(1)>0 into czy_mail_istnieje from uzytkownicy where mail=nowy_mail;
	select count(1)<>1 into czy_stopien_uprawnien_istnieje from rodzaje_uzytkownikow where id=nowy_st_upr;
	select count(1)<>1 into czy_id_typ_szkoly_istnieje from typ_szkoly where id=nowy_id_typ_szkoly;

		if czy_uzytkownik_istnieje then
		return 'Istnieje juz uzytkownik o takim loginie!';
		end if;

		if czy_mail_istnieje then
		return 'Istnieje juz uzytkownik o takim adresie e-mail!';
		end if;

		if czy_stopien_uprawnien_istnieje then
		return 'Nie istnieje rodzaj uzytkownika o takim ID!';
		end if;

		if czy_id_typ_szkoly_istnieje then
		return 'Nie istnieje typ szkoly o takim ID!';
		end if;

		if nowy_login is null then
			return 'Login uzytkownika nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_haslo is null then
			return 'Haslo uzytkownika nie moze przyjmowac wartosci NULL!';
		end if;

		if nowy_st_upr is null then
			return 'Stopien uprawnien uzytkownika nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_imie is null then
			return 'Imie nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_nazwisko is null then
			return 'Nazwisko nie moze przyjmowac wartosci NULL!';
		end if;

		if nowy_mail is null then
			return 'Adres e-mail nie moze przyjmowac wartosci NULL!';
		end if;

		if nowy_id_typ_szkoly is null then
			return 'ID typ szkoly nie moze przyjmowac wartosci NULL!';
		end if;


	insert into uzytkownicy (login,haslo,stopien_uprawnien_uzytkownika,imie,nazwisko,mail,id_typ_szkoly) values (nowy_login,nowe_haslo,nowy_st_upr,nowe_imie,nowe_nazwisko,nowy_mail,nowy_id_typ_szkoly);
	return 'Dodanie nowego uzytkownika zakonczone powodzeniem!';
end;
$$ language 'plpgsql';


-- poziomy --

drop function dodaj_poziom cascade;
create or replace function dodaj_poziom(nowa_nazwa_poziomu text, nowy_id_typ_szkoly integer)
returns text as $$
declare 
	czy_poziom_istnieje boolean;
	czy_typ_szkoly_istnieje boolean;
begin
	select count(1)>0 into czy_poziom_istnieje from poziomy where nazwa=nowa_nazwa_poziomu;
	select count(1)<>0 into czy_typ_szkoly_istnieje from typ_szkoly where id=nowy_id_typ_szkoly;

		if czy_poziom_istnieje then
		return 'Istnieje juz poziom o takiej nazwie!';
		end if;

		if czy_typ_szkoly_istnieje then
		return 'Nie istnieje typ szkoly o takim ID!';
		end if;

		if nowa_nazwa_poziomu is null then
			return 'Nazwa poziomu nie moze przyjmowac wartosci NULL!';
		end if;

		if nowy_id_typ_szkoly is null then
			return 'ID typu szkoly nie moze przyjmowac wartosci NULL!';
		end if;


	insert into poziomy (nazwa,id_typ_szkoly) values (nowa_nazwa_poziomu,nowy_id_typ_szkoly);
	return 'Dodanie nowego poziomu zakonczone powodzeniem!';
end;
$$ language 'plpgsql';


-- daty kursu -- 

drop function dodaj_daty_kursu cascade;
create or replace function dodaj_daty_kursu(nowy_pocz_zap date,nowy_kon_zap date,nowy_pocz_zaj date,nowy_kon_zaj date, nowy_id_typ_kursu integer)
returns text as $$
declare 
	czy_daty_kursu_istnieja boolean;
	czy_id_typ_kursu_istnieje boolean;
begin
	select count(1)>0 into czy_daty_kursu_istnieja from daty_kursu where poczatek_zapisow=nowy_pocz_zap and poczatek_zajec=nowy_pocz_zaj and koniec_zajec=nowy_kon_zaj and koniec_zapisow=nowy_kon_zap and id_typ_kursu=nowy_id_typ_kursu;
	select count(1)<>0 into czy_id_typ_kursu_istnieje from typ_kursu where id=nowy_id_typ_kursu;

		if czy_daty_kursu_istnieja then
		return 'Istnieja juz takie daty kursu!';
		end if;

		if czy_id_typ_kursu_istnieje then
		return 'Nie istnieje typ kursu o takim ID!';
		end if;

		if nowy_pocz_zap is null then
			return 'Poczatek zapisow nie moze przyjmowac wartosci NULL!';
		end if;

		if nowy_pocz_zaj is null then
			return 'Poczatek zajec nie moze przyjmowac wartosci NULL!';
		end if;

		if nowy_kon_zap is null then
			return 'Koniec zapisów nie moze przyjmowac wartosci NULL!';
		end if;

		if nowy_kon_zaj is null then
			return 'Koniec zajec nie moze przyjmowac wartosci NULL!';
		end if;

		if nowy_id_typ_kursu is null then
			return 'ID typ kursu nie moze przyjmowac wartosci NULL!';
		end if;

		if nowy_kon_zap<nowy_pocz_zap or  nowy_kon_zap=nowy_pocz_zap then
			return 'Koniec zapisow musi byc pozniej niz poczatek zapisow!';
		end if;

		if nowy_kon_zaj<nowy_pocz_zaj or  nowy_kon_zaj=nowy_pocz_zaj then
			return 'Koniec zajec musi byc pozniej niz poczatek zajec!';
		end if;

	insert into daty_kursu (poczatek_zapisow,koniec_zapisow,poczatek_zajec,koniec_zajec,id_typ_kursu) values (nowy_pocz_zap,nowy_kon_zap,nowy_pocz_zaj,nowy_kon_zaj,nowy_id_typ_kursu);
	return 'Dodanie nowych dat kursu zakonczone powodzeniem!';
end;
$$ language 'plpgsql';


-- ceny --

drop function dodaj_cene cascade;
create or replace function dodaj_cene(nowe_id_limitu integer,nowe_id_poziomu integer, nowe_id_typu integer, nowa_cena decimal(6,2))
returns text as $$
declare 
	czy_cena_istnieje boolean;
	czy_id_limitu_istnieje boolean;
	czy_id_poziomu_istnieje boolean;
	czy_id_typu_istnieje boolean;
begin
	select count(1)>0 into czy_cena_istnieje from ceny where id_limitu=nowe_id_limitu and id_poziomu=nowe_id_poziomu;
	select count(1)<>1 into czy_id_limitu_istnieje from limity where id=nowe_id_limitu;
	select count(1)<>1 into czy_id_poziomu_istnieje from poziomy where id=nowe_id_poziomu;
	select count(1)<>1 into czy_id_typu_istnieje from typ_kursu where id=nowe_id_typu;

		if czy_cena_istnieje then
		return 'Istnieje juz cena dla podanego poziomu i limitu!';
		end if;

		if czy_id_limitu_istnieje then
		return 'Nie istnieje limit o takim ID!';
		end if;

		if czy_id_poziomu_istnieje then
		return 'Nie istnieje poziom o takim ID!';
		end if;
		
		if czy_id_typu_istnieje then
		return 'Nie istnieje typ o takim ID!';
		end if;

		if nowe_id_limitu is null then
			return 'ID limitu nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_id_poziomu is null then
			return 'ID poziomu nie moze przyjmowac wartosci NULL!';
		end if;
		
		if nowe_id_typu is null then
			return 'ID typu nie moze przyjmowac wartosci NULL!';
		end if;

		if nowa_cena is null then
			return 'Cena nie moze przyjmowac wartosci NULL!';
		end if;

	insert into ceny (id_limitu,id_poziomu,cena_za_kurs) values (nowe_id_limitu,nowe_id_poziomu,nowa_cena);
	return 'Dodanie nowej ceny zakonczone powodzeniem!';
end;
$$ language 'plpgsql';


-- grupy --

drop function dodaj_grupe cascade;

create or replace function dodaj_grupe(nowa_nazwa text, nowe_id_limitu integer, nowe_id_przedmiotu integer, nowe_id_nauczyciela integer, nowe_id_daty_kursu integer, nowe_id_poziomu integer, nowe_id_statusu integer)
returns text as $$
declare 
	czy_grupa_istnieje boolean;
	czy_id_limitu_istnieje boolean;
	czy_id_przedmiotu_istnieje boolean;
	czy_nauczyciel_istnieje boolean;
	czy_id_daty_kursu_istnieja boolean;
	czy_id_poziomu_istnieje boolean;
	czy_id_statusu_istnieje boolean;
begin
	select count(1)>0 into czy_grupa_istnieje from grupy where nazwa=nowa_nazwa and id_limitu=nowe_id_limitu and id_przedmiotu=nowe_id_przedmiotu and id_nauczyciela=nowe_id_nauczyciela and id_daty_kursu=nowe_id_daty_kursu and id_poziomu=nowe_id_poziomu and id_status=nowe_id_statusu;
	select count(1)<>1 into czy_id_limitu_istnieje from limity where id=nowe_id_limitu;
	select count(1)<>1 into czy_id_przedmiotu_istnieje from przedmioty where id=nowe_id_przedmiotu;
	select count(1)<>1 into czy_nauczyciel_istnieje from uzytkownicy join rodzaje_uzytkownikow on(uzytkownicy.stopien_uprawnien_uzytkownika=rodzaje_uzytkownikow.id) where uzytkownicy.id=nowe_id_nauczyciela and rodzaje_uzytkownikow.nazwa='nauczyciel';
	select count(1)<>1 into czy_id_daty_kursu_istnieja from daty_kursu where id=nowe_id_daty_kursu;
	select count(1)<>1 into czy_id_poziomu_istnieje from poziomy where id=nowe_id_poziomu;
	select count(1)<>1 into czy_id_statusu_istnieje from status_grupy where id=nowe_id_statusu;



		if czy_grupa_istnieje then
		return 'Istnieje juz taka grupa!';
		end if;

		if czy_id_limitu_istnieje then
		return 'Nie istnieje limit o takim ID!';
		end if;
		
		if czy_nauczyciel_istnieje then
		return 'Nie istnieje nauczyciel o takim ID!';
		end if;

		if czy_id_daty_kursu_istnieja then
		return 'Nie istnieja daty kursu o takim ID!';
		end if;

		if czy_id_poziomu_istnieje then
		return 'Nie istnieje poziom o takim ID!';
		end if;

		if czy_id_statusu_istnieje then
		return 'Nie istnieje status grupy o takim ID!';
		end if;

		if nowa_nazwa is null then
			return 'Nazwa grupy nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_id_limitu is null then
			return 'ID limitu nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_id_przedmiotu is null then
			return 'ID przedmiotu nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_id_nauczyciela is null then
			return 'ID nauczyciela nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_id_daty_kursu is null then
			return 'ID dat kursu nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_id_poziomu is null then
			return 'ID poziomu nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_id_statusu is null then
			return 'ID status grupy nie moze przyjmowac wartosci NULL!';
		end if;

	insert into grupy (nazwa, id_limitu, id_przedmiotu,id_nauczyciela,id_daty_kursu,id_poziomu, id_status) values (nowa_nazwa,nowe_id_limitu,nowe_id_przedmiotu, nowe_id_nauczyciela,nowe_id_daty_kursu, nowe_id_poziomu,nowe_id_statusu);
	return 'Dodanie nowej grupy zakonczone powodzeniem!';
end;
$$ language 'plpgsql';


-- terminy zajec grup --

drop function dodaj_zajecia_grupy cascade;
create or replace function dodaj_zajecia_grupy(nowe_id_termin_zajec integer, nowe_id_grupy integer)
returns text as $$
declare 
	czy_termin_istnieje boolean;
	czy_termin_zajec_istnieje boolean;
	czy_grupa_istnieje boolean;
	krotka record;
begin
	select count(1)>0 into czy_termin_istnieje from terminy_zajec_grup where id_termin_zajec=nowe_id_termin_zajec and id_grupy=nowe_id_grupy;
	select count(1)<>1 into czy_termin_zajec_istnieje from termin_zajec where id=nowe_id_termin_zajec;
	select count(1)<>1 into czy_grupa_istnieje from grupy where id=nowe_id_grupy;

		if czy_termin_istnieje then
		return 'Istnieja juz zajecia dla tej grupy w tym terminie!';
		end if;

		if czy_termin_zajec_istnieje then
		return 'Nie istnieje termin zajec o takim ID!';
		end if;

		if czy_grupa_istnieje then
		return 'Nie istnieje grupa o takim ID!';
		end if;

		if nowe_id_termin_zajec is null then
			return 'ID terminu zajec nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_id_grupy is null then
			return 'ID grupy nie moze przyjmowac wartosci NULL!';
		end if;
		
		for krotka in 
		(select id_daty_kursu, id_termin_zajec from grupy join terminy_zajec_grup on (id = id_grupy) where id_nauczyciela = (select id_nauczyciela from grupy where id = nowe_id_grupy))
		loop
			if  krotka.id_daty_kursu  = (SELECT ID_daty_kursu FROM grupy WHERE id = nowe_id_grupy) and krotka.id_termin_zajec = nowe_id_termin_zajec then  
			return 'Nauczyciel ma już zaplanowane inne zajecia w tym samym czasie';
			end if;
		end loop;

	insert into terminy_zajec_grup (id_termin_zajec,id_grupy) values (nowe_id_termin_zajec,nowe_id_grupy);
	return 'Dodanie nowych zajec dla grupy zakonczone powodzeniem!';
end;
$$ language 'plpgsql';


-- zajecia uczniów --

drop function dodaj_zajecia_ucznia cascade;
create or replace function dodaj_zajecia_ucznia(nowe_id_ucznia integer, nowe_id_grupy integer)
returns text as $$
declare 
	czy_zajecia_istnieja boolean;
	czy_uczen_istnieje boolean;
	czy_grupa_istnieje boolean;
begin
	select count(1)>0 into czy_zajecia_istnieja from zajecia_uczniow where id_ucznia=nowe_id_ucznia and id_grupy=nowe_id_grupy;
	select count(1)<>1 into czy_uczen_istnieje from uzytkownicy join rodzaje_uzytkownikow on(uzytkownicy.stopien_uprawnien_uzytkownika=rodzaje_uzytkownikow.id) where uzytkownicy.id=nowe_id_ucznia and rodzaje_uzytkownikow.nazwa='uczen';
	select count(1)<>1 into czy_grupa_istnieje from grupy where id=nowe_id_grupy;

		if czy_zajecia_istnieja then
		return 'Istnieja juz takie zajecia dla tego ucznia!';
		end if;

		if czy_uczen_istnieje then
		return 'Nie istnieje uczen o takim ID!';
		end if;

		if czy_grupa_istnieje then
		return 'Nie istnieje grupa o takim ID!';
		end if;

		if nowe_id_ucznia is null then
			return 'ID ucznia nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_id_grupy is null then
			return 'ID grupy nie moze przyjmowac wartosci NULL!';
		end if;

	insert into zajecia_uczniow (id_ucznia,id_grupy) values (nowe_id_ucznia,nowe_id_grupy);
	return 'Dodanie nowych zajec ucznia zakonczone powodzeniem!';
end;
$$ language 'plpgsql';
------------------------------- KONIEC ZWYKLYCH FUNKCJI DODAJACYCH DLA POSZCZEGOLNYCH TABEL ------------

-- funkcja tworzaca tabele z zajeciami ucznia dla ucznia, ktorego id podamy jako argument funkcji (bez id grupy) --

drop function zajecia_ucznia CASCADE;
create or replace function zajecia_ucznia(moje_id integer)
returns table (
	Nazwa_grupy text, 
	Dzien text, 
	Godzina_zajec text, 
	Imie_nauczyciela text, 
	Nazwisko_nauczyciela text, 
	Status text)
as $$
declare krotka record;

begin
	for krotka in
		(Select nazwa, dzien_tygodnia, godzina, imie, nazwisko,opis from((select * from((SELECT * From((SELECT nazwa,  id_termin_zajec, id_status, id_nauczyciela 
		FROM ((SELECT nazwa, id,id_status, id_nauczyciela FROM grupy where id in (SELECT id_grupy FROM zajecia_uczniow where id_ucznia = moje_id)) left join terminy_zajec_grup on (id_grupy = id))) 
		left join termin_zajec on(id = id_termin_zajec))) join status_grupy on(id_status = status_grupy.id))) join uzytkownicy on(uzytkownicy.id = id_nauczyciela)))
	Loop 
		Nazwa_grupy := krotka.nazwa;
		Dzien := krotka.dzien_tygodnia;
		Godzina_zajec := krotka.godzina;
		Imie_nauczyciela := krotka.imie;
		Nazwisko_nauczyciela := krotka.nazwisko;
		Status := krotka.opis;
		return next;
	end loop;
	return;
end;
$$ language 'plpgsql';


-- funkcja tworzaca tabele z zajeciami ucznia dla ucznia, ktorego id podamy jako argument funkcji (z id grupy) --

drop function zajecia_ucznia CASCADE;
create or replace function zajecia_ucznia(moje_id integer)
returns table (
	Id_g text,
	Nazwa_grupy text, 
	Dzien text, 
	Godzina_zajec text, 
	Imie_nauczyciela text, 
	Nazwisko_nauczyciela text, 
	Status text)
as $$
declare krotka record;

begin
	for krotka in
		(Select i, nazwa, dzien_tygodnia, godzina, imie, nazwisko,opis from((select * from((SELECT * From((SELECT i, nazwa,  id_termin_zajec, id_status, id_nauczyciela 
		FROM ((SELECT nazwa, id as i,id_status, id_nauczyciela FROM grupy where id in (SELECT id_grupy FROM zajecia_uczniow where id_ucznia = moje_id)) left join terminy_zajec_grup on (id_grupy = i))) 
		left join termin_zajec on(id = id_termin_zajec))) join status_grupy on(id_status = status_grupy.id))) join uzytkownicy on(uzytkownicy.id = id_nauczyciela)))

	Loop 
		Id_g := krotka.i;
		Nazwa_grupy := krotka.nazwa;
		Dzien := krotka.dzien_tygodnia;
		Godzina_zajec := krotka.godzina;
		Imie_nauczyciela := krotka.imie;
		Nazwisko_nauczyciela := krotka.nazwisko;
		Status := krotka.opis;
		return next;
	end loop;
	return;
end;
$$ language 'plpgsql';


-- funkcja tworzaca tabele z grupami nauczyciela, ktorego id podamy jako argument funkcji --

drop function grupy_nauczyciela CASCADE;
create or replace function grupy_nauczyciela(moje_id integer)
returns table ( 
	Id integer,
	Nazwa_grupy text, 
	Dzien text, 
	Godzina_zajec text, 
	Status text)
as $$
declare krotka record;

begin
	for krotka in 
		(select i, nazwa, dzien_tygodnia, godzina, opis from ((SELECT * FROM (select * from((SELECT * FROM ((SELECT grupy.id as i, nazwa, id_nauczyciela, id_status 
		From grupy where(id_nauczyciela = moje_id))as T1 left JOIN  terminy_zajec_grup on(T1.i = id_grupy)))left join termin_zajec on (id_termin_zajec=termin_zajec.id))) 
		join status_grupy on(id_status=status_grupy.id))))
	Loop 
		Id := krotka.i;
		Nazwa_grupy := krotka.nazwa;
		Dzien := krotka.dzien_tygodnia;
		Godzina_zajec := krotka.godzina;
		Status := krotka.opis;
		return next;
	end loop;
	return;
end;
$$ language 'plpgsql';


-- funkcja tworzaca tabele z grupami nauczyciela, ktorego id podamy jako drugi argument funkcji, o konkretnym statusie(pierwszy argument funkcji) --

drop function statusy_grup_nauczyciela cascade;
create or replace function statusy_grup_nauczyciela(wybrany_status text, wyb_id_nauczyciela integer)
returns table( 
	Id_1 integer,
	Nazwa_grupy_1 text, 
	Dzien_1 text, 
	Godzina_zajec_1 text,
	Status_1 text)
as $$
declare krotka record;
BEGIN
	for krotka in 
		(select id, nazwa_grupy, dzien, godzina_zajec, status from grupy_nauczyciela(wyb_id_nauczyciela) where status = wybrany_status) 
	Loop 
		Id_1:= krotka.id;
		Nazwa_grupy_1:= krotka.nazwa_grupy;
		Dzien_1 := krotka.dzien;
		Godzina_zajec_1 := krotka.godzina_zajec;
		Status_1 := krotka.status;
		return next;
	end loop;
	return;  
end;
$$ language 'plpgsql';


-- funkcja usuwająca ucznia z konkretnej grupy, za pierwszy argument przyjmuje id ucznia, za drugi id grupy, funkcja jest wykorzystywana w interfejsie dla administratora --

drop function wypisz_ucznia cascade;
create or replace function wypisz_ucznia(id_wyp_ucznia integer, id_wyp_grupy integer)
returns text as $$
declare 
	czy_uczen_istnieje boolean;
	czy_grupa_istnieje boolean;
begin	
	select count(1)<>1 into czy_uczen_istnieje from uzytkownicy join rodzaje_uzytkownikow on(uzytkownicy.stopien_uprawnien_uzytkownika=rodzaje_uzytkownikow.id) where uzytkownicy.id=id_wyp_ucznia and rodzaje_uzytkownikow.nazwa='uczen';
	select count(1)<>1 into czy_grupa_istnieje from grupy where id=id_wyp_grupy;
	
	if czy_uczen_istnieje then
		return 'Nie istnieje uczen o takim ID!';
		end if;

	if czy_grupa_istnieje then
		return 'Nie istnieje grupa o takim ID!';
	end if;
	
	DELETE FROM zajecia_uczniow WHERE id_ucznia = id_wyp_ucznia and id_grupy = id_wyp_grupy;
	return 'Uczen zostal pomyslnie wypisany z grupy.';
end;
    $$ language 'plpgsql';
	
-- funkcja zwalniajaca nauczyciela, ktorego id podamy w argumencie funkcji, uzywana w funkcjonalnosci dla administratora --

drop function zwolnij_nauczyciela cascade;
create or replace function zwolnij_nauczyciela(id_zw_nauczyciela INTEGER)
returns text as $$
DECLARE
	czy_nauczyciel_istnieje BOOLEAN;
BEGIN
	select count(1)<>1 into czy_nauczyciel_istnieje from uzytkownicy join rodzaje_uzytkownikow on(uzytkownicy.stopien_uprawnien_uzytkownika=rodzaje_uzytkownikow.id) where uzytkownicy.id=id_zw_nauczyciela and rodzaje_uzytkownikow.nazwa='nauczyciel';
    
    if czy_nauczyciel_istnieje THEN
    	return 'Nie istnieje nauczyciel o takim ID!';
    end if;
    
    delete from uzytkownicy where id = id_zw_nauczyciela;
    
    return 'Nauczyciel zostal zwolniony.';
    
 end;
 $$ language 'plpgsql';
 
 
 -- funkcja pokazujaca tabele z uczniami z konkretnej grupy, jako argumenty przyjmuje id nauczyciela prowadzacego grupe i id grupy, ktora prowadzi,
-- wykorzystywana w funkcjonalnosci interfejsu dla nauczyciela --

drop function uczniowie_w_grupie CASCADE;
create or replace function uczniowie_w_grupie(moje_id integer, id_mojej_grupy integer)

returns table ( 
	Imie_ucznia text, 
	Nazwisko_ucznia text,
	Adres_e_mail text)
as $$
declare krotka record;

begin
	IF id_mojej_grupy not in (select id from grupy_nauczyciela(moje_id)) THEN
        RAISE EXCEPTION 'Nie prowadzisz zajec w takiej grupie!';
    END IF;
	
	for krotka in 
		(select imie, nazwisko, mail from uzytkownicy where id in(select id_ucznia from zajecia_uczniow where id_grupy = id_mojej_grupy))
	Loop 
		Imie_ucznia := krotka.imie;
		Nazwisko_ucznia := krotka.nazwisko;
		Adres_e_mail := krotka.mail;
		return next;
	end loop;
	return;
end;
$$ language 'plpgsql';


-- funkcja dodajaca nowy termin zajec grupy w tygodniu, argumenty to id terminu zajec oraz id grupy --

drop function dodaj_zajecia_grupy cascade;
create or replace function dodaj_zajecia_grupy(nowe_id_termin_zajec integer, nowe_id_grupy integer)
returns text as $$
declare 
	czy_termin_istnieje boolean;
	czy_termin_zajec_istnieje boolean;
	czy_grupa_istnieje boolean;
	krotka record;
begin
	select count(1)>0 into czy_termin_istnieje from terminy_zajec_grup where id_termin_zajec=nowe_id_termin_zajec and id_grupy=nowe_id_grupy;
	select count(1)<>1 into czy_termin_zajec_istnieje from termin_zajec where id=nowe_id_termin_zajec;
	select count(1)<>1 into czy_grupa_istnieje from grupy where id=nowe_id_grupy;

		if czy_termin_istnieje then
		return 'Istnieja juz zajecia dla tej grupy w tym terminie!';
		end if;

		if czy_termin_zajec_istnieje then
		return 'Nie istnieje termin zajec o takim ID!';
		end if;

		if czy_grupa_istnieje then
		return 'Nie istnieje grupa o takim ID!';
		end if;

		if nowe_id_termin_zajec is null then
			return 'ID terminu zajec nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_id_grupy is null then
			return 'ID grupy nie moze przyjmowac wartosci NULL!';
		end if;
		
		for krotka in 
		(select id_daty_kursu, id_termin_zajec from grupy join terminy_zajec_grup on (id = id_grupy) where id_nauczyciela = (select id_nauczyciela from grupy where id = nowe_id_grupy))
		loop
			if  krotka.id_daty_kursu  = (SELECT ID_daty_kursu FROM grupy WHERE id = nowe_id_grupy) and krotka.id_termin_zajec = nowe_id_termin_zajec then  
			return 'Nauczyciel ma już zaplanowane inne zajecia w tym samym czasie';
			end if;
		end loop;

	insert into terminy_zajec_grup (id_termin_zajec,id_grupy) values (nowe_id_termin_zajec,nowe_id_grupy);
	return 'Dodanie nowych zajec dla grupy zakonczone powodzeniem!';
end;
$$ language 'plpgsql';

-- funkcja pokazujaca tabele uczniow zapisanych do wszystkich grup danego nauczyciela, za argument przyjmuje id nauczyciela 
-- wykorzystywana w interfejsie w widoku ze strony nauczyciela --

drop function moi_uczniowie CASCADE;
create or replace function moi_uczniowie(moje_id integer)

returns table ( 
	Imie_ucznia text, 
	Nazwisko_ucznia text,
	Adres_e_mail text)
as $$
declare krotka record;

begin	
	for krotka in 
		(Select imie, nazwisko, mail from uzytkownicy where id in (select id_ucznia from zajecia_uczniow where id_grupy in (select id from grupy where id_nauczyciela = moje_id)))
	Loop 
		Imie_ucznia := krotka.imie;
		Nazwisko_ucznia := krotka.nazwisko;
		Adres_e_mail := krotka.mail;
		return next;
	end loop;
	return;
end;
$$ language 'plpgsql';



-- funkcja zapisujaca ucznia do grupy, argumenty to id ucznia i id grupy
-- wykorzystywana w funkcjonalnosci interfejsu z widoku ucznia --

create or replace function zapisz_sie_do_grupy(nowe_id_ucznia integer, nowe_id_grupy integer)
returns text as $$
declare 
	czy_zajecia_istnieja boolean;
	czy_uczen_istnieje boolean;
	czy_grupa_istnieje boolean;
	krotka record;
begin
	select count(1)>0 into czy_zajecia_istnieja from zajecia_uczniow where id_ucznia=nowe_id_ucznia and id_grupy=nowe_id_grupy;
	select count(1)<>1 into czy_uczen_istnieje from uzytkownicy join rodzaje_uzytkownikow on(uzytkownicy.stopien_uprawnien_uzytkownika=rodzaje_uzytkownikow.id) where uzytkownicy.id=nowe_id_ucznia and rodzaje_uzytkownikow.nazwa='uczen';
	select count(1)<>1 into czy_grupa_istnieje from grupy where id=nowe_id_grupy;

		if czy_zajecia_istnieja then
		return 'Jestes juz zapisany na ten kurs!';
		end if;

		if czy_uczen_istnieje then
		return 'Nie istnieje uczen o takim ID!';
		end if;

		if czy_grupa_istnieje then
		return 'Nie istnieje grupa o takim ID!';
		end if;

		if nowe_id_ucznia is null then
		return 'ID ucznia nie moze przyjmowac wartosci NULL!';
		end if;

		if nowe_id_grupy is null then
		return 'ID grupy nie moze przyjmowac wartosci NULL!';
		end if;

		if (CURRENT_DATE <= (SELECT poczatek_zapisow FROM (grupy JOIN daty_kursu on (grupy.id_daty_kursu = daty_kursu.id)) WHERE grupy.id = nowe_id_grupy))
			OR (CURRENT_DATE >= (SELECT koniec_zapisow FROM (grupy JOIN daty_kursu on (grupy.id_daty_kursu = daty_kursu.id)) WHERE grupy.id = nowe_id_grupy)) THEN
        return 'Obecnie nie trwają zapisy do tej grupy';
		end if;

		if (SELECT count(*) FROM zajecia_uczniow WHERE id_grupy = nowe_id_grupy) >= (SElECT id_limitu FROM grupy WHERE id = nowe_id_grupy) then
		return 'Limit uczniow w tej grupie zostal juz zapelniony!';
		end if;
		
		for krotka in 
		(select id_daty_kursu, id_termin_zajec from((select id, id_daty_kursu from grupy where id in (select id_grupy from zajecia_uczniow where id_ucznia = nowe_id_ucznia)) 
		join terminy_zajec_grup on (id = id_grupy)))
		loop
			if  krotka.id_daty_kursu  = (SELECT ID_daty_kursu FROM grupy WHERE id = nowe_id_grupy) and krotka.id_termin_zajec = (SELECT id_termin_zajec FROM terminy_zajec_grup where id_grupy = nowe_id_grupy) then  
			return 'Nie można zapisać się na kilka zajec, ktore odbywaja sie w tym samym czasie!';
			end if;
		end loop;


	insert into zajecia_uczniow (id_ucznia,id_grupy) values (nowe_id_ucznia,nowe_id_grupy);
	return 'Z powodzeniem zapisales sie do grupy!';
end;
$$ language 'plpgsql';


-- funkcja usuwajaca rodzaj uzytkownika, ktorego nazwe podamy jako argument funkcji 
-- wykorzystywana dla funkcjonalnosci w widoku dla administratora --

drop function usun_rodzaj_uzytkownika cascade;
create or replace function usun_rodzaj_uzytkownika(nazwa_rodzaju_uzytkownika text)
returns text as $$
declare 
		czy_rodzaj_uzytkownika_istnieje boolean;
		czy_istnieja_uzytkownicy_tego_rodzaju boolean;
begin
	select count(1)> 0 into czy_istnieja_uzytkownicy_tego_rodzaju from (select * from uzytkownicy where stopien_uprawnien_uzytkownika = (SELECT id from rodzaje_uzytkownikow where nazwa = nazwa_rodzaju_uzytkownika));
	select count(1) = 0 into czy_rodzaj_uzytkownika_istnieje from rodzaje_uzytkownikow where nazwa = nazwa_rodzaju_uzytkownika;
	
		if nazwa_rodzaju_uzytkownika in ('administrator', 'nauczyciel', 'uczen') then
			return 'Tego rodzaju uzytkownika nie mozna usunac';
		end if;
	
	
		if czy_rodzaj_uzytkownika_istnieje then
			return 'Taki rodzaj uzytkownika nie istnieje.';
		end if;
	
	
		if czy_istnieja_uzytkownicy_tego_rodzaju then
			return 'Nie mozna usunac tego rodzaju uzytkownika, poniewaz istnieja uzytkownicy, ktorym przypisano ten rodzaj';
		end if;

	delete from rodzaje_uzytkownikow where nazwa = nazwa_rodzaju_uzytkownika;
	return 'Usunieto typ uzytkownika.';
end;
$$ language 'plpgsql';

-- funkcja usuwajaca ucznia z uzytkownikow, argument id ucznia
-- wykorzystywana z poziomu administratora --

drop function usun_ucznia cascade;
create or replace function usun_ucznia(id_us_ucznia integer)
returns text as $$
declare 
	czy_uczen_istnieje boolean;
	czy_uczen_jest_zapisany boolean;
begin 
	select count(1) <>1 into czy_uczen_istnieje from uzytkownicy join rodzaje_uzytkownikow on(uzytkownicy.stopien_uprawnien_uzytkownika=rodzaje_uzytkownikow.id) where uzytkownicy.id=id_us_ucznia and rodzaje_uzytkownikow.nazwa='uczen';
	select count(1) >0  into czy_uczen_jest_zapisany from zajecia_uczniow where id_ucznia = id_us_ucznia;
	
	if czy_uczen_istnieje then	
		return 'Informacji o takim uczniu nie ma w bazie.';
	end if;
	
	if czy_uczen_jest_zapisany then
		return 'Uczen ten jest uczestnikiem zajec. Nie mozna go usunac.';
	end if;

	delete from uzytkownicy where id_us_ucznia = id;
	return 'Uczen zostal pomyslnie usuniety z bazy.';
end;
 $$ language 'plpgsql';
 
 
-- funkcja usuwajaca pozycje z tabeli daty_kursu, podajac odpowiednie daty jako argumenty i id typu kursu

drop function usun_daty_kursu cascade;
create or replace function usun_daty_kursu(nowy_pocz_zap date,nowy_kon_zap date,nowy_pocz_zaj date,nowy_kon_zaj date, nowy_id_typ_kursu integer)
returns text as $$
declare 
	czy_daty_kursu_nie_istnieja boolean;
	czy_istnieja_grupy_z_ta_data boolean;
begin
	select count(1)=0 into czy_daty_kursu_istnieja from daty_kursu where (poczatek_zapisow=nowy_pocz_zap and poczatek_zajec=nowy_pocz_zaj and koniec_zajec=nowy_kon_zaj and koniec_zapisow=nowy_kon_zap and id_typ_kursu=nowy_id_typ_kursu);
	select count(1) >0 into czy_istnieja_grupy_z_ta_data  from grupy where id = (select id from daty_kursu where (poczatek_zapisow=nowy_pocz_zap and poczatek_zajec=nowy_pocz_zaj and koniec_zajec=nowy_kon_zaj and koniec_zapisow=nowy_kon_zap and id_typ_kursu=nowy_id_typ_kursu));
		
	if czy_daty_kursu_nie_istnieja then
	return 'Nie istnieja_takie_daty_kursu.';
	end if;
	
	id czy_istnieja_grupy_z_ta_data then
	return 'Istnieja grupy z przypisanymi takimi datami. Nie mozna usunac dat.';
	end if;

	delete from daty_kursu where(poczatek_zapisow=nowy_pocz_zap and poczatek_zajec=nowy_pocz_zaj and koniec_zajec=nowy_kon_zaj and koniec_zapisow=nowy_kon_zap and id_typ_kursu=nowy_id_typ_kursu);
	return 'Usunieto wybrany zakres czasowy!';
end;
$$ language 'plpgsql';


-- funkcja aktualizujaca ceny w cenniku, argumenty id limitu, id poziomu, id typu kursu, nowa cena 

drop function uaktualnij_cene cascade;
create or replace function uaktualnij_cene(nowe_id_limitu integer,nowe_id_poziomu integer, nowe_id_typu integer, nowa_cena decimal(6,2))
returns text as $$
declare 
	czy_krotka_istnieje boolean;
	
begin
		select count(1)<>1 into czy_krotka_istnieje from (SELECT * FROM ceny  where (id_limitu = nowe_id_limitu and id_poziomu = nowe_id_poziomu and id_typu = nowe_id_typu));
		
		if czy_krotka_istnieje then
			return 'W cenniku nie istnieje opcja o zadanych parametrach.';
		end if;

		if nowa_cena is null then
			return 'Cena nie moze przyjmowac wartosci NULL!';
		end if;
		
	UPDATE ceny SET cena_za_kurs = nowa_cena WHERE (id_limitu = nowe_id_limitu and id_poziomu = nowe_id_poziomu and id_typu = nowe_id_typu);
	RETURN 'Cena zostala zaktualizowana.';
end;
$$ language 'plpgsql';

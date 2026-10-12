CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_L_METRIK_2(
	METRIK_ID,
	METRIK_FORM,
	METRIK_FG,
	METRIK_BEZ,
	METRIK_BEZ_CZ,
	METRIK_BEZ_SK,
	METRIK_BEZ_HR,
	METRIK_BEZ_PL,
	METRIK_BEZ_RO,
	METRIK_BEZ_BG
) AS 

/*	JZG LOOKUP : Jahreszielgespräch Metriken (Kennzahlen)
	2023-02-15 ssch0611 : Setup inkl. Translation. AP0144461
	2023-10-25 ssch0611 : Review AP0144461. Syntax + Remapping ID
	2024-01-11 ssch0611 : Release version
	2024-01-25 ssch0611 : Finetuning
	2024-02-07 ssch0611 : Update Translations 
	2025-01-21 ssch0611 : Review 2025. Neue Metriken. Neu FG + FORM [AP0244672]
	2025-02-17 ssch0611 : Update Bezeichnungen/Übersetzungen [AP0244672]
	2025-02-28 ssch0611 : Fix Resturlaub FG [AP0244672]
	2025-03-31 ssch0611 : Final GJ2025. Umstellung Scans/min (KPOS) [AP0264011]
*/

SELECT
  $1 ::INTEGER AS METRIK_ID 
, $2 ::STRING  AS METRIK_FORM /* Zahlenformat */
, $3 ::INTEGER AS METRIK_FG   /* 10 Metrik, 20 Kommentar + Wert agg , 21 Kommentar + Wert kalk/agg, 22 Wert kalk/agg, 25 Level Filiale/Abt_2/HWG/OWG, 30 Kommentar + Wert (nicht agg), 40 nur Kommentar */
, $4 ::STRING  AS METRIK_BEZ
, $5 ::STRING  AS METRIK_BEZ_CZ
, $6 ::STRING  AS METRIK_BEZ_SK
, $7 ::STRING  AS METRIK_BEZ_HR
, $8 ::STRING  AS METRIK_BEZ_PL
, $9 ::STRING  AS METRIK_BEZ_RO
, $10 ::STRING AS METRIK_BEZ_BG
FROM (
	SELECT           10, '0' ,    25, 'Umsatz netto', 'Obrat netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzăre_2 netă', 'Оборот нето'
	UNION ALL SELECT 16, '0',     20, 'Kunden', 'Zákazníci', 'Zákazníci', 'Kupci', 'Klienci', 'Clienți', 'Клиенти'
	UNION ALL SELECT 18, '0.00',  22, 'Ø-Bon', 'Ø-nákup', 'Ø-Bon', 'Ø-Ra_2čun', 'Ø-Bon', 'Ø-Bon', 'Ø-Bon'
	UNION ALL SELECT 20, '0',     22, 'Nettoleistung', 'Hodinový výkon', 'Čistý výkon', 'Neto produkt.', 'Produktyw. netto', 'Eficiență', 'Нето продукт.'
	UNION ALL SELECT 24, '0',     20, 'Nettostunden', 'Hodiny Netto', 'Čisté hodiny', 'Neto sati', 'Godziny netto', 'Ore nete', 'Нето часове'
	UNION ALL SELECT 30, '0.0',   30, 'Kassierleistung', 'Produktivita pokladen', 'Výkon pokladníka', 'Produkt. blagajni', 'Produktyw. kasjer.', 'Eficiență case', 'Продукт. на каси'
	 /* 32 Scans/min (KPOS - ODS_BON_KASSENABSCHLUSS_2) + 33 Scans/min (DWH - alte Definition) -- 2025/04 */
	UNION ALL SELECT 32, '0.00',  30, 'Scans/min', 'Skeny za minutu', 'Počet skenov/min', 'Skenirano/min.', 'Skan./min', 'Scanări/min', 'Сканиране/мин'
	UNION ALL SELECT 33, '0.00',  30, 'Scans/min (DWH)', 'Skeny za minutu (DWH)', 'Počet skenov/min (DWH)', 'Skenirano/min. (DWH)', 'Skan./min (DWH)', 'Scanări/min (DWH)', 'Сканиране/мин (DWH)' 
	UNION ALL SELECT 34, '0.0%',  30, 'SCO Nutzungsquote (Umsatz)', 'SCO Míra_2 použávání (Obrat)', 'SCO kvóta využitia (Obrat)', 'SCO stopa korištenja (Promet)', 'SCO wskaźnik wykorzystania (Obrót)', 'Cotă utilizare case SCO (Vânzare)', 'Квота Каси на самообсл. (Оборот)'
	UNION ALL SELECT 36, '0.0%',  30, 'SCO Nutzungsquote (Kunden)', 'SCO Míra_2 použávání (Zákazníci)', 'SCO kvóta využitia (Zákazníci)', 'SCO stopa korištenja (Kupci)', 'SCO wskaźnik wykorzystania (Klienci)', 'Cotă utilizare case SCO (Clienți)', 'Квота Каси на самообсл. (Клиенти)'
	UNION ALL SELECT 37, '0.0%',  30, 'K-Scan Nutzungsquote', 'K-Scan Míra_2 použávání', 'K-Scan kvóta využitia', 'K-Scan stopa korištenja', 'K-Scan wskaźnik wykorzystania', 'Cotă utilizare case K-Scan', 'Квота K-Scan'
	UNION ALL SELECT 39, '0.0%',  30, 'K Card Anteil', 'K Card Podíl', 'K Card Podiel', 'K Card Udio', 'K Card udział', 'K Card Cotă', 'Дял K Card'
	UNION ALL SELECT 40, '0.00%', 25, 'Abschriften_2 operativ', 'Odpisy operativní', 'Operatívne odpisy', 'Otpis operativni', 'Odpisy operac.', 'Pierderi operativ', 'Опер. загуби'
	UNION ALL SELECT 46, '0.00%', 25, 'Inventur_2', 'Inventura', 'Inventúra_2', 'Inventura', 'Inwentaryzacja', 'Inventar', 'Инвентаризация'
	UNION ALL SELECT 50, '0.00%', 30, 'Kurzcheck', 'Kurzcheck', 'Kurzcheck', 'Kurzcheck', 'Kurzcheck', 'Kurzcheck', 'Кратки проверки'
	/* Kundenfeedback gelöscht */
	UNION ALL SELECT 54, '0',     30, 'Warten Kasse', 'Záruka Čekání na pokladně', 'Záruka "Čakanie na pokladni"', 'Čekanje na blagajni', 'Gwarancja kasy', 'Timp așteptare case', 'Чакане на каса'
	UNION ALL SELECT 55, '0.00',  10, 'Ø Warten Kasse', 'Ø Záruka Čekání na pokladně', 'Ø Záruka "Čakanie na pokladni"', 'Ø Čekanje na blagajni', 'Ø Gwarancja kasy', 'Ø Timp așteptare case', 'Ø Чакане на каса'
	UNION ALL SELECT 56, '0',     30, 'Warten Theke', 'Záruka Čekání na pultu', 'Záruka "Pulty"', 'Čekanje na pultu', 'Gwarancja lada', 'Timp așteptare vitrină', 'Чакане на витрина'
	UNION ALL SELECT 57, '0.00',  10, 'Ø Warten Theke', 'Ø Záruka Čekání na pultu', 'Ø Záruka "Pulty"', 'Ø Čekanje na pultu', 'Ø Gwarancja lada', 'Ø Timp așteptare vitrină', 'Ø Чакане на витрина'
	UNION ALL SELECT 58, '0',     30, 'Mangel MHD', 'Záruka Čerstvosti', 'Záruka "Čerstvosť"', 'Nedostatak svježine', 'Gwarancja świeżości', 'Deficiențe TDV', 'MHD гаранции'
	UNION ALL SELECT 59, '0.00',  10, 'Ø Mangel MHD', 'Ø Záruka Čerstvosti', 'Ø Záruka "Čerstvosť"', 'Ø Nedostatak svježine', 'Ø Gwarancja świeżości', 'Ø Deficiențe TDV', 'Ø MHD гаранции'
	UNION ALL SELECT 60, '0',     30, 'Preisauszeichnung', 'Špatná cena', 'Zlá cena', 'Pogrešna cijena', 'Błędna cena', 'Preţ greşit', 'Грешна цена'
	UNION ALL SELECT 61, '0.00',  10, 'Ø Preisauszeichnung', 'Ø Špatná cena', 'Ø Zlá cena', 'Ø Pogrešna cijena', 'Ø Błędna cena', 'Ø Preţ greşit', 'Ø Грешна цена'
	UNION ALL SELECT 62, '0',     30, 'Kassierfehler', 'Chybovost pokladních', 'Chyba pokladníka', 'Greške na blagajni', 'Błędy kasjerskie', 'Erori case', 'Касиерски грешки'
	UNION ALL SELECT 63, '0.00',  10, 'Ø Kassierfehler', 'Ø Chybovost pokladních', 'Ø Chyba pokladníka', 'Ø Greške na blagajni', 'Ø Błędy kasjerskie', 'Ø Erori case', 'Ø Касиерски грешки'
	UNION ALL SELECT 70, '0.00%', 21, 'Personalkosten_2 (%)', 'Personální náklady (%)', 'Personálne nákladyv (%)', 'Kadrovski troškovi (%)', 'Koszty personalne (%)', 'Costuri de personal (%)', 'Персонални разходи (%)'
	UNION ALL SELECT 72, '0.0%',  10, 'Nachtzuschläge', 'Příplatek za práci v noci', 'Príplatky za prácu v noci', 'Dodaci - kasni/noćni rad', 'Godziny nocne', 'Spor ore de noapte', 'Доплащане нощен труд'
	UNION ALL SELECT 73, '0.0%',  10, 'Wochenendzuschläge', 'Příplatek za práci o víkendu', 'Príplatky za víkend', 'Dodaci - rad vikendom', 'Godziny dodatkowe', 'Spor ore de week-end', 'Доплащане труд уикенд'
	UNION ALL SELECT 74, '0.0%',  10, 'Feiertagszuschläge', 'Příplatek za práci ve svátek', 'Príplatky za sviatok', 'Dodaci - rad na praznik', 'Godziny świąteczne', 'Spor sărbătoare legală', 'Доплащане празничен труд'
	UNION ALL SELECT 75, '0.0%',  10, 'Mehrstundenzuschläge', 'Příplatky přesčas', 'Príplatky nadčasové hodiny', 'Dodaci - prekovremeni sati', 'Nadgodziny', 'Spor ore suplimentare', 'Доплащане плащания Плюсови часове'
	UNION ALL SELECT 76, '0.0%',  30, 'Resturlaub', 'Převedená stará dovolená', 'Dovolenka', 'Preostali godišnji odmor', 'Pozostały urlop', 'Rest concediu', 'Остатъчен отпуск'
	UNION ALL SELECT 77, '0.0%',  10, 'Krankenstand', 'Nemocnost', 'Pracovná neschopnosť', 'Bolovanje', 'Absencje chorobowe', 'Concediu medical', 'Болнични'
	UNION ALL SELECT 78, '0.0%',  30, 'Fluktuation rollierend', 'Fluktuace za posledních 12 měsíců', 'Fluktuácia - posl. 12 mesiacov', 'Fluktuacija rolana', 'Fluktuacja rollierend', 'Fluctuație cumulată', 'Текучество rollierend'
	UNION ALL SELECT 80, '0',     10, 'Köpfe Gesamt', 'Celkový počet zaměstnanců (hlavy)', 'Počet zamestnanec (celkom)', 'Broj zaposlenici (ukupno)', 'Liczba pracowników (razem)', 'Număr angajați (total)', 'Брой служител (общо)' 
	UNION ALL SELECT 81, '0',     10, 'Anzahl Mitarbeiter', 'Počet zaměstnanců', 'Počet zamestnanec', 'Broj zaposlenici (bez rukovoditelja)', 'Liczba pracowników', 'Număr angajați', 'Брой служител'
	UNION ALL SELECT 82, '0',     10, 'Anzahl VZK', 'Počet zaměstnanců na plný úvazek', 'Počet FTE (plný úväzok)', 'Broj FTE', 'Liczba pełnych etatów', 'Număr norme FT', 'Брой ПРВ'
	UNION ALL SELECT 84, '0',     30, 'Anzahl Vertragsstunden', 'Počet smluvních hodin', 'Počet zml. Hodiny', 'Broj ugovorenih sati', 'Wymiar godzin', 'Număr ore contractuale', 'Брой часове по договор'
	UNION ALL SELECT 86, '0.0',   10, 'Ø Vertragsstunden', 'Ø Smluvní hodiny', 'Ø zml. hodiny', 'Ø ugovorenih sati', 'Ø wymiar godzin', 'Ø Ore contractuale', 'Ø Часове по договор'
	UNION ALL SELECT 88, '0.0%',  30, 'Anteil TZK', 'Podíl zkrácených úvazků', 'Podiel skrátených úväzkov', 'Udio zap. nepuno rv', 'Udział niepełnych etatów', 'Cotă angajați cu normă part time', 'Дял сл-ли НРВ'
	UNION ALL SELECT 91, '-',     40, 'TOP 1', 'TOP 1', 'TOP 1', 'TOP 1', 'TOP 1', 'TOP 1', 'TOP 1'
	UNION ALL SELECT 92, '-',     40, 'TOP 2', 'TOP 2', 'TOP 2', 'TOP 2', 'TOP 2', 'TOP 2', 'TOP 2'
	UNION ALL SELECT 93, '-',     40, 'TOP 3', 'TOP 3', 'TOP 3', 'TOP 3', 'TOP 3', 'TOP 3', 'TOP 3'
	UNION ALL SELECT 94, '-',     40, 'TOP 4', 'TOP 4', 'TOP 4', 'TOP 4', 'TOP 4', 'TOP 4', 'TOP 4'
	UNION ALL SELECT 95, '-',     40, 'TOP 5', 'TOP 5', 'TOP 5', 'TOP 5', 'TOP 5', 'TOP 5', 'TOP 5'
) jzg;
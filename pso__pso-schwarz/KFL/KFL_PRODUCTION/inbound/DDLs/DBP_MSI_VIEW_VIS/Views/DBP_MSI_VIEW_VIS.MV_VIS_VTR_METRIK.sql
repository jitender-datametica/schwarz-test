CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_VTR_METRIK(
 VTR_ID,
 VTR_GRP_ID,
 VTR_FG,
 VTR_BEZ,
 VTR_EINHEIT,
 VTR_R1,
 VTR_R2,
 VTR_R3,
 VTR_F1,
 VTR_F2,
 VTR_F3,
 VTR_Z1,
 VTR_Z2,
 VTR_Z3,
 VTR_BEZ_CZ,
 VTR_BEZ_SK,
 VTR_BEZ_HR,
 VTR_BEZ_PL,
 VTR_BEZ_RO,
 VTR_BEZ_BG,
 VTR_EINHEIT_CZ,
 VTR_EINHEIT_SK,
 VTR_EINHEIT_HR,
 VTR_EINHEIT_PL,
 VTR_EINHEIT_RO,
 VTR_EINHEIT_BG
) AS

/* 
	VTR LOOKUP : Metriken, Flags, Translations, Einheiten
	2023-07-31 ssch0611 : Initial. AP0176993
	2023-09-06 ssch0611 : Update_090 Neue View Struktur/Syntax + Neue Spalten
	2024-01-10 ssch0611 : Release Version
	2024-01-23 ssch0611 : Update Translations BG
	2025-02-19 ssch0611 : Review 2025. Neue Metriken [AP0237182] 
	2025-02-25 ssch0611 : Rang Null/Minusquote = ASC! [AP0237182] 
	2025-04-02 ssch0611 : Umstellung Scans/min (KPOS) [AP0264011]
	2025-04-23 ssch0611 : Finetuning Übersetzungen [AP0237182]
*/

SELECT 
  $1::INTEGER AS VTR_ID			/* Kennzahl */
, $2::INTEGER AS VTR_GRP_ID		/* Kennzahlenblöcke */
, $3::INTEGER AS VTR_FG			/* Kennzahl : '0' = INAKTIV, '1' = AKTIV, '2' = TEST/PREVIEW */
, $4::STRING  AS VTR_BEZ		/* Kennzahlen Bezeichnung */
, $5::STRING  AS VTR_EINHEIT	/* Kennzahlen Einheit/Beschriftung */
, $6::STRING  AS VTR_R1			/* Rang : '0' = INAKTIV, '1' = AKTIV, '2' = PREVIEW */
, $7::STRING  AS VTR_R2			/* Rang : Berechnung/Beschriftung */
, $8::STRING  AS VTR_R3			/* Rang : 'DESC' = absteigend, 'ASC' = aufsteigend */
, $9::STRING  AS VTR_F1			/* Formel/Berechnung IST/VJ/Plan */
, $10::STRING AS VTR_F2			/* Formel/Berechnung ∆VJ/∆Plan */
, $11::STRING AS VTR_F3			/* Formel/Berechnung ∆Region/∆Land */
, $12::STRING AS VTR_Z1			/* Zahlenformat IST/VJ/Plan */
, $13::STRING AS VTR_Z2			/* Zahlenformat ∆VJ/∆Plan */
, $14::STRING AS VTR_Z3			/* Zahlenformat ∆Region/∆Land */
, $15::STRING AS VTR_BEZ_CZ
, $16::STRING AS VTR_BEZ_SK
, $17::STRING AS VTR_BEZ_HR
, $18::STRING AS VTR_BEZ_PL
, $19::STRING AS VTR_BEZ_RO
, $20::STRING AS VTR_BEZ_BG
, $21::STRING AS VTR_EINHEIT_CZ
, $22::STRING AS VTR_EINHEIT_SK
, $23::STRING AS VTR_EINHEIT_HR
, $24::STRING AS VTR_EINHEIT_PL
, $25::STRING AS VTR_EINHEIT_RO
, $26::STRING AS VTR_EINHEIT_BG
FROM (
SELECT             0, 0, 0, 'Gesamt', ' ', '0', ' ', ' ', 'W', '-', '-', '-', '-', '-', 'Celkem', 'Celkom', 'Ukupno', 'Razem', 'Total', 'Общо', ' ', ' ', ' ', ' ', ' ', ' '
UNION ALL SELECT 100, 1, 1, 'Umsatz netto', 'T', '1', '∆Plan %', 'DESC', 'W', 'W%', 'W%p', '0T', '0.0%', '0.00%p', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето', 'T', 'T', 'T', 'T', 'Mii', 'х.'
UNION ALL SELECT 110, 1, 1, 'Umsatz Ultra-Frische', 'T', '0', ' ', ' ', 'W', 'W%', 'W%p', '0T', '0.0%', '0.00%p', 'Obrat Ultra Frische', 'Obrat Ultra-Frische', 'Promet Ultra svježe', 'Obrót Ultra Świeże', 'Vânzare Ultra-Frische', 'Оборот Свежи храни', 'T', 'T', 'T', 'T', 'Mii', 'х.'
UNION ALL SELECT 115, 1, 0, 'Umsatzanteil Ultra-Frische', '%', '0', ' ', ' ', 'Q', 'Q%p', 'Q%p', '0.00%', '0.00%p', '0.00%p', 'Podíl obratů Ultra Frische', 'Podiel obratu (Ultra-Frische)', 'Udio prometa Ultra svježe', 'Udział obrót Ultra Świeże', 'Cotă de vânzare Ultra-Frische', 'Дял оборот Свежи храни', '%', '%', '%', '%', '%', '%' -- ZUSÄTZLICH
UNION ALL SELECT 120, 1, 1, 'Umsatz SA', 'T', '0', ' ', ' ', 'W', 'W%', 'W%p', '0T', '0.0%', '0.00%p', 'Obrat Akce', 'Obrat (akcia)', 'Promet SA', 'Obrót SA', 'Vânzare promoție', 'Оборот SA', 'T', 'T', 'T', 'T', 'Mii', 'х.'
UNION ALL SELECT 125, 1, 1, 'Umsatzanteil SA', '%', '0', ' ', ' ', 'Q', 'Q%p', 'Q%p', '0.00%', '0.00%p', '0.00%p', 'Podíl obratů Akce', 'Podiel obratu (akcia)', 'Udio prometa SA', 'Udział obrót SA', 'Cotă de vânzare promoție ', 'Дял оборот SA', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 140, 1, 1, 'Absatz', 'T', '0', ' ', ' ', 'W', 'W%', 'W%p', '0T', '0.0%', '0.00%p', 'Množství', 'Množstvo', 'Količina', 'Liczba sztuk', 'Cantitate', 'Количество', 'T', 'T', 'T', 'T', 'Mii', 'х.'
UNION ALL SELECT 160, 1, 1, 'Kunden', 'T', '0', ' ', ' ', 'W', 'W%', 'W%p', '0T', '0.0%', '0.00%p', 'Zákazníci', 'Zákazníci', 'Kupci', 'Klienci', 'Clienți', 'Клиенти', 'T', 'T', 'T', 'T', 'Mii', 'х.'
UNION ALL SELECT 180, 1, 1, 'Ø-Bon', ' ', '0', ' ', ' ', 'Q', 'Q', 'Q', '0.00', '0.00', '0.00', 'Ø-nákup', 'Ø-Bon', 'Ø-Račun', 'Ø-Paragon', 'Ø-Bon', 'Ø-Bon', ' ', ' ', ' ', ' ', ' ', ' '
UNION ALL SELECT 200, 1, 1, 'Nettostunden', 'h', '0', '∆Plan %', 'DESC', 'W', 'W%', 'W%p', '0', '0.0%', '0.00%p', 'Hodiny netto', 'Čisté hodiny', 'Neto sati', 'Godziny netto', 'Ore nete', 'Нето часове', 'h', 'h', 'h', 'h', 'oră', 'h'
UNION ALL SELECT 210, 1, 1, 'Nettoleistung', '/h', '1', '∆Plan', 'DESC', 'Q', 'Q', 'Q', '0', '0.0', '0.0', 'Hodinový výkon', 'Čistý výkon', 'Neto produkt.', 'Produktyw. netto', 'Eficiență netă', 'Нето продукт.', '/h', '/h', '/h', '/h', '/oră', '/h'
UNION ALL SELECT 220, 1, 0, 'Nettostückleistung', '/h', '0', ' ', ' ', 'Q', 'Q', 'Q', '0', '0.0', '0.0', 'Čistý výkon na kus', 'Čistý kusový výkon', 'Neto produkt. po komadu', 'Produktyw. w szt.', 'Eficiență cantitativă', 'Нето прод. на бр. а-ли', '/h', '/h', '/h', '/h', '/oră', '/h'
UNION ALL SELECT 240, 1, 1, 'Kassierleistung', '/h', '1', 'IST', 'DESC', 'Q', 'Q', 'Q', '0', '0.0', '0.0', 'Produktivita pokladen', 'Výkon pokladníka', 'Produkt. blagajni', 'Produktyw. kasjer.', 'Eficiență case', 'Продукт. на каси', '/h', '/h', '/h', '/h', '/oră', '/h'
 /* 250 Scans/min - KPOS (ODS_BON_KASSENABSCHLUSS) + 255 Scans/min (DWH) - alte Definition bis 2025/04 */
UNION ALL SELECT 250, 1, 1, 'Scans/min', '/min', '1', 'IST', 'DESC', 'Q', 'Q', 'Q', '0.0', '0.00', '0.00', 'Skeny za minutu', 'Počet skenov/min', 'Skenirano/min.', 'Skan./min', 'Scanări/min', 'Сканиране/мин', '/min', '/min', '/min', '/min', '/min', '/мин' 
UNION ALL SELECT 255, 1, 0, 'Scans/min (DWH)' , '/min', '0', 'IST', 'DESC', 'Q', 'Q', 'Q', '0.0', '0.00', '0.00', 'Skeny za minutu (DWH)', 'Počet skenov/min (DWH)', 'Skenirano/min. (DWH)', 'Skan./min (DWH)', 'Scanări/min (DWH)', 'Сканиране/мин (DWH)', '/min', '/min', '/min', '/min', '/min', '/мин' 
UNION ALL SELECT 270, 1, 1, 'Personalkosten', 'T', '0', ' ', ' ', 'W', 'W%', 'W%p', '0T', '0.0%', '0.00%p', 'Personální náklady', 'Personálne náklady', 'Kadrovski troškovi', 'Koszty personalne', 'Costuri de personal', 'Персонални разходи', 'T', 'T', 'T', 'T', 'T', 'х.'
UNION ALL SELECT 275, 1, 1, 'Personalkosten (%)', '%', '1', 'IST%', 'DESC', 'Q', 'Q%p', 'Q%p', '0.0%', '0.00%p', '0.00%p', 'Personální náklady (%)', 'Personálne náklady %', 'Kadrovski troškovi %', 'Koszty personalne %', 'Costuri de personal (%)', 'Персонални разходи %', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 300, 3, 0, 'Abschriften operativ', 'T', '0', ' ', ' ', 'W', 'W%', 'W%p', '0T', '0.0%', '0.00%p', 'Odpisy operativní', 'Operatívne odpisy', 'Otpis operativni', 'Odpisy operac.', 'Pierderi operativ', 'Опер. загуби', 'T', 'T', 'T', 'T', 'T', 'T'
UNION ALL SELECT 310, 3, 1, 'Abschriften operativ (%)', '%', '1', '∆Plan %p', 'DESC', 'Q', 'Q%p', 'Q%p', '0.00%', '0.00%p', '0.00%p', 'Odpisy operativní (%)', 'Operatívne odpisy (%)', 'Otpis operativni (%)', 'Odpisy operac. (%)', 'Pierderi operativ (%)', 'Опер. Загуби (%)', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 320, 3, 1, 'Abschriften Ultra-Frische (%)', '%', '0', ' ', ' ', 'Q', 'Q%p', 'Q%p', '0.00%', '0.00%p', '0.00%p', 'Odpisy op. Ultra Frische (%)', 'Odpis op. Ultra-Frische (%)', 'Otpisi op. Ult.svj. (%)', 'Odpisy op. Ultra-Śwież. (%)', 'Pierderi Ultra-Frische (%)', 'Опер. загуби Свежи храни (%)', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 340, 3, 1, 'Preisabschriften (%)', '%', '0', '', '', 'Q', 'Q%p', 'Q%p', '0.00%', '0.00%p', '0.00%p', 'Cenové odpisy (%)', 'Zníženie ceny (%)', 'Sniženja (%)', 'Przeceny (%)', 'Reduceri de preț (%)', 'Ценови промени (%)', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 345, 3, 1, 'Preisabschriften Anteil', '%', '0', 'IST%', 'DESC', 'Q', 'Q%p', 'Q%p', '0.00%', '0.00%p', '0.00%p', 'Podíl cenové odpisy', 'Podiel zníženie ceny', 'Udio sniženja cijena', 'Przeceny udział', 'Cotă pierderi din reduceri de preț', 'Дял Ценови промени', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 360, 3, 1, 'Totalabschriften (%)', '%', '0', ' ', ' ', 'Q', 'Q%p', 'Q%p', '0.00%', '0.00%p', '0.00%p', 'Odpisy celé hodnoty (%)', 'Odpisy (%)', 'Totalni otpisi (%)', 'Odpisy całkowite (%)', 'Deprecieri totale (%)', 'Брак (%)', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 365, 3, 1, 'Totalabschriften Anteil', '%', '0', ' ', ' ', 'Q', 'Q%p', 'Q%p', '0.00%', '0.00%p', '0.00%p', 'Podil odpisy celé hodnoty', 'Podiel odpisov', 'Udio totalni otpisi', 'Odpisy całkowite udział', 'Cotă deprecieri totale', 'Дял Брак', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 410, 3, 1, 'Inventurdifferenz Ultra-Frische', '%', '1', 'IST%', 'DESC', 'Q', '-', 'Q%p', '0.00%', '-', '0.00%p', 'Inventura Ultra Frische', 'Inventúra Ultra-Frische', 'Inventurna razlika Ultra Svježe', 'Inwentaryz. Ultra-Świeże', 'Diferență de inventar Ultra-Frische', 'Инвент. разлика Ultra-Frische ', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 420, 3, 1, 'Bestandsentwicklung', ' ', '0', ' ', ' ', 'W', '-', '-', '0', '-', '-', 'Vývoj stavu zásoby', 'Vývoj stavu zásob', 'Razvoj zalihe', 'Rozwój zapasów', 'Evolutie stoc', 'Промяна на наличностите', ' ', ' ', ' ', ' ', ' ', ' '
UNION ALL SELECT 425, 3, 1, 'Bestandsentw. zum Umsatz', '%', '1', 'IST%', 'ASC', 'Q', '-', 'Q%p', '0.0%', '-', '0.00%p', 'Vývoj stavu zásoby k obratu', 'Vývoj stavu zásob k obratu', 'Razvoj zalihe prema prometu', 'Rozwój zapasów do obrotu', 'Evolutie stoc vs. vanzare', 'Промяна на наличностите към оборота', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 500, 5, 1, 'Google Bewertungen', '★', '1', 'IST', 'DESC', 'Q', '-', 'Q', '0.0', '-', '0.0', 'Google Hodnocení', 'Google Hodnotenie', 'Google Recenzije', 'Ocena Google', 'Google feedback', 'Google Оценки', '★', '★', '★', '★', '★', '★'
UNION ALL SELECT 505, 5, 1, 'K Card Anteil', '%', '1',   'IST%', 'DESC', 'Q', 'Q%p', 'Q%p', '0.0%', '0.00%p', '0.00%p', 'K Card podil', 'K Card podiel', 'K Card udio', 'K Card udział', 'K Card cotă%', 'Дял K Card', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 506, 5, 1, 'K Card Anteil', '%', '1', '∆VJ %p', 'DESC', 'Q', 'Q%p', 'Q%p', '0.0%', '0.00%p', '0.00%p', 'K Card podil', 'K Card podiel', 'K Card udio', 'K Card udział', 'K Card cotă%', 'Дял K Card', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 510, 5, 1, 'Warten Kasse', 'Anz.', '1', 'IST', 'ASC', 'W', 'W', '-', '0', '0', '-', 'Záruka Čekání na pokladně', 'Záruka "Čakanie na pokladni"', 'Čekanje na blagajni', 'Gwarancja kasy', 'Garanții timp așteptare case', 'Чакане на каса', 'Poč.', 'Poč.', 'Broj', 'Licz.', 'Num.', 'Брой'
UNION ALL SELECT 515, 5, 1, 'Ø Warten Kasse', '/10T', '0', 'IST', 'ASC', 'Q', 'Q', 'Q', '0.00', '0.00', '0.00', 'Ø Záruka Čekání na pokladně', 'Ø Záruka "Čakanie na pokladni"', 'Ø Čekanje na blagajni', 'Ø Gwarancja kasy', 'Ø Garanții timp așteptare case', 'Ø Чакане на каса', '/10T', '/10T', '/10T', '/10T', '/10Mii', '/10х.'
UNION ALL SELECT 520, 5, 1, 'Warten Theke', 'Anz.', '1', 'IST', 'ASC', 'W', 'W', '-', '0', '0', '-', 'Záruka Čekání na pultu', 'Záruka "Pulty"', 'Čekanje na pultu', 'Gwarancje lada', 'Garanții timp așteptare vitrină', 'Чакане на витрина', 'Poč.', 'Poč.', 'Broj', 'Licz.', 'Num.', 'Брой'
UNION ALL SELECT 525, 5, 1, 'Ø Warten Theke', '/10T', '0', 'IST', 'ASC', 'Q', 'Q', 'Q', '0.00', '0.00', '0.00', 'Ø Záruka Čekání na pultu', 'Ø Záruka "Pulty"', 'Ø Čekanje na pultu', 'Ø Gwarancje lada', 'Ø Garanții timp așteptare vitrină', 'Ø Чакане на витрина', '/10T', '/10T', '/10T', '/10T', '/10Mii', '/10х.'
UNION ALL SELECT 530, 5, 1, 'Mangel MHD', 'Anz.', '0', 'IST', 'ASC', 'W', 'W', '-', '0', '0', '-', 'Záruka Čerstvosti', 'Záruka "Čerstvosť"', 'Nedostatak svježine', 'Gwarancja świeżości', 'Garanții deficiențe TDV', 'MHD гаранции', 'Poč.', 'Poč.', 'Broj', 'Licz.', 'Num.', 'Брой'
UNION ALL SELECT 535, 5, 1, 'Ø Mangel MHD', '/10T', '0', 'IST', 'ASC', 'Q', 'Q', 'Q', '0.00', '0.00', '0.00', 'Ø Záruka Čerstvosti', 'Ø Záruka "Čerstvosť"', 'Ø Nedostatak svježine', 'Ø Gwarancja świeżości', 'Ø Garanții deficiențe TDV', 'Ø MHD гаранции', '/10T', '/10T', '/10T', '/10T', '/10Mii', '/10х.'
UNION ALL SELECT 540, 5, 1, 'Preisauszeichnung', 'Anz.', '0', 'IST', 'ASC', 'W', 'W', '-', '0', '0', '-', 'Špatná cena', 'Zlá cena', 'Pogrešna cijena', 'Błędna Cena', 'Preţ greşit', 'грешна цена', 'Poč.', 'Poč.', 'Broj', 'Licz.', 'Num.', 'Брой'
UNION ALL SELECT 545, 5, 1, 'Ø Preisauszeichnung', '/10T', '0', 'IST', 'ASC', 'Q', 'Q', 'Q', '0.00', '0.00', '0.00', 'Ø Špatná cena', 'Ø Zlá cena', 'Ø Pogrešna cijena', 'Ø Błędna Cena', 'Ø Preţ greşit', 'Ø грешна цена', '/10T', '/10T', '/10T', '/10T', '/10Mii', '/10х.'
UNION ALL SELECT 550, 5, 1, 'Kassierfehler', 'Anz.', '1', 'IST', 'ASC', 'W', 'W', '-', '0', '0', '-', 'Chybovost pokladních', 'Chyby pokladníka ', 'Greške na blagajni', 'Błędy kasjerskie', 'Erori case', 'Касиерски грешки ', 'Poč.', 'Poč.', 'Broj', 'Licz.', 'Num.', 'Брой'
UNION ALL SELECT 555, 5, 1, 'Ø Kassierfehler', '/100T', '0', 'IST', 'ASC', 'Q', 'Q', 'Q', '0.00', '0.00', '0.00', 'Ø Chybovost pokladních', 'Ø chyby pokladníka', 'Ø Greške na blagajni', 'Ø Błędy kasjerskie', 'Ø Erori case', 'Ø Kassierfehler', '/100T', '/100T', '/100T', '/100T', '/100Mii', '/100х.'
UNION ALL SELECT 710, 7, 1, 'Übernahmequote', '%', '1', 'IST%', 'DESC', 'Q', '-', 'Q%p', '0.00%', '-', '0.00%p', 'Akceptace Autodispa', 'Kvóta prevzatia AD', 'Übernahmequote', 'Poziom akceptacji (ilość)', 'Cotă de acceptare', 'Квота успеваемост ', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 730, 7, 1, 'Zählaufträge (Gesamt)', 'Anz.', '0', ' ', ' ', 'W', '-', '-', '0', '-', '-', 'Výjimky (Celkem)', 'Výnimky celkom', 'Zadana brojanja (ukupno)', 'Wyjatki (razem)', 'Excepții (total)', 'Дневни стокови корекции (Общо)', 'Poč.', 'Poč.', 'Broj', 'Licz.', 'Num.', 'Брой'
UNION ALL SELECT 732, 7, 1, 'Zählungen durchgeführt', 'Anz.', '0', ' ', ' ', 'W', '-', '-', '0', '-', '-', 'Zpracování výjimek', 'Výnimky spracované', 'Odrađena brojanja', 'Opracowane wyjątki (ilość)', 'Excepții prelucrate', 'Преброени ', 'Poč.', 'Poč.', 'Broj', 'Licz.', 'Num.', 'Брой'
UNION ALL SELECT 735, 7, 1, 'Zählaufträge bearbeitet (%)', '%', '0', ' ', ' ', 'Q', '-', 'Q%p', '0.00%', '-', '0.00%p', 'Zpracování výjimek (%)', 'Výnimky spracované (%)', 'Odrađenost zadanih brojanja (%)', 'Opracowane wyjątki (%)', 'Excepții prelucrate (%)', 'Обработени изключения (%)', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 750, 7, 1, 'Nullbestandsquote', '%', '0', ' ', ' ', 'Q', '-', 'Q%p', '0.00%', '-', '0.00%p', 'Nulová zásoba (%)', 'Nulová zásoba', 'Kvota nula stanja zalihe', 'Zapas zerowy', 'Cotă corecții de stoc zero', 'Квота нулева наличност', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 752, 7, 1, 'Minusbestandsquote', '%', '0', ' ', ' ', 'Q', '-', 'Q%p', '0.00%', '-', '0.00%p', 'Negativní zásoba (%)', 'Mínusová zásoba', 'Kvota minus stanja zalihe', 'Zapas ujemny', 'Cotă stocuri negative', 'Квота отрицателна наличност', '%', '%', '%', '%', '%', '%'
UNION ALL SELECT 755, 7, 1, 'Null-/Minusquote', '%', '1', 'IST%', 'ASC', 'Q', '-', 'Q%p', '0.00%', '-', '0.00%p', 'Nulová / Negativní zásoba (%)', 'Nulová / mínusová zásoba', 'Nula-/minus kvota', 'Zapas zerowy/ujemny', 'Zero- / corecții negative', 'Нулева/ Отрицателна квота ', '%', '%', '%', '%', '%', '%'
);
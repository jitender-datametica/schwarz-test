CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MARKT_LAGERBUCH_ART_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	ART_ID,
	DAT,
	WRG_ID,
	BETRAG_VK_BRUTTO_MIN,
	BETRAG_VK_BRUTTO_AVG,
	BETRAG_VK_BRUTTO_MAX,
	BETRAG_VK_BRUTTO_OHNE_MIN,
	BETRAG_VK_BRUTTO_OHNE_AVG,
	BETRAG_VK_BRUTTO_OHNE_MAX,
	ANZAHL_STELLPLATZ,
	ANZAHL_LAGERBEREICH,
	ANZAHL_MHD,
	ANZAHL_ARTIKEL,
	MENGE_STELLPLATZ_SUM,
	MENGE_LAGERBESTAND,
	MENGE_FILIALBESTAND,
	MENGE_OPT_BESTAND,
	RATE_VERRAEUM_AVG,
	RATE_VERRAEUM_000_SUM,
	RATE_VERRAEUM_001_SUM,
	RATE_VERRAEUM_050_SUM,
	RATE_VERRAEUM_080_SUM,
	RATE_VERRAEUM_100_SUM,
	VERRAEUM_GRUND_00_SUM,
	VERRAEUM_GRUND_01_SUM,
	VERRAEUM_GRUND_02_SUM,
	VERRAEUM_GRUND_04_SUM,
	VERRAEUM_GRUND_05_SUM,
	VERRAEUM_GRUND_06_SUM,
	VERRAEUM_GRUND_12_SUM,
	VERRAEUM_GRUND_13_SUM,
	VERRAEUM_GRUND_50_SUM,
	VERRAEUM_GRUND_55_SUM,
	VERRAEUM_GRUND_60_SUM,
	VERRAEUM_GRUND_70_SUM,
	VERRAEUM_GRUND_80_SUM,
	VERRAEUM_GRUENDE_SUM
) AS

/*
	FAKT : Lagerbuch aggregiert. Artikel_1 pro Filiale/Tag_1 
	Inklusive Priogründen
	2025-09-08 ssch0611 : Initial [AP0263148]
*/

WITH labu AS (
	/* Lagerbuch Daten gruppiert pro Artikel. Rate Veräumung zusätzlich in Spalten */
	SELECT mandant_id
		, nb_id
		, wup_id
		, art_id
		, dat_lagerbuch
		, MIN(betrag_vk_brutto) AS betrag_vk_brutto_min
		, AVG(betrag_vk_brutto) AS betrag_vk_brutto_avg
		, MAX(betrag_vk_brutto) AS betrag_vk_brutto_max
		, COUNT(DISTINCT stellplatz_nr)         AS anzahl_stellplatz     -- Stellplätze (Artikel_1 pro Filiale)
		, COUNT(DISTINCT markt_lagerbereich_id) AS anzahl_lagerbereich   -- Lagerbereiche (Artikel_1 pro Filiale)
		, COUNT(DISTINCT dat_mhd)               AS anzahl_mhd            -- unterschiedliche MHD (Artikel_1 pro Filiale)
		, 1 ::NUMBER(38,0)                      AS anzahl_artikel        -- Anzahl (Artikel_1 pro Filiale)
		, SUM(menge_lagerbestand_stellplatz)    AS menge_stellplatz_sum  -- weicht bei einzelnen Artikel_1 ab 
		, MAX(menge_lagerbestand_gesamt)        AS menge_lagerbestand
		, MAX(menge_filialbestand)              AS menge_filialbestand
		, MAX(menge_opt_bestand)                AS menge_opt_bestand
		, AVG(rate_verraeumung)                                    AS rate_verraeum_avg     -- durchschnittliche Quote
		, SUM(IFF(rate_verraeumung = 0.00, 1, 0))                  AS rate_verraeum_000_sum -- Quote   0.00 %
		, SUM(IFF(rate_verraeumung BETWEEN  0.01 AND 49.99, 1, 0)) AS rate_verraeum_001_sum -- Quote   0.01 - 49.99 %
		, SUM(IFF(rate_verraeumung BETWEEN 50.00 AND 79.99, 1, 0)) AS rate_verraeum_050_sum -- Quote  50.00 - 79.99 %
		, SUM(IFF(rate_verraeumung BETWEEN 80.00 AND 99.99, 1, 0)) AS rate_verraeum_080_sum -- Quote  80.00 - 99.99 %
		, SUM(IFF(rate_verraeumung = 100.00, 1, 0))                AS rate_verraeum_100_sum -- Quote 100.00 %
	FROM DBP_VIEW.V_MARKT_LAGERBUCH_1 labu 
	GROUP BY ALL 
)

, prio AS (
	/* Daten gruppiert pro Artikel. Verräum Prio Gründe in Spalten */
	SELECT mandant_id
		, nb_id
		, wup_id
		, art_id
		, dat_lagerbuch
		, MIN(IFF(verraeumung_prio_grund_id NOT IN ('50', '55'), betrag_vk_brutto, NULL)) AS betrag_vk_brutto_ohne_min -- ohne Werbung
		, AVG(IFF(verraeumung_prio_grund_id NOT IN ('50', '55'), betrag_vk_brutto, NULL)) AS betrag_vk_brutto_ohne_avg -- ohne Werbung
		, MAX(IFF(verraeumung_prio_grund_id NOT IN ('50', '55'), betrag_vk_brutto, NULL)) AS betrag_vk_brutto_ohne_max -- ohne Werbung
		, SUM(IFF(verraeumung_prio_grund_id = '00', 1, 0)) AS verraeum_grund_00_sum -- 00 Ohne
		, SUM(IFF(verraeumung_prio_grund_id = '01', 1, 0)) AS verraeum_grund_01_sum -- 01 MHD NVE
		, SUM(IFF(verraeumung_prio_grund_id = '02', 1, 0)) AS verraeum_grund_02_sum -- 02 Nullbest. LGB
		, SUM(IFF(verraeumung_prio_grund_id = '04', 1, 0)) AS verraeum_grund_04_sum -- 04 MHD Zuteilung
		, SUM(IFF(verraeumung_prio_grund_id = '05', 1, 0)) AS verraeum_grund_05_sum -- 05 Nullbest. NVE
		, SUM(IFF(verraeumung_prio_grund_id = '06', 1, 0)) AS verraeum_grund_06_sum -- 06 MHD LGB
		, SUM(IFF(verraeumung_prio_grund_id = '12', 1, 0)) AS verraeum_grund_12_sum -- 12 Mindestbestand
		, SUM(IFF(verraeumung_prio_grund_id = '13', 1, 0)) AS verraeum_grund_13_sum -- 13 LGB>Bestand
		, SUM(IFF(verraeumung_prio_grund_id = '50', 1, 0)) AS verraeum_grund_50_sum -- 50 Werbung
		, SUM(IFF(verraeumung_prio_grund_id = '55', 1, 0)) AS verraeum_grund_55_sum -- 50 Zuk. Werbung
		, SUM(IFF(verraeumung_prio_grund_id = '60', 1, 0)) AS verraeum_grund_60_sum -- 60 AS Artikel_1
		, SUM(IFF(verraeumung_prio_grund_id = '70', 1, 0)) AS verraeum_grund_70_sum -- 70 K-Card
		, SUM(IFF(verraeumung_prio_grund_id = '80', 1, 0)) AS verraeum_grund_80_sum -- 80 Unbekannter Artikel_1
		, IFF(verraeum_grund_00_sum > 0, '00 ','') || IFF(verraeum_grund_01_sum > 0, '01 ','') || 
		  IFF(verraeum_grund_02_sum > 0, '02 ','') || IFF(verraeum_grund_04_sum > 0, '04 ','') ||
		  IFF(verraeum_grund_05_sum > 0, '05 ','') || IFF(verraeum_grund_06_sum > 0, '06 ','') ||
		  IFF(verraeum_grund_12_sum > 0, '12 ','') || IFF(verraeum_grund_13_sum > 0, '13 ','') ||
		  IFF(verraeum_grund_50_sum > 0, '50 ','') || IFF(verraeum_grund_55_sum > 0, '55 ','') ||
		  IFF(verraeum_grund_60_sum > 0, '60 ','') || IFF(verraeum_grund_70_sum > 0, '70 ','') ||
		  IFF(verraeum_grund_80_sum > 0, '80 ','') AS verraeum_gruende_sum
	FROM DBP_VIEW.V_MARKT_LAGERBUCH_VERRAEUM_PRIO_GRUND_ZU_1 
	GROUP BY ALL 
)


/* MAIN */

SELECT labu.mandant_id
	, labu.nb_id
	, labu.wup_id
	, labu.art_id
	, labu.dat_lagerbuch AS dat
	, krs.nach_wrg_id    AS wrg_id
	, labu.betrag_vk_brutto_min      * krs.umrechnungskurs AS betrag_vk_brutto_min
	, labu.betrag_vk_brutto_avg      * krs.umrechnungskurs AS betrag_vk_brutto_avg
	, labu.betrag_vk_brutto_max      * krs.umrechnungskurs AS betrag_vk_brutto_max
	, prio.betrag_vk_brutto_ohne_min * krs.umrechnungskurs AS betrag_vk_brutto_ohne_min
	, prio.betrag_vk_brutto_ohne_avg * krs.umrechnungskurs AS betrag_vk_brutto_ohne_avg
	, prio.betrag_vk_brutto_ohne_max * krs.umrechnungskurs AS betrag_vk_brutto_ohne_max
	, labu.anzahl_stellplatz
	, labu.anzahl_lagerbereich
	, labu.anzahl_mhd
	, labu.anzahl_artikel
	, labu.menge_stellplatz_sum 
	, labu.menge_lagerbestand
	, labu.menge_filialbestand
	, labu.menge_opt_bestand
	, labu.rate_verraeum_avg
	, labu.rate_verraeum_000_sum
	, labu.rate_verraeum_001_sum
	, labu.rate_verraeum_050_sum
	, labu.rate_verraeum_080_sum
	, labu.rate_verraeum_100_sum
	, prio.verraeum_grund_00_sum
	, prio.verraeum_grund_01_sum
	, prio.verraeum_grund_02_sum
	, prio.verraeum_grund_04_sum
	, prio.verraeum_grund_05_sum
	, prio.verraeum_grund_06_sum
	, prio.verraeum_grund_12_sum
	, prio.verraeum_grund_13_sum
	, prio.verraeum_grund_50_sum
	, prio.verraeum_grund_55_sum
	, prio.verraeum_grund_60_sum
	, prio.verraeum_grund_70_sum
	, prio.verraeum_grund_80_sum
	, prio.verraeum_gruende_sum
FROM labu 

INNER JOIN prio 
ON prio.mandant_id = labu.mandant_id AND prio.wup_id = labu.wup_id
AND prio.art_id = labu.art_id
AND prio.dat_lagerbuch = labu.dat_lagerbuch

INNER JOIN DBP_VIEW.V_MANDANT_WRG_ZU_PER_1 wrg_1
ON wrg.mandant_id = labu.mandant_id 
AND labu.dat_lagerbuch BETWEEN wrg.dat_von AND wrg.dat_bis

INNER JOIN DBP_MSI_VIEW_VIS.MV_KURS_UMRECHNUNG_1 krs 
ON krs.von_wrg_id = wrg.wrg_id 
;
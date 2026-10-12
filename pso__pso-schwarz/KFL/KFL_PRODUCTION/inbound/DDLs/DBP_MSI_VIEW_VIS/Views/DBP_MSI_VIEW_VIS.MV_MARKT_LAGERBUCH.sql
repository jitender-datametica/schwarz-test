create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_MARKT_LAGERBUCH(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	ART_ID,
	STELLPLATZ_NR,
	MARKT_LAGERBEREICH_ID,
	DAT_MHD,
	DAT,
	WRG_ID,
	BETRAG_VK_BRUTTO,
	MENGE_LAGERBESTAND_STELLPLATZ,
	RATE_VERRAEUM,
	RATE_VERRAEUM_000,
	RATE_VERRAEUM_001,
	RATE_VERRAEUM_050,
	RATE_VERRAEUM_080,
	RATE_VERRAEUM_100,
	DAT_LAGERBUCH,
	DAT_AENDERUNG,
	VERRAEUM_GRUND_00,
	VERRAEUM_GRUND_01,
	VERRAEUM_GRUND_02,
	VERRAEUM_GRUND_04,
	VERRAEUM_GRUND_05,
	VERRAEUM_GRUND_06,
	VERRAEUM_GRUND_12,
	VERRAEUM_GRUND_13,
	VERRAEUM_GRUND_50,
	VERRAEUM_GRUND_55,
	VERRAEUM_GRUND_60,
	VERRAEUM_GRUND_70,
	VERRAEUM_GRUND_80,
	VERRAEUM_GRUENDE
) as

/*
	FAKT : Markt Lagerbuch (Details). Artikel/Lagerbereich/Stellplatz/MHD/VK_brutto pro Filiale/Tag 
	Inklusive Priogründen
	2025-09-08 ssch0611 : Initial [AP0263148]
*/


WITH labu AS (
	/* Lagerbuch Daten. Rate Veräumung zusätzlich in Spalten */
	SELECT mandant_id
		, nb_id
		, wup_id
		, art_id
		, stellplatz_nr
		, markt_lagerbereich_id
		, dat_mhd
		, dat_lagerbuch
		, betrag_vk_brutto
		, menge_lagerbestand_stellplatz
		--, menge_lagerbestand_gesamt  -- nur Ebene Filiale/Artikel
		--, menge_filialbestand        -- nur Ebene Filiale/Artikel
		--, menge_opt_bestand          -- nur Ebene Filiale/Artikel
		, rate_verraeumung                                    AS rate_verraeum     -- Quote
		, IFF(rate_verraeumung = 0.00, 1, 0)                  AS rate_verraeum_000 -- Quote   0.00 %
		, IFF(rate_verraeumung BETWEEN  0.01 AND 49.99, 1, 0) AS rate_verraeum_001 -- Quote   0.01 - 49.99 %
		, IFF(rate_verraeumung BETWEEN 50.00 AND 79.99, 1, 0) AS rate_verraeum_050 -- Quote  50.00 - 79.99 %
		, IFF(rate_verraeumung BETWEEN 80.00 AND 99.99, 1, 0) AS rate_verraeum_080 -- Quote  80.00 - 99.99 %
		, IFF(rate_verraeumung = 100.00, 1, 0)                AS rate_verraeum_100 -- Quote 100.00 %
		, dat_aenderung
	FROM DBP_VIEW.V_MARKT_LAGERBUCH labu 
)

, prio AS (
	/* Daten gruppiert. Verräum Prio Gründe in Spalten. */
	SELECT mandant_id
		, nb_id
		, wup_id
		, art_id
		, stellplatz_nr
		, markt_lagerbereich_id
		, dat_mhd
		, dat_lagerbuch
		, betrag_vk_brutto
		/* Prio Veräumgründe in Spalten */
		, MAX(IFF(verraeumung_prio_grund_id = '00', 1, 0)) AS  verraeum_grund_00 -- 00 Ohne
		, MAX(IFF(verraeumung_prio_grund_id = '01', 1, 0)) AS  verraeum_grund_01 -- 01 MHD NVE
		, MAX(IFF(verraeumung_prio_grund_id = '02', 1, 0)) AS  verraeum_grund_02 -- 02 Nullbest. LGB
		, MAX(IFF(verraeumung_prio_grund_id = '04', 1, 0)) AS  verraeum_grund_04 -- 04 MHD Zuteilung
		, MAX(IFF(verraeumung_prio_grund_id = '05', 1, 0)) AS  verraeum_grund_05 -- 05 Nullbest. NVE
		, MAX(IFF(verraeumung_prio_grund_id = '06', 1, 0)) AS  verraeum_grund_06 -- 06 MHD LGB
		, MAX(IFF(verraeumung_prio_grund_id = '12', 1, 0)) AS  verraeum_grund_12 -- 12 Mindestbestand
		, MAX(IFF(verraeumung_prio_grund_id = '13', 1, 0)) AS  verraeum_grund_13 -- 13 LGB>Bestand
		, MAX(IFF(verraeumung_prio_grund_id = '50', 1, 0)) AS  verraeum_grund_50 -- 50 Werbung
		, MAX(IFF(verraeumung_prio_grund_id = '55', 1, 0)) AS  verraeum_grund_55 -- 50 Zuk. Werbung
		, MAX(IFF(verraeumung_prio_grund_id = '60', 1, 0)) AS  verraeum_grund_60 -- 60 AS Artikel
		, MAX(IFF(verraeumung_prio_grund_id = '70', 1, 0)) AS  verraeum_grund_70 -- 70 K-Card
		, MAX(IFF(verraeumung_prio_grund_id = '80', 1, 0)) AS  verraeum_grund_80 -- 80 Unbekannter Artikel
		, IFF(verraeum_grund_00 = 1, '00 ','') || IFF(verraeum_grund_01 = 1, '01 ','') || 
		  IFF(verraeum_grund_02 = 1, '02 ','') || IFF(verraeum_grund_04 = 1, '04 ','') || 
		  IFF(verraeum_grund_05 = 1, '05 ','') || IFF(verraeum_grund_06 = 1, '06 ','') || 
		  IFF(verraeum_grund_12 = 1, '12 ','') || IFF(verraeum_grund_13 = 1, '13 ','') || 
		  IFF(verraeum_grund_50 = 1, '50 ','') || IFF(verraeum_grund_55 = 1, '55 ','') || 
		  IFF(verraeum_grund_60 = 1, '60 ','') || IFF(verraeum_grund_70 = 1, '70 ','') ||
		  IFF(verraeum_grund_80 = 1, '80 ','') AS verraeum_prio_gruende -- Alle Gründe Verkettet
	FROM DBP_VIEW.V_MARKT_LAGERBUCH_VERRAEUM_PRIO_GRUND_ZU 
	GROUP BY ALL 
)

/* MAIN */

SELECT labu.mandant_id
	, labu.nb_id
	, labu.wup_id
	, labu.art_id
	, labu.stellplatz_nr
	, labu.markt_lagerbereich_id
	, labu.dat_mhd
	, labu.dat_lagerbuch AS dat
	, krs.nach_wrg_id    AS wrg_id
	, labu.betrag_vk_brutto * krs.umrechnungskurs AS betrag_vk_brutto
	, labu.menge_lagerbestand_stellplatz
	, labu.rate_verraeum
	, labu.rate_verraeum_000
	, labu.rate_verraeum_001
	, labu.rate_verraeum_050
	, labu.rate_verraeum_080
	, labu.rate_verraeum_100
	, labu.dat_lagerbuch -- Originalspalte doppelt 
	, labu.dat_aenderung
	, prio.verraeum_grund_00
	, prio.verraeum_grund_01
	, prio.verraeum_grund_02
	, prio.verraeum_grund_04
	, prio.verraeum_grund_05
	, prio.verraeum_grund_06
	, prio.verraeum_grund_12
	, prio.verraeum_grund_13
	, prio.verraeum_grund_50
	, prio.verraeum_grund_55
	, prio.verraeum_grund_60
	, prio.verraeum_grund_70
	, prio.verraeum_grund_80
	, prio.verraeum_prio_gruende

FROM labu 

INNER JOIN prio 
ON prio.mandant_id = labu.mandant_id AND prio.wup_id = labu.wup_id AND prio.art_id = labu.art_id
AND prio.markt_lagerbereich_id = labu.markt_lagerbereich_id AND prio.stellplatz_nr = labu.stellplatz_nr
AND prio.dat_lagerbuch = labu.dat_lagerbuch AND prio.dat_mhd = labu.dat_mhd 
AND prio.betrag_vk_brutto = labu.betrag_vk_brutto -- Wichtig für WG Erfassartikel wie Presse, Elektro, Zigaretten

INNER JOIN DBP_VIEW.V_MANDANT_WRG_ZU_PER wrg
ON wrg.mandant_id = labu.mandant_id 
AND labu.dat_lagerbuch BETWEEN wrg.dat_von AND wrg.dat_bis

INNER JOIN DBP_MSI_VIEW_VIS.MV_KURS_UMRECHNUNG krs 
ON krs.von_wrg_id = wrg.wrg_id 
;

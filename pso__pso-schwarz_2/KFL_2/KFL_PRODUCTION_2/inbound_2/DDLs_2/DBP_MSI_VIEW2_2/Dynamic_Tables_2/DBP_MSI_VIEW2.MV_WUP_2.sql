CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_WUP_2
(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	WUP_AENDERUNG_GRUND_ID,
	AKTUELL_WUP_ID,
	ORIG_WUP_ID,
	LAND_ID,
	DAT_VON,
	WUP_TYP_ID,
	WUP_NAME_V,
	WUP_NAME_E,
	WUP_STANDORT,
	AKT_WUP_STANDORT,
	WUP_PLZ,
	AKT_WUP_PLZ,
	WUP_STR,
	VF_ID,
	VKL_ID,
	HL_ID,
	DAT_BIS,
	UEBERNAHME_VON,
	AKT_UEBERNAHME_VON,
	REAL_FLAG,
	BREAKEVENUMSATZ,
	SYSTEMRENTABILITAET,
	VERKAUFSFLAECHE,
	BETRIEBSFLAECHE,
	FLEISCHSYSTEM,
	PREISKATEGORIE_FOOD,
	PREISKATEGORIE_NONFOOD,
	SORTKATEGORIE_FOOD,
	SORTKATEGORIE_NONFOOD,
	SONDERMARKT,
	REF_WUP_ID,
	WM_ID,
	KASSENTYP,
	DAT_QBM_UMSTELLUNG,
	KREISTYP_GRUPPE_ID,
	DAT_UMSTELLUNG_WAAGE,
	LEAD_MWST,
	REGION_ID,
	AKT_REGION_ID,
	KUNDENFAKTOR,
	VZ_WUP_ID,
	MARKT,
	GETRAENKEMARKT_FG,
	VS_ID,
	WREG_ID,
	VERKAUFSORGANISATION_ID,
	ADRESSE_ID,
	BREITENGRAD,
	LAENGENGRAD,
	AKT_BREITENGRAD,
	AKT_LAENGENGRAD,
	DAT_EROEFFNUNG,
	GF_ID,
	UMZUGSFILIALE_FG,
	EXPANSIONS_FLAG_VVJ,
	EXPANSIONS_FLAG_VJ,
	AKT_GLN_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
-- P0753 Erweiterung um feld adresse_id - sschuecke 06.05.2016
-- AP0009229 Erweiterung um Feld_kreistyp_gruppe_id - sschuecke 24.08.2016
-- AP0009229 Ausbau vw_id - sschuecke 28.09.2016
-- Erweiterung Breitengrad, Laengengrad - sschuecke 02.05.2017
-- AP0186806 neue Marktattribute zur Abloesung der Dynmaischengruppen 
WITH GJ_Zeitraum AS 
(
SELECT GJ, 
akt_gj, 
MIN(dat)+1 AS Start_Tag_GJ, 
MAX(dat)-1 AS END_Tag_GJ
FROM DBP_VIEW.V_TAG_2
GROUP BY 
GJ, akt_gj
)

SELECT
 v01.WUP_ID
,v01.NB_ID
,v01.MANDANT_ID
,v01.wup_aenderung_grund_id
-- AP0204035/SPEC0256280 Erweiterung um neue Spalten / sschuecke 19.09.2024
,COALESCE (v02.aktuell_wup_id, v01.aktuell_wup_id) AS aktuell_wup_id1
,COALESCE(MAX(v01.wup_id_alt) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1),v01.orig_wup_id) AS orig_wup_id

,v01.LAND_ID
--SPEC0207781 sschuecke 18.07.2023 / vorher nur dat_von mit CASE
,CASE WHEN v01.wup_id = 2660 THEN TO_DATE('2009-09-17','YYYY-MM_2-DD') ELSE COALESCE(v01.dat_von_alt, v01.dat_von) END AS DAT_VON
,v01.WUP_TYP_ID
,v01.WUP_NAME_V
,v01.WUP_NAME_E
,v01.WUP_STANDORT
-- AP0204035/SPEC0256280 Erweiterung um neue Spalten / sschuecke 19.09.2024
,FIRST_VALUE (v01.wup_standort) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS AKT_WUP_STANDORT

,v01.WUP_PLZ
--SPEC0256280/ Erweiterung um neue Spalten / prescherad 15.11.2024
,FIRST_VALUE (v01.wup_plz) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS AKT_WUP_PLZ
,v01.WUP_STR
,v01.VF_ID
--SPEC0212614 sschuecke 21.08.2023 / Anpassung Anzeige Logik VKL_ID bzgl geschlossene Filialen
--SPEC0256280 sschuecke 24.07.2024 / Ersetzen umzugsfiliale_fg = 1 durch wup_aenderung_grund_id in (1,2,3,4) bzw umzugsfiliale_fg = 0 durch wup_aenderung_grund_id = 0
,CASE WHEN (v01.dat_bis <> '9999-12-31' AND v01.wup_aenderung_grund_id IN (1,2,3,4) AND v01.vkl_id < 0) THEN COALESCE(v02.vkl_id, 1000 + v01.mandant_id * 100 + v01.vs_id * 10 * -1)
      WHEN (v01.dat_bis <> '9999-12-31' AND v01.wup_aenderung_grund_id = 0 AND v01.vkl_id < 0) THEN (1000 + v01.mandant_id * 100 + v01.vs_id * 10) * -1
      ELSE v01.vkl_id END AS vkl_id
,v01.HL_ID
,v01.DAT_BIS
--NSR3772959 Verlagerung CASE WHEN von Frontend in View / sschuecke 21.06.2023
,CASE WHEN v01.UEBERNAHME_VON IS NULL THEN '' ELSE v01.UEBERNAHME_VON END AS UEBERNAHME_VON
--SPEC0256280/ Erweiterung um neue Spalten / prescherad 15.11.2024
,FIRST_VALUE (v01.UEBERNAHME_VON) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von,v01.dat_bis DESC NULLS LAST) AS AKT_UEBERNAHME_VON
--- Neues Flag Bestand oder Real  
,CASE WHEN v01.UEBERNAHME_VON = 'real 2021' THEN 'Real' ELSE 'Bestand' END AS Real_flag
,v01.BREAKEVENUMSATZ
,v01.SYSTEMRENTABILITAET
,v01.VERKAUFSFLAECHE
,v01.BETRIEBSFLAECHE
,v01.FLEISCHSYSTEM
,v01.PREISKATEGORIE_FOOD
,v01.PREISKATEGORIE_NONFOOD
,v01.SORTKATEGORIE_FOOD
,v01.SORTKATEGORIE_NONFOOD
,v01.SONDERMARKT
,v01.REF_WUP_ID
,v01.WM_ID
,v01.KASSENTYP
,v01.DAT_QBM_UMSTELLUNG
,v01.KREISTYP_GRUPPE_ID
,v01.DAT_UMSTELLUNG_WAAGE
,v01.LEAD_MWST
,v01.REGION_ID
-- AP0204035/SPEC0256280 Erweiterung um neue Spalten / sschuecke 19.09.2024
,FIRST_VALUE (v01.REGION_ID) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS AKT_REGION_ID

,v01.KUNDENFAKTOR
,v01.VZ_WUP_ID
,TRIM(v01.WUP_ID || ' ' || v01.WUP_STANDORT) AS MARKT
,v01.GETRAENKEMARKT_FG
,v01.VS_ID
,CASE WHEN v01.vs_id IN (2,7) THEN 1
      WHEN v01.vs_id IN (1,3) THEN 2
      WHEN v01.vs_id IN (6,8) THEN 3 END AS wreg_id
,v01.VERKAUFSORGANISATION_ID
,v01.ADRESSE_ID
,v01.BREITENGRAD
,v01.LAENGENGRAD
-- AP0204035/SPEC0256280 Erweiterung um neue Spalten / sschuecke 19.09.2024
,FIRST_VALUE (v01.BREITENGRAD) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS AKT_BREITENGRAD
,FIRST_VALUE (v01.LAENGENGRAD) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS AKT_LAENGENGRAD

--NSR2837249 sschuecke 22.04.2022
--SPEC0207781 sschuecke 18.07.2023 / vorher nur dat_eroeffnung
,COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung) AS DAT_EROEFFNUNG
--SPEC0212614 sschuecke 21.08.2023 / Anpassung Anzeige Logik GF_ID bzgl geschlossene Filialen
--SPEC0256280 sschuecke 24.07.2024 / Ersetzen umzugsfiliale_fg = 1 durch wup_aenderung_grund_id in (1,2,3,4) bzw umzugsfiliale_fg = 0 durch wup_aenderung_grund_id = 0
,CASE WHEN (v01.dat_bis <> '9999-12-31' AND v01.wup_aenderung_grund_id IN (1,2,3,4) AND v01.gf_id < 0) THEN COALESCE(v02.gf_id, 1000 + v01.mandant_id * 100 + v01.vs_id * 10 * -1)
      WHEN (v01.dat_bis <> '9999-12-31' AND v01.wup_aenderung_grund_id = 0 AND v01.gf_id < 0) THEN (1000 + v01.mandant_id * 100 + v01.vs_id * 10) * -1
      ELSE v01.gf_id END AS gf_id
,v01.UMZUGSFILIALE_FG
-- Expansions Flags 
-- Schliessdatum vor dem uebernaechsten GJ 
-- Eroeeffnungsdatum liegt nach dem GJ VVVJ / VVJ 
,CASE WHEN v03.akt_gj < 1 OR (v04.akt_gj > -3 OR YEAR(COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) > YEAR(CURRENT_DATE) ) THEN 'Exp.' ELSE 'Exp.ber.' END AS Expansions_flag_vvj
,CASE WHEN v03.akt_gj < 1 OR (v04.akt_gj > -2 OR YEAR(COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) > YEAR(CURRENT_DATE) ) THEN 'Exp.' ELSE 'Exp.ber.' END AS Expansions_flag_vj
-- AP0204035/SPEC0256280 Erweiterung um neue Spalten / sschuecke 19.09.2024
,FIRST_VALUE (v01.gln_id) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS AKT_GLN_ID

FROM DBP_VIEW.V_WUP_2 v01

--SPEC0212614 sschuecke 21.08.2023 / Anpassung Anzeige Logik VKL_ID bzgl geschlossene Filialen
LEFT JOIN DBP_VIEW.V_WUP_2 v02
ON  v01.mandant_id = v02. mandant_id
AND v01.wup_id = v02.wup_id_alt
AND v01.nb_id = v02.nb_id

--pruefen ob Schliessdatum 
LEFT JOIN GJ_Zeitraum v03
ON v01.DAT_BIS BETWEEN v03.Start_Tag_GJ AND v03.END_Tag_GJ
--pruefen ob Eroeffnungsdatum 
LEFT JOIN GJ_Zeitraum v04
ON COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung) BETWEEN v04.Start_Tag_GJ AND v04.END_Tag_GJ
---

WHERE v01.MANDANT_ID = 1
AND (((v01.DAT_EROEFFNUNG < CURRENT_DATE
OR v01.DAT_EROEFFNUNG< CURRENT_DATE +45)
AND v01.DAT_VON IS NOT NULL)
OR v01.NB_ID <> 0
OR v01.WUP_ID = 9203)-- Filterung von Zentralfilialen

AND NOT v01.WUP_ID BETWEEN 1 AND 999 -- 20100330 Filterung der IWT Betriebe
AND v01.NB_ID <> 99;

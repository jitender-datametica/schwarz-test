create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_KMO.MV_WUP_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	WUP_AENDERUNG_GRUND_ID,
	AKTUELL_WUP_ID,
	ORIG_WUP_ID,
	WUP_STANDORT,
	AKT_WUP_STANDORT,
	DAT_VON,
	DAT_BIS,
	DAT_QBM_UMSTELLUNG,
	DAT_EROEFFNUNG,
	WUP_PLZ,
	AKT_WUP_PLZ,
	REGION_ID,
	AKT_REGION_ID,
	KREISTYP_GRUPPE_ID,
	VKL_ID,
	BREITENGRAD,
	LAENGENGRAD,
	AKT_BREITENGRAD,
	AKT_LAENGENGRAD,
	GF_ID,
	UMZUGSFILIALE_FG,
	GLN_ID,
	AKT_GLN_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_AIS_KMO
 as
SELECT
 v01.mandant_id
,v01.wup_id
,v01.nb_id
-- AP0204035/SPEC0256280 Erweiterung um neue Spalten / ssch1303 19.09.2024
,v01.wup_aenderung_grund_id
,COALESCE (v03.aktuell_wup_id,v01.aktuell_wup_id) AS aktuell_wup_id1
,COALESCE (MAX(v01.wup_id_alt) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1),v01.orig_wup_id) AS orig_wup_id
,v01.wup_standort
,FIRST_VALUE (v01.WUP_STANDORT) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS akt_wup_standort

--SPEC0207781 sschuecke 18.07.2023 / vorher nur dat_von
,COALESCE(v01.dat_von_alt, v01.dat_von) AS dat_von
,v01.dat_bis
,v01.dat_qbm_umstellung
--SPEC0207781 sschuecke 18.07.2023 / vorher nudat_eroeffnungr dat_eroeffnung
,COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung) AS dat_eroeffnung
,v01.wup_plz
--SPEC0256280/ Erweiterung um neue Spalten / prescherad 15.11.2024
,FIRST_VALUE (v01.wup_plz) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS akt_wup_plz
,v02.region_id
-- AP0204035/SPEC0256280 Erweiterung um neue Spalten / ssch1303 19.09.2024
,FIRST_VALUE (v02.region_id) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS akt_region_id

,v01.kreistyp_gruppe_id
--SPEC0212614 sschuecke 21.08.2023 / Anpassung Anzeige Logik VKL_ID bzgl geschlossene Filialen
--SPEC0256280 sschuecke 24.07.2024 / Ersetzen umzugsfiliale_fg = 1 durch wup_aenderung_grund_id in (1,2,3,4) bzw umzugsfiliale_fg = 0 durch wup_aenderung_grund_id = 0
,CASE WHEN (v01.dat_bis <> '9999-12-31' AND v01.wup_aenderung_grund_id IN (1,2,3,4) AND v01.vkl_id < 0) THEN COALESCE(v03.vkl_id, 1000 + v01.mandant_id * 100 + v01.vs_id * 10 * -1)
  WHEN (v01.dat_bis <> '9999-12-31' AND v01.wup_aenderung_grund_id = 0 AND v01.vkl_id < 0) THEN (1000 + v01.mandant_id * 100 + v01.vs_id * 10) * -1
  ELSE v01.vkl_id 
  END AS vkl_id
,v01.breitengrad
,v01.laengengrad
-- AP0204035/SPEC0256280 Erweiterung um neue Spalten / ssch1303 19.09.2024
,FIRST_VALUE (v01.breitengrad) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS akt_breitengrad
,FIRST_VALUE (v01.laengengrad) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS akt_laengengrad

--SPEC0212614 sschuecke 21.08.2023 / Anpassung Anzeige Logik GF_ID bzgl geschlossene Filialen
--SPEC0256280 sschuecke 24.07.2024 / Ersetzen umzugsfiliale_fg = 1 durch wup_aenderung_grund_id in (1,2,3,4) bzw umzugsfiliale_fg = 0 durch wup_aenderung_grund_id = 0
,CASE WHEN (v01.dat_bis <> '9999-12-31' AND v01.wup_aenderung_grund_id IN (1,2,3,4) AND v01.gf_id < 0) THEN COALESCE(v03.gf_id, 1000 + v01.mandant_id * 100 + v01.vs_id * 10 * -1)
  WHEN (v01.dat_bis <> '9999-12-31' AND v01.wup_aenderung_grund_id = 0 AND v01.gf_id < 0) THEN (1000 + v01.mandant_id * 100 + v01.vs_id * 10) * -1
  ELSE v01.gf_id 
  END AS gf_id
-- AP0204035/SPEC0256280 Erweiterung um neue Spalten / ssch1303 19.09.2024
,v01.umzugsfiliale_fg
,v01.gln_id
,FIRST_VALUE (v01.gln_id) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS akt_gln_id

FROM dbp_view.v_wup_2 AS v01

LEFT JOIN dbp_view.v_vaus_wup_2 v02
ON  v01.mandant_id = v02.mandant_id
AND v01.wup_id = v02.wup_id

--SPEC0212614 sschuecke 21.08.2023 / Anpassung Anzeige Logik VKL_ID bzgl geschlossene Filialen
LEFT JOIN DBP_VIEW.V_WUP_2 v03
ON  v01.mandant_id = v03. mandant_id
AND v01.wup_id = v03.wup_id_alt
AND v01.nb_id = v03.nb_id

WHERE v01.mandant_id <> 1
AND (v01.nb_id = 0 OR v01.wup_id=0)
-- SPEC0152531 Erweiterung WHERE CLAUSE analog AIS_DE / sschuecke 31.05.2022
AND (((v01.DAT_EROEFFNUNG < CURRENT_DATE OR v01.DAT_EROEFFNUNG< CURRENT_DATE +45) AND v01.DAT_VON IS NOT NULL)
       OR v01.NB_ID <> 0
       OR v01.WUP_ID = 9203)-- Filterung von Zentralfilialen
	    AND NOT v01.WUP_ID BETWEEN 1 AND 999 -- 20100330 Filterung der IWT Betriebe
	    AND v01.NB_ID <> 99;

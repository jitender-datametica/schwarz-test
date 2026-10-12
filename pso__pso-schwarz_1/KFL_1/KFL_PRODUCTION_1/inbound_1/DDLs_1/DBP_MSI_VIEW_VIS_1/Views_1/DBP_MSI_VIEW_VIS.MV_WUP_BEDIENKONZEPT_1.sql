CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_BEDIENKONZEPT_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DUMMY_1,
	GLV_LAND_ID,
	VS_ID,
	GL_VERTRIEB_ID,
	GF_GBL_VERTRIEB_ID,
	FRISCHE_MANAGER_ID,
	VKL_ID,
	HAUSLEITER_ID,
	REGIONALE_PSB_ID,
	WBL_FOOD_ID,
	WBL_FRISCHE_ID,
	WBL_NONFOOD_ID,
	WBL_KASSE_ID,
	EDAT,
	DAT_EROEFFNUNG,
	BED_FLEISCH_FG,
	BED_FLEISCH_DAT,
	BED_WURST_FG,
	BED_WURST_DAT,
	BED_GEFL_FG,
	BED_GEFL_DAT,
	BED_KAESE_FG,
	BED_KAESE_DAT,
	BED_FISCH_ID,
	BED_FISCH_DAT,
	BED_FEINK_FG,
	BED_FEINK_DAT,
	BED_BULK_FG,
	BED_BULK_DAT,
	BED_BEDINS_FG,
	BED_BEDINS_DAT,
	BED_IMBISS_FG,
	BED_IMBISS_DAT,
	SYSTEM_BACKSHOP,
	BED_BACKSHOP_DAT,
	ANZ_LEERGUT_AUTOMAT,
	KONZEPT_LEERGUT,
	TANKSTELLE_VORH_FG,
	TANKSTELLE_EIGEN_FG,
	PARKHAUS_KZ,
	EIGENTUM_FG,
	INT_EIGENTUM_FG,
	MA_VERMIETUNG_ID,
	DAT_LETZTE_REORGA,
	ANZ_AUFZUEGE_AUSSERHALB,
	ANZ_ROLLSTEIGE_AUSSERHALB,
	ANZ_AUFZUEGE_INTERN,
	ANZ_ROLLSTEIGE_INTERN,
	UNTERVERMIETUNG_KZ,
	UNTERVERMIETUNG_TEXT,
	UNTERVERMIETUNG_FREITEXT,
	UNTERVERMIETUNG_BEZ,
	ANZ_DIFF_TAGE
) AS 
-- 12.01.2012 AL neu erstellt
-- 13.01.2012 MR neue Spalte
-- 18.01.2012 AL Spalten aus SAP REFX aufgenommen hinzugefügt
-- 02.04.2012 AL HL_1,VKL_1, GF_1 Spalten in die View aufgenommen
-- 10.05.2012 AL Eigentum Anzeige für KMO rausgenommen (Laut Hr. Ganz ist Datenqualität nicht stimmig)
-- 15.06.2012 AL Join mit wup_1, Logik Umstellungsdatum = dat_eroeffnung ==> keine Anzeige
-- 18.06.2012 AL Aufnahme EQUI Informationen in die View
-- 19.06.2012 TB Aufnahme von frische_manager_id in die View
-- 2012-11-22 Erweiterung Zentralfilialen, neue Dummyelemente, Anpassung GL, GLV
-- 2013-09-16 Erweiterung Recht zur Untervermietung (3 Spalten) 
-- 2013KW46 : Review / Erweiterung >> Umzugsfilialen / GF_1
-- 20160304 : Anpassung GL, analog wup_1, join ueber mv_vs_1
-- 20201111 : '0' AS eigentum_fg,ma_vermietung_id,tankstelle_vorh_fg,untervermietung_kz,untervermietung_text,untervermietung_freitext
-- 2024-07-09 ssch0611 : Review + Neue Logik für dat_bedienkonzept/dat_eroeffnung
 
SELECT
  w.mandant_id
, w.nb_id
, w.wup_id
, (1000 + w.mandant_id*100 + w.vs_id*10)*-1::INTEGER   AS DUMMY_1
, MAX(wd.glv_land_id) OVER (PARTITION BY w.mandant_id) AS glv_land_id
, w.vs_id                                              AS vs_id   
, vs.gl_vertrieb_id                                    AS gl_vertrieb_id 
, COALESCE(wd.gf_gbl_vertrieb_id, DUMMY_1)               AS gf_gbl_vertrieb_id
, COALESCE(wd.frische_manager_id,-1)                   AS frische_manager_id
, COALESCE(wd.vkl_id, DUMMY_1)                           AS vkl_id
, COALESCE(wd.hausleiter_id, DUMMY_1)                    AS hausleiter_id
, wd.regionale_psb_id
, wd.wbl_food_id
, wd.wbl_frische_id
, wd.wbl_nonfood_id
, wd.wbl_kasse_id
, COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung) AS EDAT
, EDAT AS dat_eroeffnung
, bed_fleisch_fg
, CASE WHEN bed_fleisch_fg = 1 THEN COALESCE(bed_fleisch_dat, EDAT) END AS bed_fleisch_dat
, bed_wurst_fg
, CASE WHEN bed_wurst_fg = 1 THEN COALESCE(bed_wurst_dat, EDAT) END AS bed_wurst_dat
, bed_gefl_fg
, CASE WHEN bed_gefl_fg = 1 THEN COALESCE(bed_gefl_dat, EDAT) END AS bed_gefl_dat
, bed_kaese_fg
, CASE WHEN bed_kaese_fg = 1 THEN COALESCE(bed_kaese_dat, EDAT) END AS bed_kaese_dat
, bed_fisch_id
, CASE WHEN bed_fleisch_fg > 1 THEN COALESCE(bed_fisch_dat, EDAT) END AS bed_fisch_dat
, bed_feink_fg
, CASE WHEN bed_feink_fg = 1 THEN COALESCE(bed_feink_dat, EDAT) END AS bed_feink_dat
, bed_bulk_fg
, CASE WHEN bed_bulk_fg = 1 THEN COALESCE(bed_bulk_dat, EDAT) END AS bed_bulk_dat
, bed_bedins_fg
, CASE WHEN bed_bedins_fg = 1 THEN COALESCE(bed_bedins_dat, EDAT) END AS bed_bedins_dat
, bed_imbiss_fg
, CASE WHEN bed_imbiss_fg = 1 THEN COALESCE(bed_imbiss_dat, EDAT) END AS bed_imbiss_dat
, backshop_system  AS system_backshop
, CASE WHEN backshop_system IS NOT NULL THEN COALESCE(bed_backshop_dat, EDAT) END AS bed_backshop_dat
, anz_leergutautomaten  AS anz_leergut_automat
, leergut_system  AS konzept_leergut
, '0' AS tankstelle_vorh_fg
, tankstelle_eigen_fg
, wd.parkhaus_kz
, '0' AS eigentum_fg
, '0' AS int_eigentum_fg
, '0' AS ma_vermietung_id
, dat_letzte_reorga
, anz_aufzuege - anz_aufzuege_intern AS anz_aufzuege_ausserhalb
, anz_rollsteige  -  anz_rollsteige_intern  AS  anz_rollsteige_ausserhalb
, anz_aufzuege_intern
, anz_rollsteige_intern
, '0' AS untervermietung_kz
, '0' AS untervermietung_text
, '0' AS untervermietung_freitext
, '0' AS untervermietung_bez
, 1 AS ANZ_DIFF_TAGE
FROM (SELECT
ww.mandant_id,
ww.nb_id,
ww.vs_id,
ww.wup_id,
ww.dat_eroeffnung,
ww.dat_eroeffnung_alt
FROM dbp_view.v_wup_1 ww
WHERE ww.nb_id IN (-2, -1, 0)  -- ZF, Filiale OHNE Gastro, TKS
AND (ww.dat_von > TO_DATE('1900-01-01') AND ww.dat_eroeffnung > TO_DATE('1900-01-01'))  -- Filterung wup_1 Sumpf
AND ww.umzugsfiliale_fg = 0 -- ohne Umzugsfilialen (alt)
) w

LEFT JOIN dbp_msi_v_view.v_wup_denorm_1 wd
ON wd.wup_id = w.wup_id AND wd.mandant_id = w.mandant_id

LEFT JOIN dbp_msi_view_vis.mv_vs_1 vs_1
ON vs.vs_id = w.vs_id AND vs.mandant_id = w.mandant_id
;
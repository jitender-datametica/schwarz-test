CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_WUP_BEDIENKONZEPT_1 AS
-- 12.01.2012 AL neu erstellt
-- 13.01.2012 MR neue Spalte
-- 18.01.2012 AL Spalten aus SAP REFX aufgenommen hinzugefügt
-- 02.04.2012 AL HL_1,VKL_1, GF_1 Spalten in die View aufgenommen
-- 10.05.2012 AL Eigentum Anzeige für KMO rausgenommen (Laut Hr. Ganz ist Datenqualität nicht stimmig)
-- 15.06.2012 AL Join mit wup_1, Logik Umstellungsdatum = dat_eroeffnung ==> keine Anzeige
-- 18.06.2012 AL Aufnahme EQUI Informationen in die View
-- 19.06.2012 TB Aufnahme von frische_manager_id in die View
-- 17.06.2013 twie: Kopie aus VIS, wenn Flag NULL ist auf -1 bzw. Dummywert setzen, Filter auskommentiert
-- 2012-11-22 Erweiterung Zentralfilialen, neue Dummyelemente, Anpassung GL, GLV

   SELECT
   w.mandant_id,
   w.nb_id,
   w.wup_id,
   w.vs_id,
   -- Mitarbeiter Vertrieb
   COALESCE(wd.hausleiter_id, (1000 + w.mandant_id * 100 + w.vs_id * 10) * -1::INTEGER) AS hausleiter_id,
   COALESCE(wd.vkl_id, (1000 + w.mandant_id * 100 + w.vs_id * 10) * -1::INTEGER) vkl_id,
   COALESCE(wd.frische_manager_id,-1) AS frische_manager_id,
   COALESCE(wd.gf_gbl_vertrieb_id, 0) AS gf_gbl_vertrieb_id  --0 statt dummy_1
   ,
   MAX(wd.gl_vertrieb_id) OVER (PARTITION BY w.mandant_id, w.vs_id) AS gl_vertrieb_id,
   MAX(wd.glv_land_id) OVER (PARTITION BY w.mandant_id) AS glv_land_id,
   wd.regionale_psb_id,
   wd.wbl_food_id,
   wd.wbl_frische_id,
   wd.wbl_nonfood_id,
   wd.wbl_kasse_id,
   -- Bedienkonzepte aus RPM
   -- Wenn zwischen Eröffnung und Umstellung <= anz_dif_tage liegen wird Datum nicht angezeigt.
   COALESCE(bed_fleisch_fg, -1) AS bed_fleisch_fg,
   CASE WHEN ABS(bed_fleisch_dat  - dat_eroeffnung) < 1 THEN TO_DATE('1900-01-01','YYYY-MM_1-DD') ELSE bed_fleisch_dat END AS bed_fleisch_dat,
   COALESCE(bed_wurst_fg, -1) AS bed_wurst_fg,
   CASE WHEN ABS(bed_wurst_dat  - dat_eroeffnung) < 1 THEN TO_DATE('1900-01-01','YYYY-MM_1-DD') ELSE bed_wurst_dat END AS bed_wurst_dat,
   COALESCE(bed_gefl_fg, -1) AS bed_gefl_fg,
   CASE WHEN ABS(bed_gefl_dat  - dat_eroeffnung) < 1 THEN TO_DATE('1900-01-01','YYYY-MM_1-DD') ELSE bed_gefl_dat END AS bed_gefl_dat,
   COALESCE(bed_kaese_fg, -1) AS bed_kaese_fg,
   CASE WHEN ABS(bed_kaese_dat  - dat_eroeffnung) < 1 THEN TO_DATE('1900-01-01','YYYY-MM_1-DD') ELSE bed_kaese_dat END AS bed_kaese_dat,
   COALESCE(bed_fisch_id, 1) AS bed_fisch_id,
   CASE WHEN ABS(bed_fisch_dat   - dat_eroeffnung) < 1 THEN TO_DATE('1900-01-01','YYYY-MM_1-DD') ELSE bed_fisch_dat END AS bed_fisch_dat,
   COALESCE(bed_feink_fg, -1) AS bed_feink_fg,
   CASE WHEN ABS(bed_feink_dat   - dat_eroeffnung) < 1 THEN TO_DATE('1900-01-01','YYYY-MM_1-DD') ELSE bed_feink_dat END AS bed_feink_dat,
   COALESCE(bed_bulk_fg, -1) AS bed_bulk_fg,
   CASE WHEN ABS(bed_bulk_dat   - dat_eroeffnung) < 1 THEN TO_DATE('1900-01-01','YYYY-MM_1-DD') ELSE bed_bulk_dat END AS bed_bulk_dat,
   bed_bedins_fg,
   CASE WHEN ABS(bed_bedins_dat   - dat_eroeffnung) < 1 THEN TO_DATE('1900-01-01','YYYY-MM_1-DD') ELSE bed_bedins_dat END AS bed_bedins_dat,
   bed_imbiss_fg,
   CASE WHEN ABS(bed_imbiss_dat   - dat_eroeffnung) < 1 THEN TO_DATE('1900-01-01','YYYY-MM_1-DD') ELSE bed_imbiss_dat END AS bed_imbiss_dat,
   COALESCE(backshop_system, '') AS system_backshop,
   CASE WHEN ABS(bed_backshop_dat   - dat_eroeffnung) < 1 THEN TO_DATE('1900-01-01','YYYY-MM_1-DD') ELSE bed_backshop_dat END AS bed_backshop_dat,
   -- SAP PM_1
   anz_leergutautomaten          AS anz_leergut_automat,
   COALESCE(leergut_system, '') AS  konzept_leergut,
   -- SAP REFX
   tankstelle_vorh_fg,
   tankstelle_eigen_fg,
   wd.parkhaus_kz,
   CASE WHEN wd.mandant_id = 1 THEN eigentum_fg  ELSE -1 END eigentum_fg,
   ma_vermietung_id,
   -- CProjects
   dat_letzte_reorga,
   -- Informationen aus EQUI Schnittstelle
   anz_aufzuege - anz_aufzuege_intern AS anz_aufzuege_ausserhalb,
   anz_rollsteige  -  anz_rollsteige_intern  AS  anz_rollsteige_ausserhalb,
   anz_aufzuege_intern,
   anz_rollsteige_intern,
   -- Variablen
   (1000 + w.mandant_id * 100 + w.vs_id * 10) * -1::INTEGER AS dummy_1,
   1 AS anz_diff_tage

  FROM  dbp_view.v_wup_1  w
   LEFT JOIN  dbp_msi_v_view.v_wup_denorm_1 wd
   ON wd.wup_id = w.wup_id AND wd.mandant_id = w.mandant_id

   /* -- VIS Filterung auskommentiert:
   WHERE w.nb_id IN (-2, -1, 0)
   AND dat_eroeffnung > 101
   AND (w.mandant_id, w.wup_id) NOT IN (
   SELECT mandant_id, wup_id_alt AS wup_id
   FROM dbp_view.v_wup_1
   WHERE wup_id_alt > 0
   AND dat_von > 1000301 -- ab GJ2000
   AND dat_von < DATE    -- ab Umzugstermin
   )
   */
   ;
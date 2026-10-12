CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_BETR_KBL_NAME_SPR_ZU_1
AS
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   tp_betreuer_kbl_name, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_de, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_cz, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_pl, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_sk, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_hr, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_ro, MAX(
   tp_betreuer_kbl_name
   ) AS tp_betreuer_kbl_name_bez_bg
   FROM
   (
   SELECT
   mandant_id, COALESCE (tp_betreuer_kbl_name, '')  tp_betreuer_kbl_name
   FROM dbp_view.v_techn_platz_ebene_2_per_1
   WHERE
   dat_bis = '9999-12-31'
   UNION ALL
   /* Dummy_1-Eintrag für Leerstring */
   SELECT
   -1  AS mandant_id, '' AS tp_betreuer_kbl_name
   FROM dbp_view.v_tag_1
   WHERE
   dat = CURRENT_DATE
   ) v01
   GROUP BY
   tp_betreuer_kbl_name;
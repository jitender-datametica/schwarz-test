CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VAUS_WUP_NAME_SPR_ZU
AS
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   vaus_wup_name, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_de, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_cz, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_pl, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_sk, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_hr, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_ro, MAX(
   vaus_wup_name
   ) AS vaus_wup_name_bez_bg
   FROM
   (
   SELECT
   mandant_id, COALESCE (wup_name_1, '')  vaus_wup_name
   FROM dbp_view.v_vaus_wup
   UNION ALL
   /* Dummy-Eintrag für Leerstring */
   SELECT
   -1 AS mandant_id, '' AS vaus_wup_name
   FROM dbp_view.v_tag
   WHERE
   dat = CURRENT_DATE
   ) v01
   GROUP BY
   vaus_wup_name;
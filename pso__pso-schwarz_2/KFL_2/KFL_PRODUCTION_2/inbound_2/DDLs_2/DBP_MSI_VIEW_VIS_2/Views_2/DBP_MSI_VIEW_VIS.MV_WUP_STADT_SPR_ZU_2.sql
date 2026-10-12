CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_STADT_SPR_ZU_2
AS
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   wup_stadt, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_de, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_cz, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_pl, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_sk, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_hr, MAX(CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_ro, MAX(
   wup_stadt
   ) AS wup_stadt_bez_bg
   FROM
   (
   SELECT
   mandant_id, wup_stadt_1 AS wup_stadt
   FROM dbp_view.v_vaus_wup_2
   UNION ALL
   SELECT
   mandant_id, wup_stadt
   FROM dbp_view.v_wup_2
   ) v01
   GROUP BY
   wup_stadt;
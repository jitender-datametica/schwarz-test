CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_STR_SPR_ZU
AS
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   -- 2019.0520 ssch0611 : Review (Subselect filtered, based on wup only)

   SELECT
   wup_str, MAX(CASE WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_str) ELSE wup_str END) AS wup_str_bez, 
   MAX(CASE WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_str) ELSE wup_str END) AS wup_str_bez_cz, 
   MAX(CASE WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_str) ELSE wup_str END) AS wup_str_bez_sk,
   MAX(CASE WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_str) ELSE wup_str END) AS wup_str_bez_hr, 
   MAX(CASE WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_str) ELSE wup_str END) AS wup_str_bez_pl, 
   MAX(CASE WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_str) ELSE wup_str END) AS wup_str_bez_ro, 
   MAX(wup_str)   AS wup_str_bez_bg, 
   MAX(CASE WHEN mandant_id = 8 THEN dbp_process.Transcriptc(wup_str) ELSE wup_str END) AS wup_str_bez_de

   FROM (
   SELECT mandant_id, wup_str
   FROM dbp_view.v_wup
   WHERE nb_id IN (-2, -1, 0) AND dat_von > '1900-01-01' AND dat_Eroeffnung > '1900-01-01'
   ) v01

   GROUP BY  wup_str;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_str_spr_zu_1 AS SELECT wup_str,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_str)
   ELSE wup_str
   END) AS wup_str_bez,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_str)
   ELSE wup_str
   END) AS wup_str_bez_cz,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_str)
   ELSE wup_str
   END) AS wup_str_bez_sk,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_str)
   ELSE wup_str
   END) AS wup_str_bez_hr,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_str)
   ELSE wup_str
   END) AS wup_str_bez_pl,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_str)
   ELSE wup_str
   END) AS wup_str_bez_ro,
 MAX(wup_str) AS wup_str_bez_bg,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_str)
   ELSE wup_str
   END) AS wup_str_bez_de
FROM kfl_production_dbp_view.v_wup_1
WHERE nb_id IN (- 2, - 1, 0)
 AND dat_von > DATE '1900-01-01'
 AND dat_eroeffnung > DATE '1900-01-01'
GROUP BY wup_str;

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vaus_wup_name_spr_zu AS SELECT vaus_wup_name,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_de,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_cz,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_pl,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_sk,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_hr,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(vaus_wup_name)
   ELSE vaus_wup_name
   END) AS vaus_wup_name_bez_ro,
 MAX(vaus_wup_name) AS vaus_wup_name_bez_bg
FROM (SELECT mandant_id,
    COALESCE(wup_name_1, '') AS vaus_wup_name
   FROM kfl_production_dbp_view.v_vaus_wup
   UNION ALL
   SELECT - 1 AS mandant_id,
    '' AS vaus_wup_name
   FROM kfl_production_dbp_view.v_tag
   WHERE dat = CURRENT_DATE) AS v01
GROUP BY vaus_wup_name;

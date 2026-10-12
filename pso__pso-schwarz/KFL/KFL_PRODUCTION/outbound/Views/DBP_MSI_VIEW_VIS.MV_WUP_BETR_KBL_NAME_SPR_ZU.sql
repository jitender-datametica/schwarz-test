CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_betr_kbl_name_spr_zu AS SELECT tp_betreuer_kbl_name,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_de,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_cz,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_pl,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_sk,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_hr,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(tp_betreuer_kbl_name)
   ELSE tp_betreuer_kbl_name
   END) AS tp_betreuer_kbl_name_bez_ro,
 MAX(tp_betreuer_kbl_name) AS tp_betreuer_kbl_name_bez_bg
FROM (SELECT mandant_id,
    COALESCE(tp_betreuer_kbl_name, '') AS tp_betreuer_kbl_name
   FROM kfl_production_dbp_view.v_techn_platz_ebene_2_per
   WHERE dat_bis = DATE '9999-12-31'
   UNION ALL
   SELECT - 1 AS mandant_id,
    '' AS tp_betreuer_kbl_name
   FROM kfl_production_dbp_view.v_tag
   WHERE dat = CURRENT_DATE) AS v01
GROUP BY tp_betreuer_kbl_name;
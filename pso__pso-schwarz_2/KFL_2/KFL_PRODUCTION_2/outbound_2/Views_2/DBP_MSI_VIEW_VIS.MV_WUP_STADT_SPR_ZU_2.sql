CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_stadt_spr_zu_2 AS SELECT wup_stadt,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_de,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_cz,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_pl,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_sk,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_hr,
 MAX(CASE
   WHEN mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(wup_stadt)
   ELSE wup_stadt
   END) AS wup_stadt_bez_ro,
 MAX(wup_stadt) AS wup_stadt_bez_bg
FROM (SELECT mandant_id,
    wup_stadt_1 AS wup_stadt
   FROM kfl_production_dbp_view.v_vaus_wup_2
   UNION ALL
   SELECT mandant_id,
    wup_stadt
   FROM kfl_production_dbp_view.v_wup_2) AS v01
GROUP BY wup_stadt;
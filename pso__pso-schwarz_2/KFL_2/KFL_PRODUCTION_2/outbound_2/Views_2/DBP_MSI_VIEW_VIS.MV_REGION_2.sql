CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_region_2 AS SELECT R.mandant_id,
  CASE
  WHEN R.region_id < 0
  THEN - R.mandant_id
  ELSE R.region_id
  END AS region_id,
 MAX(CASE
   WHEN R.region_id >= 0 AND M.mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(R.region_name)
   WHEN R.region_id >= 0 AND M.mandant_id <> 8
   THEN R.region_name
   ELSE M.mandant_kbez
   END) AS region_name,
 MAX(CASE
   WHEN R.region_id >= 0 AND M.mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(R.region_name)
   WHEN R.region_id >= 0 AND M.mandant_id <> 8
   THEN R.region_name
   ELSE M.mandant_kbez
   END) AS region_name_de,
 MAX(CASE
   WHEN R.region_id >= 0 AND M.mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(R.region_name)
   WHEN R.region_id >= 0 AND M.mandant_id <> 8
   THEN R.region_name
   ELSE M.mandant_kbez
   END) AS region_name_cz,
 MAX(CASE
   WHEN R.region_id >= 0 AND M.mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(R.region_name)
   WHEN R.region_id >= 0 AND M.mandant_id <> 8
   THEN R.region_name
   ELSE M.mandant_kbez
   END) AS region_name_pl,
 MAX(CASE
   WHEN R.region_id >= 0 AND M.mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(R.region_name)
   WHEN R.region_id >= 0 AND M.mandant_id <> 8
   THEN R.region_name
   ELSE M.mandant_kbez
   END) AS region_name_sk,
 MAX(CASE
   WHEN R.region_id >= 0 AND M.mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(R.region_name)
   WHEN R.region_id >= 0 AND M.mandant_id <> 8
   THEN R.region_name
   ELSE M.mandant_kbez
   END) AS region_name_hr,
 MAX(CASE
   WHEN R.region_id >= 0 AND M.mandant_id = 8
   THEN kfl_production_dbp_process.transcriptc(R.region_name)
   WHEN R.region_id >= 0 AND M.mandant_id <> 8
   THEN R.region_name
   ELSE M.mandant_kbez
   END) AS region_name_ro,
 MAX(CASE
   WHEN R.region_id >= 0 AND M.mandant_id <> 8
   THEN kfl_production_dbp_process.transcriptc(R.region_name)
   WHEN R.region_id >= 0 AND M.mandant_id = 8
   THEN R.region_name
   ELSE M.mandant_kbez
   END) AS region_name_bg
FROM kfl_production_dbp_view.v_region_2 AS R
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS M ON R.mandant_id = M.mandant_id
WHERE CASE
   WHEN M.mandant_kbez = 'D'
   THEN 'DE'
   ELSE M.mandant_kbez
   END = R.land_id
GROUP BY R.mandant_id,
 R.region_id;
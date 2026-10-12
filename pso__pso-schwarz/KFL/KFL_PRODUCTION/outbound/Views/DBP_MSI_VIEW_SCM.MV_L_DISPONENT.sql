CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_disponent (mandant_id, disponent_id, disponent_name) AS
SELECT mandant_id,
 disponent_id,
 disponent_name
FROM (SELECT *
  FROM (SELECT mandant_id,
      disponent_id,
      disponent_name,
      1 AS prio
     FROM kfl_production_dbp_view.v_disponent_wup_zu AS V01
     WHERE nb_id = - 111
      AND (mandant_id, wup_id) IN (SELECT (mandant_id, wup_id)
        FROM kfl_production_dbp_view.v_wup
        WHERE nb_id = - 111
         AND fipo_pruef_objekt_id > 0
         AND vw_id > 0)
     UNION ALL
     SELECT mandant_id,
      '-1' AS disponent_id,
      'nicht gepflegt / not maintained' AS disponent_name,
      2 AS prio
     FROM kfl_production_dbp_view.v_mandant AS V02)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), disponent_id ORDER BY prio IS NULL, prio)) = 1)
 AS t5;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_disponent_wup_zu (mandant_id, wup_id, nb_id, disponent_id,
disponent_name) AS SELECT mandant_id,
 wup_id,
 nb_id,
 disponent_id,
 disponent_name
FROM (SELECT *
  FROM (SELECT mandant_id,
      wup_id,
      nb_id,
      disponent_id,
      disponent_name,
      1 AS prio
     FROM kfl_production_dbp_view.v_disponent_wup_zu AS V01
     WHERE nb_id = - 111
     UNION ALL
     SELECT mandant_id,
      wup_id,
      nb_id,
      '-1' AS disponent_id,
      'nicht gepflegt / not maintained' AS disponent_name,
      2 AS prio
     FROM kfl_production_dbp_view.v_wup AS V02
     WHERE nb_id = - 111)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(nb_id AS STRING),
        disponent_id ORDER BY prio IS NULL, prio)) = 1) AS t4;
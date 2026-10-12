CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_lagernummer_spr_zu_1 AS SELECT lagernummer_bez,
 lagernummer_id,
 mandant_id,
 nb_id,
 spr_id,
 wup_id
FROM kfl_production_dbp_view.v_lagernummer_spr_zu_1 AS V01
UNION ALL
SELECT DISTINCT 'keine Zuordnung (VZ ' || TRIM(SUBSTR(CAST(wup_id AS STRING), 1, 39)) || ')' AS lagernummer_bez,
  CASE
  WHEN mandant_id = 1 AND nb_id = - 111
  THEN '-' || SUBSTR(SUBSTR(CAST(wup_id AS STRING), 1, 39), 2, 4)
  WHEN mandant_id <> 1 AND nb_id = - 111
  THEN '-' || SUBSTR(SUBSTR(CAST(wup_id AS STRING), 1, 39), 1, 3)
  ELSE '-99'
  END AS lagernummer_id,
 mandant_id,
 nb_id,
 spr_id,
 wup_id
FROM kfl_production_dbp_view.v_lagernummer_spr_zu_1 AS V03
WHERE wup_id > 1000
 AND nb_id = - 111;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_lagernummer_1 AS SELECT lagernummer_id,
 mandant_id,
 nb_id,
 wup_id,
 oug_fg,
 dummy_tor_id
FROM kfl_production_dbp_view.v_l_lagernummer_1 AS V01
UNION ALL
SELECT DISTINCT CASE
  WHEN mandant_id = 1 AND nb_id = - 111
  THEN '-' || SUBSTR(SUBSTR(CAST(wup_id AS STRING), 1, 39), 2, 4)
  WHEN mandant_id <> 1 AND nb_id = - 111
  THEN '-' || SUBSTR(SUBSTR(CAST(wup_id AS STRING), 1, 39), 1, 3)
  ELSE '-99'
  END AS lagernummer_id,
 mandant_id,
 nb_id,
 wup_id,
 0 AS oug_fg,
 0 AS dummy_tor_id
FROM kfl_production_dbp_view.v_lagernummer_spr_zu_1 AS V02
WHERE wup_id > 1000
 AND nb_id = - 111;
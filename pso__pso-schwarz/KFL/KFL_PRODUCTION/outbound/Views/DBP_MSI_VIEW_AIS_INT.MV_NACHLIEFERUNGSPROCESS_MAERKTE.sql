CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_nachlieferungsprocess_maerkte AS SELECT V1.mandant_id,
  CASE
  WHEN V1.gp_id = 10015214
  THEN 'RETAILZOOM'
  WHEN V1.gp_id = 5191480
  THEN 'STAT_BUNDESAMT'
  WHEN V1.gp_id = 3098740
  THEN 'IRI'
  WHEN V1.gp_id = 1922320
  THEN 'GFK'
  WHEN V1.gp_id = 4625810
  THEN 'NPD'
  WHEN V1.gp_id = 3126380 AND V1.mandant_id = 1
  THEN 'NIELSEN_DE'
  WHEN V1.gp_id = 3126380 AND V1.mandant_id > 1
  THEN 'NIELSEN_KMO'
  WHEN V1.gp_id = 10022115
  THEN 'MARKETVECTOR'
  ELSE NULL
  END AS gp_exp_name,
 V1.wup_id,
 V2.wup_standort
FROM kfl_production_dbp_msi_v_view.v_ais_mandant_wup AS V1
 INNER JOIN kfl_production_dbp_view.v_wup AS V2 ON V1.mandant_id = V2.mandant_id AND V1.wup_id = V2.wup_id
WHERE V1.gp_id <> - 1
GROUP BY V1.mandant_id,
 gp_exp_name,
 V1.wup_id,
 V2.wup_standort
UNION ALL
SELECT V1.mandant_id,
  CASE
  WHEN V1.gp_id = 3126380 AND V1.mandant_id > 1
  THEN 'NIELSEN_KMO_NEU'
  ELSE NULL
  END AS gp_exp_name,
 V1.wup_id,
 V2.wup_standort
FROM kfl_production_dbp_msi_v_view.v_ais_mandant_wup AS V1
 INNER JOIN kfl_production_dbp_view.v_wup AS V2 ON V1.mandant_id = V2.mandant_id AND V1.wup_id = V2.wup_id
WHERE V1.gp_id = 3126380
 AND V1.mandant_id > 1
GROUP BY V1.mandant_id,
 gp_exp_name,
 V1.wup_id,
 V2.wup_standort
UNION ALL
SELECT mandant_id,
 'PRESSEGROSSISTEN' AS gp_exp_name,
 wup_id,
 wup_standort
FROM kfl_production_dbp_view.v_wup AS V1
WHERE mandant_id = 1
 AND nb_id = 0
 AND dat_von < CURRENT_DATE
 AND dat_bis = DATE '9999-12-31'
GROUP BY mandant_id,
 gp_exp_name,
 wup_id,
 wup_standort;
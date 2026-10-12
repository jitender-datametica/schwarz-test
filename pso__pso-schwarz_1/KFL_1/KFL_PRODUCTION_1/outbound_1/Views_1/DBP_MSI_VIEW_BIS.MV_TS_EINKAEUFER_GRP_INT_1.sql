CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_ts_einkaeufer_grp_int_1 (mandant_id, einkaeufer_grp_id,
einkaeufer_grp_bez, hat_lieferant_fg) AS SELECT 99 AS mandant_id,
 V01.einkaeufer_int_id AS einkaeufer_grp_id,
 V01.einkaeufer_int_name AS einkaeufer_grp_bez,
  CASE
  WHEN V02.einkaeufer_int_id IS NOT NULL
  THEN 1
  ELSE 0
  END AS hat_lieferant_fg
FROM kfl_production_dbp_view.v_in_l_einkaeufer_int_1 AS V01
 LEFT JOIN kfl_production_dbp_msi_view_bis.ts_einkaeufer_int_lief_zu_1 AS V02 ON V01.einkaeufer_int_id = V02.einkaeufer_int_id
  
GROUP BY V02.mandant_id,
 einkaeufer_grp_id,
 einkaeufer_grp_bez,
 hat_lieferant_fg;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artkz_posten_bg_2 (mandant_id, posten_id, spr_id, posten_bez,
posten_kz) AS SELECT mandant_id,
 posten_id,
 spr_id,
 posten_bez,
  CASE
  WHEN mandant_id = 1 AND posten_id IN ('PN', 'PF') OR mandant_id <> 1 AND posten_id = '1'
  THEN 'X'
  ELSE ''
  END AS posten_kz
FROM kfl_production_dbp_view.v_artkz_posten_2 AS V01
WHERE spr_id = 18;
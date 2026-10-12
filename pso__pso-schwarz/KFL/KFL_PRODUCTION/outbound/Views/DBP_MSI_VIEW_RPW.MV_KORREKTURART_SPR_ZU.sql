CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_korrekturart_spr_zu (system_id, mandant_id, korrekturart_id,
spr_id, korrekturart_bez) AS SELECT 7 AS system_id,
 mandant_id,
  CASE
  WHEN korrekturart_id = ''
  THEN '0'
  ELSE korrekturart_id
  END AS korrekturart_id,
 spr_id,
 korrekturart_bez
FROM kfl_production_dbp_view.v_korrekturart_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_korrekturart (system_id, mandant_id, korrekturart_id) AS
SELECT 7 AS system_id,
 mandant_id,
  CASE
  WHEN korrekturart_id = ''
  THEN '0'
  ELSE korrekturart_id
  END AS korrekturart_id
FROM kfl_production_dbp_view.v_l_korrekturart
WHERE mandant_id = 1;
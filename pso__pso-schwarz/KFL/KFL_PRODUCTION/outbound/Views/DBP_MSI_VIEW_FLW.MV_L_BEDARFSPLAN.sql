CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_bedarfsplan (mandant_id, bedarfsplan_id) AS SELECT DISTINCT
 mandant_id,
  CASE
  WHEN bedarfsplan_id = ''
  THEN 'System generated'
  ELSE TRIM(bedarfsplan_id)
  END AS bedarfsplan_id
FROM kfl_production_dbp_view.v_flw_art AS V01
WHERE artikelart_id IN ('ZKMN', 'HALB', 'ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA', 'ZDIE', 'REWO', 'ZHAW', 'ZFLV')
 AND mandant_id IN (1, 2);
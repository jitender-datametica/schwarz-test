CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagernummer_2 AS SELECT lagernummer_id,
 mandant_id,
 nb_id,
 wup_id,
 oug_fg,
 dummy_tor_id,
 LEFT(lagernummer_id, 3) AS lagernummer_erp_id
FROM kfl_production_dbp_view.v_l_lagernummer_2 AS V01
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND LENGTH(TRIM(lagernummer_id)) = 4
 AND wup_id > 0;
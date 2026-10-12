CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_ewm_exc_kategorie_1 AS SELECT mandant_id,
 lagernummer_id,
 ewm_exc_kategorie_id
FROM kfl_production_dbp_view.v_l_ewm_exception_1
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND LENGTH(TRIM(lagernummer_id)) = 4
GROUP BY mandant_id,
 lagernummer_id,
 ewm_exc_kategorie_id;
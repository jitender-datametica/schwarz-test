CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ewm_exception_kategorie_zu_prompt_2 AS SELECT
 ewm_exc_kategorie_id,
 ewm_exception_id
FROM kfl_production_dbp_view.v_l_ewm_exception_2
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND LENGTH(TRIM(lagernummer_id)) = 4
GROUP BY ewm_exc_kategorie_id,
 ewm_exception_id;
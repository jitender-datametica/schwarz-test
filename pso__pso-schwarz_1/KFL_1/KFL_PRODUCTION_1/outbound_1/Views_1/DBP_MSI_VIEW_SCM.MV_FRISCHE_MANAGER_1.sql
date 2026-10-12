CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_frische_manager_1 AS SELECT mandant_id,
 ma_id AS frische_manager_id,
 MAX(ma_vorname || ' ' || ma_name) AS frische_manager_name
FROM kfl_production_dbp_view.v_ma_spr_zu_1 AS V01
WHERE (mandant_id, ma_id) IN (SELECT (mandant_id, frische_manager_id)
   FROM kfl_production_dbp_msi_v_view.v_wup_denorm_1)
GROUP BY mandant_id,
 frische_manager_id
UNION DISTINCT
SELECT 1 AS mandant_id,
 - 1 AS frische_manager_id,
 'Alle FM (DIF)' AS frische_manager_name;
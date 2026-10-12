CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_rueck_grund (rueck_grund_id, mandant_id) AS SELECT
 rueck_grund_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_rueck_grund AS V01
UNION DISTINCT
SELECT - 1 AS rueck_grund_id,
 mandant_id
FROM kfl_production_dbp_view.v_mandant;
CREATE OR REPLACE VIEW process_mining_production_eval.v_cmdb_ci_l2_reduced_tmp_2 (asset) AS SELECT CAST(SUBSTR(asset, 0, 3) AS STRING)
 AS asset
FROM process_mining_production_eval.t_cmdb_ci_l2_reduced_2;
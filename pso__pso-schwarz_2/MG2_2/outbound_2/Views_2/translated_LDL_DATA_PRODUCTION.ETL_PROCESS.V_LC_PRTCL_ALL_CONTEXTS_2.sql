CREATE OR REPLACE VIEW ldl_data_production_etl_process.v_lc_prtcl_all_contexts_2 (context_area_type, context_area,
context_load_id, processcontainer, success_state, ctx_has_started_fg, updated_ts) AS SELECT a.cluster_area_type AS
 context_area_type,
 a.cluster_area_cd AS context_area,
 t.context_load_id,
 t.processcontainer,
 MAX(t.success_state) AS success_state,
  CASE
  WHEN MAX(t.success_state) = 'raw'
  THEN 0
  ELSE 1
  END AS ctx_has_started_fg,
 MAX(t.updated_ts) AS updated_ts
FROM ldl_data_production_etl_process.t_client_cluster_hierarchy_maindef_2 AS a
 INNER JOIN ldl_data_production_etl_process.t_lc_prtcl_context_tasks_2 AS t ON a.country_cd = t.context_country_cd AND a.cluster_area_type
     = t.context_area_type AND a.cluster_type = t.cluster_type
GROUP BY context_area_type,
 context_area,
 t.context_load_id,
 t.processcontainer;
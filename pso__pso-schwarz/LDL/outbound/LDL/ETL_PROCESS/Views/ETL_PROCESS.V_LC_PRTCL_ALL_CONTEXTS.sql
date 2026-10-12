CREATE OR REPLACE VIEW ldl_etl_process.v_lc_prtcl_all_contexts AS SELECT A.cluster_area_type AS context_area_type,
 A.cluster_area_cd AS context_area,
 T.context_load_id,
 T.processcontainer,
 MAX(T.success_state) AS success_state,
  CASE
  WHEN MAX(T.success_state) = 'raw'
  THEN 0
  ELSE 1
  END AS ctx_has_started_fg,
 MAX(T.updated_ts) AS updated_ts
FROM ldl_etl_process.t_client_cluster_hierarchy_maindef AS A
 INNER JOIN ldl_etl_process.t_lc_prtcl_context_tasks AS T ON A.country_cd = T.context_country_cd AND A.cluster_area_type
     = T.context_area_type AND A.cluster_type = T.cluster_type
GROUP BY context_area_type,
 context_area,
 T.context_load_id,
 T.processcontainer;
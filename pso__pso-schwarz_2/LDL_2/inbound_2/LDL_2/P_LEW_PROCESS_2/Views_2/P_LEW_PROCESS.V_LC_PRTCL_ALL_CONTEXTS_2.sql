CREATE OR REPLACE VIEW P_LEW_PROCESS.V_LC_PRTCL_ALL_CONTEXTS_2
   AS
      SELECT  a.cluster_area_type    AS context_area_type,
      a.cluster_area_cd      AS context_area,
      t.context_load_id      AS context_load_id,
      t.processcontainer     AS processcontainer,
      MAX(success_state)     AS success_state,
      CASE WHEN MAX(success_state)='raw' THEN 0 ELSE 1 END AS ctx_has_started_fg,
      MAX(updated_ts)        AS updated_ts
     FROM p_lew_process.t_client_cluster_hierarchy_maindef_2 a
      INNER JOIN p_lew_process.t_lc_prtcl_context_tasks_2 t
      ON a.country_cd=t.context_country_cd
      AND a.cluster_area_type=t.context_area_type
      AND a.cluster_type=t.cluster_type

      GROUP BY 1,2,3,4
;
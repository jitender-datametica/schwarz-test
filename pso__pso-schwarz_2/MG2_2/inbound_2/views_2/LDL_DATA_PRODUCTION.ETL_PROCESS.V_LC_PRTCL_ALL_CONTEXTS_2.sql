create or replace view LDL_DATA_PRODUCTION.ETL_PROCESS.V_LC_PRTCL_ALL_CONTEXTS_2(
	CONTEXT_AREA_TYPE,
	CONTEXT_AREA,
	CONTEXT_LOAD_ID,
	PROCESSCONTAINER,
	SUCCESS_STATE,
	CTX_HAS_STARTED_FG,
	UPDATED_TS
) as
      SELECT  a.cluster_area_type    AS context_area_type
      ,a.cluster_area_cd      AS context_area
      ,t.context_load_id      AS context_load_id
      ,t.processcontainer     AS processcontainer
      ,MAX(success_state)     AS success_state
      ,CASE WHEN MAX(success_state)='raw' THEN 0 ELSE 1 END AS ctx_has_started_fg
      ,MAX(updated_ts)        AS updated_ts
      FROM ETL_PROCESS.t_client_cluster_hierarchy_maindef_2 a
      INNER JOIN ETL_PROCESS.t_lc_prtcl_context_tasks_2 t
      ON a.country_cd=t.context_country_cd
      AND a.cluster_area_type=t.context_area_type
      AND a.cluster_type=t.cluster_type
      GROUP BY a.cluster_area_type,a.cluster_area_cd,t.context_load_id,t.processcontainer
;
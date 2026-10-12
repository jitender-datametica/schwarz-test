CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_cntl_ddl_result_tmp_2 AS SELECT sf_schema,
 name_schema,
 table_type,
 sf_name,
 sql_getddl,
 sql_describe,
 sql_drop,
 recnbr,
 owner,
 description,
 annotation,
 created_ts,
 sql_result,
 reject_fg,
 reject_reason_id,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id,
 ROW_NUMBER() OVER (PARTITION BY sf_schema, name_schema, table_type ORDER BY dwh_created_ts IS NULL DESC, dwh_created_ts
    DESC) AS `_rownumber`,
   ((DENSE_RANK() OVER (PARTITION BY sf_schema, name_schema, table_type ORDER BY dwh_created_ts IS NULL DESC,
        dwh_created_ts DESC)) - 1) * - 1 AS moving_run_id_from_current
FROM ldl_p_lew_mart_pit_onprem.t_cntl_dll_result_tmp_2 AS DLL
WHERE deleted_fg = 0
ORDER BY sf_schema NULLS LAST,
 name_schema NULLS LAST,
 table_type NULLS LAST;
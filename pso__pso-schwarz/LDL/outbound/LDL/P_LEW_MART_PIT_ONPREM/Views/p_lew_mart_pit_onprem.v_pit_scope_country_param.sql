CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_scope_country_param AS SELECT DISTINCT pa.client_id,
 pa.param_id,
 pa.dwh_valid_from,
 pa.dwh_valid_to,
 pa.version_nr,
 DPA.param_name,
 pa.param_value,
 DPA.param_descr,
 DPA.param_column_datatype,
 pa.param_value_char,
 pa.deleted_fg,
 pa.current_fg,
 pa.dwh_created,
 pa.dwh_updated
FROM (SELECT *
  FROM ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND deleted_fg = 0
  QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY CAST(client_id AS STRING), CAST(param_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS pa
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param_ref AS DPA ON pa.param_id = DPA.param_id;
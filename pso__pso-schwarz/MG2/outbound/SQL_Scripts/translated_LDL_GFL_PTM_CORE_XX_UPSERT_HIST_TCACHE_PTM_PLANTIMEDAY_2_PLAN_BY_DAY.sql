
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, real_estate_sid, int_org_sid, cal_dt, plan_pos_nr,
 planned_val_type_key_type_cd, planned_val_type_natural_key, planned_kpi_meas, int_org_type_cd)
WITH pre_calc AS (SELECT int_org_sid,
    cal_dt,
    store,
    extraction_date,
    CAST(turnover AS NUMERIC) AS sales_piece,
    CAST(plan_hours + training + inventory AS NUMERIC) AS total_hours,
    CAST(plan_hours AS NUMERIC) AS working_hours,
    CAST(training AS NUMERIC) AS training_hours,
    CAST(inventory AS NUMERIC) AS inventory_hours
   FROM etl.${t_src_input_table}), row_expl AS (SELECT *
   FROM pre_calc UNPIVOT EXCLUDE NULLS (kpi_meas FOR kpi_type IN (sales_piece AS 'sales_piece', total_hours AS
      'total_hours', working_hours AS 'working_hours', training_hours AS 'training_hours', inventory_hours AS
      'inventory_hours'))) (SELECT 'PTM' AS dwh_node_cd,
    0 AS tf_error_fg,
    '${LOAD_ID}' AS dwh_load_id,
    extraction_date AS extraction_dt,
    CAST(0 AS BOOL) AS deleted_fg,
    CAST(0 AS STRING) AS record_id,
    CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
    '${T_SRC_INPUT_TABLE}' AS filename,
    - 1 AS real_estate_sid,
    int_org_sid,
    cal_dt,
    CAST(store AS STRING) AS plan_pos_nr,
    'PEP2' AS planned_value_tye_key_type_cd,
    kpi_type AS planned_value_type_natural_key,
    kpi_meas AS planned_kpi_meas,
    'STORE' AS int_org_type_cd
   FROM row_expl
   WHERE kpi_meas <> 0);



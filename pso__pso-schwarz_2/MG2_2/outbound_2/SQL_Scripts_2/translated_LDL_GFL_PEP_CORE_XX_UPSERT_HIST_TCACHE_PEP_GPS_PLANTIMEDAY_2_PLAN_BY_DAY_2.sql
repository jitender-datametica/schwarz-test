
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, extraction_dt, dwh_mapping_tmsp, int_org_sid, int_org_type_cd, cal_dt, real_estate_sid,
 plan_pos_nr, planned_val_type_key_type_cd, planned_val_type_natural_key, planned_kpi_meas)
WITH pre_calc AS (SELECT int_org_sid,
    cal_dt,
    store,
    DATE(extraction_tmsp) AS extraction_dt,
    CAST(turnover AS NUMERIC) AS sales_piece,
    CAST(totalhours AS NUMERIC) AS total_hours,
    CAST(totalhours - (traininghours + mischours + inventoryhours) AS NUMERIC) AS working_hours,
    CAST(traininghours AS NUMERIC) AS training_hours,
    CAST(inventoryhours AS NUMERIC) AS inventory_hours,
    CAST(mischours AS NUMERIC) AS misc_hours
   FROM ldl_data_production_etl.t_tcache_pep_gps_plantimeday_2), row_expl AS (SELECT *
   FROM pre_calc UNPIVOT EXCLUDE NULLS (kpi_meas FOR kpi_type IN (sales_piece AS 'sales_piece', total_hours AS
      'total_hours', working_hours AS 'working_hours', training_hours AS 'training_hours', inventory_hours AS
      'inventory_hours', misc_hours AS 'misc_hours'))) (SELECT 'PEP 2.0' AS dwh_node_cd,
    0 AS tf_error_fg,
    '${LOAD_ID}' AS dwh_load_id,
    CAST(0 AS BOOL) AS deleted_fg,
    CAST(0 AS STRING) AS record_id,
    '${T_SRC_INPUT_TABLE}' AS filename,
    extraction_dt,
    CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
    int_org_sid,
    'STORE' AS int_org_type_cd,
    cal_dt,
    - 1 AS real_estate_sid,
    CAST(store AS STRING) AS plan_pos_nr,
    'PEP2' AS planned_value_tye_key_type_cd,
    kpi_type AS planned_value_type_natural_key,
    kpi_meas AS planned_kpi_meas
   FROM row_expl
   WHERE kpi_meas <> 0);
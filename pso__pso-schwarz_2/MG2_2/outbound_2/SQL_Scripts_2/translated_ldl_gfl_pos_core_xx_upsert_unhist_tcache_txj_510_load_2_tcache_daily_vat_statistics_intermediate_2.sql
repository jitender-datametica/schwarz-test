DELETE FROM ldl_data_production_$_2{target_db}.${tgt_target_table}
WHERE TRUE
;


INSERT INTO ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
        src_orig_store_nr,
        src_bic_zmlila,
        store_key_type_cd,
        country_org_key_type_cd,
        geo_area_key_type_cd,
        real_estate_key_type_cd,
        stat_dt,
        bus_dt,
        curr_stat_fg,
        tax_class_cd,
        vat_stat_calc_method_cd,
        turnover_gross_val,
        vat_val,
        source_system,
        extraction_dt,
        dwh_mapping_tmsp,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        dwh_node_cd,
        dwh_load_id
)
SELECT
    src.orig_store_nr,
    src.bic_zmlila,
    'STORE' AS store_key_type_cd,
    'COUNTRY_2' AS country_org_key_type_cd,
    'CTRY' AS geo_area_key_type_cd,
    'RE_2' AS real_estate_key_type_cd,
    src.extraction_date AS stat_dt,
    src.extraction_date AS bus_dt,
    'TRUE' AS curr_stat_fg,
    src.vat_cd,
    src.closure_cd AS vat_stat_calc_method_cd,
    src.vat_turnover AS turnover_gross_val,
    src.vat_value AS vat_val,
    'TXJ' AS source_system,
    src.extraction_date AS extraction_dt,
    CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'TXJ' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM
(
    SELECT
        bic_zmlila,
        wh_id,
        record_cd,
        orig_store_nr,
        extraction_date,
        closure_cd,
        period_cd,
        'A' AS vat_cd,
        vat_group_a_turnover_gross_val AS vat_turnover,
        vat_group_a_vat_val AS vat_value
    FROM ldl_data_production_$_2{temp_db}.t_${src_input_table}

    UNION ALL

    SELECT
        bic_zmlila,
        wh_id,
        record_cd,
        orig_store_nr,
        extraction_date,
        closure_cd,
        period_cd,
        'B' AS vat_cd,
        vat_group_b_turnover_gross_val AS vat_turnover,
        vat_group_b_vat_val AS vat_value
    FROM ldl_data_production_$_2{temp_db}.t_${src_input_table}

    UNION ALL

    SELECT
        bic_zmlila,
        wh_id,
        record_cd,
        orig_store_nr,
        extraction_date,
        closure_cd,
        period_cd,
        'C' AS vat_cd,
        vat_group_c_turnover_gross_val AS vat_turnover,
        vat_group_c_vat_val AS vat_value
    FROM ldl_data_production_$_2{temp_db}.t_${src_input_table}

    UNION ALL

    SELECT
        bic_zmlila,
        wh_id,
        record_cd,
        orig_store_nr,
        extraction_date,
        closure_cd,
        period_cd,
        'D' AS vat_cd,
        vat_group_d_turnover_gross_val AS vat_turnover,
        vat_group_d_vat_val AS vat_value
    FROM ldl_data_production_$_2{temp_db}.t_${src_input_table}

    UNION ALL

    SELECT
        bic_zmlila,
        wh_id,
        record_cd,
        orig_store_nr,
        extraction_date,
        closure_cd,
        period_cd,
        'E' AS vat_cd,
        vat_group_e_turnover_gross_val AS vat_turnover,
        vat_group_e_vat_val AS vat_value
    FROM ldl_data_production_$_2{temp_db}.t_${src_input_table}

    UNION ALL

    SELECT
        bic_zmlila,
        wh_id,
        record_cd,
        orig_store_nr,
        extraction_date,
        closure_cd,
        period_cd,
        'F' AS vat_cd,
        vat_group_f_turnover_gross_val AS vat_turnover,
        vat_group_f_vat_val AS vat_value
    FROM ldl_data_production_$_2{temp_db}.t_${src_input_table}

    UNION ALL

    SELECT
        bic_zmlila,
        wh_id,
        record_cd,
        orig_store_nr,
        extraction_date,
        closure_cd,
        period_cd,
        'G' AS vat_cd,
        vat_group_g_turnover_gross_val AS vat_turnover,
        vat_group_g_vat_val AS vat_value
    FROM ldl_data_production_$_2{temp_db}.t_${src_input_table}

    UNION ALL

    SELECT
        bic_zmlila,
        wh_id,
        record_cd,
        orig_store_nr,
        extraction_date,
        closure_cd,
        period_cd,
        'H' AS vat_cd,
        vat_group_h_turnover_gross_val AS vat_turnover,
        vat_group_h_vat_val AS vat_value
    FROM ldl_data_production_$_2{temp_db}.t_${src_input_table}

    UNION ALL

    SELECT
        bic_zmlila,
        wh_id,
        record_cd,
        orig_store_nr,
        extraction_date,
        closure_cd,
        period_cd,
        'I' AS vat_cd,
        vat_group_i_turnover_gross_val AS vat_turnover,
        vat_group_i_vat_val AS vat_value
    FROM ldl_data_production_$_2{temp_db}.t_${src_input_table}
    WHERE
        period_cd = 'T'
        AND (
            vat_group_i_turnover_gross_val IS NOT NULL
            OR vat_group_i_vat_val IS NOT NULL
        )
) AS src
;

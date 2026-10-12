DELETE FROM ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
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
    'STORE',
    'COUNTRY_1',
    'CTRY',
    'RE_1',
    src.extraction_date,
    src.extraction_date,
    'TRUE',
    src.vat_cd,
    src.closure_cd,
    src.vat_turnover,
    src.vat_value,
    'TXJ',
    src.extraction_date,
    current_timestamp as dwh_mapping_tmsp,
    0 as tf_error_fg,
    0 as deleted_fg,
    0 as record_id,
    't_${SRC_INPUT_TABLE}' as filename,
    'TXJ' as dwh_node_cd,
    '${LOAD_ID}' as DWH_LOAD_ID 

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
            'A' as vat_cd,
            vat_group_a_turnover_gross_val as vat_turnover,
            vat_group_a_vat_val as vat_value
        from
            ${TEMP_DB}.t_${SRC_INPUT_TABLE}
        UNION ALL
        SELECT
            bic_zmlila,
            wh_id,
            record_cd,
            orig_store_nr,
            extraction_date,
            closure_cd,
            period_cd,
            'B' as vat_cd,
            vat_group_b_turnover_gross_val as vat_turnover,
            vat_group_b_vat_val as vat_value
        from
            ${TEMP_DB}.t_${SRC_INPUT_TABLE}
        UNION ALL
        SELECT
            bic_zmlila,
            wh_id,
            record_cd,
            orig_store_nr,
            extraction_date,
            closure_cd,
            period_cd,
            'C' as vat_cd,
            vat_group_c_turnover_gross_val as vat_turnover,
            vat_group_c_vat_val as vat_value
        from
            ${TEMP_DB}.t_${SRC_INPUT_TABLE}
        UNION ALL
        SELECT
            bic_zmlila,
            wh_id,
            record_cd,
            orig_store_nr,
            extraction_date,
            closure_cd,
            period_cd,
            'D' as vat_cd,
            vat_group_d_turnover_gross_val as vat_turnover,
            vat_group_d_vat_val as vat_value
        from
            ${TEMP_DB}.t_${SRC_INPUT_TABLE}
        UNION ALL
        SELECT
            bic_zmlila,
            wh_id,
            record_cd,
            orig_store_nr,
            extraction_date,
            closure_cd,
            period_cd,
            'E' as vat_cd,
            vat_group_e_turnover_gross_val as vat_turnover,
            vat_group_e_vat_val as vat_value
        from
            ${TEMP_DB}.t_${SRC_INPUT_TABLE}
        UNION ALL
        SELECT
            bic_zmlila,
            wh_id,
            record_cd,
            orig_store_nr,
            extraction_date,
            closure_cd,
            period_cd,
            'F' as vat_cd,
            vat_group_f_turnover_gross_val as vat_turnover,
            vat_group_f_vat_val as vat_value
        from
            ${TEMP_DB}.t_${SRC_INPUT_TABLE}
        UNION ALL
        SELECT
            bic_zmlila,
            wh_id,
            record_cd,
            orig_store_nr,
            extraction_date,
            closure_cd,
            period_cd,
            'G' as vat_cd,
            vat_group_g_turnover_gross_val as vat_turnover,
            vat_group_g_vat_val as vat_value
        from
            ${TEMP_DB}.t_${SRC_INPUT_TABLE}
        UNION ALL
        SELECT
            bic_zmlila,
            wh_id,
            record_cd,
            orig_store_nr,
            extraction_date,
            closure_cd,
            period_cd,
            'H' as vat_cd,
            vat_group_h_turnover_gross_val as vat_turnover,
            vat_group_h_vat_val as vat_value
        from
            ${TEMP_DB}.t_${SRC_INPUT_TABLE}
        UNION ALL
        SELECT
            bic_zmlila,
            wh_id,
            record_cd,
            orig_store_nr,
            extraction_date,
            closure_cd,
            period_cd,
            'I' as vat_cd,
            vat_group_i_turnover_gross_val as vat_turnover,
            vat_group_i_vat_val as vat_value
        from
            ${TEMP_DB}.t_${SRC_INPUT_TABLE}
        WHERE
            period_cd = 'T'
            AND (
                vat_turnover IS NOT NULL
                OR vat_value IS NOT NULL
            )
    ) src;

   

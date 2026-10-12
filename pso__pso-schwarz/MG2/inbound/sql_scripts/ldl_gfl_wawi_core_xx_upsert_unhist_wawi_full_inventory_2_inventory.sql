INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        inv_sid,
        inv_dt,
        inv_type_cd,
        inv_nr,
        int_org_sid,
        int_org_type_cd,
        country_org_sid,
        country_org_cd,
        inv_period_start_dt,
        inv_period_end_dt,
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
        inv_sid,
        c180_inventorydate as inv_dt,
        'FULL' as inv_type_cd,
        c180_id AS inv_nr,
        int_org_sid,
        'STORE' as int_org_type_cd,
        country_org_sid,
        ctrcode as country_org_cd,
        c182_datefrom as inv_period_start_dt,
        c182_dateuntil as inv_period_end_dt,
        'WAWI_WH' as source_system,
        current_date as extraction_dt,
        current_timestamp as dwh_mapping_tmsp,
        0 as tf_error_fg,
        0 as deleted_fg,
        0 as record_id,
        't_${SRC_INPUT_TABLE}' as filename,
        'WAWI_WH' as dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} inv
;

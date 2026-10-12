INSERT INTO  ETL.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        int_org_key_type_cd,
        int_org_nk,
        int_org_real_estate_usg_type_cd,
        real_estate_key_type_cd,
        real_estate_nk,
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
        'COMPANY' AS int_org_key_type_cd,
        substr(comp_src.igl_associationnumber, 1,2)||'|'||to_number(regexp_replace(comp_src.igl_associationnumber, '[^0-9]', '')) AS int_org_nk,
        'MANAGED_BY' AS int_org_real_estate_usg_type_cd,
        'RE_1' AS real_estate_key_type_cd,
         LOWER(SUBSTR(igl_number, 1, 2)) ||'|'||TO_NUMBER(SUBSTR(igl_number,3,5))  AS real_estate_nk,
        'LISY' AS source_system,
        CURRENT_DATE AS extraction_dt,
        NVL(LEAST_IGNORE_NULLS(igl_contractdate, igl_precontractdate), bld_src.sinkmodifiedon) AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_tcache_lisy_cds_account_snap_1' AS filename,
        'LISY' AS dwh_node_cd,
         '${LOAD_ID}' AS dwh_load_id 
FROM etl_process.T_${SRC_INPUT_TABLE} bld_src
JOIN meta.t_resource_item_key_1 bld_key
				ON bld_key.resource_item_nat_key_nr = UPPER(substr(bld_src.igl_number, 1, 2)) ||'|'|| to_number(substr(bld_src.igl_number,3,5))
				AND bld_key.resource_item_key_type_cd = 'RE_1'
JOIN etl_process.t_tcache_lisy_cds_company_snap_1 comp_src ON comp_src.id = bld_src.igl_expassocid
;

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        prod_nat_key_nr,
        prod_key_type_cd,
        int_org_key_type_cd,	
        party_nat_key_nr,

        prod_status_categ_cd,
	    prod_status_type_cd,	
        -- FRAMEWORK AND TECHNICAL COLUMNS
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
        ltrim(ctrcode,'0') || '|' || itemno AS prod_nat_key_nr,
        'WAWI' AS prod_key_type_cd,
        'COMPANY' AS int_org_key_type_cd,	
        ctrcode || '|' || warehouseno AS party_nat_key_nr,

        'WAWI_PROD_LIFECYCLE' AS prod_status_categ_cd,
	    status AS prod_status_type_cd,
        
        'WAWI' AS source_system,
        CURRENT_DATE AS extraction_dt,
        CURRENT_TIMESTAMP AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'WH_WAWIADM' AS dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id
  FROM
    ( SELECT  DISTINCT
            ctrcode,
            itemno,
            warehouseno,
            status,
      FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}
    ) AS src
;

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
    int_org_key_type_cd,	
    party_nat_key_nr,
    price_grp_key_type_cd,	
    price_grp_nat_key_nr,
    
    int_org_type_cd,
    price_grp_prio,
     
    dwh_ending_tmsp,  
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
SELECT DISTINCT
    'STORE' AS int_org_key_type_cd,
    ctrcode || '|' ||  CAST(C200_STORENR AS INTEGER) AS party_nat_key_nr,
    'WAWI' AS price_grp_key_type_cd,
    ctrcode || '|' ||  CAST(c200_groupnr AS INTEGER) AS price_grp_nat_key_nr, 

    'STORE' AS int_org_type_cd,
    c200_priority AS price_grp_prio,

    c200_dateto AS dwh_ending_tmsp,
    'WAWI' AS source_system,
    DATE_TRUNC('day',extraction_tmsp) AS extraction_dt,
    c200_datefrom AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'WAWI' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id 
FROM etl.t_wawi_precore_t200_pricegroup_2 pg
WHERE c200_lastedited >= '${SRC_START_DATE}'
QUALIFY ROW_NUMBER() OVER (PARTITION BY price_grp_nat_key_nr, dwh_mapping_tmsp ORDER BY dwh_ending_tmsp DESC) = 1
;

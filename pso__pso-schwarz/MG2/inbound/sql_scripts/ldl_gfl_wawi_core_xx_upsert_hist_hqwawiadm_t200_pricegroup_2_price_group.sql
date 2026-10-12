INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
    country_org_key_type_cd,	
    party_nat_key_nr,
    price_grp_key_type_cd,	
    price_grp_nat_key_nr,

	price_grp_nr,
	price_grp_name,
     
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
    'COUNTRY' AS country_org_key_type_cd,
    LEFT(wawi_instanz_kzl,2) AS party_nat_key_nr,
    'WAWI' AS price_grp_key_type_cd,
    wawi_instanz_kzl || '|' ||  CAST(c200_groupnr AS INTEGER) AS price_grp_nat_key_nr, 

    c200_groupnr AS price_grp_nr,
    c200_groupdesc AS price_grp_name,

    c200_dateto AS dwh_ending_tmsp,
    'WAWI' AS source_system,
    DATE_TRUNC('day',extraction_tmsp) AS extraction_dt,
    c200_dateFROM AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'WAWI' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id 
FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t200_pricegroup pg
WHERE c200_lastedited >= '${SRC_START_DATE}' AND delete_fg IS NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY price_grp_nat_key_nr, dwh_mapping_tmsp ORDER BY dwh_ending_tmsp DESC) = 1
;

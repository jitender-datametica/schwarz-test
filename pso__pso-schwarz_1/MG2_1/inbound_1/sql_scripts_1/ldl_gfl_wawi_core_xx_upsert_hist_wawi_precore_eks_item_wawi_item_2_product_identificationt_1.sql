
INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(       prod_key_type_cd,
        int_org_key_type_cd,
        prod_nr,
        ctrcode,
        prod_ident_type_cd,
        prod_ident_nr,
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
SELECT DISTINCT
       'EKS' AS prod_key_type_cd,        
       'COUNTRY_1' AS int_org_key_type_cd,
       prod_num prod_nr,
       CASE 
         WHEN ctrcode ='CS' THEN 'ES'    
         ELSE ctrcode
       END ctrcode,
       'WAWI' prod_ident_type_cd,
       itemno_wawi prod_ident_nr,
    -- FRAMEWORK AND TECHNICAL COLUMNS
       'WAWI' AS source_system,
       CURRENT_DATE AS extraction_dt,
       CURRENT_DATE AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       '${SRC_INPUT_TABLE}' AS filename,
       'WAWI_HQ' AS dwh_node_cd,
       '${LOAD_ID}' as dwh_load_id
FROM etl.t_wawi_precore_eks_item_wawi_item_1 pr;

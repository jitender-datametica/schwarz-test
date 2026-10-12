INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        INV_KEY_TYPE_CD
       ,INV_NATURAL_KEY
       ,INV_STATUS_TYPE_CD
       ,SOURCE_SYSTEM
       ,EXTRACTION_DT
       ,DWH_MAPPING_TMSP
       ,TF_ERROR_FG
       ,DELETED_FG
       ,RECORD_ID
       ,FILENAME
       ,DWH_NODE_CD
       ,DWH_LOAD_ID
)
SELECT  
       'PART' AS INV_KEY_TYPE_CD,
        o.country_org_cd || '|' || src.WH_NR || '|' || C438_INV_ID  AS INV_NATURAL_KEY,
        CASE WHEN C438_STATUS=10 THEN -10
             WHEN C438_STATUS=20 THEN -20
             WHEN C438_STATUS=99 THEN -99
        ELSE C438_STATUS END inv_status_type_cd,
        'WAWI_WH' AS SOURCE_SYSTEM,
        EXTRACTION_TMSP AS EXTRACTION_DT,
        CURRENT_TIMESTAMP() AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        '${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_WH' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
   FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src
   JOIN etl_process.t_wawi_extract_control co 
     ON co.schema_name=UPPER('whwawistd') AND co.table_name=UPPER('t438_part_inv_head') 
   JOIN etl_process.t_wawi_extract_control_status st 
     ON st.schema_name=UPPER('whwawistd') AND st.table_name=UPPER('t438_part_inv_head') AND ai_graph_name='${AI_GRAPH_NAME}'
     AND src.wawi_instanz_kzl=st.wawi_instanz_kzl AND src.wh_nr=st.wh_nr and src.scn>=IFF(co.delta_fg,st.last_scn,0) 
   JOIN meta.t_party_key k ON LEFT(src.wawi_instanz_kzl,2)=k.party_nat_key_nr 
                           AND k.dwh_valid_fg 
                           AND k.party_key_type_cd='COUNTRY'
   JOIN core_rel.t_internal_organization  o ON k.party_sid=o.int_org_sid AND o.dwh_valid_fg
   WHERE delete_fg IS NULL
   QUALIFY row_number() OVER (PARTITION BY src.wawi_instanz_kzl,src.wh_nr,c438_inv_id ORDER BY extraction_tmsp DESC ) = 1 
;

/* All SIDs are generated in the previous process.
   Use the allocated to access the internal organisation table to enrich
   country_org_cd and curr_cd
*/

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        STORE_SID,
        COUNTRY_ORG_SID,
        COUNTRY_ORG_CD,
        STAT_DT,
        BUS_DT,
        REAL_ESTATE_SID,
        CURR_STAT_FG,
        GEO_AREA_SID,
        TAX_CLASS_CD,
        VAT_STAT_CALC_METHOD_CD,
        TURNOVER_GROSS_VAL,
        VAT_VAL,
        CURR_CD,
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
)
SELECT
        SRC.STORE_SID,
        SRC.COUNTRY_ORG_SID,
        COALESCE(ORG.COUNTRY_ORG_CD, '-1'),
        SRC.STAT_DT,
        SRC.BUS_DT,
        SRC.REAL_ESTATE_SID,
        SRC.CURR_STAT_FG,
        SRC.GEO_AREA_SID,
        SRC.TAX_CLASS_CD,
        SRC.VAT_STAT_CALC_METHOD_CD,
        SRC.TURNOVER_GROSS_VAL,
        SRC.VAT_VAL,
        COALESCE(ORG.CURR_CD, '-1'),
        'TXJ',
        CURRENT_DATE,
        current_timestamp AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'TXJ' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
LEFT OUTER JOIN ${TARGET_DB}.T_INTERNAL_ORGANIZATION ORG
ON  SRC.COUNTRY_ORG_SID = ORG.INT_ORG_SID
AND SRC.BUS_DT BETWEEN ORG.DWH_VALID_FROM_TMSP AND ORG.DWH_VALID_TO_TMSP;
    

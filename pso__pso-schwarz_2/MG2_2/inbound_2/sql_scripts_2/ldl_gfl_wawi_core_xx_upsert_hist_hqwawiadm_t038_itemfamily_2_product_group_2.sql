INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_GRP_KEY_TYPE_CD,
        PROD_GRP_KEY_NR,
        PROD_GRP_TYPE_CD,
        PROD_GRP_NR,
        PROD_GRP_NAME,
        -- FRAMEWORK AND TECHNICAL COLUMNS
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
SELECT DISTINCT
        'IFG' as PROD_GRP_KEY_TYPE_CD,
        src.c038_ITEMGRPNR || '|' || src.c038_FAMILY_CODE AS PROD_GRP_KEY_NR,
        'IFG' as PROD_GRP_TYPE_CD,
        src.c038_ITEMGRPNR || '.' || LPAD(src.c038_FAMILY_CODE, 3, '0') AS PROD_GRP_NR,
        src.c038_DESC_LONG AS PROD_GRP_NAME,
        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        src.c038_MOD_DATE AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_hqwawiadm.t038_itemfamily_2' AS FILENAME,
        'WAWI_HQ' AS DWH_NODE_CD,
        '726028' as DWH_LOAD_ID
 FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} SRC
 INNER JOIN ( SELECT wawi_instanz_kzl
                    , Rank() OVER (ORDER BY CASE WHEN wawi_instanz_kzl = 'DE' THEN 1
                                                 WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR') THEN 2
                                                 WHEN wawi_instanz_kzl = 'GR' THEN 3
                                                 WHEN wawi_instanz_kzl IN ('BG', 'CY') THEN 4
                                             END, wawi_instanz_kzl) AS eks_rank
                FROM ( SELECT DISTINCT wawi_instanz_kzl
                         FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} 
                       WHERE delete_fg IS NULL) AS a
            ) AS csrc
        ON  src.wawi_instanz_kzl = csrc.wawi_instanz_kzl
 WHERE src.delete_fg IS NULL
 QUALIFY csrc.eks_rank = Min(csrc.eks_rank) OVER (PARTITION BY src.c038_ITEMGRPNR || '.' || LPAD(src.c038_FAMILY_CODE, 3, '0'))
    AND Row_Number() OVER (PARTITION BY src.c038_ITEMGRPNR || '.' || LPAD(src.c038_FAMILY_CODE, 3, '0'), src.wawi_instanz_kzl ORDER BY src.EXTRACTION_TMSP DESC) = 1
;

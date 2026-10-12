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
        'SIG' as PROD_GRP_KEY_TYPE_CD,
        src.c041_ITEMGRPNR AS PROD_GRP_KEY_NR,
        'SIG' as PROD_GRP_TYPE_CD,
        src.c041_ITEMGRPNR AS PROD_GRP_NR,
        src.c041_DESC AS PROD_GRP_NAME,
        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        src.c041_MODDATE AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_HQ' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID
  FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src 
  INNER JOIN ( SELECT LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
                    , Rank() OVER (ORDER BY CASE WHEN wawi_instanz_kzl = 'DE' THEN 1
                                                 WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR') THEN 2
                                                 WHEN wawi_instanz_kzl = 'GR' THEN 3
                                                 WHEN wawi_instanz_kzl IN ('BG', 'CY') THEN 4
                                             END, wawi_instanz_kzl) AS eks_rank
                FROM ( SELECT DISTINCT LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
                       FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src 
                       WHERE delete_fg IS NULL) AS a
            ) AS csrc
        ON  src.wawi_instanz_kzl = csrc.wawi_instanz_kzl
    WHERE src.delete_fg IS NULL
    QUALIFY csrc.eks_rank = Min(csrc.eks_rank) OVER (PARTITION BY src.c041_ITEMGRPNR)
    AND Row_Number() OVER (PARTITION BY src.c041_ITEMGRPNR, src.wawi_instanz_kzl ORDER BY src.EXTRACTION_TMSP DESC) = 1
;

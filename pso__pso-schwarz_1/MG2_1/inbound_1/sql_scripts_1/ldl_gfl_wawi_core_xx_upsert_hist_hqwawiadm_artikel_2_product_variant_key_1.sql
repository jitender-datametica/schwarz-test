INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_VARIANT_SID,
        PROD_VARIANT_KEY_TYPE_CD,
        PROD_VARIANT_NAT_KEY_NR,

        SOURCE_SYSTEM,
        DWH_MAPPING_TMSP,
        EXTRACTION_DT,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
)
/* EKS LOG */
WITH t026 AS
(
  SELECT * FROM  ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item_1
  WHERE delete_fg IS NULL
  QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1
)
SELECT DISTINCT
        VKEY.PROD_VARIANT_SID AS PROD_VARIANT_SID,
        'LOG' AS PROD_VARIANT_KEY_TYPE_CD,
        UPPER(LEFT(wawi_instanz_kzl,2) || '|' || WAWI_ITEMNR) AS PROD_VARIANT_NAT_KEY_NR,
        'EKS' AS SOURCE_SYSTEM,
        CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP,        
        SRC.EXTRACTION_TMSP AS EXTRACTION_DT,        
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_HQ' AS DWH_NODE_CD,
        '${LOAD_ID}' AS DWH_LOAD_ID
FROM 
(
        SELECT
            ART.wawi_instanz_kzl
          , TRY_CAST(ART.ARTNRVIER AS NUMBER) AS WAWI_ITEMNR
          , TRY_CAST(RIGHT(ART.ARTIKELNR, 4) AS NUMBER) AS WAWI_CASESIZE
          , SK.ITEMNO_SK
          , EKSW.PROD_NUM
          , COALESCE(SK.ITEMNO_SK, EKSW.PROD_NUM) AS PVAR_NAT_KEY
          , CASE WHEN SK.ITEMNO_SK IS NOT NULL THEN 'EKS_LOG'
                 ELSE 'EKS_LOG_UNK'
            END AS PVAR_KEY_TYPE_CD,
          ART.EXTRACTION_TMSP
        FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_1 AS ART_1
        INNER JOIN etl.t_tcache_eks_item_wawi_item_1 AS EKSW
                ON  EKSW.wawi_instanz_kzl     = ART.wawi_instanz_kzl
                AND EKSW.ITEMNO_WAWI = TRY_CAST(ART.ARTNRVIER AS NUMBER)
        LEFT OUTER JOIN
        (
            SELECT DISTINCT ITEMNO_SK
            FROM etl.t_tcache_eks_hierarchy_1
        ) AS SK
        ON  EKSW.ITEMNO = SK.ITEMNO_SK
        LEFT OUTER JOIN t026 AS WI
                ON  SK.ITEMNO_SK = WI.ITEMNO
        WHERE art.delete_fg IS NULL
        QUALIFY ROW_NUMBER() OVER (PARTITION BY LEFT(ART.wawi_instanz_kzl,2), 
                                                WAWI_ITEMNR
                                       ORDER BY WI.SEQID DESC NULLS LAST
                                              , SK.ITEMNO_SK ASC NULLS LAST) = 1
) AS SRC
INNER JOIN META.T_PRODUCT_VARIANT_KEY_1 VKEY /* !!!WITHOUT NEGATIVE-KEY-CAPTURE!!!
                                              KEY MUST ALREADY EXIST AFTER THE T_PRODUCT_VARIANT_1 (FV_SLS_UNK) JOB. */
         ON VKEY.PROD_VARIANT_NAT_KEY_NR = CAST( SRC.PVAR_NAT_KEY AS VARCHAR(200))
        AND VKEY.DWH_VALID_FG = TRUE
        AND VKEY.PROD_VARIANT_KEY_TYPE_CD = SRC.PVAR_KEY_TYPE_CD
;

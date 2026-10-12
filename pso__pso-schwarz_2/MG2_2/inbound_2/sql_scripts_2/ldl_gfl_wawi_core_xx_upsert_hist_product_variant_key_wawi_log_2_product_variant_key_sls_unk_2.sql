INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
 (
        PROD_VARIANT_SID,
        PROD_VARIANT_KEY_TYPE_CD,
        PROD_VARIANT_NAT_KEY_NR,
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
/* WAW LOG */
SELECT	DISTINCT
        KY.PROD_VARIANT_SID,
        'LOG' AS PROD_VARIANT_NAT_KEY_NR,
        UPPER(LEFT(ART.wawi_instanz_kzl,2)) || '|' || ART.ITEMNR,

        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_TIMESTAMP AS EXTRACTION_DT,
        CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP,
        0 TF_ERROR_FG,
        0 DELETED_FG,
        0 RECORD_ID,
        't_${SRC_INPUT_TABLE}' FILENAME,
        'WAWI_HQ' DWH_NODE_CD,
        '${LOAD_ID}' DWH_LOAD_ID 
FROM
        (
                SELECT *
                , CAST(AR.ARTNRVIER AS NUMBER) AS ITEMNR
                , CAST(RIGHT(AR.ARTIKELNR, 4) AS NUMBER) AS CASE_SIZE
                FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_2  AR
                WHERE delete_fg IS NULL
        ) AS ART_2
LEFT OUTER JOIN
        (
                SELECT DISTINCT
                ITM.wawi_instanz_kzl
              , CAST(SUBSTRING(C215_ITEMNR, 1, LENGTH(C215_ITEMNR)-4) AS NUMBER) AS ITEMNR
              , CAST(C215_INT_ITEMNR AS NUMBER) AS C215_INT_ITEMNR
                FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr_2 ITM
                WHERE delete_fg IS NULL
        ) AS II
        ON  ART.wawi_instanz_kzl = II.wawi_instanz_kzl
        AND ART.ITEMNR = II.ITEMNR
LEFT OUTER JOIN META.T_PRODUCT_KEY_2 AS IPK
        ON  CAST(II.C215_INT_ITEMNR AS STRING) = IPK.PROD_NAT_KEY_NR
        AND IPK.PROD_KEY_TYPE_CD IN ('CBX', 'FV')
        AND IPK.DWH_VALID_FG
LEFT OUTER JOIN
        (
                SELECT DISTINCT ITEMNO
                FROM etl.t_tcache_eks_item_wawi_item_2
        ) AS EKS
        ON  II.C215_INT_ITEMNR = EKS.ITEMNO
INNER JOIN META.T_PRODUCT_VARIANT_KEY_2 AS  KY
           ON KY.PROD_VARIANT_KEY_TYPE_CD = 'WAW_LOG'
          AND KY.PROD_VARIANT_NAT_KEY_NR = UPPER( LEFT(ART.wawi_instanz_kzl,2) || '|' || ART.ITEMNR)
          AND KY.DWH_VALID_FG
WHERE
(
        II.ITEMNR IS NULL /* NO LINK TO INTERNATIONAL ITEM_2 NUMBER */
        OR
        (
            IPK.PROD_SID IS NULL /* INTERNATIONAL NUMBER NOT FOUND IN INTERNATIONAL KEYS */
        AND EKS.ITEMNO IS NULL
        )
)
QUALIFY ROW_NUMBER() OVER (PARTITION BY ART.wawi_instanz_kzl, ART.ITEMNR
                               ORDER BY ART.CASE_SIZE DESC NULLS LAST) = 1
;

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
 (
        PROD_NAT_KEY_NR,    
        PROD_KEY_TYPE_CD,  
        PROD_VARIANT_KEY_TYPE_CD,  
        PROD_VARIANT_NR,
        INT_ORG_KEY_TYPE_CD,	
        PARTY_NAT_KEY_NR,

        PROD_VARIANT_NAT_KEY_NR,
        LOCAL_PROD_VARIANT_NR,
        LOCAL_PROD_VARIANT_NAME,

        SOURCE_SYSTEM, 
        EXTRACTION_DT, 
        DWH_MAPPING_TMSP,  
        TF_ERROR_FG, 
        DELETED_FG, 
        RECORD_ID, 
        FILENAME,
        DWH_NODE_CD, 
        DWH_LOAD_ID)
SELECT
        LEFT(wawi_instanz_kzl,2) || '|' || LTRIM(ITEMNR,'0') PROD_NAT_KEY_NR,
        'WAWI' PROD_KEY_TYPE_CD, 
        'WAW_LOG' PROD_VARIANT_KEY_TYPE_CD, 
        LEFT(wawi_instanz_kzl,2) || '|' || ITEMNR || '|' || CASE_SIZE PROD_VARIANT_NR,
        'COUNTRY' PARTY_KEY_TYPE_CD,	
        LEFT(wawi_instanz_kzl,2) PARTY_NAT_KEY_NR,

        LEFT(wawi_instanz_kzl,2) || '|' || ITEMNR || '|' || CASE_SIZE PROD_VARIANT_NAT_KEY_NR,
        ITEMNR LOCAL_PROD_VARIANT_NR,
        COALESCE(BEZ_LANG, DEUTSCHTEXT) LOCAL_PROD_VARIANT_NAME,

        'WAWI' SOURCE_SYSTEM,
        EXTRACTION_TMSP EXTRACTION_DT,
        EXTRACTION_TMSP DWH_MAPPING_TMSP,
        0 TF_ERROR_FG,
        0 DELETED_FG,
        0 RECORD_ID,
        't_${SRC_INPUT_TABLE}' FILENAME,
        'WAWI_HQ' DWH_NODE_CD,
        '${LOAD_ID}' DWH_LOAD_ID 
FROM
(  
-- EXTRACTION/FILTER LOGIC FOR EACH INDIVIDUAL WAWI HQ DB:
SELECT
          ART.wawi_instanz_kzl
        , ART.ITEMNR
        , ART.CASE_SIZE
        , ART.ARTIKELNR
        , ART.EXTRACTION_TMSP
        , ART.BEZ_LANG
        , ART.DEUTSCHTEXT
FROM
        (
            SELECT
                wawi_instanz_kzl
              , CAST(ARTNRVIER AS NUMBER) AS ITEMNR
              , CAST(RIGHT(ARTIKELNR, 4) AS NUMBER) AS CASE_SIZE
              , ARTIKELNR
              , BEZ_LANG
              , DEUTSCHTEXT
              , EXTRACTION_TMSP
             FROM              
              (SELECT src.* FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src
               WHERE src.delete_fg IS NULL )
        ) AS ART
LEFT OUTER JOIN
        (
            SELECT DISTINCT
                wawi_instanz_kzl
              , CAST(SUBSTRING(C215_ITEMNR, 1, LENGTH(C215_ITEMNR)-4) AS NUMBER) AS ITEMNR
              , CAST(C215_INT_ITEMNR AS NUMBER) AS INT_ITEMNR
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr WHERE delete_fg IS NULL
        ) AS II
        ON  ART.wawi_instanz_kzl = II.wawi_instanz_kzl
        AND ART.ITEMNR = II.ITEMNR
LEFT OUTER JOIN META.T_PRODUCT_KEY AS IPK
        ON  CAST(II.INT_ITEMNR AS STRING) = IPK.PROD_NAT_KEY_NR
        AND IPK.PROD_KEY_TYPE_CD IN ('CBX', 'FV')
        AND IPK.DWH_VALID_FG
LEFT OUTER JOIN
        (
            SELECT DISTINCT
                ITEMNO
            FROM ETL.t_tcache_eks_item_wawi_item
        ) AS EKS
                ON  II.INT_ITEMNR = EKS.ITEMNO
WHERE
(
    II.ITEMNR IS NULL /* NO LINK TO INTERNATIONAL ITEM NUMBER */
    OR
    (
            IPK.PROD_SID IS NULL /* INTERNATIONAL NUMBER NOT FOUND IN INTERNATIONAL KEYS */
        AND EKS.ITEMNO IS NULL
    )
)
QUALIFY ROW_NUMBER() OVER (PARTITION BY ART.wawi_instanz_kzl, 
                                        ART.ITEMNR
                               ORDER BY ART.CASE_SIZE  
                               DESC NULLS LAST) = 1
);

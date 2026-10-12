INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
 (
        PROD_NAT_KEY_NR,    
        PROD_KEY_TYPE_CD,  
        PROD_VARIANT_KEY_TYPE_CD,  
        PROD_VARIANT_NAT_KEY_NR,
        PROD_VARIANT_NR,
        GTIN,
        PROD_VARIANT_NAME,
        PROD_VARIANT_TYPE_CD,
        WEIGHT_BASED_FG,
        LOGISTIC_VARIANT_TYPE_CD,
        CASE_SIZE_CNT,

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
        ART.wawi_instanz_kzl || '|' || LTRIM(ART.ITEMNR,'0') PROD_NAT_KEY_NR,
        'WAWI' PROD_KEY_TYPE_CD, 
        'WAW_LOG' PROD_VARIANT_KEY_TYPE_CD, 
        ART.wawi_instanz_kzl || '|' || CAST (ART.ITEMNR AS STRING) PROD_VARIANT_NAT_KEY_NR,
        ART.wawi_instanz_kzl || '|' || CAST (ART.ITEMNR AS STRING) PROD_VARIANT_NR,
        NULL GTIN,
        ART.DEUTSCHTEXT PROD_VARIANT_NAME,
        'LOGISTIC' PROD_VARIANT_TYPE_CD,
        CASE 
        WHEN  COALESCE(GEWICHTSARTIKEL,0) = 1 THEN TRUE 
        ELSE FALSE 
        END	WEIGHT_BASED_FG,
        NULL LOGISTIC_VARIANT_TYPE_CD,
        NULL CASE_SIZE_CNT,
        'WAWI' SOURCE_SYSTEM,
        ART.EXTRACTION_TMSP EXTRACTION_DT,
        ART.EXTRACTION_TMSP DWH_MAPPING_TMSP,
        0 TF_ERROR_FG,
        0 DELETED_FG,
        0 RECORD_ID,
        't_${SRC_INPUT_TABLE}' FILENAME,
        'WAWI_HQ' DWH_NODE_CD,
        '${LOAD_ID}' DWH_LOAD_ID 
FROM
  (  
        SELECT
            LEFT(ART.wawi_instanz_kzl,2) AS wawi_instanz_kzl
          , ART.ITEMNR
          , ART.CASE_SIZE
          , ART.EXTRACTION_TMSP
          , ART.DEUTSCHTEXT
          , ITMO.GEWICHTSARTIKEL  --WEIGHT_BASED_FG --
          , ART.ARTGRUPNR
        FROM
        (
            SELECT *
              , CAST(ARTNRVIER AS NUMBER) AS ITEMNR
              , CAST(RIGHT(ARTIKELNR, 4) AS NUMBER) AS CASE_SIZE
            FROM  
              (
               SELECT src.* FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src
               WHERE src.delete_fg IS NULL 
              )
        ) AS ART

        LEFT OUTER JOIN
        (
            SELECT DISTINCT
                wawi_instanz_kzl
              , CAST(SUBSTRING(C215_ITEMNR, 1, LENGTH(C215_ITEMNR)-4) AS NUMBER) AS ITEMNR
              , CAST(C215_INT_ITEMNR AS NUMBER) AS C215_INT_ITEMNR
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr WHERE delete_fg IS NULL
        ) AS II
                ON  ART.wawi_instanz_kzl = II.wawi_instanz_kzl
                AND ART.ITEMNR = II.ITEMNR
        LEFT OUTER JOIN META.T_PRODUCT_KEY AS IPK
                ON  CAST(II.C215_INT_ITEMNR AS STRING) = IPK.PROD_NAT_KEY_NR
                AND IPK.PROD_KEY_TYPE_CD IN ('CBX', 'FV')
                AND IPK.DWH_VALID_FG
        LEFT OUTER JOIN
        (
            SELECT DISTINCT ITEMNO
            FROM ETL.t_tcache_eks_item_wawi_item
        ) AS EKS
                ON  II.C215_INT_ITEMNR = EKS.ITEMNO
        LEFT OUTER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t271_packagetype AS PT
                ON  ART.wawi_instanz_kzl = PT.wawi_instanz_kzl
                AND ART.PACKUNG = PT.C271_PACKDESCRIPT
                AND pt.delete_fg IS NULL 

        INNER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikelbestell AS ITMO
                ON  ART.wawi_instanz_kzl = ITMO.wawi_instanz_kzl
                AND ART.ARTIKELNR = ITMO.ARTIKELNR
                AND ITMO.delete_fg IS NULL

        INNER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t277_unitfactors AS UNIT
                ON  ART.wawi_instanz_kzl = UNIT.wawi_instanz_kzl
                AND ART.UNIT_ID = UNIT.C277_ID
                AND UNIT.delete_fg IS NULL
        WHERE
        (
            II.ITEMNR IS NULL /* NO LINK TO INTERNATIONAL ITEM NUMBER */
            OR
            (
                    IPK.PROD_SID IS NULL /* INTERNATIONAL NUMBER NOT FOUND IN INTERNATIONAL KEYS */
                AND EKS.ITEMNO IS NULL
            ))

        QUALIFY ROW_NUMBER() OVER (PARTITION BY ART.wawi_instanz_kzl, 
                                                ART.ITEMNR
                                        ORDER BY ART.CASE_SIZE DESC NULLS LAST
                                      ) = 1
) AS ART
;

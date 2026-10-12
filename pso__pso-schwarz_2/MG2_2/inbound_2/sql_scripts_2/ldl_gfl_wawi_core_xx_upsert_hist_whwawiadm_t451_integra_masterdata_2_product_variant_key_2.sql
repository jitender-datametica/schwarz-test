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
/* FV LOG */
WITH t451 AS
   (
    SELECT * 
    FROM  ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t451_integra_masterdata_2 src
    WHERE delete_fg IS NULL
        AND CAST( src.c451_itemnr AS Number) NOT IN ( SELECT CAST( itemno AS Number)
                                                    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item_2
                                                    WHERE delete_fg IS NULL AND NOT itemgrshortdesc BETWEEN 10 AND 13
                                                    
                                                   )
    QUALIFY Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2),    src.c451_itemnr,    src.c451_subitemnr 
                            ORDER BY src.EXTRACTION_TMSP DESC ) =1
   )
,t026 AS
(
  SELECT * FROM  ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item_2
  WHERE delete_fg IS NULL
  QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1
)
SELECT DISTINCT
        VKEY.PROD_VARIANT_SID AS PROD_VARIANT_SID,
        'LOG' AS PROD_VARIANT_KEY_TYPE_CD,
        UPPER(LEFT(wawi_instanz_kzl,2) || '|' || WAWI_ITEMNR) AS PROD_VARIANT_NAT_KEY_NR,
        'FV' AS SOURCE_SYSTEM,
        CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP,
        CURRENT_TIMESTAMP AS EXTRACTION_DT,        
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_WH' AS DWH_NODE_CD,
        '${LOAD_ID}' AS DWH_LOAD_ID
FROM 
(  
        SELECT
            LEFT(WINT.wawi_instanz_kzl,2) AS wawi_instanz_kzl
          , WINT.WAWI_ITEMNR
          , WINT.WAWI_CASESIZE
          , CASE WHEN ITM.CNT = 1
                     THEN ITM.ITEMNR || '|' || ITM.SUBITEMNR
                     ELSE CAST(ITM.ITEMNR AS STRING)
            END AS PVAR_NAT_KEY
          , CASE WHEN ITM.CNT = 1
                     THEN 'FV_LOG'
                     ELSE 'FV_LOG_UNK'
            END AS PVAR_KEY_TYPE_CD
        FROM
        (
            SELECT ITEMNR, COUNT(*) AS CNT, MAX(C451_SUBITEMNR) AS SUBITEMNR
            FROM
            (
                SELECT
                    CAST(C451_ITEMNR AS NUMBER) AS ITEMNR
                  , C451_SUBITEMNR
                FROM T451
                GROUP BY 1,2
             )
             GROUP BY 1

            UNION ALL

            SELECT ITEMNO, 0 AS CNT, 0 AS SUBITEMNR
            FROM T026
            WHERE ITEMGRSHORTDESC BETWEEN 10 AND 13
              AND ITEMNO NOT IN (
                    SELECT DISTINCT CAST(C451_ITEMNR AS NUMBER) AS ITEMNR
                    FROM T451
                )
        ) AS ITM
        INNER JOIN
        (
            SELECT
                LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
              , TRY_CAST(C215_INT_ITEMNR AS NUMBER) AS INT_ITEMNR
              , TRY_CAST(SUBSTRING(C215_ITEMNR, 1, LENGTH(C215_ITEMNR) -4) AS NUMBER) AS WAWI_ITEMNR
              , TRY_CAST(RIGHT(C215_ITEMNR, 4) AS NUMBER) AS WAWI_CASESIZE
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr_2 
            WHERE delete_fg IS NULL
        ) AS WINT
ON  ITM.ITEMNR = WINT.INT_ITEMNR
QUALIFY ROW_NUMBER() OVER (PARTITION BY WINT.wawi_instanz_kzl, 
                                        WINT.WAWI_ITEMNR
                               ORDER BY WINT.WAWI_CASESIZE DESC NULLS LAST) = 1
) AS SRC
INNER JOIN META.T_PRODUCT_VARIANT_KEY_2 VKEY 
         ON VKEY.PROD_VARIANT_NAT_KEY_NR = CAST( SRC.PVAR_NAT_KEY AS VARCHAR(200))
        AND VKEY.DWH_VALID_FG = TRUE
        AND VKEY.PROD_VARIANT_KEY_TYPE_CD = SRC.PVAR_KEY_TYPE_CD
UNION ALL
SELECT DISTINCT

        vkey.prod_variant_sid AS prod_variant_sid,
        'SLS_UNK' AS prod_variant_key_type_cd,
        LEFT(src.wawi_instanz_kzl,2) || '|' || src.itemnr AS prod_variant_nat_key_nr,
        'FV' AS SOURCE_SYSTEM,        
        CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP,
        src.extraction_tmsp AS EXTRACTION_DT,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_WH' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID
FROM
( 
    SELECT
        CAST(itemnr.itemnr AS STRING) AS prod_nr
      , LEFT(iit.wawi_instanz_kzl,2) AS wawi_instanz_kzl
      , iit.itemnr AS itemnr
      , iit.extraction_tmsp
    FROM
    (
        SELECT itemnr
        FROM
        (
            SELECT
                Cast(c451_itemnr AS Number) AS itemnr
              , c451_subitemnr
            FROM T451
            GROUP BY 1,2
        )
        GROUP BY 1 HAVING Count(*) > 1

        UNION ALL

        SELECT itemno
        FROM t026
        WHERE itemgrshortdesc BETWEEN 10 AND 13
          AND itemno NOT IN (
                SELECT DISTINCT Cast(c451_itemnr AS Number) AS itemnr
                FROM t451
            )
    ) AS itemnr
    INNER JOIN
    (
        SELECT
            wawi_instanz_kzl
          , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
          , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
          , Min(extraction_tmsp) AS extraction_tmsp
          , Max(c215_active) AS active_fg
        FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr_2 
        WHERE delete_fg IS NULL
        GROUP BY 1,2,3        
        QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, itemnr
                                   ORDER BY CASE WHEN active_fg = 1 THEN 1 ELSE 2 END
                                          , Cast(c215_int_itemnr AS Number)) = 1
    ) AS iit
    ON  itemnr.itemnr = iit.c215_int_itemnr
) AS src
INNER JOIN meta.t_product_variant_key_2 vkey /* !!!Without Negative-Key-Capture!!!
                                              Key must already exist after the T_PRODUCT_VARIANT_2 (FV_SLS_UNK) job. */
 ON vkey.prod_variant_nat_key_nr = src.prod_nr
AND vkey.dwh_valid_fg = TRUE
AND vkey.prod_variant_key_type_cd = 'FV_SLS_UNK'

UNION ALL

SELECT DISTINCT

        vkey.prod_variant_sid AS prod_variant_sid,
        'SLS_UNK' AS prod_variant_key_type_cd,
        LEFT(src.wawi_instanz_kzl,2) || '|' || src.itemnr AS prod_variant_nat_key_nr,
        'FV' AS SOURCE_SYSTEM,
        src.extraction_tmsp AS EXTRACTION_DT,
        CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_WH' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID
FROM
( 
    SELECT
        CAST(itemnr.itemnr AS STRING) || '|' || CAST(itemnr.subitemnr AS STRING) AS prod_variant_nat_key_nr
      , LEFT(iit.wawi_instanz_kzl,2) AS wawi_instanz_kzl
      , iit.itemnr AS itemnr
      , iit.extraction_tmsp
    FROM
    (
        SELECT itemnr, Min(c451_subitemnr) AS subitemnr
        FROM
        (
            SELECT
                Cast(c451_itemnr AS Number) AS itemnr
              , c451_subitemnr
            FROM T451
            GROUP BY 1,2
        )
        GROUP BY 1 HAVING Count(*) = 1
    ) AS itemnr
    INNER JOIN
    (
        SELECT
            wawi_instanz_kzl
          , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
          , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
          , Min(extraction_tmsp) AS extraction_tmsp
          , Max(c215_active) AS active_fg
        FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr_2 
        WHERE delete_fg IS NULL
        GROUP BY 1,2,3
        QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, itemnr
                                   ORDER BY CASE WHEN active_fg = 1 THEN 1 ELSE 2 END
                                          , Cast(c215_int_itemnr AS Number)) = 1
    ) AS iit
    ON  itemnr.itemnr = iit.c215_int_itemnr
) AS src
INNER JOIN meta.t_product_variant_key_2 vkey /* !!!Without Negative-Key-Capture!!!
                                              Key must already exist after the T_PRODUCT_VARIANT_2 (FV_SLS_UNK) job. */
 ON vkey.prod_variant_nat_key_nr = src.prod_variant_nat_key_nr
AND vkey.dwh_valid_fg = TRUE
AND vkey.prod_variant_key_type_cd = 'FV_SLS'
;

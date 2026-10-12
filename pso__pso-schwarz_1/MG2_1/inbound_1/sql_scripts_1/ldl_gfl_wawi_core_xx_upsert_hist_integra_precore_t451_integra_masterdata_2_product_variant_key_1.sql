INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_VARIANT_SID,
        PROD_VARIANT_KEY_TYPE_CD,
        PROD_VARIANT_NAT_KEY_NR,
        -- FRAMEWORK AND TECHNICAL COLUMNS
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

SELECT DISTINCT

        vkey.prod_variant_sid AS prod_variant_sid,
        'SLS_UNK' AS prod_variant_key_type_cd,
        src.ctrcode || '|' || src.itemnr AS prod_variant_nat_key_nr,
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
      , iit.ctrcode
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
            FROM ETL.T_INTEGRA_PRECORE_T451_INTEGRA_MASTERDATA_1
            GROUP BY 1,2
        )
        GROUP BY 1 HAVING Count(*) > 1

        UNION ALL

        SELECT itemno
        FROM ETL.t_wawi_precore_t026_wawi_item_1
        WHERE itemgrshortdesc BETWEEN 10 AND 13
          AND itemno NOT IN (
                SELECT DISTINCT Cast(c451_itemnr AS Number) AS itemnr
                FROM ETL.t_integra_precore_t451_integra_masterdata_1
            )
    ) AS itemnr
    INNER JOIN
    (
        SELECT
            ctrcode
          , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
          , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
          , Min(extraction_tmsp) AS extraction_tmsp
          , Max(c215_active) AS active_fg
        FROM ETL.t_wawi_precore_t215_int_itemnr_1
        GROUP BY 1,2,3
        QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr
                                   ORDER BY CASE WHEN active_fg = 1 THEN 1 ELSE 2 END
                                          , Cast(c215_int_itemnr AS Number)) = 1
    ) AS iit
    ON  itemnr.itemnr = iit.c215_int_itemnr
) AS src
INNER JOIN meta.t_product_variant_key_1 vkey /* !!!Without Negative-Key-Capture!!!
                                              Key must already exist after the T_PRODUCT_VARIANT_1 (FV_SLS_UNK) job. */
 ON vkey.prod_variant_nat_key_nr = src.prod_nr
AND vkey.dwh_valid_fg = TRUE
AND vkey.prod_variant_key_type_cd = 'FV_SLS_UNK'

UNION ALL

SELECT DISTINCT

        vkey.prod_variant_sid AS prod_variant_sid,
        'SLS_UNK' AS prod_variant_key_type_cd,
        src.ctrcode || '|' || src.itemnr AS prod_variant_nat_key_nr,
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
      , iit.ctrcode
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
            FROM ETL.T_INTEGRA_PRECORE_T451_INTEGRA_MASTERDATA_1
            GROUP BY 1,2
        )
        GROUP BY 1 HAVING Count(*) = 1
    ) AS itemnr
    INNER JOIN
    (
        SELECT
            ctrcode
          , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
          , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
          , Min(extraction_tmsp) AS extraction_tmsp
          , Max(c215_active) AS active_fg
        FROM ETL.t_wawi_precore_t215_int_itemnr_1
        GROUP BY 1,2,3
        QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr
                                   ORDER BY CASE WHEN active_fg = 1 THEN 1 ELSE 2 END
                                          , Cast(c215_int_itemnr AS Number)) = 1
    ) AS iit
    ON  itemnr.itemnr = iit.c215_int_itemnr
) AS src
INNER JOIN meta.t_product_variant_key_1 vkey /* !!!Without Negative-Key-Capture!!!
                                              Key must already exist after the T_PRODUCT_VARIANT_1 (FV_SLS_UNK) job. */
 ON vkey.prod_variant_nat_key_nr = src.prod_variant_nat_key_nr
AND vkey.dwh_valid_fg = TRUE
AND vkey.prod_variant_key_type_cd = 'FV_SLS'

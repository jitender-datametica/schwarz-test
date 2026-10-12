INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
          CTRCODE
        , INT_ORG_KEY_TYPE_CD
        , PROD_NR
        , PROD_KEY_TYPE_CD
        , PROD_VARIANT_NR
        , PROD_VARIANT_KEY_TYPE_CD
        , LOCAL_PROD_VARIANT_NR
        , LOCAL_PROD_VARIANT_NAME
        
        , prod_nat_key_nr
        , party_nat_key_nr
        , prod_variant_nat_key_nr

        -- FRAMEWORK AND TECHNICAL COLUMNS
        , SOURCE_SYSTEM
        , EXTRACTION_DT
        , DWH_MAPPING_TMSP
        , TF_ERROR_FG
        , DELETED_FG
        , RECORD_ID
        , FILENAME
        , DWH_NODE_CD
        , DWH_LOAD_ID
)
SELECT    ctrcode                           AS CTRCODE
        , 'COUNTRY'                         AS INT_ORG_KEY_TYPE_CD
        , itemnr                            AS PROD_NR 
        , 'FV'                              AS PROD_KEY_TYPE_CD
        , itemnr || '|' || subitemnr        AS PROD_VARIANT_NR
        , 'FV_SLS'                          AS PROD_VARIANT_KEY_TYPE_CD      
        , CAST(itemnr AS String) 
          || '|' || 
          CAST(subitemnr AS String)         AS LOCAL_PROD_VARIANT_NR
        , COALESCE(bez_lang, deutschtext) 
          || '|' || 
          CAST(src.subitemnr as String)     AS LOCAL_PROD_VARIANT_NAME

        , itemnr                          AS prod_nat_key_nr
        , ctrcode                         AS party_nat_key_nr
        , itemnr || '|' || subitemnr      AS prod_variant_nat_key_nr
        
        -- FRAMEWORK AND TECHNICAL COLUMNS
        , 'WAWI'                            AS SOURCE_SYSTEM
        , CURRENT_DATE                      AS EXTRACTION_DT
        , extraction_tmsp                   AS DWH_MAPPING_TMSP
        , 0                                 AS TF_ERROR_FG
        , 0                                 AS DELETED_FG
        , 0                                 AS RECORD_ID
        , 't_${SRC_INPUT_TABLE}'            AS FILENAME
        , 'WAWI_HQ'                         AS DWH_NODE_CD
        , '${LOAD_ID}'                      AS DWH_LOAD_ID

FROM (
        -- Extraction/Filter Logic:
        SELECT
            iit.ctrcode
          , itm.itemnr
          , itm.subitemnr
          , waw.bez_lang
          , waw.deutschtext
          , waw.extraction_tmsp
        FROM
        (
            SELECT DISTINCT
                Cast(c451_itemnr AS Number) AS itemnr
              , Cast(c451_subitemnr AS Number) AS subitemnr
            FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}
        ) AS itm
        INNER JOIN
        (
            SELECT DISTINCT
                ctrcode
              , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
              , Cast(c215_int_itemnr AS Number) AS int_itemnr
            FROM ETL.t_wawi_precore_t215_int_itemnr
        ) AS iit
        ON  itm.itemnr = iit.int_itemnr
        LEFT OUTER JOIN
        (
            SELECT
                ctrcode
              , Cast(artnrvier AS Number) AS itemnr
              , bez_lang
              , deutschtext
              , extraction_tmsp
            FROM ETL.artikel
            QUALIFY Row_Number() OVER (
                PARTITION BY ctrcode, itemnr
                ORDER BY artikelnr) = 1
        ) AS waw
        ON  iit.ctrcode = waw.ctrcode
        AND iit.int_itemnr = waw.itemnr     
) SRC

;


INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
          CTRCODE
        , INT_ORG_KEY_TYPE_CD
        , PROD_NR
        , PROD_KEY_TYPE_CD
        , PROD_VARIANT_NR
        , PROD_VARIANT_KEY_TYPE_CD
        , LOCAL_PROD_VARIANT_NR
        , LOCAL_PROD_VARIANT_NAME

        , prod_nat_key_nr
        , party_nat_key_nr
        , prod_variant_nat_key_nr

        -- FRAMEWORK AND TECHNICAL COLUMNS
        , SOURCE_SYSTEM
        , EXTRACTION_DT
        , DWH_MAPPING_TMSP
        , TF_ERROR_FG
        , DELETED_FG
        , RECORD_ID
        , FILENAME
        , DWH_NODE_CD
        , DWH_LOAD_ID
)
  SELECT
          CTRCODE
        , INT_ORG_KEY_TYPE_CD
        , PROD_NR
        , PROD_KEY_TYPE_CD
        , PROD_VARIANT_NR
        , 'FV_LOG' AS PROD_VARIANT_KEY_TYPE_CD
        , LOCAL_PROD_VARIANT_NR
        , LOCAL_PROD_VARIANT_NAME

        , prod_nat_key_nr
        , party_nat_key_nr
        , prod_variant_nat_key_nr

        -- FRAMEWORK AND TECHNICAL COLUMNS
        , SOURCE_SYSTEM
        , EXTRACTION_DT
        , DWH_MAPPING_TMSP
        , TF_ERROR_FG
        , DELETED_FG
        , RECORD_ID
        , FILENAME
        , DWH_NODE_CD
        , DWH_LOAD_ID
  FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
  WHERE PROD_VARIANT_KEY_TYPE_CD = 'FV_SLS'
; 

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
          CTRCODE
        , INT_ORG_KEY_TYPE_CD
        , PROD_NR
        , PROD_KEY_TYPE_CD
        , PROD_VARIANT_NR
        , PROD_VARIANT_KEY_TYPE_CD
        , LOCAL_PROD_VARIANT_NR
        , LOCAL_PROD_VARIANT_NAME

        , prod_nat_key_nr
        , party_nat_key_nr
        , prod_variant_nat_key_nr

        -- FRAMEWORK AND TECHNICAL COLUMNS
        , SOURCE_SYSTEM
        , EXTRACTION_DT
        , DWH_MAPPING_TMSP
        , TF_ERROR_FG
        , DELETED_FG
        , RECORD_ID
        , FILENAME
        , DWH_NODE_CD
        , DWH_LOAD_ID
)
SELECT    country_iso_cd                    AS CTRCODE
        , 'COUNTRY'                         AS INT_ORG_KEY_TYPE_CD
        , itemnr                            AS PROD_NR 
        , 'FV'                              AS PROD_KEY_TYPE_CD
        , itemnr                            AS PROD_VARIANT_NR
        , 'FV_SLS_UNK'                      AS PROD_VARIANT_KEY_TYPE_CD      
        , CAST(itemnr AS String)            AS LOCAL_PROD_VARIANT_NR
        , COALESCE(bez_lang, deutschtext)   AS LOCAL_PROD_VARIANT_NAME

         , itemnr                           AS prod_nat_key_nr
         , country_iso_cd                   AS party_nat_key_nr
         , itemnr                           AS prod_variant_nat_key_nr
        
        -- FRAMEWORK AND TECHNICAL COLUMNS
        , 'WAWI'                            AS SOURCE_SYSTEM
        , CURRENT_DATE                      AS EXTRACTION_DT
        , extraction_tmsp                   AS DWH_MAPPING_TMSP
        , 0                                 AS TF_ERROR_FG
        , 0                                 AS DELETED_FG
        , 0                                 AS RECORD_ID
        , 't_${SRC_INPUT_TABLE}'            AS FILENAME
        , 'WAWI_HQ'                         AS DWH_NODE_CD
        , '${LOAD_ID}'                      AS DWH_LOAD_ID
FROM (
        SELECT
            itm.itemnr
          , iit.country_iso_cd
          , waw.bez_lang
          , waw.deutschtext
          , waw.extraction_tmsp
        FROM
        (
            SELECT itemnr
            FROM
            (
                SELECT
                    Cast(c451_itemnr AS Number) AS itemnr
                  , c451_subitemnr
                FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}
                GROUP BY 1,2
            )
            GROUP BY 1 HAVING Count(*) > 1

            UNION ALL

            SELECT itemno
            FROM ETL.t_wawi_precore_t026_wawi_item
            WHERE itemgrshortdesc BETWEEN 10 AND 13
              AND itemno NOT IN (
                    SELECT DISTINCT Cast(c451_itemnr AS Number) AS itemnr
                    FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}
                )
        ) AS itm
        INNER JOIN
        (
            SELECT DISTINCT
                ctrcode AS country_iso_cd
              , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
              , Cast(c215_int_itemnr AS Number) AS int_itemnr
            FROM ETL.t_wawi_precore_t215_int_itemnr
        ) AS iit
        ON  itm.itemnr = iit.int_itemnr
        LEFT OUTER JOIN
        (
            SELECT
                ctrcode AS country_iso_cd
              , Cast(artnrvier AS Number) AS itemnr
              , bez_lang
              , deutschtext
              , extraction_tmsp
            FROM ETL.t_wawi_precore_artikel
            QUALIFY Row_Number() OVER (
                PARTITION BY country_iso_cd, itemnr
                ORDER BY artikelnr) = 1
        ) AS waw
        ON  iit.country_iso_cd = waw.country_iso_cd
        AND iit.itemnr = waw.itemnr
) SRC
;

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
          CTRCODE
        , INT_ORG_KEY_TYPE_CD
        , PROD_NR
        , PROD_KEY_TYPE_CD
        , PROD_VARIANT_NR
        , PROD_VARIANT_KEY_TYPE_CD
        , LOCAL_PROD_VARIANT_NR
        , LOCAL_PROD_VARIANT_NAME

        , prod_nat_key_nr
        , party_nat_key_nr
        , prod_variant_nat_key_nr

        -- FRAMEWORK AND TECHNICAL COLUMNS
        , SOURCE_SYSTEM
        , EXTRACTION_DT
        , DWH_MAPPING_TMSP
        , TF_ERROR_FG
        , DELETED_FG
        , RECORD_ID
        , FILENAME
        , DWH_NODE_CD
        , DWH_LOAD_ID
)
  SELECT
          CTRCODE
        , INT_ORG_KEY_TYPE_CD
        , PROD_NR
        , PROD_KEY_TYPE_CD
        , PROD_VARIANT_NR
        , 'FV_LOG_UNK' AS PROD_VARIANT_KEY_TYPE_CD
        , LOCAL_PROD_VARIANT_NR
        , LOCAL_PROD_VARIANT_NAME

        , prod_nat_key_nr
        , party_nat_key_nr
        , prod_variant_nat_key_nr

        -- FRAMEWORK AND TECHNICAL COLUMNS
        , SOURCE_SYSTEM
        , EXTRACTION_DT
        , DWH_MAPPING_TMSP
        , TF_ERROR_FG
        , DELETED_FG
        , RECORD_ID
        , FILENAME
        , DWH_NODE_CD
        , DWH_LOAD_ID
  FROM ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
  WHERE PROD_VARIANT_KEY_TYPE_CD = 'FV_SLS_UNK'
; 


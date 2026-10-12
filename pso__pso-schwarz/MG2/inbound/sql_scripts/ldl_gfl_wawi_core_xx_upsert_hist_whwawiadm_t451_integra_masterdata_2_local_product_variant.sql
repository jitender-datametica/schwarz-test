INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
          ctrcode
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
WITH t451 AS
(
  SELECT * 
  FROM  ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src
  WHERE delete_fg IS NULL
      AND CAST( src.c451_itemnr AS Number) NOT IN ( SELECT CAST( itemno AS Number)
                                                    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item
                                                    WHERE delete_fg IS NULL AND NOT itemgrshortdesc BETWEEN 10 AND 13
                                                    
                                                   )
  QUALIFY Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2),    src.c451_itemnr,    src.c451_subitemnr 
                            ORDER BY src.EXTRACTION_TMSP DESC ) =1

)
SELECT    LEFT(wawi_instanz_kzl,2)                           AS ctrcode
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
        , LEFT(wawi_instanz_kzl,2)        AS party_nat_key_nr
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
            iit.wawi_instanz_kzl
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
            FROM t451            
        ) AS itm
        INNER JOIN
        (
            SELECT DISTINCT
                wawi_instanz_kzl
              , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
              , Cast(c215_int_itemnr AS Number) AS int_itemnr
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr src
            WHERE delete_fg IS NULL
            QUALIFY Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2), src.C215_INT_ITEMNR ORDER BY src.EXTRACTION_TMSP DESC) = 1

        ) AS iit
        ON  itm.itemnr = iit.int_itemnr
        LEFT OUTER JOIN
        (
            SELECT
                wawi_instanz_kzl
              , Cast(artnrvier AS Number) AS itemnr
              , bez_lang
              , deutschtext
              , extraction_tmsp
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel
            WHERE delete_fg IS NULL
            QUALIFY Row_Number() OVER (
                PARTITION BY wawi_instanz_kzl, itemnr
                ORDER BY artikelnr) = 1
        ) AS waw
        ON  iit.wawi_instanz_kzl = waw.wawi_instanz_kzl
        AND iit.int_itemnr = waw.itemnr     
) SRC

;


INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
          ctrcode
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
          ctrcode
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
          ctrcode
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
WITH t451 AS
(
  SELECT * 
  FROM  ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src
  WHERE delete_fg IS NULL
      AND CAST( src.c451_itemnr AS Number) NOT IN ( SELECT CAST( itemno AS Number)
                                                    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item
                                                    WHERE delete_fg IS NULL AND NOT itemgrshortdesc BETWEEN 10 AND 13
                                                    
                                                   )
  QUALIFY Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2),    src.c451_itemnr,    src.c451_subitemnr 
                            ORDER BY src.EXTRACTION_TMSP DESC ) =1

)
SELECT    LEFT(country_iso_cd,2)            AS ctrcode
        , 'COUNTRY'                         AS INT_ORG_KEY_TYPE_CD
        , itemnr                            AS PROD_NR 
        , 'FV'                              AS PROD_KEY_TYPE_CD
        , itemnr                            AS PROD_VARIANT_NR
        , 'FV_SLS_UNK'                      AS PROD_VARIANT_KEY_TYPE_CD      
        , CAST(itemnr AS String)            AS LOCAL_PROD_VARIANT_NR
        , COALESCE(bez_lang, deutschtext)   AS LOCAL_PROD_VARIANT_NAME

         , itemnr                           AS prod_nat_key_nr
         , LEFT(country_iso_cd,2)           AS party_nat_key_nr
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
                FROM t451                
                GROUP BY 1,2
            )
            GROUP BY 1 HAVING Count(*) > 1

            UNION ALL

            SELECT itemno
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item
            WHERE delete_fg IS NULL
              AND itemgrshortdesc BETWEEN 10 AND 13
              AND itemno NOT IN (
                    SELECT DISTINCT Cast(c451_itemnr AS Number) AS itemnr
                    FROM  t451                    
                )
            QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1
        ) AS itm
        INNER JOIN
        (
            SELECT DISTINCT
                wawi_instanz_kzl AS country_iso_cd
              , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
              , Cast(c215_int_itemnr AS Number) AS int_itemnr
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr src
            WHERE delete_fg IS NULL
            QUALIFY Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2), src.C215_INT_ITEMNR ORDER BY src.EXTRACTION_TMSP DESC) = 1
        ) AS iit
        ON  itm.itemnr = iit.int_itemnr
        LEFT OUTER JOIN
        (
            SELECT
                wawi_instanz_kzl AS country_iso_cd
              , Cast(artnrvier AS Number) AS itemnr
              , bez_lang
              , deutschtext
              , extraction_tmsp
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel
            WHERE delete_fg IS NULL
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
          ctrcode
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
          ctrcode
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


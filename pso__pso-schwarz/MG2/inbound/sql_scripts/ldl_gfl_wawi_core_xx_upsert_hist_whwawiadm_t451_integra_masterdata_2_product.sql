INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_TYPE_CD,
        ITEM_TYPE_CD,
        PROD_KEY_TYPE_CD,
        PROD_NR,
        PROD_NAME,
        PROD_DESCR,
        PROD_CREATION_DT,
        PACKING_TYPE_CD,
        GOODS_ON_CONSIGNMENT_FG,
        EXCL_FROM_VAT_CALC_FG,
        COUNTRY_SPECIFIC_PROD_FG,
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
WITH t451 AS
(
  SELECT * 
  FROM  ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src
  WHERE delete_fg IS NULL
      AND CAST( src.c451_itemnr AS Number) NOT IN ( SELECT CAST( itemno AS Number)
                                                    FROM ( SELECT itemno, itemgrshortdesc
                                                           FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item
                                                           WHERE delete_fg IS NULL
                                                           QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1
                                                         )
                                                    WHERE NOT itemgrshortdesc BETWEEN 10 AND 13
                                                    
                                                   )
  QUALIFY Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2),    src.c451_itemnr,    src.c451_subitemnr 
                            ORDER BY src.EXTRACTION_TMSP DESC ) =1

)
SELECT 

        'ITEM'                                           AS PROD_TYPE_CD,
        'FV'                                             AS ITEM_TYPE_CD,
        'FV'                                             AS PROD_KEY_TYPE_CD,
        itemnr.itemnr                                    AS PROD_NR,
        Coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS PROD_NAME,
        Coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS PROD_DESCR,
        waw.min_valid_FROM                               AS PROD_CREATION_DT,
        COALESCE(pt1.c271_int_short, pt2.c271_int_short) AS PACKING_TYPE_CD,
        FALSE                                            AS GOODS_ON_CONSIGNMENT_FG,
        FALSE                                            AS EXCL_FROM_VAT_CALC_FG,
        FALSE                                            AS COUNTRY_SPECIFIC_PROD_FG,

        'WAWI'                                           AS SOURCE_SYSTEM,
        CURRENT_DATE                                     AS EXTRACTION_DT,
        itemnr.extraction_tmsp                           AS DWH_MAPPING_TMSP,
        0                                                AS TF_ERROR_FG,
        0                                                AS DELETED_FG,
        0                                                AS RECORD_ID,
        't_${SRC_INPUT_TABLE}'                           AS FILENAME,
        'WAWI_HQ'                                        AS DWH_NODE_CD,
        '${LOAD_ID}'                                     AS DWH_LOAD_ID

    FROM
    (
        SELECT itemnr, Min(extraction_tmsp) AS extraction_tmsp
        FROM
        (
            SELECT Cast(c451_itemnr AS Number) AS itemnr, extraction_tmsp
            FROM  t451            
            UNION ALL
            SELECT itemno, extraction_tmsp
            FROM
            (
                SELECT itemno, extraction_tmsp, itemgrshortdesc
                FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item
                WHERE delete_fg IS NULL
                QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1
            )
            WHERE itemgrshortdesc BETWEEN 10 AND 13
        )
        GROUP BY 1
    ) AS itemnr
    LEFT OUTER JOIN 
          ( SELECT * FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item 
            WHERE delete_fg IS NULL
            QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1
          ) AS eks
    ON  itemnr.itemnr = eks.itemno 
    LEFT OUTER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t271_packagetype AS pt1
    ON  eks.wawi_instanz_kzl = pt1.wawi_instanz_kzl
    AND eks.packageid = pt1.c271_packnr AND pt1.delete_fg IS NULL
    LEFT OUTER JOIN
    (
        SELECT a.*
          , Cast(artnrvier AS Number) AS itemnr
          , Min(gueltig_ab) OVER (PARTITION BY itemnr) AS min_valid_from
        FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel AS a
        WHERE delete_fg IS NULL
        QUALIFY Row_Number() OVER (
            PARTITION BY itemnr
            ORDER BY CASE
                WHEN wawi_instanz_kzl = 'DE' THEN 1
                WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR') THEN 2
                WHEN wawi_instanz_kzl = 'GR' THEN 3
                WHEN wawi_instanz_kzl in ('BG', 'CY') THEN 4
            END, wawi_instanz_kzl, artikelnr) = 1
    ) AS waw
    ON itemnr.itemnr = waw.itemnr
    LEFT OUTER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t271_packagetype AS pt2
    ON  waw.wawi_instanz_kzl = pt2.wawi_instanz_kzl
    AND waw.packung = pt2.c271_packdescript AND pt2.delete_fg IS NULL
-- /* TEMPORARY/not is mapping */WHERE PROD_NAME IS NOT NULL
;

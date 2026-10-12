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

SELECT 

        'ITEM_1'                                           AS PROD_TYPE_CD,
        'FV'                                             AS ITEM_TYPE_CD,
        'FV'                                             AS PROD_KEY_TYPE_CD,
        itemnr.itemnr                                    AS PROD_NR,
        Coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS PROD_NAME,
        Coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS PROD_DESCR,
        waw.min_valid_from                               AS PROD_CREATION_DT,
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
            FROM etl.t_${SRC_INPUT_TABLE}
            UNION ALL
            SELECT itemno, extraction_tmsp
            FROM ETL.t_wawi_precore_t026_wawi_item_1
            WHERE itemgrshortdesc BETWEEN 10 AND 13
        )
        GROUP BY 1
    ) AS itemnr
    LEFT OUTER JOIN ETL.t_wawi_precore_t026_wawi_item_1 AS eks
    ON  itemnr.itemnr = eks.itemno
    LEFT OUTER JOIN ETL.t_wawi_precore_t271_packagetype_1 AS pt1
    ON  eks.ctrcode = pt1.ctrcode
    AND eks.packageid = pt1.c271_packnr
    LEFT OUTER JOIN
    (
        SELECT a.*
          , Cast(artnrvier AS Number) AS itemnr
          , Min(gueltig_ab) OVER (PARTITION BY itemnr) AS min_valid_from
        FROM etl.t_wawi_precore_artikel_1 AS a
        QUALIFY Row_Number() OVER (
            PARTITION BY itemnr
            ORDER BY CASE
                WHEN ctrcode = 'DE' THEN 1
                WHEN ctrcode NOT IN ('BG', 'CY', 'GR') THEN 2
                WHEN ctrcode = 'GR' THEN 3
                WHEN ctrcode in ('BG', 'CY') THEN 4
            END, ctrcode, artikelnr) = 1
    ) AS waw
    ON itemnr.itemnr = waw.itemnr
    LEFT OUTER JOIN ETL.t_wawi_precore_t271_packagetype_1 AS pt2
    ON  waw.ctrcode = pt2.ctrcode
AND waw.packung = pt2.c271_packdescript
-- /* TEMPORARY/not is mapping */WHERE PROD_NAME IS NOT NULL
;

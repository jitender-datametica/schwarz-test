--Extraction/Filter Logic:
INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_KEY_TYPE_CD,
        PROD_NR,
        PROD_GRP_KEY_TYPE_CD,
        PROD_GRP_NR,
        PROD_GRP_TYPE_CD,
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
        'EKS' AS prod_key_type_cd,
        prod_num AS prod_nr,
        'IFG' AS prod_grp_key_type_cd,
        CONCAT(uwgnr,'|',fgnr) AS prod_grp_nr,
        'IFG' AS prod_grp_type_cd,
    -- FRAMEWORK AND TECHNICAL COLUMNS
        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        extraction_tmsp AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        '${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_HQ' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID
FROM
(
SELECT prod_num, extraction_tmsp, uwgnr, fgnr
FROM
(
    WITH eks_item AS (
        SELECT
            itemno
          , itemgrshortdesc AS uwgnr
          , itemgroupid AS fgnr
          , CASE bitflag WHEN 0 THEN 1 /*EA*/ 
                              WHEN 4 THEN 2 /*SK*/
                             WHEN 2 THEN 3 /*BA*/
            END AS level
          , extraction_tmsp
        FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item_1
        WHERE delete_fg IS NULL
        QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1
    )
    SELECT
        eks.prod_num
      , eksp.extraction_tmsp
      , CASE WHEN eksp.uwgnr || '|' || eksp.fgnr IS NOT NULL
                 THEN eksp.uwgnr
                 ELSE eksi.uwgnr END AS uwgnr
      , CASE WHEN eksp.uwgnr || '|' || eksp.fgnr IS NOT NULL
                 THEN eksp.fgnr
                 ELSE eksi.fgnr END AS fgnr                 
    FROM
    (            
        SELECT itemno_ba AS prod_num, itemno_sk AS itemno
        FROM etl.t_tcache_eks_hierarchy_1
        UNION
        SELECT itemno_ba AS prod_num, itemno_ea AS itemno
        FROM etl.t_tcache_eks_hierarchy_1
    ) AS eks
    INNER JOIN eks_item AS eksp
    ON  eks.prod_num = eksp.itemno
    INNER JOIN eks_item AS eksi
    ON  eks.itemno = eksi.itemno
    QUALIFY Row_Number() OVER (
        PARTITION BY eks.prod_num
        ORDER BY
            CASE WHEN eksp.uwgnr || '|' || eksp.fgnr IS NOT NULL THEN 1 ELSE 2 END
          , CASE WHEN eksi.uwgnr || '|' || eksi.fgnr IS NOT NULL THEN 1 ELSE 2 END
          , eksi.level DESC) = 1
)
WHERE uwgnr IS NOT NULL AND fgnr IS NOT NULL
)

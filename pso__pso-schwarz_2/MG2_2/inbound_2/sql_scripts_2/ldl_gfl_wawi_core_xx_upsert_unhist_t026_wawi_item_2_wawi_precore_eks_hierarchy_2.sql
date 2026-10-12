TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        ITEMNO_EA,
        ITEMNO_SK,
        ITEMNO_BA,
    -- FRAMEWORK AND TECHNICAL COLUMNS
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_LOAD_ID
)
SELECT
        itemno_1  AS itemno_ea,
        CASE WHEN itemno_3 IS NULL THEN itemno_1
            ELSE itemno_2
        END AS itemno_sk,
        CASE WHEN itemno_2 IS NULL AND itemno_3 IS NULL THEN itemno_1
            WHEN itemno_3 IS NULL THEN itemno_2
            ELSE itemno_3
        END AS itemno_ba,
        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        current_timestamp AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        '${SRC_INPUT_TABLE}' AS FILENAME,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM
(
    SELECT DISTINCT
        i1.itemno        AS itemno_1
      , d1.level_detail  AS level_1
      , i2.itemno        AS itemno_2
      , d1.level_head    AS level_2
      , i3.itemno        AS itemno_3
      , d2.level_head    AS level_3
      , CASE WHEN dx.itemno_detail IS NULL /*EA no parent*/ THEN i1.itemno
             WHEN d1.level_head = 3 /*BA*/ THEN i2.itemno
             WHEN d2.level_head = 3 /*BA*/ THEN i3.itemno
        END AS prod_num
    FROM ETL.t_wawi_precore_t026_wawi_item_2 AS i1
    LEFT OUTER JOIN ETL.t_wawi_precore_t024_wawi_item_dep_2 AS d1
    ON  i1.itemno = d1.itemno_detail
    LEFT OUTER JOIN ETL.t_wawi_precore_t026_wawi_item_2 AS i2
    ON  d1.itemno_head = i2.itemno
    LEFT OUTER JOIN ETL.t_wawi_precore_t024_wawi_item_dep_2 AS d2
    ON  i2.itemno = d2.itemno_detail
    LEFT OUTER JOIN ETL.t_wawi_precore_t026_wawi_item_2 AS i3
    ON  d2.itemno_head = i3.itemno
    LEFT OUTER JOIN
    (
        SELECT DISTINCT itemno_detail
        FROM ETL.t_wawi_precore_t024_wawi_item_dep_2
    ) AS dx
    ON  i1.itemno = dx.itemno_detail
    WHERE i1.bitflag in (0) /*EA*/
      AND (
             i1.itemgrshortdesc BETWEEN 20 AND 99
          OR i2.itemgrshortdesc BETWEEN 20 AND 99
          OR i3.itemgrshortdesc BETWEEN 20 AND 99
      )
      AND prod_num IS NOT NULL
);

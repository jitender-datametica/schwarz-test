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

WITH tmp_t026_wawi_item AS       
(
  SELECT * 
  FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item_1
  WHERE delete_fg IS NULL 
  QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1 
)
,wawi_item_dep AS 
(
  SELECT
       left( ctrcode, 2) as ctrcode,
        extraction_tmsp,
        seqid,
        itemno_head,
        level_head,
        itemno_detail,
        level_detail,
        posno,
        quantity,
        transferdate,
        transferflag,
        action_flag,
        location_1,
        scn,
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
  
     WITH eks_item AS 
     (
       SELECT
         itemno
         ,CASE bitflag WHEN 0 THEN 1 /*EA*/ 
                     WHEN 4 THEN 2 /*SK*/
                     WHEN 2 THEN 3 /*BA*/
         END AS hier_level 
        FROM tmp_t026_wawi_item
     ) ,
    eks_dep AS 
    (
      SELECT
        d.wawi_instanz_kzl AS ctrcode
      , d.extraction_tmsp
      , d.seqid
      , d.itemno_head
      , i2.hier_level  AS level_head
      , d.itemno_detail
      , i1.hier_level  AS level_detail
      , d.posno
      , d.quantity
      , d.transferdate
      , d.transferflag
      , d.action_flag
      , d.location_1
      , d.scn
      , CASE WHEN i1.hier_level = 1 AND i2.hier_level = 2 THEN 'EA-SK'
             WHEN i1.hier_level = 1 AND i2.hier_level = 3 THEN 'EA-BA'
             WHEN i1.hier_level = 2 AND i2.hier_level = 3 THEN 'SK-BA'
        END AS dep_descr
     FROM
      (
        /* Keep source data per Item_1 pair with the most recent SeqID */
        SELECT 
          src.* 
        FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t024_wawi_item_dep_1 src        
        WHERE delete_fg IS NULL    
        QUALIFY Row_Number() OVER (PARTITION BY src.itemno_head, src.itemno_detail ORDER BY src.seqid DESC) = 1
      ) AS d
    INNER JOIN eks_item AS i1   ON  d.itemno_detail = i1.itemno
    INNER JOIN eks_item AS i2   ON  d.itemno_head = i2.itemno    AND i1.hier_level < i2.hier_level
    QUALIFY (dep_descr = 'EA-SK' AND d.seqid = Max(d.seqid) OVER (PARTITION BY d.itemno_head, dep_descr))
         OR (dep_descr IN ('EA-BA', 'SK-BA') AND Row_Number() OVER (PARTITION BY i1.itemno, dep_descr ORDER BY d.seqid DESC) = 1)
   )
  SELECT d1.*
  FROM eks_dep AS d1
  LEFT OUTER JOIN eks_dep AS d2
  ON  d1.dep_descr = 'EA-SK'
  AND d2.dep_descr = 'SK-BA'
  AND d1.itemno_head = d2.itemno_detail
  QUALIFY d1.dep_descr <> 'EA-SK'
  /* Verify EA-SK dependencies additionally using the BA (product), use only most recent BA. */
  OR FIRST_VALUE(d2.itemno_head) IGNORE NULLS OVER (PARTITION BY d1.itemno_detail ORDER BY d2.seqid DESC) = d2.itemno_head
  )
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
    FROM tmp_t026_wawi_item AS i1
    LEFT OUTER JOIN wawi_item_dep AS d1
    ON  i1.itemno = d1.itemno_detail
    LEFT OUTER JOIN tmp_t026_wawi_item AS i2
    ON  d1.itemno_head = i2.itemno
    LEFT OUTER JOIN wawi_item_dep AS d2
    ON  i2.itemno = d2.itemno_detail
    LEFT OUTER JOIN tmp_t026_wawi_item AS i3
    ON  d2.itemno_head = i3.itemno
    LEFT OUTER JOIN
    (
        SELECT DISTINCT itemno_detail
        FROM wawi_item_dep
    ) AS dx
    ON  i1.itemno = dx.itemno_detail
    WHERE i1.bitflag in (0) /*EA*/
      AND (
             i1.itemgrshortdesc BETWEEN 20 AND 99
          OR i2.itemgrshortdesc BETWEEN 20 AND 99
          OR i3.itemgrshortdesc BETWEEN 20 AND 99
      )
      AND prod_num IS NOT NULL
    AND i1.delete_fg IS NULL AND i2.delete_fg IS NULL AND i3.delete_fg IS NULL
);

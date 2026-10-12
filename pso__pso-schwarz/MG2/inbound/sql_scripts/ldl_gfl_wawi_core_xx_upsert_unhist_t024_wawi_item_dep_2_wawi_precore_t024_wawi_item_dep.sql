TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        CTRCODE,
        EXTRACTION_TMSP,
        SEQID,
        ITEMNO_HEAD,
        LEVEL_HEAD,
        ITEMNO_DETAIL,
        LEVEL_DETAIL,
        POSNO,
        QUANTITY,
        TRANSFERDATE,
        TRANSFERFLAG,
        ACTION_FLAG,
        LOCATION,
        SCN,
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
        location,
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
  
WITH eks_item AS (
    SELECT
        itemno
      , CASE bitflag WHEN 0 THEN 1 /*EA*/ 
                     WHEN 4 THEN 2 /*SK*/
                     WHEN 2 THEN 3 /*BA*/
        END AS hier_level
    FROM ETL.t_wawi_precore_t026_wawi_item
) ,
eks_dep AS (
    SELECT
        d.ctrcode
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
      , d.location
      , d.scn
      , CASE WHEN i1.hier_level = 1 AND i2.hier_level = 2 THEN 'EA-SK'
             WHEN i1.hier_level = 1 AND i2.hier_level = 3 THEN 'EA-BA'
             WHEN i1.hier_level = 2 AND i2.hier_level = 3 THEN 'SK-BA'
        END AS dep_descr
    FROM
    (
        /* Keep source data per Item pair with the most recent SeqID */
        SELECT s.*
        FROM ETL.t024_wawi_item_dep AS s
        INNER JOIN ETL.WAWI_CONTROL_TABLE ctrl
        ON  ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
        AND ctrl.SOURCE_STATUS = 'A'
        AND s.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
        QUALIFY Row_Number() OVER (PARTITION BY s.itemno_head, s.itemno_detail ORDER BY s.seqid DESC) = 1
    ) AS d
    INNER JOIN eks_item AS i1
    ON  d.itemno_detail = i1.itemno
    INNER JOIN eks_item AS i2
    ON  d.itemno_head = i2.itemno
    AND i1.hier_level < i2.hier_level
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
);

TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        CTRCODE,
        EXTRACTION_TMSP,
        SEQID,
        POSNO,
        ITEMNO,
        EAN,
        EANDESC,
        LOCATION,
        TRANSFERDATE,
        TRANSFERFLAG,
        ACTION_FLAG,
        SCN,
        --
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
SELECT left( src.ctrcode, 2) as ctrcode,
       src.extraction_tmsp,
       src.seqid,
       src.posno,
       src.itemno,
       src.ean,
       src.eandesc,
       src.location,
       src.transferdate,
       src.transferflag,
       src.action_flag,
       src.scn,
       
       'UNSET' AS SOURCE_SYSTEM,
       CURRENT_DATE AS EXTRACTION_DT,
       current_timestamp AS DWH_MAPPING_TMSP,
       0 AS TF_ERROR_FG,
       0 AS DELETED_FG,
       0 AS RECORD_ID,
       '${SRC_INPUT_TABLE}' AS FILENAME,
       'WAWI' AS DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
  FROM ${TEMP_DB}.${SRC_INPUT_TABLE} SRC
 INNER JOIN ( SELECT ctrcode
                    , Rank() OVER (ORDER BY CASE WHEN ctrcode = 'DE' THEN 1
                                                 WHEN ctrcode NOT IN ('BG', 'CY', 'GR') THEN 2
                                                 WHEN ctrcode = 'GR' THEN 3
                                                 WHEN ctrcode IN ('BG', 'CY') THEN 4
                                             END, ctrcode) AS eks_rank
                FROM ( SELECT DISTINCT ctrcode
                         FROM ${TEMP_DB}.${SRC_INPUT_TABLE}) AS a
            ) AS csrc
        ON  src.ctrcode = csrc.ctrcode
    QUALIFY csrc.eks_rank = Min(csrc.eks_rank) OVER (PARTITION BY src.itemno, src.ean)
    AND Row_Number() OVER (PARTITION BY src.itemno, src.ean, src.ctrcode ORDER BY src.seqid DESC) = 1
;

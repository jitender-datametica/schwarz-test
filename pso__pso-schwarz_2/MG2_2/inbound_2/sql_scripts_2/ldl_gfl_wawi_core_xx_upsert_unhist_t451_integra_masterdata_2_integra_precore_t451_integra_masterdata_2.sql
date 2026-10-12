TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
      CTRCODE
    , WH_NR
    , C451_ID
    , C451_ITEMNR
    , C451_ITEMSTATUS
    , C451_SUBITEMNR
    , C451_CASESIZE
    , C451_ORIGIN
    , C451_CLASS
    , BKP_C451_CALIBER_MAX_TMP
    , C451_CALIBER_MAX_TMP
    , C451_CALIBER_MIN
    , C451_CALIBER_MAX
    , C451_CALIBER_UNIT
    , C451_SORT
    , C451_TRADEMARK
    , C451_SUBITEM7
    , C451_SUBITEM8
    , C451_SUBITEMSTATUS
    , C451_TEMP_MIN
    , C451_TEMP_MAX
    , C451_DISPOGROUPNR
    , C451_DISPOGROUPNAME
    , C451_MODDATE
    , C451_MODUSER
    , C451_DIRTY_FLAG
    , C451_CSIZE_COUNTER
    , C451_INTERN_ID
    , SCN
    , EXTRACTION_TMSP
    --------------------------------
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
      LEFT( SRC.CTRCODE, 2) as CTRCODE
    , WH_NR
    , C451_ID
    , C451_ITEMNR
    , C451_ITEMSTATUS
    , C451_SUBITEMNR
    , C451_CASESIZE
    , C451_ORIGIN
    , C451_CLASS
    , BKP_C451_CALIBER_MAX_TMP
    , C451_CALIBER_MAX_TMP
    , C451_CALIBER_MIN
    , C451_CALIBER_MAX
    , C451_CALIBER_UNIT
    , C451_SORT
    , C451_TRADEMARK
    , C451_SUBITEM7
    , C451_SUBITEM8
    , C451_SUBITEMSTATUS
    , C451_TEMP_MIN
    , C451_TEMP_MAX
    , C451_DISPOGROUPNR
    , C451_DISPOGROUPNAME
    , C451_MODDATE
    , C451_MODUSER
    , C451_DIRTY_FLAG
    , C451_CSIZE_COUNTER
    , C451_INTERN_ID
    , SCN
    , EXTRACTION_TMSP
    --------------------------------
    , 'WAWI'                             AS SOURCE_SYSTEM
    , CURRENT_DATE                       AS EXTRACTION_DT
    , current_timestamp                  AS DWH_MAPPING_TMSP
    , 0                                  AS TF_ERROR_FG
    , 0                                  AS DELETED_FG
    , 0                                  AS RECORD_ID
    , '${SRC_INPUT_TABLE}'               AS FILENAME
    , 'WAWI_HQ'                          AS DWH_NODE_CD
    , '${LOAD_ID}'                       AS DWH_LOAD_ID
FROM ${TEMP_DB}.${SRC_INPUT_TABLE} src
INNER JOIN ETL.WAWI_CONTROL_TABLE_2 ctrl
ON true
AND ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
AND ctrl.SOURCE_STATUS = 'A'
AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
AND CAST( src.c451_itemnr AS Number) NOT IN ( SELECT CAST( itemno AS Number)
                                                FROM ${TEMP_DB}.t_wawi_precore_t026_wawi_item_2
                                               WHERE NOT itemgrshortdesc BETWEEN 10 AND 13)
QUALIFY Row_Number() OVER 
(PARTITION BY LEFT( src.CTRCODE, 2),
              src.c451_itemnr, 
              src.c451_subitemnr
 ORDER BY src.EXTRACTION_TMSP DESC
) = 1 
;

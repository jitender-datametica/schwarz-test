TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
      CTRCODE
    , C277_ID
    , C277_UNIT
    , C277_BASEUNIT
    , C277_BASEFACTOR
    , C277_INTUNIT
    , C277_INTFACTOR
    , C277_VALIDFROM
    , C277_VALIDUNTIL
    , C277_EKS_LINK
    , C277_BASE_FAMILY
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
      LEFT( src.CTRCODE, 2) as CTRCODE
    , C277_ID
    , C277_UNIT
    , C277_BASEUNIT
    , C277_BASEFACTOR
    , C277_INTUNIT
    , C277_INTFACTOR
    , C277_VALIDFROM
    , C277_VALIDUNTIL
    , C277_EKS_LINK
    , C277_BASE_FAMILY
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
QUALIFY Row_Number() OVER 
(PARTITION BY 
      LEFT( src.CTRCODE, 2)
    , SRC.C277_ID
 ORDER BY src.EXTRACTION_TMSP DESC
) = 1 
;

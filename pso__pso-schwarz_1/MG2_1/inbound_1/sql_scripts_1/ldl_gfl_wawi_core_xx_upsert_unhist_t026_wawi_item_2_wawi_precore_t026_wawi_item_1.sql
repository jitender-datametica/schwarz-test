TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        CTRCODE,
        EXTRACTION_TMSP,
        SEQID,
        POSNO,
        ITEMNO,
        LOCATION_1,
        CASESIZE,
        BRANDDESC,
        ITEMDESC,
        ITEMTYPEID,
        ITEMGROUPID,
        ITEMGRDESC,
        ITEMGRSHORTDESC,
        PACKAGEID,
        UNITID,
        BUNDLEFACT,
        VOLUME,
        TRANSFERDATE,
        TRANSFERFLAG,
        COUNTRYCODE,
        ACTION_FLAG,
        BITFLAG,
        INSERTDATE,
        PROTNO,
        C026_ITEM_WEIGHT_INFORMATION,
        SCN,
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_LOAD_ID
)
        SELECT LEFT( src.CTRCODE, 2) as CTRCODE,
        src.EXTRACTION_TMSP,
        src.SEQID,
        src.POSNO,
        src.ITEMNO,
        src.LOCATION_1,
        src.CASESIZE,
        src.BRANDDESC,
        src.ITEMDESC,
        src.ITEMTYPEID,
        src.ITEMGROUPID,
        src.ITEMGRDESC,
        src.ITEMGRSHORTDESC,
        src.PACKAGEID,
        src.UNITID,
        src.BUNDLEFACT,
        src.VOLUME,
        src.TRANSFERDATE,
        src.TRANSFERFLAG,
        src.COUNTRYCODE,
        src.ACTION_FLAG,
        src.BITFLAG,
        MIN(src.insertdate) OVER (PARTITION BY src.itemno) AS INSERTDATE,
        src.PROTNO,
        src.C026_ITEM_WEIGHT_INFORMATION,
        src.SCN,
        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        current_timestamp AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        '${SRC_INPUT_TABLE}' AS FILENAME,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.${SRC_INPUT_TABLE} SRC
INNER JOIN ETL.WAWI_CONTROL_TABLE_1 ctrl
       ON ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
      AND ctrl.SOURCE_STATUS = 'A'
      AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
QUALIFY ROW_NUMBER() OVER (PARTITION BY src.itemno ORDER BY src.seqid DESC) = 1
;



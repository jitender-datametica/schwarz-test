BEGIN TRANSACTION;

TRUNCATE TABLE <TARGET>;

INSERT INTO <TARGET>:
(

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
SELECT 
        --
       'WAWI' AS SOURCE_SYSTEM,
       CURRENT_DATE AS EXTRACTION_DT,
       current_timestamp AS DWH_MAPPING_TMSP,
       0 AS TF_ERROR_FG,
       0 AS DELETED_FG,
       0 AS RECORD_ID,
       'ETL.txxx_dummy' AS FILENAME,
       'WAWI' AS DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID
FROM   ETL.txxx_dummy src
INNER JOIN ETL.WAWI_CONTROL_TABLE ctrl
        ON ctrl.SOURCE_TABLE_NAME = UPPER('ETL.txxx_dummy')
       AND ctrl.SOURCE_STATUS = 'A'
       AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
QUALIFY Row_Number() OVER 
(PARTITION BY 
      <SRC_KEY>
 ORDER BY src.EXTRACTION_TMSP DESC
) = 1 
;
COMMIT;

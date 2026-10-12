--==============================================================
-- Table: nfmd_pipeline_export_log
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nfmd_pipeline_export_log
   generated from Powerdesigner on Montag, 4. Juli 2022 13:39:02
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.NFMD_PIPELINE_EXPORT_LOG (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   execution_tmsp                      TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of export execution',
   execution_year                      INTEGER    COMMENT 'Year when the process exported data ',
   execution_week                      INTEGER    COMMENT 'Week of the year when the process exported data',
   sent_rows_cnt                       INTEGER    COMMENT 'additive - number of rows send for the export',
   environment_name                    VARCHAR(50)     COMMENT 'Environmend where data was sent (ex PROD)',
   erp_guid                            VARCHAR(36)     COMMENT 'ID for sending confirmation from the ESB',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_NFMD_PIPELINE_EXPORT_LOG PRIMARY KEY (mandant_id, execution_tmsp) NOT ENFORCED
)  COMMENT = 'Information on the export of the approved (reduced) prices for non-food items from DWH  to SAP';
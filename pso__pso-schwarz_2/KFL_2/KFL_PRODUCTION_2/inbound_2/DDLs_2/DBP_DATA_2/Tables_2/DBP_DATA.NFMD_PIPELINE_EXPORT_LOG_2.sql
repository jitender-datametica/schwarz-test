--==============================================================
-- Table: nfmd_pipeline_export_log_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nfmd_pipeline_export_log_2
   generated from Powerdesigner on Montag, 4. Juli 2022 13:39:02
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.NFMD_PIPELINE_EXPORT_LOG_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   execution_tmsp                      TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of export execution',
   execution_year                      NUMBER(38,0)    COMMENT 'Year when the process exported data ',
   execution_week                      NUMBER(38,0)    COMMENT 'Week of the year when the process exported data',
   sent_rows_cnt                       NUMBER(38,0)    COMMENT 'additive - number of rows send for the export',
   environment_name                    VARCHAR(50)     COMMENT 'Environmend where data was sent (ex PROD)',
   erp_guid                            VARCHAR(36)     COMMENT 'ID for sending confirmation from the ESB',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_NFMD_PIPELINE_EXPORT_LOG PRIMARY KEY (mandant_id, execution_tmsp) NOT ENFORCED
)  COMMENT = 'Information on the export of the approved (reduced) prices for non-food items from DWH  to SAP';
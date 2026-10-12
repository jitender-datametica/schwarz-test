/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CHARGER_STATION_TYPE_2
   generated from Powerdesigner on Dienstag, 16. Januar 2024 10:53:23
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CHARGER_STATION_TYPE_2 (
   CHARGER_STATION_TYPE_CD             VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charger station type.',
   CHARGER_STATION_TYPE_NAME           VARCHAR(100)    NOT NULL COMMENT 'The displayable name of the charger station type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_CHARGER_STATION_TYPE PRIMARY KEY (CHARGER_STATION_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - The type of the charging station. - Source - Manual';

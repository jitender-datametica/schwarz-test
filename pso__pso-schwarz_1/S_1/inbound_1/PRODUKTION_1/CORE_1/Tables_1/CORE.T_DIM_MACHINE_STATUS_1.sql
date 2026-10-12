--==============================================================
-- Table: T_DIM_MACHINE_STATUS_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MACHINE_STATUS_1
   generated from Powerdesigner on Montag, 25. November 2024 10:51:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_MACHINE_STATUS_1 (
   MACHINE_STATUS_CD                   NUMBER(38,0)    NOT NULL COMMENT 'The code for the status_1 of the machine.',
   MACHINE_STATUS_DESCR                VARCHAR(250)    NOT NULL COMMENT 'A textual description of the code for the status_1 of the machine.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_DIM_MACHINE_STATUS PRIMARY KEY (MACHINE_STATUS_CD) NOT ENFORCED
 )  COMMENT= 'Minor Dimension - for describing the status_1 for different machines in a Plant - Source - Calculated Master Data (indirect). Extraction from production line parameter master data from defined sensor data. ';


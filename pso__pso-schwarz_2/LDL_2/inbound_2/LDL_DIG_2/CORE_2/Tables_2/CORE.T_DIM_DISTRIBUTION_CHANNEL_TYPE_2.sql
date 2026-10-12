/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_DISTRIBUTION_CHANNEL_TYPE_2
   GENERATED FROM POWERDESIGNER ON Montag, 17. Juli 2023 08:56:34
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_DISTRIBUTION_CHANNEL_TYPE_2 (
   DIST_CHANNEL_TYPE_CD                VARCHAR(5)      NOT NULL COMMENT 'A  type of distribution channel ( Wshop for LD Webshop , IC for Intercompany)',
   DIST_CHANNEL_TYPE_DESCR             VARCHAR(250)    COMMENT 'A  description for the distribution channel  type ( Webshop , Intercompany)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_DISTRIBUTION_CHANNEL_TYPE PRIMARY KEY (DIST_CHANNEL_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'The dimension that describes distribution channels types  -  Wshop for LD Webshop , IC for Intercompany';

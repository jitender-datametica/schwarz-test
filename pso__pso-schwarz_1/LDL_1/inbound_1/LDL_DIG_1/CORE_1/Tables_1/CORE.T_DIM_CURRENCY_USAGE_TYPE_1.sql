/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CURRENCY_USAGE_TYPE_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 12. September 2023 09:42:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CURRENCY_USAGE_TYPE_1 (
   CURR_USAGE_TYPE_CD                  VARCHAR(5)      NOT NULL COMMENT 'The code for the currency usage ( Local Currency vs_1 Global Currency ).',
   CURR_USAGE_TYPE_DESCR               VARCHAR(250)    NOT NULL COMMENT 'A textual description for the currency usage.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CURRENCY_USAGE_TYPE PRIMARY KEY (CURR_USAGE_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension describing the way currency is used in reports. Global currency use case - all countries / web shops are reported on in the same ONE currency, which is the HQ-Currency. The global currency is EUR,.
             Local is the individual currency of a web shop, but cannot be summed up with other currencies of course.';

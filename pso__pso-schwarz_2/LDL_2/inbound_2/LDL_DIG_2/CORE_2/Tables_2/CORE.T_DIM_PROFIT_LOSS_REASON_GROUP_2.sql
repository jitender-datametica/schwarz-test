/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PROFIT_LOSS_REASON_GROUP_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 31. Mai 2022 08:02:16
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PROFIT_LOSS_REASON_GROUP_2 (
   PROFIT_LOSS_REASON_GROUP_CD         VARCHAR(5)      NOT NULL COMMENT 'The code for the group of reasons for profit or loss ( 011, 320, 220)',
   PROFIT_LOSS_REASON_GROUP_NAME       VARCHAR(100)    COMMENT 'The textual descriottion for the group of reasons for profit or loss (ex Interne Abwicklung)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_PROFIT_LOSS_REASON_GROUP PRIMARY KEY (PROFIT_LOSS_REASON_GROUP_CD) NOT ENFORCED
 )  COMMENT= 'The minor dimension that defines the groups of  reason for profit or loss ';

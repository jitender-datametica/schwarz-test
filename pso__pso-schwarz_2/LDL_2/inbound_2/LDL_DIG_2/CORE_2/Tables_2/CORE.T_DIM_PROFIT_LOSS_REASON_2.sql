/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PROFIT_LOSS_REASON_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 31. Mai 2022 08:03:25
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PROFIT_LOSS_REASON_2 (
   PROFIT_LOSS_REASON_CD               VARCHAR(5)      NOT NULL COMMENT 'The code for the reason of profit/loss  ( 001, 327, 326... etc)',
   PROFIT_LOSS_REASON_NAME             VARCHAR(100)    NOT NULL COMMENT 'A textual description for the reason of profit or loss (Storno /0-Meldung Lager ,Technisch Probleme Shop, etc)',
   PROFIT_LOSS_REASON_GROUP_CD         VARCHAR(5)      COMMENT 'The code for the group of reasons for profit or loss (001, 320, 220)',
   PROFIT_LOSS_REASON_GROUP_NAME       VARCHAR(100)    COMMENT 'The textual descriottion for the group of reasons for profit or loss (ex Interne Abwicklung)',
   PROFIT_LOSS_TYPE_NAME               VARCHAR(100)    COMMENT 'The textual description of the type of reason for profit or loss (Abschriften_2, PV)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_PROFIT_LOSS_REASON PRIMARY KEY (PROFIT_LOSS_REASON_CD) NOT ENFORCED
 )  COMMENT= 'The minor dimension that defines the reasons for profit or loss';

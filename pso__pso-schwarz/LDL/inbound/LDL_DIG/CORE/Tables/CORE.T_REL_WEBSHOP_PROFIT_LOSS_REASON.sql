/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_WEBSHOP_PROFIT_LOSS_REASON
   GENERATED FROM POWERDESIGNER ON Donnerstag, 9. Juni 2022 10:48:59
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_WEBSHOP_PROFIT_LOSS_REASON (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   PROFIT_LOSS_REASON_CD               VARCHAR(5)      NOT NULL COMMENT 'The code for the reason of profit/loss  ( 327, 326... etc)',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   FIN_ACCT_SID                        NUMBER          COMMENT 'The unique identifier (surrogate key) for the Financial Account',
   RECONCIL_FIN_ACCT_SID               NUMBER          COMMENT 'The unique identifier (surrogate key) for the Financial Account',
   CORRECTION_FIN_ACCT_SID             NUMBER          COMMENT 'The unique identifier (surrogate key) for the Financial Account',
   DEPART_NAME                         VARCHAR(100)    COMMENT 'Department taken into account for the loss',
   PROFIT_LOSS_REASON_POS_GROUP_CD     VARCHAR(50)     COMMENT 'Label used by controlling department in reports for grouping different reason codes in same P&L position',
   PROFIT_LOSS_REASON_MGMT_GROUP_CD    VARCHAR(50)     COMMENT 'Label used by controlling department in reports for grouping different reason codes in same management view position',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_REL_WEBSHOP_PROFIT_LOSS_REASON PRIMARY KEY (WSHOP_CD, PROFIT_LOSS_REASON_CD, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'Table that contains mapping between webshops and profit/loss reason code.';

/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_COST_ELEMENT_GROUP_PROFIT_LOSS_POSITION_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 22. Februar 2023 10:45:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_COST_ELEMENT_GROUP_PROFIT_LOSS_POSITION_2 (
   FISCAL_YEAR                         NUMBER          NOT NULL COMMENT 'A number that represents the fiscal year for which the accounting document is posted',
   CE_GROUP_LVL3_NR                    VARCHAR(20)     NOT NULL COMMENT 'Identifier of the Cost Element Group (a.k.a. KER Position) to which this Cost Element belongs according to the Standard  Hierarchy_2',
   PROFIT_LOSS_POSITION_NR             VARCHAR(20)     NOT NULL COMMENT 'Identifier of the Profit/Loss position (KER Position) according to the associated fiscal year hierarchy_2',
   CE_GROUP_LVL3_NAME_DE               VARCHAR(100)    COMMENT 'Short description of the  level 3 Cost Element Group in German',
   PROFIT_LOSS_POSITION_NAME           VARCHAR(100)    COMMENT 'Description of the profit/loss position (KER Position) according to the associated fiscal year hierarchy_2',
   CE_GROUP_LVL2_NR                    VARCHAR(20)     COMMENT 'Identifier of the Cost Element Group (a.k.a. KER Position) to which the CE Group lvl3 belongs according to the Standard  Hierarchy_2',
   PROFIT_LOSS_POSITION_DISPLAY_ORDER_NR NUMBER          COMMENT 'The number indicates in which order the Ker Position will appear in front end ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_REL_COST_ELEMENT_GROUP_PROFIT_LOSS_POSITION PRIMARY KEY (FISCAL_YEAR, CE_GROUP_LVL3_NR, PROFIT_LOSS_POSITION_NR) NOT ENFORCED
 )  COMMENT= 'Table that describes and historizes the Profit and Loss Positions (KER Positions) and their relationships with the Cost Element Groups';

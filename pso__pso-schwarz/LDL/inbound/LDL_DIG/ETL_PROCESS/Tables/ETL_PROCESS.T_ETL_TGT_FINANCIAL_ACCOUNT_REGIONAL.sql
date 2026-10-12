/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_TGT_FINANCIAL_ACCOUNT_REGIONAL
   GENERATED FROM POWERDESIGNER ON Montag, 19. Dezember 2022 10:38:25
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_TGT_FINANCIAL_ACCOUNT_REGIONAL (
   BUS_YEAR                            NUMBER          NOT NULL COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
   MONTH_OF_BUS_YEAR                   NUMBER          NOT NULL COMMENT 'The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   GROUP_ACCT_NR                       VARCHAR(20)     NOT NULL COMMENT 'For operative accounts ( Chart Of Accounts = ''LDI1'') this is the group account they are asscoiated to. This facilitates reporting at group level',
   IS_WINE_SPIRITS_FG                  BOOLEAN         NOT NULL COMMENT 'Flag to identify if the values are belonging to the wine/spirits product gs1 category.',
   DB_POS_NAME                         VARCHAR(200)    COMMENT 'Name of the Contribution Margin position in German',
   CURR_CD                             VARCHAR(5)      COMMENT 'Currency in which target is set',
   TGT_PRICE_NET_EUR_VAL               NUMBER(38, 5)   COMMENT 'Planned price in euro',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_TGT_FINANCIAL_ACCOUNT_REGIONAL PRIMARY KEY (BUS_YEAR, MONTH_OF_BUS_YEAR, WSHOP_CD, GROUP_ACCT_NR, IS_WINE_SPIRITS_FG) NOT ENFORCED
 )  COMMENT= 'ETL Support table -   input data for the Deckungsbeitragsrechnung /Contribution Margin';

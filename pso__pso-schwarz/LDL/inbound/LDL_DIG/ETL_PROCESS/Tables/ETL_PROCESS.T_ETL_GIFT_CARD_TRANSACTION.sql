CREATE TABLE ETL_PROCESS.T_ETL_GIFT_CARD_TRANSACTION (
   DIST_CHANNEL_CD                     VARCHAR(5)      COMMENT 'The code for the distribution channel ( a channel  through which the goods are sold )',
   CUST_ORDER_SID                      NUMBER          NOT NULL COMMENT 'The unique identifier  for customer order ( can be return or intercompany order)',
   CUST_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   LIDL_GIFT_CARD_NR                   VARCHAR(30)     NOT NULL COMMENT 'The unique identifier or number of the gift card used',
   LIDL_GIFT_CARD_EAN_NR               VARCHAR(13)     COMMENT 'Ean number of the Gift Card',
   LIDL_GIFT_CARD_TYPE_CD              VARCHAR(10)     COMMENT 'Code identifying the type of gift card (e.g.,''LGK'' - Lidl Gift Card, ''ENT'' - Gift Card, ''UNENT'' - Voucher, ''MA'' - Employee Card, ''SONSTIGE'' - Social Card.).',
   LIDL_GIFT_CARD_GROSS_LOCAL_VAL      NUMBER(38, 5)   COMMENT 'The value of the Gift Card in gross local currency',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_GIFT_CARD_TRANSACTION PRIMARY KEY (CUST_ORDER_SID, LIDL_GIFT_CARD_NR) NOT ENFORCED 
)  COMMENT = 'This staging table captures granular details of Lidl Gift Card usage transactions for customer orders. The primary function of this data is to identify orders where a gift card was applied, allowing correctly determine and record the original gross selling price before the gift card reduction.
             Source: SAP table: ZSDT_LGK_TRAN';
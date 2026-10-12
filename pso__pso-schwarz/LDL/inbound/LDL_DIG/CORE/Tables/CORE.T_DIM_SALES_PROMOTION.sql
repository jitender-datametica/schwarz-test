/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_SALES_PROMOTION
   GENERATED FROM POWERDESIGNER ON Montag, 6. Oktober 2025 13:30:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SALES_PROMOTION (
   PROMO_ID                            NUMERIC(38,0)   NOT NULL COMMENT 'An identifier from source system to uniqly identify the promotion',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   PROD_SID                            NUMERIC         COMMENT 'The unique identifier (surrogate key) for the product',
   PROMO_NR                            VARCHAR(20)     COMMENT 'Unique season ID (Primary Key) in the source system',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   SALE_PROMO_TYPE_CD                  VARCHAR(20)     COMMENT 'The unique code for that defines the way the product gets promoted e.g. website, flyer, etc.',
   SALE_PROMO_STATUS_CD                VARCHAR(25)     COMMENT 'The unique code for the status of a promotion/delivery.',
   PROMO_DESCR                         VARCHAR(250)    COMMENT 'Description of the promotion',
   CAMPAIGN_DESCR                      VARCHAR(250)    COMMENT 'A description or name of the campaign represented by this promotion.',
   AMC_IAN_NR                          VARCHAR(20)     COMMENT 'In AMC system there is a one-to-many relationship between product number and ian number - AMC users can create ian numbers in the system. Sometimes these ian numbers don''t match the SAP ian numbers.',
   TGT_PROD_RECEIVE_CY_WEEK            NUMERIC         COMMENT 'Calendar week when the promotion products are received. If there is a delivery split it will only appear one date - the minimum date.',
   TGT_PROD_SALE_QTY                   NUMBER(38,0)   COMMENT 'Number of products expected to be sold. Product quantities in stock units (no decimal values).',
   SUPPLIER_ORDER_QTY                  NUMBER(38,0)   COMMENT 'Number of products ordered from suppliers. If it is zero, it means that nothing was ordered because there is still stock available from another promotion. ',
   PROMO_START_DT                      DATE            COMMENT 'Start date of the product promotion in stationary business',
   PROMO_SALE_START_DT                 DATE            COMMENT 'Date when sales of promotional goods starts',
   PROMO_SALE_END_DT                   DATE            COMMENT 'Date when sales of promotional goods end',
   CAMPAIGN_START_DT                   DATE            COMMENT 'The campaign start date as a german local time date.The campaign start date defines the full period of availability for the promotional articles online, not just the official advertising date. While the formal promotion start date for the articles is on Monday (aligning with physical store promotions), online shop launch and sell the articles at least 7 days prior to this date.',
   CAMPAIGN_END_DT                     DATE            COMMENT 'The campaign end date as a german local time date',
   FIRST_WEEK_START_DT                 DATE            COMMENT 'This is the date when the first week of the promotion started.
            Special logic for DE and CZ because these countries focus on promotion weeks and not on promotion dates.
            For DE and CZ the promotions always starts on a monday, even if the promotion start date refers to another weekday.',
   ANALYSIS_START_DT                   DATE            COMMENT 'For this analysis, only the sales orders with an order date in between this start and end date will be considered. For BM promotion type (magazine) in Germany, the start date will be the first day of the month based on promotion start date, otherwise the start date will be the promotion sales start date.',
   ANALYSIS_END_DT                     DATE            COMMENT ' For this analysis, only the sales orders with an order date in between this start and end date will be considered.',
   FIRST_DELIVERY_CY_WEEK              NUMERIC         COMMENT 'Week when was the first time when the combination of this product & IAN & Charge entered the Warehouse. ',
   IS_CATALOG_PROD_FG                  BOOLEAN         COMMENT 'When catalog article is equal to true, the product will keep the same IAN Number in different periods.',
   PROMO_DUR_WEEK_CNT                  NUMERIC         COMMENT 'How long was the promotion planned to be active (number of weeks)',
   IS_REPEATED_FG                      BOOLEAN         COMMENT 'If it is the first time that promotion happens on a specific country then false, else true',
   IS_TV_PROMO_FG                      BOOLEAN         COMMENT 'This Fag indicates whether during a certain promotion a television promotion is planned while the other promotion is ongoing.',
   RETURN_COND_DESCR                   VARCHAR(250)    COMMENT 'In case if we as a company are not able to sell all products, we have in some cases agreements with the supplier where they are taking back the non sold goods.',
   ASSORTMENT_PLAN_PERIOD_NR           VARCHAR(20)     COMMENT 'The period number of the Ausmusterung which shows when the Ausmusterung was.e.g.1904 - Ausmusterung 2019 April',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product, which is country independent',
   PROMO_SEASON_CD                     VARCHAR(50)     COMMENT 'The unique code for the promotional season (e.g. CARNIVAL, AUTUMN_WINTER, SPRING_SUMMER, HALLOWEEN, CHRISTMAS, etc.)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',   
   CONSTRAINT PK_T_DIM_SALES_PROMOTION PRIMARY KEY (PROMO_ID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'A table indication which products are part of the promotions relevant for LD selling goods
             
             Promotion (Thema) is a general topic from the purchasing department during the "Ausmusterung". Articles are clustered in topics to provide a full assortment for a week ( comparable with"Greek Week" or "XXL offer week" from food department).The countries have around 200 articles to chose from and on the Ausmusterung they know that these articles are perfectly fitting together for a predefined topic. 
             
             Campagn (for example Black Week, SummerSale) is unique per Onlineshop and is defined by the country. The country managers can give the articles in the AMC the special campaign name and then work with it (e. g. filter for these articles).';

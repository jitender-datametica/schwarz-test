/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_ECOMMERCE_CAMPAIGN_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. März 2024 11:58:45
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_ECOMMERCE_CAMPAIGN_2 (
   VALID_TIME_KEY_TMSP                 TIMESTAMP_TZ    NOT NULL COMMENT 'Timestamp when campaign page was updated in the source system.',
   CAMPAIGN_PAGE_ID                    NUMBER(38,0)    NOT NULL COMMENT 'The campaign page identifier from source system',
   PROD_NR                             VARCHAR(20)     NOT NULL COMMENT 'The number for internal onlineshop product, which is country_2 independent.',
   CAMPAIGN_PAGE_NAME                  VARCHAR(200)    COMMENT 'The name of the campaign page.',
   TOP_NAVIGATION_NAME                 VARCHAR(200)    COMMENT 'The name in the top navigation.',
   SUBTITLE_TXT                        VARCHAR(200)    COMMENT 'Subtitles for the promotion page.',
   URL_TXT                             VARCHAR(200)    COMMENT 'URL for the promotion page.',
   CAMPAIGN_START_TMSP                 TIMESTAMP_NTZ   COMMENT 'The timestamp when the campaign starts.',
   CAMPAIGN_FINISH_TMSP                TIMESTAMP_NTZ   COMMENT 'The timestamp when the campaign ends.',
   COUNTRY_CD                          VARCHAR(5)      COMMENT 'The unique code for the country.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_ETL_ECOMMERCE_CAMPAIGN PRIMARY KEY (VALID_TIME_KEY_TMSP, CAMPAIGN_PAGE_ID, PROD_NR) NOT ENFORCED 
)  COMMENT = 'ETL table that shows the data about the promotional campaign pages and the products that participate in those campaigns. Campaign Pages are the offer pages with the current weekly only store, only online and store & online offers. They normally change every week.
             
             ';

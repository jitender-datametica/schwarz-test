CREATE TABLE CORE.T_DIM_TRAVEL_SOURCE_MARKET_1 (
   trav_source_market_cd               VARCHAR(5)      NOT NULL COMMENT 'The code for the source market in Lidl Travel ',
   trav_source_market_name             VARCHAR(100)    NOT NULL COMMENT 'The description for the source market in Lidl Travel ',
   country_cd                          VARCHAR(5)      COMMENT 'The unique code for a country_1 according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_TRAVEL_SOURCE_MARKET PRIMARY KEY (trav_source_market_cd)
)
COMMENT = 'This minor dimension defines different source markets_1 available for Lidl Travel ( German , Austrian, Swiss French Speaking , etc...)';
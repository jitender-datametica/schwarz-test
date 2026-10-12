CREATE TABLE CORE.t_dim_country_2 (
   country_cd                          VARCHAR(5)      NOT NULL COMMENT 'The unique code for a country_2 according to ISO-3166 Alpha-2. E.g. DE for Germany or FR for France',
   country_name                        VARCHAR(250)    NOT NULL COMMENT 'The textual description for the country_2',
   country_iso3_cd                     VARCHAR(5)      COMMENT 'ISO Alpha 3-letter-code',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_COUNTRY PRIMARY KEY (country_cd)
   )COMMENT = 'This minor dimension defines the country_2';

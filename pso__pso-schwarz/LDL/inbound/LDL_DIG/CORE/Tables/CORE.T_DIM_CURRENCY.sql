CREATE TABLE CORE.t_dim_currency (
   curr_cd                             VARCHAR(5)      NOT NULL COMMENT 'The code identifying the currency according to ISO-4217.',
   curr_name                           VARCHAR(250)    NOT NULL COMMENT 'A textual description for the currency.',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_currency PRIMARY KEY (curr_cd)
   )COMMENT = 'This minor dimension defines the currency codes according to ISO-4217. (E.g. EUR, USD, GBP, ...)';

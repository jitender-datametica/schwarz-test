CREATE TABLE core_rel.T_CAL_CUM_BUSINESS_YEAR_QUARTER_TO_PARTIAL_WEEK_2 (
   part_week                           NUMBER(38, 0)   NOT NULL COMMENT 'The partial week for which the business-year-quarter-to-partial-week interval is defined',
   incl_part_week                      NUMBER(38, 0)   NOT NULL COMMENT 'The partial week that needs to be included in the business-year-quarter-to-partial-week interval.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CAL_CUM_BUSINESS_YEAR_QUARTER_TO_PARTIAL_WEEK PRIMARY KEY (part_week, incl_part_week) NOT ENFORCED
 )  COMMENT= 'This table relates a partial week to all partial weeks that form its business-year-quarter-to-partial-week interval.';

CREATE TABLE core_rel.T_CAL_CUM_BUSINESS_YEAR_TO_QUARTER_1 (
   bus_year_qtr                        NUMBER(38, 0)   NOT NULL COMMENT 'The business year quarter for which the business-year-to-quarter interval is defined.',
   incl_bus_year_qtr                   NUMBER(38, 0)   NOT NULL COMMENT 'The business year quarter that needs to be included in the business-year-to-quarter interval.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CAL_CUM_BUSINESS_YEAR_TO_QUARTER PRIMARY KEY (bus_year_qtr, incl_bus_year_qtr) NOT ENFORCED
 )  COMMENT= 'This table relates a business year quarter to all business year quarters that form the business-year-to-quarter interval of this quarter. E.g. for Q3/2021 this is Q1/2021, Q2/2021 and Q3/2021.';

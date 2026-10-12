CREATE TABLE CORE.T_DIM_TRAVEL_COST_CENTER (
   trav_cost_center_cd                 VARCHAR(5)      NOT NULL COMMENT 'The code for the cost center ( for each source market )',
   trav_source_market_cd               VARCHAR(5)      COMMENT 'The code for the source market in Lidl Travel ',
   trav_cost_center_descr              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the cost center in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_TRAVEL_COST_CENTER PRIMARY KEY (trav_cost_center_cd)
)
COMMENT = 'This minor dimension defines the cost center ( for each source market )
          10 - Germany
          30 - Austria
          20 - Switzerland (german speaking)
          21 - Switzerland (french speaking) etc';
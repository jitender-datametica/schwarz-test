CREATE TABLE core_dim.T_DIM_HOLIDAY (
   holiday_name                        VARCHAR(100)    NOT NULL COMMENT 'The name for the holiday in group language, i.e. German.',
   holiday_name_de                     VARCHAR(100)    COMMENT 'A name for the holiday in German.',
   holiday_name_en                     VARCHAR(100)    COMMENT 'A name for the holiday in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_HOLIDAY PRIMARY KEY (holiday_name) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the holidays. E.g. Christmas, Easter Sunday, ...';

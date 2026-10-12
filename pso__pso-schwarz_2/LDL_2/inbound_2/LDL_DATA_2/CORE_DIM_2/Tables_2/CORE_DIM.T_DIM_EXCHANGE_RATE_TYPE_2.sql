CREATE TABLE core_dim.T_DIM_EXCHANGE_RATE_TYPE_2 (
   exchange_rate_type_cd               VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way in which one currency can be converted into another.',
   exchange_rate_type_descr            VARCHAR(250)    NOT NULL COMMENT 'A textual description for the way in which one currency can be converted into another expressed in group language, i.e. in German.',
   exchange_rate_type_descr_de         VARCHAR(250)    COMMENT 'A textual description for the way in which one currency can be converted into another expressed in German.',
   exchange_rate_type_descr_en         VARCHAR(250)    COMMENT 'A textual description for the way in which one currency can be converted into another expressed in English.',
   active_for_bus_year_fg              BOOLEAN         NOT NULL COMMENT 'An indicator showing whether the related exchange rate is, in principle, active for an entire business year.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_EXCHANGE_RATE_TYPE PRIMARY KEY (exchange_rate_type_cd) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the ways in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...';

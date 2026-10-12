CREATE TABLE core_rel.T_EXCHANGE_RATE_TYPE_1 (
   exchange_rate_type_cd               VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   exchange_rate_type_descr            VARCHAR(250)    NOT NULL COMMENT 'A textual description for the way in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...',
   fixed_rate_fg                       BOOLEAN         COMMENT 'An indicator showing, if the exchange rate does not change over a longer period of time, e.g. during a business year.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_EXCHANGE_RATE_TYPE PRIMARY KEY (exchange_rate_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the ways in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...';

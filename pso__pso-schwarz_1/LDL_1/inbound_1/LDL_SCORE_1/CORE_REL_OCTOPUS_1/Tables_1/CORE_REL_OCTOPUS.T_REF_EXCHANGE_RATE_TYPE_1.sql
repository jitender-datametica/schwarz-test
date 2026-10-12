CREATE TABLE CORE_REL_OCTOPUS.T_REF_EXCHANGE_RATE_TYPE_1 (
   exchange_rate_type_cd               VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...',
   exchange_rate_type_descr            VARCHAR(100)    NOT NULL COMMENT 'A textual description for the way in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate.',
   exchange_rate_type_descr_de         VARCHAR(100)    COMMENT 'A textual description for the way in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate (Description in German)',
   exchange_rate_type_descr_en         VARCHAR(100)    COMMENT 'A textual description for the way in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate (Description in Engllish)',
   fixed_rate_fg                       BOOLEAN         COMMENT 'An indicator showing, if the exchange rate does not change over a longer period of time, e.g. during a business year.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_EXCHANGE_RATE_TYPE PRIMARY KEY (exchange_rate_type_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the ways in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...';

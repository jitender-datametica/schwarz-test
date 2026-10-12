CREATE TABLE META_OCTOPUS.T_LOGISTICS_TARIFF_KEY_2 (
   logistics_tariff_sid                NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the LOGISTICS TARIFF.',
   logistics_tariff_key_type_cd        VARCHAR(20)     NOT NULL COMMENT 'The code for the type of natural key which identifies the LOGISTICS TARIFF.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   nat_key_comp_nr                     VARCHAR(100)    NOT NULL COMMENT 'The natural key which identifies the Agreement.In case the natural key consist of several columns, all components get concatenated.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_LOGISTICS_TARIFF_KEY PRIMARY KEY (logistics_tariff_key_type_cd, dwh_valid_from_tmsp, nat_key_comp_nr) NOT ENFORCED 
)  COMMENT = 'Key table for the LOGISTICS TARIFF key space. A surrogate key is identified by one or several natural keys. The kind of natural key is defined by the key type code. In case the natural key consists of several columns, all components get concatenated using a separator character. The association between a natural key and its surrogate key can change over time, e.g. because of a re_2-numbering in the source. That is why the key table is historized.';

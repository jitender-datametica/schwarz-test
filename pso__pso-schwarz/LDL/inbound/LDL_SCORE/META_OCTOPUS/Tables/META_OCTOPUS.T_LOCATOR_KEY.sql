
CREATE TABLE META_OCTOPUS.T_LOCATOR_KEY (
   locator_sid                         NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the Locator.',
   locator_type_cd                     VARCHAR(100)    NOT NULL COMMENT 'The code for the type of natural key which identifies the Locator.',
   DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL DEFAULT CAST('1900-01-01 00:00:00' AS TIMESTAMP_LTZ(9)) COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL DEFAULT CAST('9999-12-31 23:59:59' AS TIMESTAMP_LTZ(9)) COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'An indicator showing the current record in history.',
   nat_key_comp_1_nr                   VARCHAR(100)    DEFAULT '@' NOT NULL COMMENT 'The natural key which identifies the Locator.In case the natural key consist of several columns, all components get concatenated.',
   nat_key_comp_2_nr                   VARCHAR(100)    DEFAULT '@' NOT NULL COMMENT 'The natural key which identifies the Locator.In case the natural key consist of several columns, all components get concatenated.',
   nat_key_comp_3_nr                   VARCHAR(100)    DEFAULT '@' NOT NULL COMMENT 'The natural key which identifies the Locator.In case the natural key consist of several columns, all components get concatenated.',
   DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'The point in time when this record was created or last updated.',
   CONSTRAINT PK_T_LOCATOR_KEY PRIMARY KEY (locator_type_cd, dwh_valid_from_tmsp, nat_key_comp_1_nr, nat_key_comp_2_nr, nat_key_comp_3_nr) NOT ENFORCED 
)  COMMENT = 'Key table for the Locator key space. A surrogate key is identified by one or several natural keys. The kind of natural key is defined by the key type code. In case the natural key consists of several columns, all components get concatenated using a separator character. The association between a natural key and its surrogate key can change over time, e.g. because of a re-numbering in the source. That is why the key table is historized.';

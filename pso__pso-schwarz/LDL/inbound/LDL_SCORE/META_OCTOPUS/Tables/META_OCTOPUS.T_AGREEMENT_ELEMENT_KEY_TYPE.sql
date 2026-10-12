CREATE TABLE meta_octopus.T_AGREEMENT_ELEMENT_KEY_TYPE (
   agreement_element_key_type_cd       VARCHAR(20)     NOT NULL COMMENT 'The code for the type of natural key which identifies the AGREEMENT ELEMENT.',
   agreement_element_key_type_name     VARCHAR(100)    NOT NULL COMMENT 'The name of the type of natural key which identifies the AGREEMENT ELEMENT.',
   agreement_element_key_type_descr    VARCHAR(100)    NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_AGREEMENT_ELEMENT_KEY_TYPE PRIMARY KEY (agreement_element_key_type_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the type of natural key which identifies a AGREEMENT ELEMENT.';
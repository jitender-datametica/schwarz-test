CREATE OR REPLACE TABLE szd_production.meta.t_agreement_key_1 (
    agreement_sid NUMBER(38,0) NOT NULL COMMENT 'the unique identifier (surrogate key) for the agreement.',
    agreement_key_type_cd VARCHAR(50) NOT NULL COMMENT 'the code for the type of natural key which identifies the agreement.',
    dwh_valid_from_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record became valid.',
    dwh_valid_to_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was no longer valid.',
    dwh_valid_fg BOOLEAN NOT NULL COMMENT 'an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
    agreement_nat_key_nr VARCHAR(250) NOT NULL COMMENT 'the natural key which identifies the agreement.in case the natural key consist of several columns, all components get concatenated.',
    dwh_created_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was created in the data warehouse.',
    dwh_updated_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was created or last updated.',
    CONSTRAINT pk_agreement_key PRIMARY KEY (agreement_key_type_cd, dwh_valid_from_tmsp, agreement_nat_key_nr)
) 
COMMENT = 'metadata - keytable - agreement - contains the mapping between surrogate keys and natural keys for business objects from the subject area "agreement".';
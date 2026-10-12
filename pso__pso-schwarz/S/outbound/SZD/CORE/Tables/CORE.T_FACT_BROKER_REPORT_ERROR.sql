/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_BROKER_REPORT_ERROR
   generated from Powerdesigner on Mittwoch, 9. August 2023 10:02:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_broker_report_error (
movement_ref_number STRING(250) NOT NULL
OPTIONS(description='The movement reference number that identifies a declaration.'),
item_position BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The position number within the shipment/declaration.'),
declarant_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the declarant.'),
cds_acceptance_dt DATE NOT NULL
OPTIONS(description='This is the date when the goods have arrived at the import location.'),
attribute_name STRING(100) NOT NULL OPTIONS(description='The name of the attribute containing the invalid value.'),
attribute_value_txt STRING(1000) NOT NULL OPTIONS(description='The invalid value of the attribute as text.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (movement_ref_number, item_position, declarant_party_sid, cds_acceptance_dt) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional Events - Transactional - Contains invalid records from the broker report to be shown in a dashboard. - Source - Broker Report');
/* --------------------------------------------------------------------------------
   DDL for table: T_BROKER_REPORT_ERROR
   generated from Powerdesigner on Dienstag, 8. August 2023 14:52:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_broker_report_error (
movement_ref_number STRING(250) NOT NULL
OPTIONS(description='This is a customs identification number that’s created each time a declaration is submitted            The movement reference number for importing or exporting goods. The number generated is bespoke, allowing your goods to be uniquely linked to you. As such, it forms an important part of the audit process for your declarations.'),
item_position BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The number of the Item to which the report line refers. It\'s "Item Number" in CDS item.'),
broker_declarant_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the broker.'),
cds_acceptance_dt DATE NOT NULL
OPTIONS(description='This is the date when the goods have arrived at the import location.'),
attribute_name STRING(100) NOT NULL OPTIONS(description='The name of the attribute with the invalid value.'),
attribute_value_txt STRING(1000) NOT NULL OPTIONS(description='The invalid value as text.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (movement_ref_number, item_position, broker_declarant_party_sid, cds_acceptance_dt) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional Events - Transaction - Contains lines from the broker report that contains attributes with invalid content and needs to be reviewed by the business department. - Source - Broker Report');